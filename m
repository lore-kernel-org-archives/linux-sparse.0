Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A49C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D0E2089D
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2o/TEJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGMWdS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGMWdQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:16 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09622C08C5DD
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a1so9734619edt.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5VuQJWO6epFKSIA5jo6jeiqlwweo8XLjawSGp92FRM=;
        b=t2o/TEJMfvweG07+cUxpWtv+QEvz5qoCXu62SpoQXnotfYwd5n3jepP78i7X8/wi/r
         MGAA9WgUdgG7ztl+jTdyPjYcFCQVNjvwwZRMQ/YZgfBNddhh2wSK3c0uqerJufqkjxpF
         rIhxjUR1wzyrWScnMciQ46ytjcr1Q547XxoGlvQKy+z4W6os4W5yaP8VQeFepqKHkgsU
         gnR5CWIIBCIL8mzOBpEvCAbu/8MTZd9/TvZMdTdQqikJzfbl0mcUNCgC+sK8kejph5Ve
         JQ1FPSgoKTA2aQuSepKIZR7MlxH6VX4RL6pXZ6+SGOmrwpkNo6ArH+Pf6lxO2BjQZ+/7
         3z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5VuQJWO6epFKSIA5jo6jeiqlwweo8XLjawSGp92FRM=;
        b=CTTuH6Uj0RuGkKlpd1uUpxfG4RMHf290U4a98PMQas0ba1RU++oT7o3HRv4r+HNJkR
         QODGSm0EimyyNnVeLB90Q5GQyb8X1xEN4UK2c2oNmG0QsryNFdMx0UsIQcXRO8uIZPXC
         iGBawzAgjlzqMR7Nc2vCJdaRgZCn25WxY+EC62fIIa2ied3eJj1dYZCd4tcmHiEP+i5p
         723RY+K4Y83ggk3P1uWbqzjUXl4Wd+1Fo7pRXIzbi3nzjaYwpUZjs3YgCQJ6iD7PdGUG
         IuTUDZlC3W7J1Cwb3NDvf9X57lox4R4sgNdacpNRBBPh/4PzkvRMcIR6tj5/o7II/Oty
         pOZQ==
X-Gm-Message-State: AOAM532y6QzgX+Ww94P1Nr8499kJCa98VlTihiL5vITWhtCBRF4xb2sm
        RUTuSRwLjIPEThQpMehqPvZfW/9B
X-Google-Smtp-Source: ABdhPJz5YzKqp1+OtiyNPpCpGUusMMxOE5tUGGe3U7s58xfYhQuPJ88P8ekrvovtnRngaPtIZiZxkA==
X-Received: by 2002:a50:ee8d:: with SMTP id f13mr1496587edr.302.1594679594548;
        Mon, 13 Jul 2020 15:33:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] x86-x32: fix it by defining a separate target for it
Date:   Tue, 14 Jul 2020 00:33:02 +0200
Message-Id: <20200713223304.83666-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On x86-64, the x32 ABI was processed as a kind of special case
of the usual 32-bit variant. But this doesn't work very well.

Fix it and help avoiding possible future problems by defining
a separate target for it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-x86.c | 32 ++++++++++++++++++++++++++++++++
 target.c     | 11 ++++++++---
 target.h     |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/target-x86.c b/target-x86.c
index e69594edac0e..b7ff8f2ab4ed 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -67,6 +67,37 @@ const struct target target_i386 = {
 };
 
 
+static void init_x86_x32(const struct target *target)
+{
+	init_x86_common(target);
+
+	max_int_alignment = 8;
+
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+	wchar_ctype = &long_ctype;
+}
+
+static const struct target target_x86_x32 = {
+	.mach = MACH_X86_64,
+	.bitness = ARCH_X32,
+	.big_endian = 0,
+	.unsigned_char = 0,
+	.has_int128 = 1,
+
+	.bits_in_longdouble = 128,
+	.max_fp_alignment = 16,
+
+	.target_32bit = &target_i386,
+	.target_64bit = &target_x86_64,
+
+	.init = init_x86_x32,
+	.predefine = predefine_x86_64,
+};
+
+
 static void init_x86_64(const struct target *target)
 {
 	init_x86_common(target);
@@ -124,6 +155,7 @@ const struct target target_x86_64 = {
 	.max_fp_alignment = 16,
 
 	.target_32bit = &target_i386,
+	.target_x32bit = &target_x86_x32,
 
 	.init = init_x86_64,
 	.predefine = predefine_x86_64,
diff --git a/target.c b/target.c
index 308386b8fa7d..8ae22d744f40 100644
--- a/target.c
+++ b/target.c
@@ -213,10 +213,17 @@ void target_init(void)
 	const struct target *target = arch_target;
 
 	switch (arch_m64) {
+	case ARCH_X32:
+		if (target->target_x32bit)
+			target = target->target_x32bit;
+		goto case_32bit;
+
 	case ARCH_LP32:
 		max_int_alignment = 4;
+		if (target->target_32bit)
+			target = target->target_32bit;
 		/* fallthrough */
-	case ARCH_X32:
+	case_32bit:
 		bits_in_long = 32;
 		bits_in_pointer = 32;
 		pointer_alignment = 4;
@@ -228,8 +235,6 @@ void target_init(void)
 		uintmax_ctype = &ullong_ctype;
 		fast64_ctype = &llong_ctype;
 		ufast64_ctype = &ullong_ctype;
-		if (target->target_32bit)
-			target = target->target_32bit;
 		break;
 
 	case ARCH_LLP64:
diff --git a/target.h b/target.h
index 8ffd8e882906..92b8af9169d7 100644
--- a/target.h
+++ b/target.h
@@ -92,6 +92,7 @@ struct target {
 	unsigned int	max_fp_alignment;
 
 	const struct target *target_32bit;
+	const struct target *target_x32bit;
 	const struct target *target_64bit;
 
 	const struct builtin_fn *builtins;
-- 
2.27.0

