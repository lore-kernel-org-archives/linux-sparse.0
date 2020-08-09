Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C8CC433E5
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA718206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn9O2iKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIQw6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgHIQwx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FBC06178C
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l4so7041463ejd.13
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANHELd6C+X/z7tdNkaZSbmW8tUpir67xm/qpHskCSFU=;
        b=Fn9O2iKFANbPso9q5MGbPHjVgw0r2c4U2h7B+DLJokwR+FPQLS25b+a2YnZRPj9oXh
         NXQkcjyHGeBA/Ns253wDOmY982ZoEWcSpvnqFjmQUCnpOAHio0uERbggngXLDWBBRws9
         mfWIdYkErxLTEAAePTLz7pftqch/ZM2Pc/belH35W1Ge7jGFrQ/d453xIlBSwJAEoB9V
         T46Li/Ze8lwuWc6YbX/3KH5ZUxA/FMD6jLxj9zFJY34xxwrGIQxAhJKoIWx0W7dXhYgX
         RB9Hb4WNX1Pn/ZIn4FAUlQKZny1XhNzSik57ukHZw1rbmxeJIGmgSG5A4YUYNi2y1dPH
         NZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANHELd6C+X/z7tdNkaZSbmW8tUpir67xm/qpHskCSFU=;
        b=dR+MUajxZwwrLWJLYUEpF1CSfaHhByES8LQPeygBcuR1nywwAMEzhMKC9Dmfb8UvyL
         rorwNV+l7/F30ISNz9oIW2QFclWoWTMhozDR5Eec4pydwqeA0d8PHlz7N1Axsv/bCgph
         nR0n0adxeM6H1hV78GttvEjrRz5RKVGBdrYwGT3dbQPBH+9rlYh7ccO7V6acQ8e1bQQC
         npQj8hMGmV+UM3AB7Aywj8um5C7IwY06mwTuYpSeizjzAx5o33sD7nuVRYLIYTTyDWG4
         /pbbKjZu1C1SSElea9ZESD/unW0zWuhmSGZqOXlK5aHwubljUYhDgz+K1Sk8/d71Aodx
         oJBQ==
X-Gm-Message-State: AOAM531R5SPjKJgSJagohk96hFiN2biVqLUZJqIvhtQKK1KXT1isALvQ
        3auP79iP5SYToHl08VsixXqA7zYQ
X-Google-Smtp-Source: ABdhPJwR08C7VgOKmoqU7RK0XTMmptYYZhav9DNOXDsW4KJ/BX8IUHSLsge2yMbJjaWYTnk0EGLuNQ==
X-Received: by 2002:a17:906:7787:: with SMTP id s7mr19316183ejm.533.1596991962143;
        Sun, 09 Aug 2020 09:52:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] parse: improve error messages concerning storage specifiers
Date:   Sun,  9 Aug 2020 18:52:28 +0200
Message-Id: <20200809165229.36677-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index fad41d36dda6..92ca1b66e140 100644
--- a/parse.c
+++ b/parse.c
@@ -1382,12 +1382,11 @@ static struct token *storage_specifier(struct token *next, struct symbol *sym, s
 {
 	int is_tls = ctx->ctype.modifiers & MOD_TLS;
 	unsigned long class = sym->ctype.modifiers;
-	const char *storage = modifier_string(class);
+	const char *storage = modifier_name(class);
 
 	/* __thread can be used alone, or with extern or static */
 	if (is_tls && (class & ~(MOD_STATIC|MOD_EXTERN))) {
-		sparse_error(next->pos, "__thread can only be used alone, or with "
-				"extern or static");
+		sparse_error(next->pos, "__thread cannot be used with '%s'", storage);
 		return next;
 	}
 
@@ -1406,8 +1405,8 @@ static struct token *thread_specifier(struct token *next, struct symbol *sym, st
 	if (!(ctx->storage_class & ~(MOD_STATIC|MOD_EXTERN))) {
 		apply_qualifier(&next->pos, &ctx->ctype, MOD_TLS);
 	} else {
-		sparse_error(next->pos, "__thread can only be used alone, or "
-				"with extern or static");
+		sparse_error(next->pos, "__thread cannot be used with '%s'",
+			modifier_name(ctx->storage_class));
 	}
 
 	return next;
-- 
2.28.0

