Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F485C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C52520772
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0TkmTgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgGHVsQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVsQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:48:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2BC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:48:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so69704ejc.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtrZPZJFo7LjtLTzLGgK88m9Q5oELmXUtOHFgPyFOPU=;
        b=o0TkmTggjPnzflS6iW3I4vH1Dt49sHt1hNbpb9IuZhIQMZ+xWToXla0Wdn1lQqRlj8
         w5vEQNROip/wJqYs1iCg/HXlYRwW9wyD3Qg5v5D39S5nlKG2bWc+Ju9dNgMgrXCdawTl
         awVYhm7a+kvo9XQ4nV8W7SvowbNWfTjVqMdrgoysaVWnxhMUrT2cvnQWMP3fbbDmLSDq
         BuwlN+h96qHxblQOyvMMC58Y4rNp0NZmvXxUbeRS/uJ/KC7/aecBu0y5zQ9F7cZYyzc0
         6Z1jRrSQP4rNnIxXlIa45gkOi9rt3kPoc8OgTX74UVw20y1JS+YUhWPXcWWDIeiN9NwD
         W5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtrZPZJFo7LjtLTzLGgK88m9Q5oELmXUtOHFgPyFOPU=;
        b=ky5qaALcc7JaZYnvZcCB3JfY0TY92NRWws2gYEa67ENPBREycvG8dROKHlcB1WTC6l
         k35TJFib4WtBOb2nyFPWv8K/RfQkzaUDrSNzdtAPgfvFje4PhBRzbOlWeB+irt8O3oT2
         M3Alp2G0wN6zWiK1jGgXfDqck5cIILV7W8rK8OcTwGtf2+kuDGk7/M7M4pxHQREhw+lD
         OUcSJ99i6w0uV1GpW0kVpqMeqt5SnGi9XRj3myckcFAxqIfP7UH+5pPheGV7M17MPUD8
         rwDIH4IA58FH6XATj9r00fOyN8tCQ3FLaVAQFgkOYv0lO3N+2QHWhuTF4nZPU86OrhWK
         BtrA==
X-Gm-Message-State: AOAM531mOaMUouuKw76Jy4/LoRgH/5pwXmagezl1hlip4IwixTRoHu0R
        Wrq48bboAtmSZeq2aXyouLCAJO7f
X-Google-Smtp-Source: ABdhPJwZSFK8FGCheqH45CSBNg3rKNdJOdqLp2gj/whDsEte6cAfAxHHP2rQiLSKu4dll2OE8v4Exg==
X-Received: by 2002:a17:906:5909:: with SMTP id h9mr52096859ejq.501.1594244894895;
        Wed, 08 Jul 2020 14:48:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id l15sm450370ejd.100.2020.07.08.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:48:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] arch: teach sparse about the '-march' option
Date:   Wed,  8 Jul 2020 23:48:07 +0200
Message-Id: <20200708214810.56214-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
References: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The option '-march' is not one of the common option but is
architecture specific.

So, teach sparse to delegate the parsing of this option to
the targets.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c | 8 ++++++++
 target.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/options.c b/options.c
index 9f05bdf9cf4f..1a3fee3c6751 100644
--- a/options.c
+++ b/options.c
@@ -609,6 +609,13 @@ static char **handle_switch_M(char *arg, char **next)
 	return next;
 }
 
+static int handle_march(const char *opt, const char *arg, const struct flag *flag, int options)
+{
+	if (arch_target->parse_march)
+		arch_target->parse_march(arg);
+	return 1;
+}
+
 static int handle_mcmodel(const char *opt, const char *arg, const struct flag *flag, int options)
 {
 	static const struct val_map cmodels[] = {
@@ -650,6 +657,7 @@ static const struct flag mflags[] = {
 	{ "x32",&arch_m64, NULL, OPT_VAL, ARCH_X32 },
 	{ "size-llp64", &arch_m64, NULL, OPT_VAL, ARCH_LLP64 },
 	{ "size-long", &arch_msize_long },
+	{ "arch=", NULL, handle_march },
 	{ "big-endian", &arch_big_endian, NULL },
 	{ "little-endian", &arch_big_endian, NULL, OPT_INVERSE },
 	{ "cmodel", &arch_cmodel, handle_mcmodel },
diff --git a/target.h b/target.h
index 8f79426c096a..54e97e83b10d 100644
--- a/target.h
+++ b/target.h
@@ -76,6 +76,7 @@ struct target {
 	const struct builtin_fn *builtins;
 
 	void (*init)(const struct target *self);
+	void (*parse_march)(const char *arg);
 	void (*predefine)(const struct target *self);
 	const char *(*asm_constraint)(struct asm_operand *op, int c, const char *str);
 };
-- 
2.27.0

