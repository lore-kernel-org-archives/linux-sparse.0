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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1CAC433DF
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC32206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRBnAR0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgJNJXh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731257AbgJNJWz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0641C08E81A
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 33so1163973edq.13
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QguL12NZ8MPToQ6/tV5vDq/+CVOY31eX9n/O2NWLy3I=;
        b=kRBnAR0tMSdWepoliSTtJWSwJvoRkE5RW0UNBIlPXOecvISXfQLT6/0XcO6UV/3VeM
         cMiz/gDuTwVHNuiIudm3C0otzwTEDHvR6nmSXon1URRZJuu68wPzhUba8aMlLbbbiIxw
         Ncvw6g8Srt9uJBKpeCL3SfBTqqqSKK8YpHB6Gng3Au4a59Fdq3o70x3/ifpFLqckphzG
         zXDAKCS/AJ/c9qqDLBMQHeIAElsILaIP4gqKexWb0EVaYwHf9CeoZqnOSISXK36seYyS
         +M2HxsHIsN32Kt1IdevmrGn+QUeVc+/2MQ2pMIPbFYe3R3d/6itySR0oIsleokz5qXIm
         AmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QguL12NZ8MPToQ6/tV5vDq/+CVOY31eX9n/O2NWLy3I=;
        b=m0uBuijjoZNa5TgQciMdwyidQ6HsmEDWmUErq/Tsn9w6dpgadcUdFSE3PCapXsPuuq
         24foYFkarqHKVgo71lntEtB8hUn7hyLXn9InY7faCWRkmjj2KR2ySuSAVEnqsy1QpY3s
         1RG2oKy4+B40df/tI02zqjJ09gSRUIHJUx6YOH2ZWeW8CZyp0uFL5hvD7oXNBRqrc6SA
         bzYDUttkPNkzZVSupRemv/MdMNV6g3/VnP5N5lOsJ7aihUKBW4+/GxaG3FODrf5414pA
         yCzlXmWiA0J+NJTWoYqh8IKUtDvubAuGPuL05BSTnU1beO3EXDfFhAb+Edztt+N4yjyg
         vdww==
X-Gm-Message-State: AOAM532cwHpkd28iufLtGCiNZ3fkAb8H5QU4T/uke8ur2aOsM7XhLtNt
        f27kLsCRHOjWkq94DafG1EEhkFiGjXM=
X-Google-Smtp-Source: ABdhPJxPy8T2RYo41p/1gmE/MCl20rXg/Pvakj0MjtD6jsUbpZAbRb5iTVmHc2JKhqOlat5zAWbfBw==
X-Received: by 2002:a50:af21:: with SMTP id g30mr2165179edd.46.1602631368282;
        Tue, 13 Oct 2020 16:22:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/13] format-check: add a function to check to type of pointers
Date:   Wed, 14 Oct 2020 01:22:26 +0200
Message-Id: <20201013232231.10349-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
References: <20201013232231.10349-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This checking is currently done by check_assignment_types()
but as an extension, specific pointer types will be checked.

So, add a custom checking function, currently accepting any
pointer type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/verify-format.c b/verify-format.c
index 1b40b2c796a2..cd55a49e0676 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -181,12 +181,24 @@ static int printf_fmt_length(struct format_type *fmt,
 	return !(*typediff = check_printf_length(fmt, ctype));
 }
 
+// For 'p' specifiers
+static const char *check_printf_pointer(struct format_type *fmt, struct symbol *source)
+{
+	const char *typediff = "different base types";
+	struct symbol *base;
+
+	if (type_class(source, &base) != CLASS_PTR)
+		return typediff;
+	// FIXME: check or ignore address spaces
+	return NULL;
+}
+
 static int printf_fmt_pointer(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
 			      const char **typediff)
 {
-	return check_assignment_types(fmt->type, expr, typediff);
+	return !(*typediff = check_printf_pointer(fmt, ctype));
 }
 
 static int printf_fmt_print_pointer(struct format_type *fmt,
-- 
2.28.0

