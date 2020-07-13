Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72FBC433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E3D20C56
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGZ1AO5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGMWdR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGMWdP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:15 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D0C08C5DB
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:15 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so15178870edv.6
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juJkRHEXgBeQsv7FfiIuEkhutk94RaoUqgXWqpQkuxU=;
        b=MGZ1AO5xal1850TAoLFF7ZWXM9Pq+GBTB/YaM3tViGhQYlJyHMFGpanEmip39g54KL
         7v2+XuZNn2XJ59G0QXx6nQOoB2DOxJWELCtUernD2pLycePBuxb/q1pxpPJRcTE1GWHx
         DTYp40KegY/19V6TdHNGYRPfqB/dg85SzlRkeCaY0l5H0Q/9k9KPrDfJTitxuLM9pXFx
         km4cAcjNthwiAm6On+S6ZHhZaAzc1zmOuJpmAhHLrjWoJFQr66gjPsNVijHt7IVwPWpl
         rdAjlYG+BGCg06mc/kkl0Rf+7JiUQTz5dV2U5s6+dfQAwsvJ516n0DA7kijBo6NQv1XY
         +zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juJkRHEXgBeQsv7FfiIuEkhutk94RaoUqgXWqpQkuxU=;
        b=LI9fjAaHEzBpGstZN2OnarAvyUoONBBRjjMWkcKphcXKq5pz3pJffeD1BJkl4zRLRo
         3dmDfdJQmpoi36LNKkWk+9EnsMwXBX6KzfXd0NeaAY/4TD2+nOb7oT1NLSxAQYkBF85j
         +F/vK3zAFiloji7O0UE2Fwlrq+NafNHlejuVGiEPtaphmogYgoJT+7DY9G3dM6UoL4By
         Dv9llVTUqFLutFS5LZYJEy/+Wb5xeWoDKE+u5b8YCt06+4ZN7iolRUcp7tCPoDIcgQcg
         djEIfKjGH0Grdualq2rNnm4beXerBEwLRx4YSDGXyrQ6evMMGx+l1coXKiAdAXtxFLZf
         NTmQ==
X-Gm-Message-State: AOAM532LtOzRcvVYek8G2uR4XP6XPO6jzrgywrB/NGf8+V3oW4Set/UC
        AwcLOB0YZhMKLEQCKlU2Ag1YJWfs
X-Google-Smtp-Source: ABdhPJxEj6rMu+8mWArTtU15CdJ0HgSRv7nSCc1qeEVtErrfxGqMl5n5Dkq/uo5Pzj1xwvgEpWzydw==
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr1567531edy.198.1594679593711;
        Mon, 13 Jul 2020 15:33:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] arch: allow target specific [u]intptr_t & ptrdiff_t
Date:   Tue, 14 Jul 2020 00:33:01 +0200
Message-Id: <20200713223304.83666-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These types are aliased to size_t & ssize_t but this is not
correct for all architectures.

So, add a variable for them so that target files can adjust them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c    | 6 +++---
 symbol.c       | 7 +++++++
 symbol.h       | 3 ---
 target-h8300.c | 2 ++
 target-s390.c  | 3 +++
 target-sh.c    | 2 ++
 target.c       | 3 +++
 target.h       | 3 +++
 8 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/predefine.c b/predefine.c
index 60ecc7070045..7120d4381f16 100644
--- a/predefine.c
+++ b/predefine.c
@@ -165,9 +165,9 @@ void predefined_macros(void)
 
 	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
 	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
-	predefined_ctype("UINTPTR",   size_t_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
+	predefined_ctype("INTPTR",    intptr_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINTPTR",  uintptr_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("PTRDIFF",  ptrdiff_ctype, PTYPE_ALL_T|PTYPE_TYPE);
 	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
 	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
 	predefined_ctype("SIG_ATOMIC", sig_atomic_ctype, PTYPE_MAX|PTYPE_MIN|PTYPE_TYPE|PTYPE_WIDTH);
diff --git a/symbol.c b/symbol.c
index 6ee521ba48d8..c0ca79e42e96 100644
--- a/symbol.c
+++ b/symbol.c
@@ -899,4 +899,11 @@ void init_ctype(void)
 		char_ctype.ctype.modifiers |= MOD_UNSIGNED;
 		char_ctype.ctype.modifiers &= ~MOD_SIGNED;
 	}
+
+	if (!ptrdiff_ctype)
+		ptrdiff_ctype = ssize_t_ctype;
+	if (!intptr_ctype)
+		intptr_ctype = ssize_t_ctype;
+	if (!uintptr_ctype)
+		uintptr_ctype = size_t_ctype;
 }
diff --git a/symbol.h b/symbol.h
index 67464d659cc2..c2b60ce91c27 100644
--- a/symbol.h
+++ b/symbol.h
@@ -304,9 +304,6 @@ extern struct symbol	float128_ctype;
 extern struct symbol	const_void_ctype, const_char_ctype;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
 
-#define	uintptr_ctype	 size_t_ctype
-#define	 intptr_ctype	ssize_t_ctype
-
 /* Special internal symbols */
 extern struct symbol	zero_int;
 
diff --git a/target-h8300.c b/target-h8300.c
index 84d168b7410a..c3652350bac7 100644
--- a/target-h8300.c
+++ b/target-h8300.c
@@ -5,6 +5,8 @@
 
 static void init_h8300(const struct target *self)
 {
+	intptr_ctype = &int_ctype;
+	uintptr_ctype = &uint_ctype;
 	ssize_t_ctype = &long_ctype;
 	size_t_ctype = &ulong_ctype;
 	wchar_ctype = &ushort_ctype;
diff --git a/target-s390.c b/target-s390.c
index cdbd685a2099..84889c0aa7ad 100644
--- a/target-s390.c
+++ b/target-s390.c
@@ -6,6 +6,9 @@
 
 static void init_s390(const struct target *self)
 {
+	intptr_ctype = &int_ctype;
+	uintptr_ctype = &uint_ctype;
+
 	fast16_ctype = &int_ctype;
 	ufast16_ctype = &uint_ctype;
 	fast32_ctype = &int_ctype;
diff --git a/target-sh.c b/target-sh.c
index d4ddf45504cf..d3a66180a0aa 100644
--- a/target-sh.c
+++ b/target-sh.c
@@ -7,6 +7,8 @@ static void init_sh(const struct target *self)
 {
 	int64_ctype = &llong_ctype;
 	uint64_ctype = &ullong_ctype;
+	intptr_ctype = &int_ctype;
+	uintptr_ctype = &uint_ctype;
 
 	fast16_ctype = &int_ctype;
 	ufast16_ctype = &uint_ctype;
diff --git a/target.c b/target.c
index f320ab525dfb..308386b8fa7d 100644
--- a/target.c
+++ b/target.c
@@ -5,6 +5,9 @@
 #include "target.h"
 #include "machine.h"
 
+struct symbol *ptrdiff_ctype;
+struct symbol *intptr_ctype;
+struct symbol *uintptr_ctype;
 struct symbol *size_t_ctype = &ulong_ctype;
 struct symbol *ssize_t_ctype = &long_ctype;
 struct symbol *intmax_ctype = &long_ctype;
diff --git a/target.h b/target.h
index 5bbce397bba5..8ffd8e882906 100644
--- a/target.h
+++ b/target.h
@@ -5,6 +5,9 @@
 
 extern struct symbol *size_t_ctype;
 extern struct symbol *ssize_t_ctype;
+extern struct symbol *ptrdiff_ctype;
+extern struct symbol *intptr_ctype;
+extern struct symbol *uintptr_ctype;
 extern struct symbol *intmax_ctype;
 extern struct symbol *uintmax_ctype;
 extern struct symbol *int64_ctype;
-- 
2.27.0

