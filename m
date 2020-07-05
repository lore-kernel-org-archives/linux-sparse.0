Return-Path: <SRS0=rRy8=AQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6EC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCD020747
	for <linux-sparse@archiver.kernel.org>; Sun,  5 Jul 2020 13:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4W6BsV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGENCc (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENCc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C9FC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so26551962edv.6
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLDxotR4LWJLM1++xc/ZIF1iQIELRIcRP3vM3vOzBKE=;
        b=Q4W6BsV9Doe8YG+EJmdRNr/AWYUlwA55GHAUBbFh+OZkzErbBv0EGerW5oWYswq4hh
         g5f94eJ1W7Y7OKrYmEtnEfqjOFZXRs/AEYCnHGh25ScXNVFIovdOgOieo5yEp3mHqXAC
         qRBFyHcc7DU2zOja8sI62JXHjbFGcrrJjrYYPkGURQoF4fTc3GyirbJ00Ws+oZmG8eIK
         fGUAyZHvcHlSUMkCvx4YNqgybbWmAWSSWiR748ntVrLeT5Y3aAt6OULyUN+G/vPee2C3
         e0jjsCuTM/ieRHIRZLmpq+jamlM2VFvpQUjYPP7kuIfhtrrvyfkZBA7ve9S3umQJxLcZ
         EuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLDxotR4LWJLM1++xc/ZIF1iQIELRIcRP3vM3vOzBKE=;
        b=tp9Fh+01TK+UKUTpYDu8SRcswOtQl69ONXk9Iin6KN+si0hmlawD2D5ax9wxOOc8Sw
         vX4AxFPjqXpz2grDU99lucPJn1Jrls13+wNHM+3iy6JS6uejBI/2C0P4fMa8DJ0kdQRk
         mUB6txh9ieH67h+sxgK2xB8dg11AYPQA6E3LgUEpQH8d/z1mML14A10QbDqv9bHbCZG9
         yvJ4cdP0X5w3tUDYQsd9ZQjqiAhEpO3XGAJrt8x7SM6Ynzj+Tfmfq+cnLWYChB8wnBsm
         Hmk++/znfsK6iR9+4aYzt0uA/Yl8OB81brjXPIEXScmeBBEkylVXfYbNPcoMEV++0D7U
         WnnQ==
X-Gm-Message-State: AOAM531oAUVQjq1xEoTY6AxzIxLUepmyCxOy1bTbV+9rGjkxYwz/sY7K
        l93PMf3pFQ/Vhl6Ep05ews/3U1wt
X-Google-Smtp-Source: ABdhPJylz/l0iBaQ5h4THW8GgH16WnAe5A4gkcnNi+hlepLffbsvnVIMoKpKydZv1fq3tuXwvBFv2w==
X-Received: by 2002:a05:6402:b84:: with SMTP id cf4mr25796953edb.21.1593954150416;
        Sun, 05 Jul 2020 06:02:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:a542:d3fb:b75a:dec5])
        by smtp.gmail.com with ESMTPSA id x16sm19535945edr.52.2020.07.05.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:02:29 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/15] options: move on top the definition of warning type enums
Date:   Sun,  5 Jul 2020 15:02:08 +0200
Message-ID: <20200705130220.26230-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200705130208.cjgLPWRSGKFKtH_xB2Vdm0Nq-Y9mpnbl7cxezvyyOp0@z>

This allows to reuse these enums in earlier helpers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib.c b/lib.c
index 5128a5b64e9e..43d55a0648ee 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,12 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
+enum warning_type {
+	WARNING_OFF,
+	WARNING_ON,
+	WARNING_FORCE_OFF
+};
+
 int Waddress = 0;
 int Waddress_space = 1;
 int Wbitwise = 1;
@@ -523,12 +529,6 @@ static int opt_##NAME(const char *arg, const char *opt, TYPE *ptr, int flag)	\
 OPT_NUMERIC(ullong, unsigned long long, strtoull)
 OPT_NUMERIC(uint, unsigned int, strtoul)
 
-enum {
-	WARNING_OFF,
-	WARNING_ON,
-	WARNING_FORCE_OFF
-};
-
 static char **handle_onoff_switch(char *arg, char **next, const struct flag warnings[])
 {
 	int flag = WARNING_ON;
-- 
2.27.0

