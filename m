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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F35C4363C
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FD02074F
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 02:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdv9KB6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJECAK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 4 Oct 2020 22:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECAK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 4 Oct 2020 22:00:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40568C0613CE
        for <linux-sparse@vger.kernel.org>; Sun,  4 Oct 2020 19:00:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so7161158wme.1
        for <linux-sparse@vger.kernel.org>; Sun, 04 Oct 2020 19:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i986Yb8/I7uUX3wjqlQH37k3bwP/SWF3dFyy4q0txHI=;
        b=vdv9KB6su9IrPJdTSJM8LeJO+NwoJA1qQNizXSwt/eKAgwHJThCdTtzgytL/ogHG1i
         saV3Hlc/QHNTEpFOjmbVEOI/PLmIZURPZsI3JCrmMAN9xe8TVml0ZwytT2uLY4t3b3Oo
         Ta91WWUxfQjq25zRlAIDAuflBKkhnbLgq22gdQYY6CiCZ/spNR0xIRLxuGA1Em/8gCez
         BZu5BIIm9ZE6A2rLAI9IfveAH0UnuBW6C33eXW8qkVmBxwtiVhBRfTXFOa5kZcXlTYQY
         bhcisVve2FgFkAZbmlX/rbEF47Vk8kFBEw4BgvqULTwOf3xsKXX7okxQaGqpiYYSwsWn
         CvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i986Yb8/I7uUX3wjqlQH37k3bwP/SWF3dFyy4q0txHI=;
        b=QhvbdwL10gfFX7CVHyoz5YnXBaAniNGeehidKWyiOrY4FVXekgUGUSS+ab86Raj2Wy
         7672yikf78Bn6VTKloSDzxqwIiVpIzvxgBBe7imHw8qupOF49FLEzxmSCuIVPUQgtvoO
         HOzH1vLezen2tXXILhgI/mYx4N0e7IZe6ub+nbwcdzDttGq78phPc3jD1Cf509nvpU6b
         D0s2hTBQ6aS1Eck/YWeGwPSKB12RCwd3ddzFDZxfnn0J60zg+G6Z1HooSFvSa3jknOis
         xdA9IhS/T1PS4yiYcQFBzmn7RstkhJmBGvzpgkHpFm+QK/Kug3D1aU5Mpl/o/X0yFKAa
         gu+w==
X-Gm-Message-State: AOAM532/wq+43OZ43FZVM76LKhluv5EtDm/xx4kDVptJZ3WYhxGrAPd0
        +iTaK76SZe6kNpjSIvAd3jNIIMBsvYk=
X-Google-Smtp-Source: ABdhPJy6/eK9z3U6XLYOWGguxM5KkKaycQUB7oWixEwwhxLlmughKVl7CiNX3/te3fHQKaUQmjqdgQ==
X-Received: by 2002:a7b:c359:: with SMTP id l25mr13641968wmj.125.1601863208670;
        Sun, 04 Oct 2020 19:00:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f14e:9b66:59e7:4769])
        by smtp.gmail.com with ESMTPSA id b189sm5541132wmb.37.2020.10.04.19.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:00:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/8] need to strip SYM_NODE before comparing types
Date:   Mon,  5 Oct 2020 03:59:55 +0200
Message-Id: <20201005020002.1108-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Every variable has a 'symbol type' of SYM_NODE which needs to
be stripped before comparing with builtin types like int_ctype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/varargs-format-dyn-prec.c | 11 +++++++++++
 verify-format.c                      |  3 +++
 2 files changed, 14 insertions(+)
 create mode 100644 validation/varargs-format-dyn-prec.c

diff --git a/validation/varargs-format-dyn-prec.c b/validation/varargs-format-dyn-prec.c
new file mode 100644
index 000000000000..a143f1661c84
--- /dev/null
+++ b/validation/varargs-format-dyn-prec.c
@@ -0,0 +1,11 @@
+extern void pf(const char *msg, ...) __attribute__((format(printf, 1, 2)));
+
+static void test(int prec)
+{
+	pf("%*s\n", prec, "xyz");
+}
+
+/*
+ * check-name: variadic formatting test dynamic precision
+ * check-command: sparse -Wformat $file
+ */
diff --git a/verify-format.c b/verify-format.c
index 2da9d2069121..ba6cb5646dba 100644
--- a/verify-format.c
+++ b/verify-format.c
@@ -325,6 +325,9 @@ static int parse_format_printf_argfield(const char **fmtptr,
 	if (ctype) {
 		struct symbol *target = &int_ctype;
 
+		if (ctype->type == SYM_NODE)
+			ctype = ctype->ctype.base_type;
+
 		if (ctype != &int_ctype && ctype != &uint_ctype) {
 			warning(expr->pos, "incorrect type for %s argument %d", which, argpos);
 			info(expr->pos, "   expected %s", show_typename(target));
-- 
2.28.0

