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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECAEC433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A334320708
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9Mfm2a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGHVzh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHVzh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:55:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D9C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:55:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so100730ejx.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/1mN0pIqQchc7+X9ti2jVU71lrwnR2dwc1SVufQkIg=;
        b=N9Mfm2a7Ji9gkSboNGVo0UblW+oC6clVAYlRXflR8A+69cSM9HIdUa4je85PHJ4EyL
         XhjtpuMI/SQ1kYmQCrjt8Wo3jnmtrWdQNiy6c4P6RL0LdTppWzWl4ClE+JcILcdZhh2Q
         YT9Er4o0htWfGboHYd44P/zEEMhbe3tP685YI4Ih2G4l/pFxgCW4nkDocYfapn8L1WA+
         ePT+p3xGpQDV4M8+qaiQyHv9SzJN5DjLd4Ex9WDURWprVVL7dbIcAhoOPBvs7+slWmqx
         V4+5QkepOmYRwQaqUxb052XSU2Z4ObINOUbyNmXyjWJhjMLB3wBejLO1gwh1SEwEghc5
         jN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/1mN0pIqQchc7+X9ti2jVU71lrwnR2dwc1SVufQkIg=;
        b=ADOg39YyEReWa9WNMATLjM7SAqTKmehUmfZb4+s/zoOXIAwwbU7Lp+5qeWn9mXSnPK
         4LcLPY/MxwFn121DfXagMJsUFykh3kvc4sSA75FUGvp0+vge+DYa/wDrtpLdpP8a0bE/
         lwMYZbiTcypMEyuEQPfJ+AtkUl/DF7/oO5A/wfWtpywp45J3JCHcTW7qfCmWpiUiotPg
         Mt/cX76LQaw5lL8cjZ6qCc2uhv7XaNgoYCBlpsnCvhBvRUZESiY5urjgyX47zNuukSFj
         92q1DEPMbsre8tuwpBWI5Nz6/NPN64pvwZOgYhOM5l3TJOc/PniwQf8uB5Mmr5U8VkBA
         ghSw==
X-Gm-Message-State: AOAM532tPNpfG0H7N1z583zH1iglqdn0A5OculUNLs1cHer4VebD8sjN
        RFeNoZaXSGRK64aF4V2jtQlBTE/f
X-Google-Smtp-Source: ABdhPJzbN9fGsjCfnTugXJphOPGtUKMkJ033GKsJbsL3AfFpZHifYdH0mRbZRpvybA4BrhNwNJU3AQ==
X-Received: by 2002:a17:906:3984:: with SMTP id h4mr48579723eje.254.1594245335333;
        Wed, 08 Jul 2020 14:55:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id a8sm478999ejp.51.2020.07.08.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:55:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] arm64: add predefine for endianness
Date:   Wed,  8 Jul 2020 23:53:28 +0200
Message-Id: <20200708215329.56404-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
References: <20200708215329.56404-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Depending on the endianness, predefine '__AARCH64EL__' or '__AARCH64EB__'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-arm64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target-arm64.c b/target-arm64.c
index 8619bd842f9b..d92ab16be592 100644
--- a/target-arm64.c
+++ b/target-arm64.c
@@ -20,6 +20,11 @@ static void predefine_arm64(const struct target *self)
 
 	predefine("__aarch64__", 1, "1");
 
+	if (arch_big_endian)
+		predefine("__AARCH64EB__", 0, "1");
+	else
+		predefine("__AARCH64EL__", 0, "1");
+
 	if (cmodel)
 		predefine_strong("__AARCH64_CMODEL_%s__", cmodel);
 }
-- 
2.27.0

