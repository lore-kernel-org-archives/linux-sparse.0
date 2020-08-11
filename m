Return-Path: <SRS0=GPIt=BV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76746C433E0
	for <linux-sparse@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432572076B
	for <linux-sparse@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3M+/8cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHKQrr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgHKQrq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Aug 2020 12:47:46 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB7C06174A
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2020 09:47:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m20so9585108eds.2
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2020 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5DEcYS61pJ7APhq/eOh53K4EFVBvaoIwp3FcSFZIKE=;
        b=P3M+/8cCECbgjGj5TpiU+qEPH7dRLAQlIquewdT8Vww44cDtB17VqOT0NpH3G4jO0e
         8N1oFaJZxKcN9ha5KGTiiRDnSrQEK6VIv9zaIqaUfhKsbljVRzrHZTM4UK2pb+sWUZMB
         oxZez9ibZOR+4hMERXPS0PEtUzVPbHXaFVmIe9XS/5aptf4NqlkJ0L/rWSSdro99KD9U
         Erh4gMwoJUgiY4bR43quijl2byz139e0ltamPbSxrafpFBRKLtxpf/GE4My35koi7VhD
         bD5P4Y4IB4RTzZnMSijdR53JuqvyBMh9m0MQAJHepGOmSY96+mOVhYuM9XW3RIlXTr64
         76dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5DEcYS61pJ7APhq/eOh53K4EFVBvaoIwp3FcSFZIKE=;
        b=kJTsJl9FDyUg9E9bakI6+hSJI3yWdN+dfPA/NkFm9QN434wfcGkbsdcnEtyJSZRt+n
         Gst701T6bBYzA+kqExl+2ZiAtZwXrEp6WRWIeK1RbxN7rgUbb8pY9hU/OpdgmoV6rYQK
         JN5ci4pfZSBIdmRSoaJDLK6N6lCI7+6JPCEJ/A3yb+RLqp7bR6fahYyUwJcPiPzIC79P
         H0SEehsYAQ4e91YKiakfH51u2dku5lZPd8LngXAy9RCjIzjbXWSGFP1JGF74B+DwQmpk
         +KWmMfkC1sTbZWI125NE4odMFlqPO9jIV983yLzC06pRt+ho/FpBGxfBS47zDb7F4AMu
         j/uQ==
X-Gm-Message-State: AOAM532Tq/tiW9juH+ygL58UYr6C4VTIOXzmN6N58URMd8wcd7hLOA81
        IhuhL7wYNX/79aAjJYCOGpn7sigI
X-Google-Smtp-Source: ABdhPJw/8UiWsQQkftdqgekmRAuSIecullU4l1vYv+exSzLZZpkqGdkrZGtipO4Dtx6PW0eHJul1+Q==
X-Received: by 2002:aa7:d8d8:: with SMTP id k24mr28250956eds.32.1597164464783;
        Tue, 11 Aug 2020 09:47:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:302d:f138:51cb:bace])
        by smtp.gmail.com with ESMTPSA id fx15sm15551359ejb.1.2020.08.11.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 09:47:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix is_scalar_type(): fouled types are scalars
Date:   Tue, 11 Aug 2020 18:47:40 +0200
Message-Id: <20200811164740.43766-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

is_scalar_type() accept SYM_RESTRICT but not SYM_FOULED
but both are for integer types (and only for them).

So, let it accept SYM_FOULED too. Same for is_integral_type().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h                 |  2 ++
 validation/foul-scalar.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 validation/foul-scalar.c

diff --git a/symbol.h b/symbol.h
index 873d69fcf547..a3ed95678ee5 100644
--- a/symbol.h
+++ b/symbol.h
@@ -463,6 +463,7 @@ static inline int is_scalar_type(struct symbol *type)
 	case SYM_BITFIELD:
 	case SYM_PTR:
 	case SYM_RESTRICT:	// OK, always integer types
+	case SYM_FOULED:	// idem
 		return 1;
 	default:
 		break;
@@ -483,6 +484,7 @@ static inline bool is_integral_type(struct symbol *type)
 	case SYM_ENUM:
 	case SYM_PTR:
 	case SYM_RESTRICT:	// OK, always integer types
+	case SYM_FOULED:	// idem
 		return 1;
 	default:
 		break;
diff --git a/validation/foul-scalar.c b/validation/foul-scalar.c
new file mode 100644
index 000000000000..8e053b96edbd
--- /dev/null
+++ b/validation/foul-scalar.c
@@ -0,0 +1,13 @@
+#define __bitwise __attribute__((bitwise))
+
+typedef unsigned short __bitwise __be16;
+
+static void foo(__be16 x)
+{
+	if (~x)
+		;
+}
+
+/*
+ * check-name: foul-scalar
+ */
-- 
2.28.0

