Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA10C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1947320720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnG9ACYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHWZf (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWZf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 18:25:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5AC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 15:25:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so260227edv.6
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEV25Ugnd/QNL5vyqk+GfmnAzH/CfumLCfZsdl6hVaA=;
        b=VnG9ACYUDUqyjTBjDr2L4UPRz42pgh5Dpw9ufhdatp9ME7apfqfp8IHdnROqXJFIGi
         bLgACzT8y1zzrhC4uQJ+MRKXkbxcUVlfN99JjTwm04EB70NMSSOhx5Q2iwdhaLys9961
         zNNWHcYn5BukN8TxtsOhrrWyU+l8ub5FYEOkFmBOrpB2gtWBv1YMT1yD2DEDNv7DNJ48
         rtjrEpoCvzFqmlrjNyjvX6hOt+QHSSQqskva7l5OXSX+twjeE2HI3B4QDPrmymjBKljn
         iT1lUaxS7kugWPp4GFLVVlk9qXFj8MS/Cy/X5FM4W+WrB6J9o8LhJCdFGhVZkq0whzJB
         rsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JEV25Ugnd/QNL5vyqk+GfmnAzH/CfumLCfZsdl6hVaA=;
        b=g79WDpSaTtUrHJMu1j6uUZ8pElZ42cSIf1GDP68Viw+z9b6xvTG8vq23vuBPW7iTgk
         lPQl4n4EDlDX1EpkC4evL4d/PBPRw3v+JXfu71VdzaiCplNUUF3yTr3w91CwjCqTRmKY
         foak9CS8CjKrcqUDl/56IdggbVrw26AicRHFSjzHVdk1cQ9hl49mCFFGQWmCN4zVRmsY
         czWkRNnearb6EthnaZZmWPfY93DDROnG92J6yNdVKq8A2cLwz87xI3q2HMDt/kiXh4ua
         nKiMgkULGEXcuxDttKYDW4QXhyvC3kSAZUVyuZx15CAuUmkD010YnJV8MzqONog0nTQk
         3YIw==
X-Gm-Message-State: AOAM533FV0sHjA42jvJJq64AQBl2p03xzj3tOn6RBXn1c4vzliKS1uz2
        b6RZvke6fNRIe2+tAkXp6nU+lbwv
X-Google-Smtp-Source: ABdhPJxg1TWs1dt6OFl5wKqBGIyar8cusLggq8VKYlCZa0QA4h6yVocVP1ei3SQvPVtMWK7R7kiYLw==
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr66336013edj.93.1594247133369;
        Wed, 08 Jul 2020 15:25:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id a1sm506654ejk.125.2020.07.08.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:25:32 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] target: keep tables sorted
Date:   Thu,  9 Jul 2020 00:24:10 +0200
Message-Id: <20200708222410.56854-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target.c b/target.c
index 6776c3a1cbb0..e512f7f1b618 100644
--- a/target.c
+++ b/target.c
@@ -60,9 +60,9 @@ static const struct target *targets[] = {
 	[MACH_ALPHA] =		&target_alpha,
 	[MACH_ARM] =		&target_arm,
 	[MACH_ARM64] =		&target_arm64,
-	[MACH_I386] =		&target_i386,
 	[MACH_BFIN] =		&target_bfin,
-	[MACH_X86_64] =		&target_x86_64,
+	[MACH_I386] =		&target_i386,
+	[MACH_M68K] =		&target_m68k,
 	[MACH_MICROBLAZE] =	&target_microblaze,
 	[MACH_MIPS32] =		&target_mips32,
 	[MACH_MIPS64] =		&target_mips64,
@@ -75,7 +75,7 @@ static const struct target *targets[] = {
 	[MACH_S390X] =		&target_s390x,
 	[MACH_SPARC32] =	&target_sparc32,
 	[MACH_SPARC64] =	&target_sparc64,
-	[MACH_M68K] =		&target_m68k,
+	[MACH_X86_64] =		&target_x86_64,
 	[MACH_UNKNOWN] =	&target_default,
 };
 const struct target *arch_target = &target_default;
@@ -91,8 +91,8 @@ enum machine target_parse(const char *name)
 		{ "aarch64",	MACH_ARM64,	64, },
 		{ "arm64",	MACH_ARM64,	64, },
 		{ "arm",	MACH_ARM,	32, },
-		{ "i386",	MACH_I386,	32, },
 		{ "bfin",	MACH_BFIN,	32, },
+		{ "i386",	MACH_I386,	32, },
 		{ "m68k",	MACH_M68K,	32, },
 		{ "microblaze",	MACH_MICROBLAZE,32, },
 		{ "mips",	MACH_MIPS32,	0,  },
-- 
2.27.0

