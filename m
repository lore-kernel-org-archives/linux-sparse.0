From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compile-i386.c: don't ignore return value of write(2)
Date: Tue, 14 Oct 2014 00:03:31 +0100
Message-ID: <543C5A43.9@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:50175 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751343AbaJMXDd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 13 Oct 2014 19:03:33 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Some versions of gcc (e.g. v4.8.2) complain about ignoring the return
value of a call to the write(2) system call, since the system header
files have marked its declaration with the warn_unused_result attribute.

In order to suppress the compiler warning, check the return value from
'write' and, if it indicates an error (a negative return value), exit
the process using 'die' to display an error message. Replace a second
call to 'write', which does not provoke a compiler warning, with similar
code for consistency.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

This is an (almost) minimal patch to suppress the compiler warning.
You could drop the second hunk (and edit the commit message) if you
prefer an absolutely minimal patch. :-D

ATB,
Ramsay Jones

 compile-i386.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 88169ec..44b72ec 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -732,7 +732,8 @@ static void emit_insn_atom(struct function *f, struct atom *atom)
 			atom->insn,
 			comment[0] ? "\t\t" : "", comment);
 
-	write(STDOUT_FILENO, s, strlen(s));
+	if (write(STDOUT_FILENO, s, strlen(s)) < 0)
+		die("can't write to stdout");
 }
 
 static void emit_atom_list(struct function *f)
@@ -742,9 +743,8 @@ static void emit_atom_list(struct function *f)
 	FOR_EACH_PTR(f->atom_list, atom) {
 		switch (atom->type) {
 		case ATOM_TEXT: {
-			ssize_t rc = write(STDOUT_FILENO, atom->text,
-					   atom->text_len);
-			(void) rc;	/* FIXME */
+			if (write(STDOUT_FILENO, atom->text, atom->text_len) < 0)
+				die("can't write to stdout");
 			break;
 		}
 		case ATOM_INSN:
-- 
2.1.0
