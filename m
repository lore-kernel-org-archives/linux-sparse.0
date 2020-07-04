Return-Path: <SRS0=R0+E=AP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB0C433DF
	for <linux-sparse@archiver.kernel.org>; Sat,  4 Jul 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE602084C
	for <linux-sparse@archiver.kernel.org>; Sat,  4 Jul 2020 13:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li5dPY79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGDN5y (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 4 Jul 2020 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDN5x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 09:57:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6101BC061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 06:57:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so37383318ejq.6
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COXeAUL18hdrSXD+At7C4xdndPcfAFyxiVsz37xMwc8=;
        b=Li5dPY79OKarHWfSp05g37TMdd1TqA8Vot1TPE4fk9NPurmhs5ME1VxA5oTWF5Av4i
         w05xSGQv6xOrbvDGF+B0iG7OgISLNZKDkjKFTG3MCKfLyi3lGFb0Ok0iKy/zQoTKkdSV
         CRBHob+hQpeypy95JqN4wRPoweaooKxagzhvq6ciuHDnulua1/4DBW99mBnf3Y+VXn74
         qZ+u04QAkec9Ccf04zumXP3mjLv1VvGyDrCZeXHu4XlZjY4UVPWCtwtST6/15Al+g6P1
         CaNsF6qgmBbj+jbWR21d6eHoXOoauNFj/skID/2woPTmfFgGdKPTlsgAVeJmVZQVcrE7
         Wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COXeAUL18hdrSXD+At7C4xdndPcfAFyxiVsz37xMwc8=;
        b=PIa+FaxJBqlmWBIu2Goer5VzKpmn6uX97ePsC+fPeGPq6+ErV8QFXq7kCk/zNA8luM
         0Ch8adZ2xguYIVCUdoRrC4C5wrO4QgFXpwNNNbjL/TPe/yxDBYmOx/g5BMKXAAK0bes+
         P1Z8sdRU8b3J2eC7XluWANNDxGYAOwbmCSae8C4T0zF2o05Q6SQ8RUWdeMHbFqcyKKkK
         vgV9rZKvs1z7eyf2cxPd+lM5QwPZcqjnEq3uhl2ChuWVbHEzB7/fzIhD62TAduwJyVbL
         x/MAzpX4vliQqgyS4ftFYTLv3SVKmv2Apv4S9tRtTfptScev0I49/EnpF14pdjJvbIzV
         dAyA==
X-Gm-Message-State: AOAM5328LLSQWcOvachlSJfG7qdgxemz/Sk6Y1caqGqMh7uOyt33jdjV
        IE5dfRvRSGulEI2FFBu/S+HflLqc
X-Google-Smtp-Source: ABdhPJxFsC9qGwstmFa7O3LpH90tP+JRDpGNKYIo0gNiYqnhtr9h6FaIrCPcNJSv5vQYOLclHxjavg==
X-Received: by 2002:a17:906:1187:: with SMTP id n7mr31075163eja.161.1593871071785;
        Sat, 04 Jul 2020 06:57:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:41c2:9e8d:5955:8578])
        by smtp.gmail.com with ESMTPSA id w18sm16348297edv.11.2020.07.04.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 06:57:51 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add support for arch specific asm constraints
Date:   Sat,  4 Jul 2020 15:57:45 +0200
Message-ID: <20200704135747.87752-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200704135745.lPH6Y2P4wYpTfErtl5P7dkdbBoepAoe793g873e9BRc@z>

When evaluating asm operands it must be known if they correspond
to a memory operand or not in order to process/ignore the 'noderef'
attribute.

This is done for operands specified with the common constraints
but not for the machine specific constraints.

So, add support for processing machine specific constraints.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 5 ++++-
 target.h   | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 3b9aec3c13c0..f515ce6f2de6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3642,7 +3642,10 @@ static void parse_asm_constraint(struct asm_operand *op)
 			return;
 
 		default:
-			// FIXME: arch-specific (and multi-letter) constraints
+			if (arch_target->asm_constraint)
+				str = arch_target->asm_constraint(op, c, str);
+
+			// FIXME: multi-letter constraints
 			break;
 		}
 	}
diff --git a/target.h b/target.h
index 8640026cc6d4..3ef0d520f83c 100644
--- a/target.h
+++ b/target.h
@@ -53,7 +53,7 @@ extern int pointer_alignment;
 extern int bits_in_enum;
 extern int enum_alignment;
 
-
+struct asm_operand;
 struct builtin_fn;
 
 struct target {
@@ -77,6 +77,7 @@ struct target {
 
 	void (*init)(const struct target *self);
 	void (*predefine)(const struct target *self);
+	const char *(*asm_constraint)(struct asm_operand *op, int c, const char *str);
 };
 
 extern const struct target target_default;
-- 
2.27.0

