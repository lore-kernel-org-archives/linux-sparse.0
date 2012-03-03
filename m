From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: strings
Date: Sat, 03 Mar 2012 21:46:12 +1100
Message-ID: <1330771572.11728.76.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47282 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab2CCKqT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 3 Mar 2012 05:46:19 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org

Hi folks !

I just noticed, as I was digging into (yet another) unrelated llvm
problem with my code, that sparse-llvm fails to compile something that
has a statement such as:

static char *foo = "Foo !\n";

It pukes in output_data(), where we have initializer non-NULL and
initializer->type is EXPR_STRING. So we hit the default: case which is
an assert(0);

Now a trivial "fix" below doesn't quite work:

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9226a21..f151939 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1181,6 +1181,12 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 				initial_value = output_data(module, sym);
 			break;
 		}
+		case EXPR_STRING: {
+			const char *s = initializer->string->data;
+
+			initial_value = LLVMConstString(strdup(s), strlen(s) + 1, true);
+			break;
+		}
 		default:
 			assert(0);
 		}

That has two interesting effects. First, if llvm is compiled with asserts,
it pukes claiming that the initializer is of the wrong type. Now that's
odd because as far as I can tell, the type is an array of i8 ... and it
works if you don't build the asserts in llvm.

Mind you, I had that problem with a different program, which was using
the various "InContext" variants of the various functions rather than
the global context ones... because at one point I was using the global
context for one of the LLVMInt8Type and that made it fail (again worked
fine without asserts).

Looks like the assert internally to LLVM is a pointer comparison of
Type * so it has to resolve to -exactly- the same type object internally,
pretty touchy. Maybe throwing a cast might help.

The second effect however is that the result is not nice:

  .../...

@"<noident>" = private global [7 x i8] c"Foo !\0A\00"
@foo = private global i8* @"<noident>"

  .../...

I haven't quite manage to coerce it to just have a single @foo = <something>
so it looks like we need to separately define the storage (the string)
and foo as a pointer to it, unless I missed something.

I tried to use the same construct we use in pseudo_to_value() (I factored
it out) but that results in worse output, where it now names the string
(.str<N>) but then creates a <noident> ptr and then assigns that to foo...

LLVM is harder than it seems :-)

Cheers,
Ben.


