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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E18C43467
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A400206DD
	for <linux-sparse@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrrV7GTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgJNJXg (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbgJNJWz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4EC08E750
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so2134198eje.8
        for <linux-sparse@vger.kernel.org>; Tue, 13 Oct 2020 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJE9DhAOhF1t4lhbl/R3uiXvlM63N8OiEE/VqUaZud8=;
        b=IrrV7GTpo1xGitjTuBhdDDQBkER3CMOtgEg8VqQ82mrXMlT232OCh1VCJJ2VT4FE1a
         iS+HdvqAf7XPbWBQwOVP1CJLw/cOaORDTMtoKFdCxYBt3r2K5+vSeQLd/jXpTw1iZSv6
         SzTIHh1IhC/A0l2qj+Jdz5sko/eswFYYWMftk+mAAOd6U0/rT/0h5WbkXwsvRaSFf9FN
         QtkU7QMUJQ5VQD+aPFSQo4pmqKphgu3G/BoED+LyTD24+xC2q07NLxvyR0zqGYOiGX+r
         h1Th3asBR3Q4wLy1wM8njy7mn4h2NgAyg51bswkCE4AZ3C+8MfYRNJes0USGqNJsVJhC
         s4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJE9DhAOhF1t4lhbl/R3uiXvlM63N8OiEE/VqUaZud8=;
        b=WVRVW5qoN3Wz4RYqak0EhnhlTspLNHcd1+pYSwESp8cH8N/AMUhQIMsrv3LSr15glt
         JRtF9hU42AkKX14AhkDRUzj0tBRq//n2GcnUT9p5YsOz1IAWyHK2Ahf5A8PoZkZdW53v
         kZrfFq4tw5FZmqHPPWkEJoM/MNQsk9YbNXKooXhXOnihAYewTwSyKWolDxQczaKm1ipf
         9OKKuaJDY9LC0ptidFXZpjgD+uBMHK9scbBtrBOQzKkFjBci4HNF5HJrxuVJNh6SDjpw
         c9RJpErGb2one8GZ0S8SLaXpUfIqQGL/rUwnDG+R1PpyPI7qbM3lVFaaVC697A6on/he
         hgsQ==
X-Gm-Message-State: AOAM533Xicz/ovDlTZthoQlH3cDUIzpzhyk3ppMzwpKK5o48NvL+IOpn
        kNxpQCg9NrJ1aPblNQ+BKTa5Wn6Zue8=
X-Google-Smtp-Source: ABdhPJx+sAo4gLNwstNGXuDxf/M9L9X9385kfbEpwUduWnVVZHyHPxnyce8E0CcO1KOZFKpDX3TFzA==
X-Received: by 2002:a17:906:486:: with SMTP id f6mr2210355eja.473.1602631367211;
        Tue, 13 Oct 2020 16:22:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:5515:f93d:cc48:6a5f])
        by smtp.gmail.com with ESMTPSA id g8sm640902ejp.73.2020.10.13.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:22:46 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/13] format-check: add a function to check to type of 'n' arguments
Date:   Wed, 14 Oct 2020 01:22:25 +0200
Message-Id: <20201013232231.10349-8-luc.vanoostenryck@gmail.com>
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
a void pointer while a pointer of the specific type is needed.

So, add a custom checking function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 verify-format.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/verify-format.c b/verify-format.c
index 90fe0ede0431..1b40b2c796a2 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -146,6 +146,41 @@ static int printf_fmt_string(struct format_type *fmt,
 	return !(*typediff = check_printf_string(fmt, ctype));
 }
 
+
+#define MOD_IGN (MOD_QUALIFIER | MOD_FUN_ATTR)
+static inline const char *compare_pointer(struct symbol *target, struct symbol *source)
+{
+	unsigned long modt = target->ctype.modifiers & MOD_IGN & ~MOD_REV_QUAL;
+	unsigned long mods = source->ctype.modifiers & MOD_IGN &  MOD_REV_QUAL;
+
+	return type_difference(&target->ctype, &source->ctype, mods, modt);
+}
+
+// For 'n' specifier
+static const char *check_printf_length(struct format_type *fmt, struct symbol *source)
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
+	return compare_pointer(target, source);
+}
+
+static int printf_fmt_length(struct format_type *fmt,
+			      struct expression **expr,
+			      struct symbol *ctype,
+			      const char **typediff)
+{
+	return !(*typediff = check_printf_length(fmt, ctype));
+}
+
 static int printf_fmt_pointer(struct format_type *fmt,
 			      struct expression **expr,
 			      struct symbol *ctype,
@@ -335,7 +370,7 @@ static struct format_type *parse_printf_get_fmt(struct format_type *type,
 		/* pointer to an de-referenced int/etc */
 		// todo - we should construct pointer to int/etc //
 		// also should not have any flags or widths for this
-		type->test = printf_fmt_pointer;
+		type->test = printf_fmt_length;
 		type->type = &const_ptr_ctype;
 		break;
 	default:
-- 
2.28.0

