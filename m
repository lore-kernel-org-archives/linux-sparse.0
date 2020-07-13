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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22631C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F5120B80
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXki18Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMWdO (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGMWdN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA49C08C5DB
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so19279247ejb.4
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ed2f4eQC2SRxZ6Ku5kjy8XqTvSZ3aaiQyf2+FyCFRSA=;
        b=fXki18SpczAdpVLyVqF8inOJsIPoiS0LCKKLsc8t6SAl2UEntA+P1jNnDWaFqxME9c
         t8Otc3l/fAkfBsPE3+GVRtp50UuKhLeOUrHIl2SWOSCRmY9EaFs+VBlAro0zPfSvbC4e
         6XP0D44q6sfp0kUzcE4qd0tm/a/N+YCZxAGhgdM+Bz1u+VTQ+8fs7bnsVGOiHYN422mz
         0YJF6FGF2gRFubzRlgofsHr4XrY3Z8fTHLsrQ04qj+MvQ4t9a02MXX8ts0McbIFhuBnM
         fOmBZd9NFtraJ3T1nzmfAqp6v2A44mpTdXwqQWfWSZboZRijOAWImc+Ws0ap4YyR8cUa
         nTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ed2f4eQC2SRxZ6Ku5kjy8XqTvSZ3aaiQyf2+FyCFRSA=;
        b=X/5a2Kga1+y6hup58Id76LJkrJATMelVi2ZtPiJanJhJ2aZQcA+W6W+eGc1mFd/ZRw
         5qRogTtvwlva1DnUJSEtygl345GIDk5q3Xd2zL/BG9TTJzAeOOQmfBK/ac/d6LXMOXYf
         Q3RvaNuvdILgmzNRNZuhqDsvzmMTJ9Zs6xHYhPIFK0vIOjv31LjARTSCmF5N8+U5W6Bg
         fPcIPKXq+pdB+/yrZ186TAbbht9ovtUTgbvVEMC0yocuw+aoHSPYNEDyjcrAqzsw3xBC
         PXnP9ZrWd5/s2dXRwRCZtUU3qZ78DK21238RZN6p5HDVywpFueeZYuPzcqd4APDDE8+N
         ZroA==
X-Gm-Message-State: AOAM533c5zZRv9cLQK1Cmz1YiWq7n6gF4xjyrvpHXvmdD0H8IVpgiXSk
        nZyLl0VzrpnkZPD/lF/51ulyVSHS
X-Google-Smtp-Source: ABdhPJxNH/kAQ4MwjpFXGzI03zT+Vx4Myj7iTqQ9k1QlTHx4drQ/cR0qjKFWbeBN7tWvqwgWqVTIOA==
X-Received: by 2002:a17:906:3850:: with SMTP id w16mr1884781ejc.205.1594679591243;
        Mon, 13 Jul 2020 15:33:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] arch: add predefines __INT_LEAST${N}_TYPE__
Date:   Tue, 14 Jul 2020 00:32:58 +0200
Message-Id: <20200713223304.83666-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These are used by some system headers (neon on arm64).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c  | 9 +++++++++
 target-x86.c | 2 ++
 target.c     | 8 ++++++++
 target.h     | 8 ++++++++
 4 files changed, 27 insertions(+)

diff --git a/predefine.c b/predefine.c
index 94952e81d1df..062e754bf20f 100644
--- a/predefine.c
+++ b/predefine.c
@@ -145,6 +145,15 @@ void predefined_macros(void)
 	predefined_ctype("INT64",      int64_ctype, PTYPE_MAX|PTYPE_TYPE);
 	predefined_ctype("UINT64",    uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
 
+	predefined_ctype("INT_LEAST8",   &schar_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_LEAST8",  &uchar_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_LEAST16",  &short_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_LEAST16",&ushort_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_LEAST32",   int32_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_LEAST32", uint32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_LEAST64",   int64_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_LEAST64", uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
+
 	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
 	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
 	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
diff --git a/target-x86.c b/target-x86.c
index 62323aecc52b..956af92efe4e 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -82,6 +82,8 @@ static void init_x86_64(const struct target *target)
 		uint64_ctype = &ullong_ctype;
 		intmax_ctype = &llong_ctype;
 		uintmax_ctype = &ullong_ctype;
+		least64_ctype = &long_ctype;
+		uleast64_ctype = &ulong_ctype;
 		break;
 	}
 }
diff --git a/target.c b/target.c
index cbb25724ae09..e2eb78e25328 100644
--- a/target.c
+++ b/target.c
@@ -15,6 +15,14 @@ struct symbol *int32_ctype = &int_ctype;
 struct symbol *uint32_ctype = &uint_ctype;
 struct symbol *wchar_ctype = &int_ctype;
 struct symbol *wint_ctype = &uint_ctype;
+struct symbol *least8_ctype = &schar_ctype;
+struct symbol *uleast8_ctype = &uchar_ctype;
+struct symbol *least16_ctype = &short_ctype;
+struct symbol *uleast16_ctype = &ushort_ctype;
+struct symbol *least32_ctype = &int_ctype;
+struct symbol *uleast32_ctype = &uint_ctype;
+struct symbol *least64_ctype = &llong_ctype;
+struct symbol *uleast64_ctype = &ullong_ctype;
 
 /*
  * For "__attribute__((aligned))"
diff --git a/target.h b/target.h
index fdf311297237..4140b77c4beb 100644
--- a/target.h
+++ b/target.h
@@ -13,6 +13,14 @@ extern struct symbol *int32_ctype;
 extern struct symbol *uint32_ctype;
 extern struct symbol *wchar_ctype;
 extern struct symbol *wint_ctype;
+extern struct symbol *least8_ctype;
+extern struct symbol *uleast8_ctype;
+extern struct symbol *least16_ctype;
+extern struct symbol *uleast16_ctype;
+extern struct symbol *least32_ctype;
+extern struct symbol *uleast32_ctype;
+extern struct symbol *least64_ctype;
+extern struct symbol *uleast64_ctype;
 
 /*
  * For "__attribute__((aligned))"
-- 
2.27.0

