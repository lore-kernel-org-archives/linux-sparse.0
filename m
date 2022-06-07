Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCCDC43334
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Jun 2022 12:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiFGMzD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiFGMyu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jun 2022 08:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF979829
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 05:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 038B76127C
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 12:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02B4C34119;
        Tue,  7 Jun 2022 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654606488;
        bh=WN6NWmBZIllTeb1jiiQL2rQo5tYCpIXKwG2UgqQlWdE=;
        h=From:To:Cc:Subject:Date:From;
        b=n4G9R6uV6EcsbF6eykKoTX5oBiGCEvroj4pfBFOooRBWj1+IYF+TwLDlpBP39/voQ
         5MK4Q2+8g7hCsbLNchU/OUxQXrqvyBph0RAV2WwcAnn8dv320MqKvEIW3hvkGqpirC
         MwBEpX6yr5YjizTk0rcIejwH54tbK4KnR5tCVhCSoeZVaEPPixVutm63qANXSgDM4z
         +Bwgm+7fTyRmeG+8H7zv9Q/07KEWd51W7f7kaRnVP30pG2OlsipM8daEzSDaRPLkik
         GdZ+36G0wDO1sgCiOB+b3HntfHqesN9nYKjDsDsXB3H+eJJgvG6ygk3xqs/ZNxRCqI
         kknUyVxhR/eKw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] allow show_token() on TOKEN_ZERO_IDENT
Date:   Tue,  7 Jun 2022 14:54:41 +0200
Message-Id: <20220607125441.36757-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

TOKEN_ZERO_IDENTs are created during the evaluation of pre-processor
expressions but which otherwise are normal idents and  were first tokenized
as TOKEN_IDENTs.

As such, they could perfectly be displayed by show_token() but are not.
So, in error messages they are displayed as "unhandled token type '4'",
which is not at all informative.

Fix this by letting show_token() process them like usual TOKEN_IDENTs.
Idem for quote_token().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 tokenize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tokenize.c b/tokenize.c
index ea7105438270..fdaea370cc48 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -201,6 +201,7 @@ const char *show_token(const struct token *token)
 		return "end-of-input";
 
 	case TOKEN_IDENT:
+	case TOKEN_ZERO_IDENT:
 		return show_ident(token->ident);
 
 	case TOKEN_NUMBER:
@@ -259,6 +260,7 @@ const char *quote_token(const struct token *token)
 		return "syntax error";
 
 	case TOKEN_IDENT:
+	case TOKEN_ZERO_IDENT:
 		return show_ident(token->ident);
 
 	case TOKEN_NUMBER:
-- 
2.36.1

