From: Martin Nagy <mnagy@redhat.com>
Subject: [PATCH] Print an error if typeof() lacks an argument
Date: Sat, 25 Apr 2009 13:03:43 +0200
Message-ID: <20090425130343.3df87cbb@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39150 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbZDYLDq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Apr 2009 07:03:46 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n3PB3iNI021254
	for <linux-sparse@vger.kernel.org>; Sat, 25 Apr 2009 07:03:45 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n3PB3iN7006843
	for <linux-sparse@vger.kernel.org>; Sat, 25 Apr 2009 07:03:44 -0400
Received: from notas (vpn-10-14.str.redhat.com [10.32.10.14])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n3PB3hoC013253
	for <linux-sparse@vger.kernel.org>; Sat, 25 Apr 2009 07:03:43 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


We weren't checking if the initializer isn't NULL, which caused sparse
to segfault later on when performing lazy evaluation in classify_type().

Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
---
 parse.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/parse.c b/parse.c
index 9662122..18cfaef 100644
--- a/parse.c
+++ b/parse.c
@@ -924,12 +924,17 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
-		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
-		token = parse_expression(token->next, &typeof_sym->initializer);
