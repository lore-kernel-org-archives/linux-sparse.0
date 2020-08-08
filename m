Return-Path: <SRS0=D4es=BS=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E2EC433DF
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2969920716
	for <linux-sparse@archiver.kernel.org>; Sat,  8 Aug 2020 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF7vess1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHQL7 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHQL6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Aug 2020 12:11:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D348C061756
        for <linux-sparse@vger.kernel.org>; Sat,  8 Aug 2020 09:11:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so5140382ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 08 Aug 2020 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0XoFfodWfClj21A+5Z0dnnv+IeEGHHD8atYPrz0sRE=;
        b=IF7vess1X/IpIsZkGqlc4qK9qLyBCxy4s6e5TS72j/H9DMvgPMEgZ/2SBDWnVq6Gjt
         bL/CpupKv/nETNIY4jpA0FUWWN3GlS8GwXhCmie/QI1Dj3X4zs8uZC63WIazXvia5V1F
         fqFZbe4GC8xS0FCb6J3E3TdOASJFbBcjBOkebyx5J8GOUWA+OFphitIjg4eeDrEo4wPS
         IznqH3zJEFLJYiZf2zLv9hBJnPEPoEETDa5OZ0rEVoM6C+qBVXiVNqs4vTxtau+2qWEw
         MIyFqvyBZ1I9APNDYXF1RJKjqyTPjxg7a5vhkztwGED8TiDD9hE1EFxuOcoxpv+nSjY9
         K4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0XoFfodWfClj21A+5Z0dnnv+IeEGHHD8atYPrz0sRE=;
        b=DMHy0+Q04WtNFj4lKnw54iEU9jIxxzlhbt2uXHdeKho56ukL/G1Ef3t27/pMlEeefp
         qA9FOJMcaH9J8jlOv5w0vWV+MJ+oSCtHMYk465hvxsKfEWDO+ifoALA6EHpAMylBzxgc
         onMNCgG61wauMNz1oDiTAtg8JhAgwdyEwrmOw327iZa7Q+jPC0nh1APW0K5TWYZzgcv2
         KAisvBem1u6UkBBvpk/utFVRKRbRrkjBBss9PIu+/JIXZf+sOCsTdkH0GY+DQ9DSU9/l
         dArJLa68oA3TN4DjPDCIOozXS5M18ITMgJrde47a7OatFL3pLqwspYIofNOmY6I6hfIX
         dDdw==
X-Gm-Message-State: AOAM531jmJLITo4HcduosyTB1cM3MxKAPauLwk5xUvCH/sIjEzqz8mBf
        CZR7u7riAmzLPd+8Ui42YN3PzltE
X-Google-Smtp-Source: ABdhPJxCldOteiZ07uCf6KLEFCGqe8Sl1vKV4l1FDbEWlazSIcNYS6Vv4xJekEjqCXpYysBOO/9/oQ==
X-Received: by 2002:a17:906:27d7:: with SMTP id k23mr14345711ejc.74.1596903116668;
        Sat, 08 Aug 2020 09:11:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:658a:a334:d0cb:45f5])
        by smtp.gmail.com with ESMTPSA id g25sm8145725edp.22.2020.08.08.09.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 09:11:56 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] wstring: add support for checking size in string initializer
Date:   Sat,  8 Aug 2020 18:11:39 +0200
Message-Id: <20200808161143.28272-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
References: <20200808161143.28272-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A warning is given for string initializers if the LHS array
is not large enough to contains the string. But this check
doesn't knowns about wide strings.

Fix this by selecting the correct char type and use this type
for the size calculations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                |  6 ++++--
 validation/init-wstring.c | 41 +++++++++++++++++++++++++++++++++++++++
 validation/init_cstring.c |  2 ++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index acad11ab2712..bbfa77c3a79d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2841,10 +2841,12 @@ String:
 	*p = *e;
 	type = evaluate_expression(p);
 	if (ctype->bit_size != -1) {
-		if (ctype->bit_size + bits_in_char < type->bit_size)
+		struct symbol *char_type = e->wide ? wchar_ctype : &char_ctype;
+		unsigned int size_with_null = ctype->bit_size + char_type->bit_size;
+		if (size_with_null < type->bit_size)
 			warning(e->pos,
 				"too long initializer-string for array of char");
-		else if (Winit_cstring && ctype->bit_size + bits_in_char == type->bit_size) {
+		else if (Winit_cstring && size_with_null == type->bit_size) {
 			warning(e->pos,
 				"too long initializer-string for array of char(no space for nul char)");
 		}
diff --git a/validation/init-wstring.c b/validation/init-wstring.c
new file mode 100644
index 000000000000..846b6e2c3efd
--- /dev/null
+++ b/validation/init-wstring.c
@@ -0,0 +1,41 @@
+static const __WCHAR_TYPE__ ok0[] = L"abc";
+_Static_assert(sizeof(ok0) == 4 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok1[] = (L"abc");
+_Static_assert(sizeof(ok1) == 4 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok2[] = { L"abc" };
+_Static_assert(sizeof(ok2) == 4 * sizeof(__WCHAR_TYPE__));
+
+static const __WCHAR_TYPE__ ok3[4] = L"abc";
+_Static_assert(sizeof(ok3) == 4 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok4[4] = (L"abc");
+_Static_assert(sizeof(ok4) == 4 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok5[4] = { (L"abc") };
+_Static_assert(sizeof(ok5) == 4 * sizeof(__WCHAR_TYPE__));
+
+static const __WCHAR_TYPE__ ok6[7] = L"abc";
+_Static_assert(sizeof(ok6) == 7 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok7[7] = (L"abc");
+_Static_assert(sizeof(ok7) == 7 * sizeof(__WCHAR_TYPE__));
+static const __WCHAR_TYPE__ ok8[7] = { (L"abc") };
+_Static_assert(sizeof(ok8) == 7 * sizeof(__WCHAR_TYPE__));
+
+static const __WCHAR_TYPE__ *ptr[] =  { L"abc" };
+_Static_assert(sizeof(ptr) == sizeof(void *));
+
+static struct s {
+	const __WCHAR_TYPE__ str[4];
+} str = { L"xyz" };
+
+static const __WCHAR_TYPE__ ko3[3] = L"abc";
+static const __WCHAR_TYPE__ ko2[2] = L"abc";
+
+/*
+ * check-name: init-wstring
+ * check-command: sparse -Winit-cstring $file
+ * check-known-to-fail
+ *
+ * check-error-start
+init-wstring.c:29:38: warning: too long initializer-string for array of char(no space for nul char)
+init-wstring.c:30:38: warning: too long initializer-string for array of char
+ * check-error-end
+ */
diff --git a/validation/init_cstring.c b/validation/init_cstring.c
index 00eca20aa506..bac814e42907 100644
--- a/validation/init_cstring.c
+++ b/validation/init_cstring.c
@@ -1,11 +1,13 @@
 static struct alpha {
   char a[2];
 } x = { .a = "ab" };
+static const char str[2] = "abc";
 /*
  * check-name: -Winit-cstring option
  *
  * check-command: sparse -Winit-cstring $file
  * check-error-start
 init_cstring.c:3:14: warning: too long initializer-string for array of char(no space for nul char)
+init_cstring.c:4:28: warning: too long initializer-string for array of char
  * check-error-end
  */
-- 
2.28.0

