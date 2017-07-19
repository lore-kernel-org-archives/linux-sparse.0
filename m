From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] pre-process: replace use of vla's with heap allocation
Date: Wed, 19 Jul 2017 21:13:48 +0100
Message-ID: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:36414 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755008AbdGSUNv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 16:13:51 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>


The 'selfcheck' make target issues warnings about using vla's in the
pre-processor code, like so:

       CHECK    pre-process.c
  pre-process.c:712:25: warning: Variable length array is used.
  pre-process.c:2019:28: warning: Variable length array is used.

A Makefile change to pass '-Wno-vla' to sparse when processing this
source file (or all source files) may be a better solution than the
one given here.

Replace the use of vla's with heap allocation. This has performance
implications (although it may me safer), due to the dynamic memory
allocation and the zero initialisation of the memory (using calloc).
I have not done any timing measurements to see if this is a problem
in practice.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Chris,

This is the 'obvious' fix-up, with potential performance problems,
that I mentioned yesterday.

With these two patches on top of today's sparse-next (@f976ce2), the
'make selfcheck' is clean for me on Linux (x86_64).

BTW, I have tested today's 'sparse-next' branch on x86_64 Linux and
cygwin (without problems), but not yet i686 Linux.

ATB,
Ramsay Jones

 
 pre-process.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 74414df..0063f8b 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -709,13 +709,16 @@ static int expand(struct token **list, struct symbol *sym)
 	struct ident *expanding = token->ident;
 	struct token **tail;
 	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
-	struct arg args[nargs];
+	struct arg *args = NULL;
 
 	if (expanding->tainted) {
 		token->pos.noexpand = 1;
 		return 1;
 	}
 
+	if (nargs > 0)
+		args = calloc(nargs, sizeof(*args));
+
 	if (sym->arglist) {
 		if (!match_op(scan_next(&token->next), '('))
 			return 1;
@@ -738,6 +741,8 @@ static int expand(struct token **list, struct symbol *sym)
 	(*list)->pos.whitespace = token->pos.whitespace;
 	*tail = last;
 
+	free(args);
+
 	return 0;
 }
 
@@ -2016,9 +2021,12 @@ struct token * preprocess(struct token *token)
 static void dump_macro(struct symbol *sym)
 {
 	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
-	struct token *args[nargs];
+	struct token **args = NULL;
 	struct token *token;
 
+	if (nargs > 0)
+		args = calloc(nargs, sizeof(*args));
+
 	printf("#define %s", show_ident(sym->ident));
 	token = sym->arglist;
 	if (token) {
@@ -2053,6 +2061,8 @@ static void dump_macro(struct symbol *sym)
 		token = next;
 	}
 	putchar('\n');
+
+	free(args);
 }
 
 void dump_macro_definitions(void)
-- 
2.13.0
