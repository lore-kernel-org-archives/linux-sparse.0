From: Martin Nagy <nagy.martin@gmail.com>
Subject: Re: [PATCH] Print an error if typeof() lacks an argument
Date: Sat, 25 Apr 2009 13:11:17 +0200
Message-ID: <20090425131117.30242d75@notas>
References: <20090425130343.3df87cbb@notas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/7RXM16HfH._34LiLd8+3TOH"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:36125 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZDYLLW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 Apr 2009 07:11:22 -0400
Received: by ewy24 with SMTP id 24so1392485ewy.37
        for <linux-sparse@vger.kernel.org>; Sat, 25 Apr 2009 04:11:21 -0700 (PDT)
In-Reply-To: <20090425130343.3df87cbb@notas>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--MP_/7RXM16HfH._34LiLd8+3TOH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Martin Nagy wrote:
> 
> We weren't checking if the initializer isn't NULL, which caused sparse
> to segfault later on when performing lazy evaluation in classify_type().
> 
> Signed-off-by: Martin Nagy <nagy.martin@gmail.com>

I accidentally sent this from my work email address, which is
different than the sign-off address, sorry. I'm not sure if that's
an issue, but just to make sure, I'm sending the patch again.

Martin
--MP_/7RXM16HfH._34LiLd8+3TOH
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Print-an-error-if-typeof-lacks-an-argument.patch

From 962e4b1ad3b3cb13c7427d07dfa44cd15af11693 Mon Sep 17 00:00:00 2001
From: Martin Nagy <nagy.martin@gmail.com>
Date: Sat, 25 Apr 2009 12:56:33 +0200
Subject: [PATCH] Print an error if typeof() lacks an argument

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
--MP_/7RXM16HfH._34LiLd8+3TOH--
