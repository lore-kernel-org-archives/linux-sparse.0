From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] unify usage of VOID
Date: Sun, 10 Apr 2011 18:24:01 +0200
Message-ID: <4DA1D9A1.3090109@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep15.mx.upcmail.net ([62.179.121.35]:38407 "EHLO
	fep15.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab1DJQYG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Apr 2011 12:24:06 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Also remove unneeded empty initializator of `void_pseudo'.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 linearize.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index f2034ce..46c9726 100644
--- a/linearize.c
+++ b/linearize.c
@@ -33,7 +33,7 @@ struct access_data;
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *);
 static pseudo_t linearize_initializer(struct entrypoint *ep, struct expression *initializer, struct access_data *);
 
-struct pseudo void_pseudo = {};
+struct pseudo void_pseudo;
 
 static struct position current_pos;
 
@@ -1880,7 +1880,7 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		struct basic_block *active;
 		pseudo_t src = linearize_expression(ep, expr);
 		active = ep->active;
-		if (active && src != &void_pseudo) {
+		if (active && src != VOID) {
 			struct instruction *phi_node = first_instruction(bb_return->insns);
 			pseudo_t phi;
 			if (!phi_node) {
-- 
1.7.1
