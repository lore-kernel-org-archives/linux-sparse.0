Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4085C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7882F20878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq5YV9nB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439823AbgJQW4q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439817AbgJQW4p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B39C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l16so6479945eds.3
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQXH+XSpwSyrzZCarUHoV9BYGozadj5zbeYjlNeyYaE=;
        b=Jq5YV9nBOHHPiqeyvAp5yhhzu0PwVNrttsJ5yprvzSrZ0Mu2qT4Am4FajmqKSwBrlC
         iSJnZtdy3hLuFmNUqA2WIpEetsJbz+bIpoL0ZqDtBvIP9MMbl4Jtt9BNcSgtKUSH20kk
         vBQwipniPdx9kYTTY6hyMasOwxRn0TBz5tQpSqezhkDbWxMYrEFylyrgG5Lz9OHc/vEj
         fGYBkWhR3EnKKfedbyra+HuRPM1g/eyGQjOhJSYxdfOp9kUtqUZUekHU4IEIoH3WxNbq
         Iyh8/iHmko2e/14SqHaOY6hqic9U1qtHjI12TdLY/akd7a/xbh1WrXkWKUKMoKGdq+2U
         dBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQXH+XSpwSyrzZCarUHoV9BYGozadj5zbeYjlNeyYaE=;
        b=uQ9FBHKPQ+ycXKYexFEKXsy9X2KN+Jj0iZA6woyNoFvnhhkRXOaOUChcta72YMvd19
         WIuc4vcbw0OxE8z+hYEcasK0/++1Ihg1Jo51smWfcc0cs03dcAEnj3FUgR3xC4tIsDPt
         vgkoX3reus+RwovhP21qutLaNDbo7D2NvXdAZS9bQGtf+SLt7XjJe5Km213F29YKBe5Q
         YIscpai5Ci+kTuWy57EHo9zZegKwyfLy49AKMvvHey4rMvVsXHHJLulM9LJBqNTLlT07
         WsZGaYKk+G45aQbWkLBy24Sf2243vjjBoO3HO8kl+bI5Sp6Xpzp0qfUq/kGT0BxG0EF/
         gKkw==
X-Gm-Message-State: AOAM532elOhBs6GtkKNC89wlT8ZoanTrpTa+BGGE4vwRTz9YJ3vGEgUd
        euYYZ6jKxfyAEVi4qPIETHCwRabHg8I=
X-Google-Smtp-Source: ABdhPJzodCz9WlTv+FKjNkoRyDsXp+Gi2DqEYOWZpynIPB2xq1np2LUGpYwcshEdA3uc7ny6548opw==
X-Received: by 2002:aa7:da12:: with SMTP id r18mr10620579eds.169.1602975401560;
        Sat, 17 Oct 2020 15:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/12] builtin: evaluate __sync_*_fetch*()
Date:   Sun, 18 Oct 2020 00:56:25 +0200
Message-Id: <20201017225633.53274-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reuse the generic method for all these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                       | 26 +++++++++++++-------------
 validation/builtin-sync-fetch.c | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 13 deletions(-)
 create mode 100644 validation/builtin-sync-fetch.c

diff --git a/builtin.c b/builtin.c
index 880dd54f647e..5e490830e147 100644
--- a/builtin.c
+++ b/builtin.c
@@ -627,23 +627,23 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin___vsnprintf_chk", &int_ctype, 0, { &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
 	{ "__builtin___vsprintf_chk", &int_ctype, 0, { &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
 
-	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_add_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_and_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op},
-	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_fetch_and_or", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_fetch_and_sub", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_fetch_and_xor", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_fetch_and_add", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_fetch_and_and", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_fetch_and_nand", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_fetch_and_or", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_fetch_and_sub", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_fetch_and_xor", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_lock_release", &void_ctype, 1, { &ptr_ctype }},
-	{ "__sync_lock_test_and_set", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_nand_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_lock_test_and_set", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_nand_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_or_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
+	{ "__sync_sub_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_synchronize", &void_ctype, 0 },
 	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
-	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
+	{ "__sync_xor_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 
 	{ }
 };
diff --git a/validation/builtin-sync-fetch.c b/validation/builtin-sync-fetch.c
new file mode 100644
index 000000000000..45139a3c8c3e
--- /dev/null
+++ b/validation/builtin-sync-fetch.c
@@ -0,0 +1,24 @@
+static int ok_int(int *ptr, int val)
+{
+	return __sync_add_and_fetch(ptr, val);
+}
+
+static long* ok_ptr(long **ptr, long *val)
+{
+	return __sync_add_and_fetch(ptr, val);
+}
+
+static void chk_ret_ok(long *ptr, long val)
+{
+	_Static_assert([typeof(__sync_add_and_fetch(ptr, val))] == [long], "");
+}
+
+static int chk_val(int *ptr, long val)
+{
+	// OK: val is converted to an int
+	return __sync_add_and_fetch(ptr, val);
+}
+
+/*
+ * check-name: builtin-sync-fetch
+ */
-- 
2.28.0

