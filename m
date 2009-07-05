From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Multiple translation unit regression
Date: Mon, 06 Jul 2009 00:06:28 +0100
Message-ID: <4A5131F4.7070007@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050806070605050507090105"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49944 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754695AbZGEXrQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 5 Jul 2009 19:47:16 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050806070605050507090105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Chris,

The recent patches from Linus caught my eye, since I have my own
versions of two of them (the array restrict and transparent_union
patches) in my sparse repo. (I suspect for the same reason; try to
reduce the number of sparse warnings on git. I also have a quick
hack to sorta-kinda implement transparent_union on glibc/Linux;
new-lib/cygwin doesn't need it. I did manage to get to zero
warnings at one point).

So, I decided to fetch from your repo, in order to upgrade to the
latest sparse (I was still using Josh's repo, commit e3bff51f, as
the basis of my version). Having done so, I noticed a regression
when using sparse on libgit2.

<offtopic for="Chris, Junio">
I note that both sparse and git have only one "serious" sparse
error; but it is effectively the same one. If you run sparse
over itself you will find:

    pre-process.c:609:25: error: bad constant expression

and for git (on platforms for which THREADED_DELTA_SEARCH is
defined):

    builtin-pack-objects.c:1606:32: error: bad constant expression

These errors relate to using the "dynamic local arrays" gcc
extension (aka C99 VLAs); viz:

pre-process.c:609 in function expand():
	struct arg args[nargs];

builtin-pack-objects.c:1606 in function ll_find_deltas():
	struct thread_params p[delta_search_threads];

So, whether this is actually a problem, depends on the project
policy regarding this extension...
</offtopic>

In libgit2, the sparse Makefile target includes all source files
(via the SRC_C macro) in a single invocation of cgcc, thus:

sparse:
	cgcc -no-compile $(ALL_CFLAGS) $(SPARSE_FLAGS) $(SRC_C)

this results in the follwing warnings (on cygwin):

.../byteorder.h:39:1: warning: multiple definitions for function '__ntohl'
.../byteorder.h:39:1:  the previous one is here
.../byteorder.h:56:1: warning: multiple definitions for function '__ntohs'
.../byteorder.h:56:1:  the previous one is here

repeated 10 times. (Hint: it is significant that the number of source
files is 11 [-1 = 10]). It is much much worse on Linux, where the glibc
header files have many more extern inline function declarations.

Note that the previous definition of __ntohl is at, er... ;-)

However, if you run cgcc on each file separately, then no warnings
are issued!

To make things a little clearer, try this:

$ cat -n test.c
     1	
     2	extern __inline__ int f(int);
     3	
     4	extern __inline__ int
     5	f(int x)
     6	{
     7		return x;
     8	}
     9	
$ ./sparse test.c
$ ./sparse test.c test.c
test.c:5:1: warning: multiple definitions for function 'f'
test.c:5:1:  the previous one is here
$ cp test.c test-again.c
$ ./sparse test.c test-again.c
test-again.c:5:1: warning: multiple definitions for function 'f'
test.c:5:1:  the previous one is here
$ 

So, the previous definition was in the previous translation unit!

I then used "git bisect" to try and find the culprit, and it fingered:

    commit 0ed9c1290e9fd37e6a320d16c621beba202d422e
    Author: Al Viro <viro@ZenIV.linux.org.uk>
    Date:   Mon Feb 2 07:30:19 2009 +0000

        fun with declarations and definitions
    
        ...

The third hunk of the diff to parse.c actually triggers the problem,
but is not the real cause of the regression.

I think the problem is mainly caused by bind_symbol() binding the
global_scope to some symbols. Indeed, the global_scope/file_scope
seems to be a bit confused and confusing. Note that the global_scope
is not changed at all once intialised. In particular, each translation
unit keeps adding to the, one and only, global_scope; which is
effectively the same as the builtin_scope!

Hmm, the following diff shows a quick fix:

--->8---
diff --git a/scope.c b/scope.c
index 27e38bc..fb4c039 100644
--- a/scope.c
+++ b/scope.c
@@ -49,6 +49,7 @@ void start_file_scope(void)
 	/* top-level stuff defaults to file scope, "extern" etc will choose global scope */
 	function_scope = scope;
 	block_scope = scope;
+	start_scope(&global_scope);
 }
 
 void start_symbol_scope(void)
@@ -87,6 +88,7 @@ static void end_scope(struct scope **s)
 void end_file_scope(void)
 {
 	end_scope(&file_scope);
+	end_scope(&global_scope);
 }
 
 void new_file_scope(void)
--->8---

But this is not the correct fix. In fact it may have broken c2xml
and ctags. I haven't checked, but look at the main() code in c2xml.c
and ctags.c; again the semantics of global_scope vs. file_scope
seems confused and confusing. At least to me. ;-)

Note the comment in the first hunk above. I suspect that the
global_scope was intended to be used to check the semantics of
local extern declarations, which are effectively hoisted to global
scope, in order the check the type of the re-declarations (and
maybe re-definitions). (but it would be a separate symbol table,
used only for the semantic checks).

Hmm, you would also need to compose the two types, check the
resulting linkage... Take a look at this example:

$ cat extern-test.c

int f(void) { extern float g(int); return 0; }
int g(void) { return -1; } /* ERROR, conflicting type for g() */
int h(void) { extern double g(void); return 0; }  /* ditto */

int x;  /* the extern decl. below conflicts with this x, not param */
int k(int x)
{
	{ extern float x; x=1; }  /* ERROR, conflicting type for x */
	return x;  /* this is the parameter x */
}

static int y; /* y has internal linkage */
extern int y; /* OK, y still has internal linkage */
static int y; /* OK, y still has internal linkage */
int y;        /* ERROR, y has internal linkage */

extern int z; /* z has external linkage */
extern int z; /* OK, z still has external linkage */
int z;        /* OK, z still has external linkage */
static int z; /* ERROR, z has external linkage */

int w;        /* w has external linkage */
extern int w; /* OK, w still has external linkage */
int w;        /* OK, w still has external linkage */
static int w; /* ERROR, w has external linkage */

In order to get sparse to issue the correct errors, a lot more
code would be needed. I'm sure I could add the necessary code
eventually, but it would be better for someone who understands
the code better than me to implement this...

I prefer to provide solutions, but in this case I will have to
make do with just reporting the issue :(

Random question: I noticed the preprocessor symbols were defined
frequently; every call to preprocess() in fact: is this intended?

HTH

ATB
Ramsay Jones

P.S. I've attached extern-test.c so you can try it out yourself.
I've tried it with 5 different compilers and the results are
very uneven! Older versions of gcc (circa 3.4) don't get it
completely correct, for example.




--------------050806070605050507090105
Content-Type: text/plain;
 name="extern-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extern-test.c"


int f(void) { extern float g(int); return 0; }
int g(void) { return -1; } /* ERROR, conflicting type for g() */
int h(void) { extern double g(void); return 0; }  /* ditto */

int x;  /* the extern decl. below conflicts with this x, not param */
int k(int x)
{
	{ extern float x; x=1; }  /* ERROR, conflicting type for x */
	return x;  /* this is the parameter x */
}

static int y; /* y has internal linkage */
extern int y; /* OK, y still has internal linkage */
static int y; /* OK, y still has internal linkage */
int y;        /* ERROR, y has internal linkage */

extern int z; /* z has external linkage */
extern int z; /* OK, z still has external linkage */
int z;        /* OK, z still has external linkage */
static int z; /* ERROR, z has external linkage */

int w;        /* w has external linkage */
extern int w; /* OK, w still has external linkage */
int w;        /* OK, w still has external linkage */
static int w; /* ERROR, w has external linkage */


--------------050806070605050507090105
Content-Type: text/plain;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"


extern __inline__ int f(int);

extern __inline__ int
f(int x)
{
	return x;
}


--------------050806070605050507090105--

