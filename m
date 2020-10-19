Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BDC433E7
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF192225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV9EQtbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgJSQMk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:39 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE8C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e22so14719186ejr.4
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcG9P+1U9AztKNAkMdxfde3tR/TMbjnAaJphodDQ/98=;
        b=UV9EQtbY+Qjq2RHwR2pnOa5ww3m2okKhbVpJN2jFqJe3V1ipteJQWEMLOkLmstOoGv
         C85qdrK46Ns7eK6VxCyQKPHJozK+AEwxFKIeBS2US3acKKfEmBwooQakhTqpLC7fnLag
         6NmJUIAnmVDfb4imnMjFvQqXvHoevRHfdpF2WoLt95TyAiLh3lCn8aDDq3k0KUge/IQk
         XWUE5PG7mZvK7KsQGKj1gy7HYwCRYkIo8faMIoBjaoKPjE7SKhAj3d3fDZiaRnGCUVzi
         sNLKIYASsbIuQI9ZguqoGaCTL+ENQYrC2LRxJsViAKDPiRPxdQrhdZWpKaCPP0sNTWmw
         uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcG9P+1U9AztKNAkMdxfde3tR/TMbjnAaJphodDQ/98=;
        b=mvdGn1zpzWeo3vKedwjPLAqL1FxP6ZM0vAIGZEdtaJyiNJDM86+qT8RU5ydSrVcn5P
         2Ss7NOEVepLG79WN87fNORXgYSy6P50krYXr4lLcslBFZlfaM9aSXHWQ1kKxIJRhtu8t
         D2N/7kbE8St905oGnAg348sKG8TFAfx9Mb/zHrKW0GESp5YwpJyPydf08uEjN1l0ZO3Y
         kOjFy+QJAthIAD1SOE8FL3bhXrkiy/G29xmaMpcVcnfQZ68drzmWyTsgUJ+Tsv5msTCW
         Cu+luaHp2LWQF89cQ3M2T0qZvH1iaQ9iw5fD7ShVLJ+Y7zaA51u5IEi+3ku8cC21sn6R
         ezNQ==
X-Gm-Message-State: AOAM533jO2fZrkjt5vhxj5Q+l4Ygxs5GI9DPGJtNx2mKz4J86BzjAJT8
        63mauczhSOsPi+eRpZzTSUumOOAlX5g=
X-Google-Smtp-Source: ABdhPJzNDfC0p3x0Of2I9NZoYyAwdxWE6Mpbae52mYMdrGSbSqsD9F7V4h9CMxLfbW8b8XZz6oXRJg==
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr640736ejb.160.1603123958065;
        Mon, 19 Oct 2020 09:12:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 04/12] builtin: evaluate __sync_*_fetch*()
Date:   Mon, 19 Oct 2020 18:12:18 +0200
Message-Id: <20201019161226.97429-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
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
index a1c925725942..bd12d5651f44 100644
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

