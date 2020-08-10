Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3964C433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E17420734
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy5BldRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHJVyp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVyo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B8C061756
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so10967890ejb.0
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PewuXJOMmKcFgjGZBeYx8CJJfIZz8m/QKxQ0RGTjPRw=;
        b=dy5BldRdF89zSOCHHp3Mb+AAhnQxzuhrtKv9GTSY96QZqqh1GLkJiXeKvFKXX1TBz4
         oGbJcDGY+TQ7U9mQncgcs4wBwP3KI2LyryhyFWPWCeHja/qHQ5J+Ue3dKNqXHhKISIr/
         4/1jcvN7pzkptFfEt2IbLacOVnccAgHLQnaXPIGgjBRfCw/a0B/BrrA0TBmnTjQHPt++
         refSLp4V0mX5KytNQvdo9r6T7ysf0pFOGMLDyt70gOASYkop244KnWbZ6DfZ9BIC6M9y
         AaqUsHKU6gH+AyCF5g4yH+KuvJOOKva3pYHZSTjQP19bc6Ys8V+KpgWuzRYJp8vappnq
         RxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PewuXJOMmKcFgjGZBeYx8CJJfIZz8m/QKxQ0RGTjPRw=;
        b=r7zx8QNtgVDfdlNzJESIBh8yDR8LRhPK4ofr96vR30xRJBkJw1plx6L3IUjkvImPOn
         GzlwbDX9n/2yFmwReHeHkXqxGTssZS7eSZEaHNNu+1KAYRBtSGDEPdEAkg/EN5AaKYxV
         9uNL23k4O/GM7X1ZbzZpkSeKv0jnZnlIubwZI90qcciOGMuG0Ofjl18DoV3bksQB4CoX
         jwMbBhD95k/gMK0xqteJvav9hCCoFTk/H+f+hwkBq8hglmVtwEbvYEWG5BZW5PW6ckvn
         wYDd17Nz4kwJmMwbJ8ZWE23sbpPAxQEskYQe+pKqJtUKj6/mzEmkjiaHpjI7DHoUN63s
         OBDg==
X-Gm-Message-State: AOAM532XMFKNX+niP57lnUzAisS86qMI0h6FHQdsuF4ni7CxfehNSNYM
        PcZOxHWrFqYakeiYMxq2mz7RgJx2
X-Google-Smtp-Source: ABdhPJzP8GvJ2+bANXlD6ftS+nKAvuVvdhVlKmvhIX9kyLxs4ODHiNZAGsH3myNgcng5YEV9Kjvatw==
X-Received: by 2002:a17:906:6696:: with SMTP id z22mr7677197ejo.159.1597096482984;
        Mon, 10 Aug 2020 14:54:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/7] doc: decrease vertical spacing
Date:   Mon, 10 Aug 2020 23:53:32 +0200
Message-Id: <20200810215336.76070-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The vertical spacing in the generated HTML is a bit excessive
to my taste. So decrease it somehow, especially the top of lists.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/sphinx/static/theme_overrides.css | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/sphinx/static/theme_overrides.css b/Documentation/sphinx/static/theme_overrides.css
index 8791046c9013..3e4bc3b0223a 100644
--- a/Documentation/sphinx/static/theme_overrides.css
+++ b/Documentation/sphinx/static/theme_overrides.css
@@ -1,3 +1,16 @@
+p {
+	margin-bottom: 0.6em;
+}
+
+ul.simple {
+	margin-top: -0.5em;
+	margin-bottom: 0.5em;
+}
+
+.rst-content .toctree-wrapper ul {
+	margin-bottom: 0.5em;
+}
+
 .wy-menu-vertical a, .wy-menu-vertical li.current > a, .wy-menu-vertical p.caption {
 	padding: 0.2em 1.2em;
 }
-- 
2.28.0

