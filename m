Return-Path: <SRS0=rRy8=AQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05EC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECF72075D
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSiYvAqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGENCb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC3C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so25930027edb.13
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cF8b+JGj0G/772jPhd4SDBLuCY+ZY7XeryhECDKmgiQ=;
        b=DSiYvAqJ292ffXxftZiiOxXHHDlrQZv65oOMqBKwmHJuFA9d1+l2JCi2g7Ayqhvy7Z
         SGe6m+UGfehLT+xxAzJCtM5yzsVqZYpUzGebT/zqUBcbniXcu+xIMgwa+6+nqn9C9KZv
         eNOh6sUGOgAJz9qsaR0Uth8DazhIldDI4DomokY9c455zKpPErWlXXbJbiggp2UuiKma
         lynj4VwfAivWt2LlRDiSVgr93TrWnz3FrFFrFmPfpekn5ilq8aC2iQPwixUaYklRL+11
         du1BiI6te5uLNG/h4EMyorCTA5fIJT5+7cdwwVa/XNZBW3LFasLVQ7gjmCLL9QYxH0aM
         QAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cF8b+JGj0G/772jPhd4SDBLuCY+ZY7XeryhECDKmgiQ=;
        b=YbxIcuNi9yZXqQviG7ifUKMN06XuvNl0usmE2RfY66PedyNTFkDB/8U4e8AKuR8Uym
         h0SMPI8Eo1pB812it+SOs1R+ec0x/aV3isUOoiWAq5bBfXzZE9zqqgyvQvUyAcL/cJRM
         R1GPAuoVGdOQY4tiFm0g7mjN++/x8d/d2p52Jy5k/fdH6tHhEINUhur+rKtqtCs6xepo
         wrbRknghPBVD4sgcLW06QWkTEv6uXWny8l4NviHRBDPfnKtxI8K/bjjiIQgr+Qq3aGgw
         UcOYEVGRYRGBD+/pZ/UPK62LhZhmVYqIlLyLau2Vcsdby9D21GIHfM8Y6cQmyAvCiQOh
         zZIg==
X-Gm-Message-State: AOAM5313SoFo0RBretG+2x9fnCi5YNRwVKHCP5evSClfeEFKQp1BibRv
        yPomS7A0Y9+WOu8wHEXx8JZWgJcW
X-Google-Smtp-Source: ABdhPJzSpTvWgrB5s5MiFWtfIdqUbiTg8jXzVLGXFvZ4be9iWs1m/3qZS34ExGNrGUu6vHUTynxgRQ==
X-Received: by 2002:a05:6402:1d18:: with SMTP id dg24mr51205905edb.33.1593954149558;
        Sun, 05 Jul 2020 06:02:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:a542:d3fb:b75a:dec5])
        by smtp.gmail.com with ESMTPSA id x16sm19535945edr.52.2020.07.05.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:02:29 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/15] options: move -Wsparse-all's processing out of handle_onoff_switch()
Date:   Sun,  5 Jul 2020 15:02:07 +0200
Message-ID: <20200705130220.26230-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200705130207.qoFHeF-ei0V6dQOq6WQvmJZ_C8mbNigkRlGUYNYu9Fw@z>

Since handle_onoff_switch() can be used for other flags than the
warnings, the processing of -Wsparse-all should move elsewhere.

So move it into handle_switch_W().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib.c b/lib.c
index 709dd5176112..5128a5b64e9e 100644
--- a/lib.c
+++ b/lib.c
@@ -535,14 +535,6 @@ static char **handle_onoff_switch(char *arg, char **next, const struct flag warn
 	char *p = arg + 1;
 	unsigned i;
 
-	if (!strcmp(p, "sparse-all")) {
-		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
-				*warnings[i].flag = WARNING_ON;
-		}
-		return NULL;
-	}
-
 	// Prefixes "no" and "no-" mean to turn warning off.
 	if (p[0] == 'n' && p[1] == 'o') {
 		p += 2;
@@ -798,6 +790,14 @@ static char **handle_switch_W(char *arg, char **next)
 	if (ret)
 		return ret;
 
+	if (!strcmp(arg, "Wsparse-all")) {
+		int i;
+		for (i = 0; warnings[i].name; i++) {
+			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
+				*warnings[i].flag = WARNING_ON;
+		}
+	}
+
 	// Unknown.
 	return next;
 }
-- 
2.27.0

