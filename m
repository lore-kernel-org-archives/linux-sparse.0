From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 04/10] compile-i386.c: don't mix calls to write(2) with stdio
Date: Mon, 04 Aug 2014 19:36:39 +0100
Message-ID: <53DFD2B7.7080801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:36018 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbaHDShH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:37:07 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 558886F8C76
	for <linux-sparse@vger.kernel.org>; Mon,  4 Aug 2014 18:00:26 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Some versions of gcc (e.g. v4.8.2) complain about ignoring the return
value of a call to 'write(2)' on line 735, since it is marked with
the warn_unused_result attribute. (see also lines 745-747).

Note that this code is mixing calls to 'write' on STDOUT_FILENO with
calls to stdio functions on the stdout file handle. So, in order to
suppress the compiler warnings, we replace both calls to 'write' with
equivalent calls to stdio functions.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

Since there are no tests for the compile program, I ran the old version
(from commit 748b856) and this version over all of the .c files in the
sparse directory, saving the output to file and diff-ing the result.
Unfortunately, compile segfaults on most files and the diff shows that
this patch leads to a change in behaviour, caused by the lack of I/O
buffer flushing prior to the segfault (all of the diffs showed missing 
text at the end of each new output file).

Just to confirm, I added back the 'fflush(stdout); ...' line that I
removed in the third hunk below _and_ duplicated that line and placed
it after the call to 'emit_atom_list(f);'. This version of compile
produced (almost) exactly the same output as the original.

The reason for the almost is that three files showed a non-empty diff
which seemed to indicate (a possible bug?) that a label name was being
generated from a memory address. The actual addresses/label name
generated in each file was different, but they were used consistently
in each file. For example, the complete diff for sort.c is:

    --- sort.c.out-old	2014-08-04 17:32:32.399744973 +0100
    +++ sort.c.out-new	2014-08-04 17:37:04.189092702 +0100
    @@ -742,7 +742,7 @@
     	addl	$744, %esp
     	ret	
     	.size	merge_block_seqs, .-merge_block_seqs
    -.L0xb740550c:
    +.L0xb748068c:
     .globl sort_list
     	.type	sort_list, @function
     sort_list:
    @@ -837,7 +837,7 @@
     	movl	%eax, 68(%esp)		# .... end copy
     	jmp	.L72
     .L87:					# end if
    -	jmp	.LS0xb740550c
    +	jmp	.LS0xb748068c
     .L86:					# end if
     	movl	44(%esp), %eax		# begin copy ..
     	movl	%eax, 72(%esp)		# .... end copy

ATB,
Ramsay Jones

 compile-i386.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 88169ec..f89b6ca 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -732,7 +732,7 @@ static void emit_insn_atom(struct function *f, struct atom *atom)
 			atom->insn,
 			comment[0] ? "\t\t" : "", comment);
 
-	write(STDOUT_FILENO, s, strlen(s));
+	printf("%s", s);
 }
 
 static void emit_atom_list(struct function *f)
@@ -742,9 +742,7 @@ static void emit_atom_list(struct function *f)
 	FOR_EACH_PTR(f->atom_list, atom) {
 		switch (atom->type) {
 		case ATOM_TEXT: {
-			ssize_t rc = write(STDOUT_FILENO, atom->text,
-					   atom->text_len);
-			(void) rc;	/* FIXME */
+			printf("%.*s", (int)atom->text_len, atom->text);
 			break;
 		}
 		case ATOM_INSN:
@@ -886,7 +884,6 @@ static void emit_func_post(struct symbol *sym)
 	insn("ret", NULL, NULL, NULL);
 
 	/* output everything to stdout */
-	fflush(stdout);		/* paranoia; needed? */
 	emit_atom_list(f);
 
 	/* function footer */
-- 
2.0.0
