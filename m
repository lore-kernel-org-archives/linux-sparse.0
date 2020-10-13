Return-Path: <SRS0=XrIr=DV=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2314C433E7
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0BB20709
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYutWEpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgJNJY2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbgJNJUL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCEEC05BD3A
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x1so1231274eds.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvlC/2R8xxwE9ap0gHjMwJqLIunhhYeDJ9D8qPw+/44=;
        b=fYutWEpqiBWKQPyPdAPlCfsJsNiSkXvsV2ist6tkgk5DlL//N5aBHIk++3Dk0AQgtU
         Kaki4PMcEjdVYePz7bcMXhv1NJAWWVc/+AUiEXeFBbNZpi8jf6grBJRurVlDYGycZy1J
         FvxbPviyCp3jmUoteqobH5TFFZARqssrih8XnXqtw1vb68o2DIqovLhEnEgHUze4NcfW
         NFtWdhuoDUwyU19kqp4wFMXu/wg6qZDm+z1LgggXrE29oveEJ3jCVc53OETOfjfHdyZL
         PzEJiTel9/aCVeRIcllJbm8yfegUkesl5IIdLpsqo7rjrhnBTVLaBLX0y8lgvn6RWu3F
         gnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvlC/2R8xxwE9ap0gHjMwJqLIunhhYeDJ9D8qPw+/44=;
        b=raq26dectOH0uxDVGk7bBBY7pizuYjUcTvNJQvky7+LEIGb2FU0IZN3g6uMZ970daY
         MurqeTqchJ+TMIfe6nBw2uS9+JMBd7Qnr1h33F/A99V7epaKWLJsM0M3O7u3J4VwBEVw
         yyoYESPV+oCKi7jIBiB9pq5qheIhrcqwvfX8mfU75/z9PFp/57hN9012tVOFC4kOiz6Z
         sM6zI49GJuut7wKQSiSeC+A+vtFHIOBBxX7kcYp135mp25NVYhuO08XEZWOexbdOJj8K
         Dl3qCPR1A7qGS4x6XFu8La24Q7KWTQWon3muEy3pvdM4Vog8iETQX/GGaMBLCljYk5N4
         xkYg==
X-Gm-Message-State: AOAM530D19t64DdKRl3gHXHMWnPcNzoMYPoCpF5EYh+If1qeGZgo84IT
        Kkpir3Zv9X0pCzAVZoxFMWd+tn0T5Ok=
X-Google-Smtp-Source: ABdhPJxGr/yntWQ+HOn9bdltxvPxhH4EcACAyqgov0ohsT1qGb0SPJViXg1c1Xw1jbSifSeoB55TaQ==
X-Received: by 2002:aa7:d689:: with SMTP id d9mr2247822edr.128.1602631363337;
        Tue, 13 Oct 2020 16:22:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/13] format-check: add helper type_class()
Date:   Wed, 14 Oct 2020 01:22:21 +0200
Message-Id: <20201013232231.10349-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This will help the next patch to verify the types.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/verify-format.c b/verify-format.c
index ae5bb2e6e985..fd5a9ed821e1 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -70,6 +70,35 @@ struct format_state {
 	unsigned int		used_position: 1;
 };
 
+enum {
+	CLASS_OTHER,
+	CLASS_INT,
+	CLASS_BITWISE,
+	CLASS_FLOAT,
+	CLASS_PTR,
+};
+
+static inline int type_class(struct symbol *type, struct symbol **base)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	if (type->type == SYM_ENUM)
+		type = type->ctype.base_type;
+	*base = type;
+	if (type->type == SYM_BASETYPE) {
+		struct symbol *kind = type->ctype.base_type;
+		if (kind == &int_type)
+			return CLASS_INT;
+		if (kind == &fp_type)
+			return CLASS_FLOAT;
+	}
+	if (type->type == SYM_PTR)
+		return CLASS_PTR;
+	if (type->type == SYM_RESTRICT)
+		return CLASS_BITWISE;
+	return CLASS_OTHER;
+}
+
 static int printf_fmt_numtype(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
-- 
2.28.0

