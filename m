Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566EC433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1155C204FD
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+jsJCsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgHOVwQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgHOVwN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F5C09B04A
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so13001839ejc.2
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3I2KTIDywX0WzYJMKmMB6Y9Qt2gPgAiitm+bK/CVbuE=;
        b=h+jsJCsYDjxVqbXj4pz8iIwk76cfb5UpYHvjsYzqBXgH4E+yqyaNVCtyrghWDkDXX1
         10t6U1YoDSuelOCg5IJanCnUShcUEGA8LgADvhWlM1LZKmW9TwSU9QjNrhZXnJlnldMQ
         5TB6TGWR59Mu1pXnFqwBw11FufidWjqs6U1NBxRX01gw77hk//ZHMOe2T78m0LTbGtre
         ZP/DssI4oO3QoPS2MFKNTQI5mx288fXjn2MOgcEyS8Ismcg69JF1US3OWxLce6A+u5GZ
         TG1AnJvTQbaDRZrjphIwvAnEplcCpakUidOLaAIJ3kLQLkwotLIXJCycCIg3o9CSHMQt
         eYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3I2KTIDywX0WzYJMKmMB6Y9Qt2gPgAiitm+bK/CVbuE=;
        b=thU1rGmNaHQBBJASgDg8jSw6w9RGFROLFADv5d94Zyb64vWF0aedbvgMpYreoeRSWv
         npXKneKDnRrm7C9yMYky+iBHqwH1k7pLYr2d1UuaFTj2dTTopBchk+cjLciNT0BFDwp7
         NdCI1ohSn709FPTW+ozW+iGLinTuERYVaNQRwF29uhI0wB6l/NmVURNq82GunoQ+F6yo
         a6Si93Ay05JPJ/wnofwZHBBze9Ve4isO23S9P48FDuiEoa0LmFB/BYFLmhxm0XVEEWs6
         zT0YLv/7VZA/lxGPsJok400JhW+JQvjWD5vIzih8XS/2ALnY2GEy9djsa4Ron7ZdAVNS
         ljfg==
X-Gm-Message-State: AOAM530FXXdUpdYzz0RUzrWG3Lh3OKbfsghoMB69sSimmRH+b2RkE4OJ
        ct0qO/cUuQvfsPqL0CD68A2mPRLPCxQ=
X-Google-Smtp-Source: ABdhPJxoEsfSp13oV/PufRBynBm+xjuUNKge5X3Mo2lmVylpE6/DwXIPMl4bEuqCP6YOj04iWceSCQ==
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr7289130ejv.534.1597505289944;
        Sat, 15 Aug 2020 08:28:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:9042:5c68:7405:68b0])
        by smtp.gmail.com with ESMTPSA id o7sm9065091edq.53.2020.08.15.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 08:28:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] union-cast: add some testcases
Date:   Sat, 15 Aug 2020 17:28:01 +0200
Message-Id: <20200815152803.2788-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
References: <20200815152803.2788-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Casts to union type are a GCC extension and are similar to
compound literals.

However, sparse doesn't know about them and treats them like
other casts to non-scalars.

Add some testcases for this and its upcoming warning flag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/union-cast-no.c | 24 ++++++++++++++++++++++++
 validation/eval/union-cast.c    | 25 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/validation/eval/union-cast-no.c b/validation/eval/union-cast-no.c
new file mode 100644
index 000000000000..d06b348d209e
--- /dev/null
+++ b/validation/eval/union-cast-no.c
@@ -0,0 +1,24 @@
+union u {
+	int	i;
+	char	x[8];
+};
+
+static union u foo(int i)
+{
+	return (union u)i;
+}
+
+static union u bar(long l)
+{
+	return (union u)l;
+}
+
+/*
+ * check-name: union-cast-no
+ * check-command: sparse -Wno-union-cast $file
+ * check-known-to-fail
+ *
+ * check-error-start
+eval/union-cast-no.c:13:17: warning: cast to non-scalar
+ * check-error-end
+ */
diff --git a/validation/eval/union-cast.c b/validation/eval/union-cast.c
new file mode 100644
index 000000000000..1d8167531081
--- /dev/null
+++ b/validation/eval/union-cast.c
@@ -0,0 +1,25 @@
+union u {
+	int	i;
+	char	x[8];
+};
+
+static union u foo(int a)
+{
+	return (union u)a;
+}
+
+static union u bar(long a)
+{
+	return (union u)a;
+}
+
+/*
+ * check-name: union-cast
+ * check-command: sparse -Wunion-cast $file
+ * check-known-to-fail
+ *
+ * check-error-start
+eval/union-cast.c:8:17: warning: cast to union type
+eval/union-cast.c:13:17: warning: cast to non-scalar
+ * check-error-end
+ */
-- 
2.28.0

