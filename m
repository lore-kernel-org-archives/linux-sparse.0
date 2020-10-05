Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D82C4363C
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8012F2074F
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOiONhfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJECAN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECAN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AFEC061787
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so7703091wrw.11
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxhPmAqPArGssF1zP8+xwULOvnoGBLqwv1doNDi1zGs=;
        b=pOiONhfh5x2nH1FFCHoEPT1SCyB9gihG8mZ+/4Yc8dIHNQsVui5vVZeXetOukejUbI
         kZRBCMPubvTch/AJMVB9Kn/pyK/O5ah8x1nB3Lpk7j1XHH0D/oj/1h+iC6ogVTqRyYO0
         tZdgj1T2IdqABxMcSD+wS6ZU0REwBAD63H1fPuRWcUgP6ruGGYBu1QU0CsywvDkbvPBu
         JG+JvQTzW00KImotgu2wRYZCIfE+1ePEwV0y/QHZQypbr5x+aoOnJplAYLsu5vGPdlfy
         sqQOzCeh4zuzSQvTgvbmfGlSk+LUKpIXwOLcFMAh1OKdHbsjynISVHcxxF01W7X/IIDu
         t2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxhPmAqPArGssF1zP8+xwULOvnoGBLqwv1doNDi1zGs=;
        b=HFCQPxX3h30zGK6d1+JejsZNf/tmypBI9O3nQgjYwJJyJX/ub1Bnl/RJfgqL9+/C5h
         fDXTgSQ7eCSJBy5qZFXbPQapbYvnJ/FjHwj2KbDe3Vs1EpU78mpxAsLCVDyfxGrGas1D
         ikJ6xWWR10nG/z3asCeLcwdY09pt0IdzAeA1s7yEHzA4IqH868XF3gE2PU6CyBQD54fE
         ilTZsPl/YMRVdHyvpJH4Ijo/TmUjG2Vdi2uIbSds1zd3NeI8DSaVzVLZ1NB/4OIjQyNQ
         krywxbRF4RKViu1ZmXLxh7gFw2JkTaT5xU7+Z/ybeVAP9Z6Ldyxt0KX/0zDl8OgCnONY
         OQow==
X-Gm-Message-State: AOAM531Ps5JUEmAWntVdn7lKbu9OJdViadWbD5e7IrvzkA1E25UymOMG
        0zzwZ2KqRnb8CNlmpc3UpEz9g1zgEHY=
X-Google-Smtp-Source: ABdhPJyczHkjCrBB8n9TP18JVp8U2fjWeWzcPHsvE37l0Pb8pdsE0nf5xhlppCZKDafdKvqiqYsKUg==
X-Received: by 2002:adf:f885:: with SMTP id u5mr14214307wrp.382.1601863211041;
        Sun, 04 Oct 2020 19:00:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] parse format attribute less verbosely
Date:   Mon,  5 Oct 2020 03:59:58 +0200
Message-Id: <20201005020002.1108-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The error handling in the parsing of the format attribute is a bit too
verbose and to strict:
*) the message "only printf format attribute supported" is just noise
   for any file using 'format(scanf, ...)' when -Wformat is set
   and is not needed if -Wformat is disabled, so remove it.
*) the message "incorrect format attribute" is not needed because
   any parsing error will already be reported.
OTOH, it is useful to check that the first argument is an identifier,
so check this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/parse.c b/parse.c
index c2d29318149f..55cca01ec381 100644
--- a/parse.c
+++ b/parse.c
@@ -1215,17 +1215,18 @@ static int invalid_format_args(long long start, long long at)
 static struct token *attribute_format(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct expression *args[3];
-	struct symbol *fmt_sym = NULL;
+	int type = FMT_UNKNOWN;
 
 	/* expecting format ( type, start, va_args at) */
 
 	token = expect(token, '(', "after format attribute");
-	if (token_type(token) == TOKEN_IDENT)
-		fmt_sym = lookup_keyword(token->ident, NS_KEYWORD);
-	if (fmt_sym)
-		if (!fmt_sym->op || fmt_sym->op->type != KW_FORMAT)
-			fmt_sym = NULL;
-
+	if (token_type(token) != TOKEN_IDENT) {
+		sparse_error(token->pos, "identifier expected for format type");
+	} else {
+		struct symbol *sym = lookup_keyword(token->ident, NS_KEYWORD);
+		if (sym && sym->op && sym->op->type == KW_FORMAT)
+			type = sym->op->class;
+	}
 	token = conditional_expression(token, &args[0]);
 	token = expect(token, ',', "format attribute type");
 	token = conditional_expression(token, &args[1]);
@@ -1233,11 +1234,10 @@ static struct token *attribute_format(struct token *token, struct symbol *attr,
 	token = conditional_expression(token, &args[2]);
 	token = expect(token, ')', "format attribute arg position");
 
-	if (!fmt_sym || !args[0] || !args[1] || !args[2]) {
-		warning(token->pos, "incorrect format attribute");
-	} else if (fmt_sym->op->class != FMT_PRINTF) {
-		/* skip anything that isn't printf for the moment */
-		warning(token->pos, "only printf format attribute supported");
+	if (!args[0] || !args[1] || !args[2]) {
+		// incorrect format attribute
+	} else if (type != FMT_PRINTF) {
+		// only printf-style is supported, skip anything else
 	} else {
 		long long start, at;
 
-- 
2.28.0

