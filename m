From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] show_instruction: tolerate NULL sym for OP_SYMADDR
Date: Tue, 12 Apr 2011 22:31:07 +0200
Message-ID: <4DA4B68B.9000907@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep20.mx.upcmail.net ([62.179.121.40]:36102 "EHLO
	fep20.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056Ab1DLUbS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Apr 2011 16:31:18 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

The corner case addressed by this patch can be triggered, e.g., with
this command (`sparse' can be substituted with `test-linearize' in
which case `-ventry' is not required):

    $ ./sparse -vv -ventry compat/mmap-blob.c
    compat/mmap-blob.c:20:21: error: undefined identifier 'CHUNK'
    compat/mmap-blob.c:21:17: error: undefined identifier 'die'
    compat/mmap-blob.c:22:20: error: undefined identifier 'NULL'
    compat/mmap-blob.c:24:23: error: undefined identifier 'NULL'
    compat/mmap-blob.c:30:31: error: undefined identifier 'CHUNK'
    compat/mmap-blob.c:31:17: error: undefined identifier 'die'
    blob_alloc:
    ep 0xb74f700c: blob_alloc

    .L0xb74ef00c:
    compat/mmap-blob.c:16
        <entry-point>
        # snop.32   VOID -> 0[size]
        # lnop.32   %r1 <- 0[size]
    Segmentation fault    

The problem here is that no semantical meaning is found for `CHUNK'
identifier (sparse emits an error for this properly) so the respective
symbol is stored as a "missing" (NULL) reference in the resulting
semantical tree, connected with OP_SYMADDR instruction.

With described example, we would normally never have encountered this
as the problematic instruction is inactive -- unless we use
"be double-verbose" (-vv) switch.  This makes sparse library output
also such inactive instructions, and when it comes to our OP_SYMADDR,
it does segfault due to NULL pointer dereference.

The underscore convention mimics the usage of other angle-bracketed
labels (namely "<bad_string>" in tokenize.c).

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 linearize.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/linearize.c b/linearize.c
index f2034ce..e29ebe8 100644
--- a/linearize.c
+++ b/linearize.c
@@ -313,6 +313,10 @@ const char *show_instruction(struct instruction *insn)
 		struct symbol *sym = insn->symbol->sym;
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 
+		if (!sym) {
+			buf += sprintf(buf, "<missing_symbol>");
+			break;
+		}
 		if (sym->bb_target) {
 			buf += sprintf(buf, ".L%p", sym->bb_target);
 			break;
-- 
1.7.1
