Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB25C4363D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FCBA2074F
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKW9nf9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJECAP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJECAP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05208C0613A5
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so4860091wmh.1
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVoCPWeQx/wZcqHkMLZpG8oS9R3J5zBGi+HHDe26Vm4=;
        b=IKW9nf9bBEI7Z2qkOqOn+sKbTFkH5iebwImz1uogz3a7+4azvJ87UtTyeJh/+cQJsr
         V6dj8qCoBbfvA0nsUUyey+GSU0TUAS0rs8WvABelLCtZJ78N5nybgp+CP+qXFedDo42i
         ipKxFMLnMrsUqu/CwVnpatD2OjFywah/OdEEM9ZNuH78HmpDNnA4qk5IHj0JJC5wdvTD
         IHXGB/MT/B759hbDla5vhCHo15jI9L2PEjq1VqkwL+krefNtEikywcvzTooHqmky1xrg
         OZ4vv6yJM4G382NbGRnXORXflWjcOVTn3MM2+M5NF3VmvBpw+Us0/sWPGZnGf+w5b4au
         ulhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVoCPWeQx/wZcqHkMLZpG8oS9R3J5zBGi+HHDe26Vm4=;
        b=Q16JGnvegaMfRhJjIW4PIOCfg+iwbMhrEUPV9otnnnMV87T+cF29x8xi8xgngwqkCL
         XCy4FF2XzsxQGv0A8Fb+Qcu/Ms/iAPMctk/AKTY5cHePkSh6BJKs35mFjbV+YXE3NPJm
         6kBcqBcv96JOev6Ya+mmrQOM8RyhNvtzr0IIokNoheEyfsEhes6nURa04GGyvpB6xVnC
         3bS/kTStvSfauwxk1wE40rnm+Ri9jPD1ymPwKQPEQmDyVJoi6uL+pVCzCV1CxNX4ZWGC
         xzI1PK7qEp6ofjgKH3p52m37Kii/0I4ViiYOcYp4cS67RIh6684gJOikhGp1dVn9lJ3C
         3qfQ==
X-Gm-Message-State: AOAM532GaeLrIUMpTke4uk91Voc+PqZo4SkrPuwT4rncPfLCUp6k6x8n
        x9UWxxLQL2kD2icanVRAEB0lbnNXPfE=
X-Google-Smtp-Source: ABdhPJwyExTrnf2tc4pDQ7IyCj1et246Re65NqWF4NdwjqSrLbOqm9+DR84BknE8Mef75xNkefVgWw==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr15169177wme.185.1601863213458;
        Sun, 04 Oct 2020 19:00:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] add support for "%ls"
Date:   Mon,  5 Oct 2020 04:00:01 +0200
Message-Id: <20201005020002.1108-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/verify-format.c b/verify-format.c
index 95ff524c03cf..b27440b87c6b 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -77,7 +77,7 @@ static int printf_fmt_string(struct format_type *fmt,
 			     struct symbol *ctype,
 			     struct symbol **target, const char **typediff)
 {
-	*target = &const_string_ctype;
+	*target = fmt->type;
 	return check_assignment_types(*target, expr, typediff);
 }
 
@@ -130,6 +130,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 	if (*ptr == 's') {
 		ptr++;
 		type->test = printf_fmt_string;
+		type->type = &const_string_ctype;
 	} else if (*ptr == 'c') {
 		ptr++;
 		type->test = printf_fmt_numtype;
@@ -231,6 +232,10 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 			type->test = printf_fmt_numtype;
 			type->type = szmod == 1 ? &ldouble_ctype :  &double_ctype;
 			ptr++;
+		} else if (*ptr == 's') {
+			type->test = printf_fmt_string;
+			type->type = &const_wstring_ctype;
+			ptr++;
 		} else if (*ptr == 'n') {	/* pointer to an de-referenced int/etc */
 			// todo - we should construct pointer to int/etc //
 			// also should not have any flags or widths for this
-- 
2.28.0

