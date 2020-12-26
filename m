Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F845C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB77217A0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLZRwk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRwk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:52:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A088C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g185so5679987wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igYkLeqnIXBYQCR9l8FdXDALCmYdO0nq7AGpxF7L7EU=;
        b=aom2lx6vE3/2MHMas+7kDLos0C5GiV6kP5teojmDbbyrpI+Pjp5TLIq9B45HVRhKrx
         y81UKH63hjhDvzTWr7Xp7fOiLmXgoJWYyVSudMN25bsQcsBNGr7DPd6GLwy538KfTo1C
         5+eWYpAZDWKJ+7KB076pnsPsrTmLT6Nwfxiy/7Ui9jBcjokE6YpW5qWB5cPuQ3iV0spT
         Oa3w92KTNctlM0EgtrlD6ocm5ZGUvt9J1V4W+CrKR3uYY7VkGmo4J29W3YGiYfEn0lMa
         JuNLz1Ppn2uAi/+vuVLowGYCmpGOharuyxY7ORqlh9WRTlfhqkptw69MIHZg50iMeDzP
         DqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igYkLeqnIXBYQCR9l8FdXDALCmYdO0nq7AGpxF7L7EU=;
        b=AQthCIZTR7DaR8qrTqiHjc4vvv9W4l/5FDyL61VtaJouXhyxC+tNgIEWS5n8Uj8dg5
         lu3c17xxdbmXXWtp//lYnCi0SSKWyagl9OHe1oayzTVpB/TSTKNwuM18+mXngcfaxZWh
         KRrte/vQJP7wwvYyzC8myL9GQbP/60xet9UNjQj9IJwdgOurMIccXLtygAnPx+pFS8Dm
         0m1xsJrRZJmEGnOpUFJTc04WlRn4NYw84U/KC39HNGKu+q894rItmW0x1JeYJAuR+KoB
         HU1IbWBSLraejTFDenr5E5VLDls/caXUDY9n7PrbSf5YYgqbIHEw16ytOTDvxu0d3Tgd
         0vRw==
X-Gm-Message-State: AOAM531gO4hY+RV+ukw4cXcdOaR/mnNDJbdNWgyZ8jsFsFatGaWRMdvA
        rPY/RJTMFoEaXdKqKaUfdlx2q8IToao=
X-Google-Smtp-Source: ABdhPJxnAXUdNw3QMtDzgs9RV2T3LYw/QJlGo4XaUXEV7TMgnSArpqunUoTnE0slpZK540xOS3FQcQ==
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr12817978wmc.173.1609005118388;
        Sat, 26 Dec 2020 09:51:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:51:57 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 02/16] add testcases for exotic enum values
Date:   Sat, 26 Dec 2020 18:51:15 +0100
Message-Id: <20201226175129.9621-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There is more than one complexity in the evaluation of enums.

Add a test for enums with 'exotic' values non-covered in other tests.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/enum-type-exotic.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 validation/enum-type-exotic.c

diff --git a/validation/enum-type-exotic.c b/validation/enum-type-exotic.c
new file mode 100644
index 000000000000..a17ca0ad48ef
--- /dev/null
+++ b/validation/enum-type-exotic.c
@@ -0,0 +1,28 @@
+enum foobar {
+        C = (unsigned char)0,
+        L = 1L,
+};
+
+unsigned int foo(void);
+unsigned int foo(void)
+{
+#ifdef __CHECKER__
+	_Static_assert([typeof(C)] == [enum foobar], "enum type");
+	_Static_assert([typeof(C)] != [unsigned char], "char type");
+#endif
+
+	typeof(C) v = ~0;
+	return v;
+}
+
+/*
+ * check-name: enum-type-exotic
+ * check-description:
+ *	GCC type's for C is 'int' or maybe 'unsigned int'
+ *	but certainly not 'unsigned char' like here.
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: ret\\.32 *\\$255
+ */
-- 
2.29.2

