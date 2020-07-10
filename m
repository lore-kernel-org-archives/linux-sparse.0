Return-Path: <SRS0=t/C/=AV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2985FC433DF
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F41D020720
	for <linux-sparse@archiver.kernel.org>; Fri, 10 Jul 2020 00:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/erpjf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGJANz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJANz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Jul 2020 20:13:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D299C08C5CE
        for <linux-sparse@vger.kernel.org>; Thu,  9 Jul 2020 17:13:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so3214668edr.5
        for <linux-sparse@vger.kernel.org>; Thu, 09 Jul 2020 17:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WesqHeggsrcE18R0GPSN1/UoxJ2mRGbbleFbjjSDhz0=;
        b=U/erpjf0xU5ZEt51oRxECfYkm+YvuVg+/fPtpKsGpso3hMn9Sm79KOMYLVoPDo0Sgs
         Atxl/EvErywD1ptAbgmBMkoa/gxK2LxByBg99+amY5jEOYJxw/3cnrVRy6shsaHiocbh
         1/gKUrWKLIcrHQGNH7/IUDMCS3O8Xhp+hwnv5I46emdPbTGgKqtsnGUFCh0ZNOJ0X7SD
         IL77V8RkDz3Ezee0rXU0D/BkMQTcH6hcrCLRwc9WuaIvYtB6i8t02lUotVM7X8QrG0p/
         H2phjVf3ZC2I7zJFj3pLQv+n4yin1MI0YIjDBfhkJA8af8MlEaulb3EI/T2cbUdEs/G1
         60lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WesqHeggsrcE18R0GPSN1/UoxJ2mRGbbleFbjjSDhz0=;
        b=gA0r4Ih24MN7iaVAmM9eggbqF3YxSnCgo1Es3ol0XF79zjBqmaKy47Ya09tqbgvYgR
         DhfU3h3zQ5DM07Y117XF14bFTQH22JgH/OS6y5w4Zmb0iA0ijL2KUs3ZDjOOhDPgnoGS
         jGkLuSp2PkPiw/kQ61Q4qGLd5UCC0aBM3OofiAnpOMjMrJ4NAuaMIIcQObWfKrtTwbfr
         NMOZYArSC8WuVRYCRMnwAlfF0rTVWZi/6239PqFr0vw5GbGfRjPkILMaUZnNxpxF8fWR
         0zbUAUPFI4maEGiMOHBl3/d6ZA/+S4N1/c+taxUYavJeMMo2o42ZZEuD7RKJWf1jqXZp
         yhDQ==
X-Gm-Message-State: AOAM533nuNsIesctCaTbN98cdWVceRtmQYs1vDh1GvwbaUKmMsfl9xyc
        qbMSlojJE521AkYndMZp+pBWZDbp
X-Google-Smtp-Source: ABdhPJxV+OrM2llTUCWO1K4tgygXByELG7k34JAEN0mUC2ZYBarxk9Av5ePLj26lsy9vs48D0dYZyg==
X-Received: by 2002:a05:6402:b9b:: with SMTP id cf27mr73837415edb.84.1594340033771;
        Thu, 09 Jul 2020 17:13:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c80f:e21c:9480:e854])
        by smtp.gmail.com with ESMTPSA id u8sm2614199ejm.65.2020.07.09.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 17:13:53 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/4] add a testcase for assignment to const <type> (*)[]
Date:   Fri, 10 Jul 2020 02:13:19 +0200
Message-Id: <20200710001322.18391-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
References: <20200710001322.18391-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

You can assign a '<type>[]' to a 'const <type> *'. Likewise,
you can assign a '<type>[][N]' to a 'const <type> (*)[N]' but
sparse doesn't like this.

Analyzed-by: Ard Biesheuvel <ardb@kernel.org>
Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/linux-crypto/20200709120937.GA13332@gondor.apana.org.au/
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/eval/array-quals0.c | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 validation/eval/array-quals0.c

diff --git a/validation/eval/array-quals0.c b/validation/eval/array-quals0.c
new file mode 100644
index 000000000000..9cb08c1722d7
--- /dev/null
+++ b/validation/eval/array-quals0.c
@@ -0,0 +1,7 @@
+static int a[2][3];
+static const int (*p)[3] = a;
+
+/*
+ * check-name: array-quals0
+ * check-known-to-fail
+ */
-- 
2.27.0

