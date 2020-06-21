From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] evaluate.c: fix a gcc 'may be used uninitialized' warning
Date: Sun, 21 Jun 2020 20:34:31 +0100
Message-ID: <b3ff0d78-ceea-768e-339c-22466b84b81d@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:51755 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgFUTee (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Jun 2020 15:34:34 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Luc,

Thanks for v0.6.2! :-D

However, I am seeing a gcc compiler warning:

    CC      evaluate.o
  evaluate.c: In function ‘evaluate_generic_selection’:
  evaluate.c:3310:38: warning: ‘base’ may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (base->type == SYM_ARRAY && base->array_size) {
                                    ~~~~^~~~~~~~~~~~

This patch is just an FYI/quick-fix for this warning. The patch
I wanted to send, moved the declaration of the base symbol into
a new block at the 'if (stype->type == SYM_NODE)' conditional,
which would now include the (indented) SYM_ARRAY conditional
block. This, of course, meant that the SYM_ARRAY conditional was
indented too far to the right ... ;-)

[perhaps this argues for that code to be refactored into a function]

Thanks!

ATB,
Ramsay Jones


 evaluate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index aa0f2080..19a15ca3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3299,7 +3299,7 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 	source.ctype.modifiers &= ~(MOD_QUALIFIER|MOD_ATOMIC);
 	for (map = expr->map; map; map = map->next) {
 		struct symbol *stype = map->type;
-		struct symbol *base;
+		struct symbol *base = NULL;
 
 		if (!evaluate_symbol(stype))
 			continue;
@@ -3307,7 +3307,7 @@ static struct symbol *evaluate_generic_selection(struct expression *expr)
 		if (stype->type == SYM_NODE)
 			base = stype->ctype.base_type;
 
-		if (base->type == SYM_ARRAY && base->array_size) {
+		if (base && base->type == SYM_ARRAY && base->array_size) {
 			get_expression_value_silent(base->array_size);
 			if (base->array_size->type == EXPR_VALUE)
 				continue;
-- 
2.27.0
