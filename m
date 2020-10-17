Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0120C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5300C20878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvl9+/GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439828AbgJQW4u (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439822AbgJQW4t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67391C0613D3
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so6444625edj.8
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6STfh1QtZTmwM7DfFK1cWkmVmSNUlE4JxjQqf1gcvI=;
        b=hvl9+/GOSHHs/BgCwgzjm+1MSzjXzyOaXoYeclOVUvgmrya3mYVRiA7VX1Z4LqeGkT
         hwwi/GpZ8jQxtT6BwQPqWaQS5ierJeUDsm02XAbTYi9LNpP6/bqOrT4n3Rp4Kdv6OBru
         KBcIypTDPqJ69IeoawvIdmM7aCrXneMfwpt1K2hPbfgHyrjhS3WA21TNv3hd9Vo5e0al
         +TwH6hHbsNvMUpu+vpAWHE1I2JX4hzBm8Bgkmyu3m09yh8RPSQS7+LxjnTVKkPbm9tx9
         YpKHw9R/StbzO1b4j+qrZ/mtqc5lRHn198nxHrAHYmIHj6SCEkm07Q0BJWHsm6MQ6dHw
         MiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6STfh1QtZTmwM7DfFK1cWkmVmSNUlE4JxjQqf1gcvI=;
        b=ukTsEgsk7riPI7kuNGRQnWgM6+TUa8uVy96PC/8mo7F/Z6ulcsjQufzCRkl+DTGQnL
         +b5faSPOXdV51VwvovPc5g3xW4nHx+tyotzgMC+8rlgRq8+3EZv/iyt+arCHJJAg3jXw
         VrOTnnUP8HC6hrFASHwujJOvCu6kMjqAxTw/5VRLK25f1xw5Vf+2QfmHXyZSNMlv6zwc
         vs1Si1M5xmvNSLju1Y0FdRLrveO7DVFj+z3T4qa2RvZcxeUz9prjAkXRJsfo/C4+KQnd
         P0HZTyBRns7nMKZpw/20Ha1WGPv6SLjfljGrbXWB34wQ7WBxUvKrOWSnchN9Gax+WzsU
         qTHQ==
X-Gm-Message-State: AOAM533+13a5UMiVveBYJvcIRPN5RPlABMD9gOeoH3A7xgEV/3EtbpIz
        HdtfA3thT6AKSi20/DWC/B8SjihPEiA=
X-Google-Smtp-Source: ABdhPJzVyq4KmXMGCSvPapc8/rko6PuE09/Bt1r9QzbWwP/FR7fW9x74B+nK+xYECoAt2SZUqFImEQ==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr11245109eds.116.1602975407324;
        Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:46 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/12] builtin: add builtin type: [volatile] pointer to bool
Date:   Sun, 18 Oct 2020 00:56:31 +0200
Message-Id: <20201017225633.53274-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin type is needed for __atomic_clear()'s prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c | 3 +++
 symbol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/symbol.c b/symbol.c
index ec514eb45df4..5d4f078b3444 100644
--- a/symbol.c
+++ b/symbol.c
@@ -806,6 +806,7 @@ struct symbol	const_void_ctype, const_char_ctype;
 struct symbol	const_ptr_ctype, const_string_ctype;
 struct symbol	const_wchar_ctype, const_wstring_ctype;
 struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
 
 struct symbol	zero_int;
 
@@ -912,6 +913,8 @@ static const struct ctype_declare {
 	{ &const_wchar_ctype,  T_CONST(&int_ctype, NULL, NULL) },
 	{ &volatile_void_ctype,T_NODE(MOD_VOLATILE, &void_ctype, NULL, NULL) },
 	{ &volatile_ptr_ctype, T_PTR(&volatile_void_ctype) },
+	{ &volatile_bool_ctype,T_NODE(MOD_VOLATILE, &bool_ctype, NULL, NULL) },
+	{ &volatile_bool_ptr_ctype, T_PTR(&volatile_bool_ctype) },
 	{ NULL, }
 };
 
diff --git a/symbol.h b/symbol.h
index 97c608e84704..5c5a7f12affa 100644
--- a/symbol.h
+++ b/symbol.h
@@ -311,6 +311,7 @@ extern struct symbol	const_void_ctype, const_char_ctype;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
 extern struct symbol	const_wchar_ctype, const_wstring_ctype;
 extern struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+extern struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
 
 /* Special internal symbols */
 extern struct symbol	zero_int;
-- 
2.28.0

