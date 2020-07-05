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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB793C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8650E2070B
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV0kYtma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGENCf (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D9C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so39593499ejj.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhOexs42tN8O73J1HULhVDqy4cxDIEcuMkt/q9iXBcE=;
        b=cV0kYtmaDWh1jNMbRL7NpL1ephDsNrHZEIxo58PH8UtptqsdOSw2/zWEtlSvakfM3M
         tLjiiWAKxWicA/Uaxp1lelLnHk4ciLlZ9CF1uy57nY58JWtXbIklHaQcv1XGdUNgAGJ/
         JLSKlVRE/szK3sVHvesEQ8Nwg+pmz7074+q8Sw7NCGKG7alFTVk0xDxYmnQDpUAeFU1I
         Lm58ZyzbUisL+imyV/vbue3Dvv3vB0vyCRNsGzMYIJtl4CLGxCB0amvRmTI9YOPdxrJX
         +3Hsbnub+VFpcM7hsc3URN39xwQFbOga/l3mbQkKP219yZbAqVEOXe/PhCMnXUwXemIN
         rteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhOexs42tN8O73J1HULhVDqy4cxDIEcuMkt/q9iXBcE=;
        b=fDZmIEaG9VXvJYLQ7APMvFlKR0ZK+CH73rF6pi+uJsE3xp2CTi7263l4bQuiv5A3of
         iflRdSuCHxeGRXQoMCxoXDumT2MvIrvn5zhL43ffdKrwcLyQS6C3m07FUbuTbyeBvIz2
         3qq6zd9v95p338VUq7+jHuGZisoDq8FdqXjto1KBtHBZKe6uhpbEnOlDo6rxcifFWpjr
         e656xRxk9/aXyvKpDJTufmN/ATo8nPgCGgxHg2pDZ1Dbn+oKs8tIVPIZQY7lrOFQ2phr
         vwXZmHXsAIeQJI4g2orTU0XzLR7RfVOKDKMT+OcXmcpoFCTuTTyhG+8CeWox3X7t/Icy
         sbfA==
X-Gm-Message-State: AOAM532Lc+D0xGgBSdpOv3jQaZYjB/6fB9oSTJixWoT/5CLuth4x39Ps
        aAjXmx3UMTw9w7AF7USHlDwxbto6
X-Google-Smtp-Source: ABdhPJxLthPCH4DIWOJYBFpTFPieUOo0PNNhGaIn1yqd51hMmAZO5tv3KmiGonBqhjahWCIgBCDa0w==
X-Received: by 2002:a17:906:3a17:: with SMTP id z23mr30203297eje.238.1593954153219;
        Sun, 05 Jul 2020 06:02:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:a542:d3fb:b75a:dec5])
        by smtp.gmail.com with ESMTPSA id x16sm19535945edr.52.2020.07.05.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:02:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/15] options: move helpers up
Date:   Sun,  5 Jul 2020 15:02:11 +0200
Message-ID: <20200705130220.26230-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200705130211.qWGV8P4vZuFg5YZQAm1kbI_2qVgXor41k2vAr-Wdu4Q@z>

The helpers for parsing the options are often situated just above the
first function using them. As result, these helpers can be found a bit
everywhere in the code, it's messy and doesn't help to reuse these helpers.

So, move all these helpers to the top.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 87 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/lib.c b/lib.c
index c27773097127..4868154fa3de 100644
--- a/lib.c
+++ b/lib.c
@@ -364,6 +364,15 @@ void add_pre_buffer(const char *fmt, ...)
 ////////////////////////////////////////////////////////////////////////////////
 // Helpers for option parsing
 
+static const char *match_option(const char *arg, const char *prefix)
+{
+	unsigned int n = strlen(prefix);
+	if (strncmp(arg, prefix, n) == 0)
+		return arg + n;
+	return NULL;
+}
+
+
 struct val_map {
 	const char *name;
 	int val;
@@ -438,14 +447,6 @@ end:
 }
 
 
-static const char *match_option(const char *arg, const char *prefix)
-{
-	unsigned int n = strlen(prefix);
-	if (strncmp(arg, prefix, n) == 0)
-		return arg + n;
-	return NULL;
-}
-
 #define OPT_INVERSE	1
 #define OPT_VAL		2
 struct flag {
@@ -497,6 +498,41 @@ static int handle_switches(const char *ori, const char *opt, const struct flag *
 	return 0;
 }
 
+static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
+{
+	int flag = FLAG_ON;
+	char *p = arg + 1;
+	unsigned i;
+
+	// Prefixes "no" and "no-" mean to turn warning off.
+	if (p[0] == 'n' && p[1] == 'o') {
+		p += 2;
+		if (p[0] == '-')
+			p++;
+		flag = FLAG_FORCE_OFF;
+	}
+
+	for (i = 0; flags[i].name; i++) {
+		if (!strcmp(p,flags[i].name)) {
+			*flags[i].flag = flag;
+			return next;
+		}
+	}
+
+	// Unknown.
+	return NULL;
+}
+
+static void handle_onoff_switch_finalize(const struct flag flags[])
+{
+	unsigned i;
+
+	for (i = 0; flags[i].name; i++) {
+		if (*flags[i].flag == FLAG_FORCE_OFF)
+			*flags[i].flag = FLAG_OFF;
+	}
+}
+
 static int handle_switch_setval(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	*(flag->flag) = flag->mask;
@@ -529,31 +565,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-static char **handle_onoff_switch(char *arg, char **next, const struct flag flags[])
-{
-	int flag = FLAG_ON;
-	char *p = arg + 1;
-	unsigned i;
-
-	// Prefixes "no" and "no-" mean to turn warning off.
-	if (p[0] == 'n' && p[1] == 'o') {
-		p += 2;
-		if (p[0] == '-')
-			p++;
-		flag = FLAG_FORCE_OFF;
-	}
-
-	for (i = 0; flags[i].name; i++) {
-		if (!strcmp(p,flags[i].name)) {
-			*flags[i].flag = flag;
-			return next;
-		}
-	}
-
-	// Unknown.
-	return NULL;
-}
-
 ////////////////////////////////////////////////////////////////////////////////
 // Option parsing
 
@@ -858,16 +869,6 @@ static char **handle_switch_d(char *arg, char **next)
 }
 
 
-static void handle_onoff_switch_finalize(const struct flag flags[])
-{
-	unsigned i;
-
-	for (i = 0; flags[i].name; i++) {
-		if (*flags[i].flag == FLAG_FORCE_OFF)
-			*flags[i].flag = FLAG_OFF;
-	}
-}
-
 static void handle_switch_W_finalize(void)
 {
 	handle_onoff_switch_finalize(warnings);
-- 
2.27.0

