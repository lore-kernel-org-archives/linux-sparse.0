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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47236C433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58BA206D4
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBGUpHvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgJNJWq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbgJNJV4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD404C05BD3D
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i5so1219044edr.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJ46ZclqeWgaSQfA205KdfG7Utj/1/TZ6F9yGemHX1E=;
        b=SBGUpHvEknB/WNReU8N15ZcFlBF58gOMO+NNMdPBL1hmdm9VYexEDypf66cc6bgBhA
         K9POCj4NtN8F8ZDyCDitxyltSuDZPp2wUS/G7pcad32wBhCGVKAHKLEEa7vHEn9QErTT
         FZmeG2g9qNq134X7hwS7cTDTD+AyVuzZz8oDqCSqqbNcu6B/BEC+xEapPzMaXny/lJ6k
         Dozu1yV9vCcTnMM2KKOCRTxNZVlsZTb/4vmGZUsBpc4V/tZGMDCHExsJDJqYZG3DcC6P
         0hJo1DgG5ue3b1JhBftdQDuSlCyF+ax7/2+zwUk/CAKyG44pjo30nAllSejjfmIP5w+s
         Lljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJ46ZclqeWgaSQfA205KdfG7Utj/1/TZ6F9yGemHX1E=;
        b=CHbid5LE+aXBRLfXzGTekwbRCKKvJwesfuV3dxWeBJsnQ1KPEllRzSOYkWGi+yf2kw
         n33kQDhgspkY70PHd/ZUIioYpJj2kl2MjcWqBAjeEXQL8ynC5+zkRwyVRbm9VMJL1rgD
         Pxc/Wla58Q0GRe8W4mUreqiC+r+oG+//5aSSGcUlVJE71JupE6Lr3cnHMhNpzPe3OSf+
         V5EXN4ZOFmkbsNVLz2rxPoUqWvqZH2+BUjEpaEypzwnNS4qP+03zF2V/JEBwFrZFnzUB
         gVp4hepd/8pfRJ0m7mc26PTWPkU8nYT7wY8bR+Ot9Gsk6cxKwTK+qOhyb1TFtK9aq3j1
         P3sg==
X-Gm-Message-State: AOAM533QAo6enMux2zKumxKvWc+TzMe9FwQrg8KFmy/SwwEVAiqcFNlI
        9l1ERFNO2HJYqcXg/znqzLm0qA8kL2k=
X-Google-Smtp-Source: ABdhPJxcxnoMeCbgo1y0WNGdplUTK7GGEsTB362ZnggHp+Y6ojR0pyhkc7lktG8ysDtWpOg4KO7lsg==
X-Received: by 2002:a50:d7d8:: with SMTP id m24mr2104258edj.388.1602631366234;
        Tue, 13 Oct 2020 16:22:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/13] format-check: add a function to check to type of strings
Date:   Wed, 14 Oct 2020 01:22:24 +0200
Message-Id: <20201013232231.10349-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This checking is currently done by check_assignment_types()
but this is not adequate, for example because it allows
a void pointer for the string argument while a warning
should be issued.

So, add a custom checking function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/verify-format.c b/verify-format.c
index 0ef2cb863ae9..90fe0ede0431 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -106,12 +106,44 @@ static int printf_fmt_numtype(struct format_type *fmt,
 	return check_assignment_types(fmt->type, expr, typediff);
 }
 
+// For 's' & 'S' specifiers
+static const char *check_printf_string(struct format_type *fmt, struct symbol *source)
+{
+	const char *typediff = "different base types";
+	struct symbol *target = fmt->type;
+
+	examine_pointer_target(target);
+	examine_pointer_target(source);
+
+	if (type_class(source, &source) != CLASS_PTR)
+		return typediff;
+	if (source->ctype.as)
+		return "different address spaces";
+
+	// get the base type
+	type_class(source->ctype.base_type, &source);
+	type_class(source, &source);
+
+	if (target == &const_string_ctype) {
+		if (source == &char_ctype)
+			return NULL;
+		if (source == &uchar_ctype)
+			return NULL;
+		if (source == &schar_ctype)
+			return NULL;
+	} if (target == &const_wstring_ctype) {
+		if (source == wchar_ctype)
+			return NULL;
+	}
+	return typediff;
+}
+
 static int printf_fmt_string(struct format_type *fmt,
 			     struct expression **expr,
 			     struct symbol *ctype,
 			     const char **typediff)
 {
-	return check_assignment_types(fmt->type, expr, typediff);
+	return !(*typediff = check_printf_string(fmt, ctype));
 }
 
 static int printf_fmt_pointer(struct format_type *fmt,
-- 
2.28.0

