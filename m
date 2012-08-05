From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Fix SIGSEGV for extern symbols
Date: Sun,  5 Aug 2012 22:47:34 +0300
Message-ID: <1344196054-17208-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48473 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2HETrr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 5 Aug 2012 15:47:47 -0400
Received: by lbbgm6 with SMTP id gm6so2466765lbb.19
        for <linux-sparse@vger.kernel.org>; Sun, 05 Aug 2012 12:47:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: j.neuschaefer@gmx.net, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Jonathan Neusch=C3=A4fer writes:

  compiling a little real-world program with sparse-llvm, it segfaulted=
=2E
  Using a tool called "delta"[1] and some bash scripting, I managed to
  reduce the code to this test case:

    extern struct foo *foop;
    extern void func(struct foo *f);
    int main(int argc, char **argv) {
        func(foop);
    }

The problem is that pseudo_to_value() does not know abou the extern
symbol because Sparse never calls output_data() on it which registers
globals with LLVMAddGlobal().

As explained by Linus, 'extern' symbols are just names with types. They
don't have any value associated with them, they just have the type and
the name. Therefore we need to explicitly call LLVMAddGlobal() for
symbols we have not encountered in pseudo_to_value().

Reported by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c               |    8 ++++++++
 validation/backend/extern.c |   11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 validation/backend/extern.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6b94205..5bcc758 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -335,6 +335,14 @@ static LLVMValueRef pseudo_to_value(struct functio=
n *fn, struct instruction *ins
 			default:
 				assert(0);
 			}
+		} else {
+			const char *name =3D show_ident(sym->ident);
+
+			result =3D LLVMGetNamedGlobal(fn->module, name);
+			if (!result) {
+				LLVMTypeRef type =3D symbol_type(fn->module, sym);
+				result =3D LLVMAddGlobal(fn->module, type, name);
+			}
 		}
 		break;
 	}
diff --git a/validation/backend/extern.c b/validation/backend/extern.c
new file mode 100644
index 0000000..24cbae5
--- /dev/null
+++ b/validation/backend/extern.c
@@ -0,0 +1,11 @@
+extern unsigned long foo;
+
+static unsigned long bar(void)
+{
+	return foo;
+}
+
+/*
+ * check-name: Extern symbol code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
