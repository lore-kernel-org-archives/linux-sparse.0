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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A59C433E1
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E51206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5pp5Nlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgHJVyp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVyn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76930C061787
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f24so10943446ejx.6
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNsttxT7Akl/RI+ZvU6cHJ8Ib0z5Axz/sV1pVDMHJaE=;
        b=b5pp5Nlb2RFHZzoPGlJNlA6n/CYaUIur31+zmqyTLdUXRRAwBl4BkavBm5dr0rG4Cw
         /OzIqcKYB2KTOGKyv18JE2pO0y4qRmUCaoi3RuQgXlskDeYYQLIxYX+7U4MQdEMrsqa+
         DcWqbWu/KkG6LR5PwEJiX3Lv93iUJvZ/X4BcBC8qDivsK6xT4Wv5As0YUfM4HGi3ilwc
         gqmWCvTGEJ4KK/smmCdXsKPg3rFo/OXvdMrGjRPivjeGKKeHzY0kuYcGDcc1RhiPNEoa
         kGRB34L6zTbZZCDAZnjSy09NiDIMGf4HquUhvi2a5YlI3B5tkdXJKUDSAbwFt9yOgnKH
         5QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNsttxT7Akl/RI+ZvU6cHJ8Ib0z5Axz/sV1pVDMHJaE=;
        b=LozJlhOxAFd9ZFRHqA9h7UXW9FIHZbzGs0ROSH7LjmSwoJxWjNrutgtxT3THlZvd3C
         yi2Zy0i1w2PLvSea2v9Wqo+C0+ruB+5PD57DAYaD2Lagjm+n2J1tl+X/PWOwzImkAOsF
         Kpl8ETdIk/ZPYdpPXsglSIRQZAZHzYyGC9ZjrmRljC31PIKGSVsFG2NlTKp1X1kwYGIF
         CZAgNu/0c74Q/bNHlMI+Q6FbNLV8kwaHrMfO+rrGxFIFoU9/7CS3sI0DHRf3WQLocFU1
         Oe/vRQxnTXhBj8yVjcQ47sy++VVli85fKPl5C2WIWzPml39pflIEROulR15M80CQ9Zzq
         BflA==
X-Gm-Message-State: AOAM5329Wdmqwnk8i5/QIj2c7BTPlN47Yn5acZs0niODTMq5lU6ZVOqg
        Y4ZlKDGBofx97K7DzhDgGjxdhHAI
X-Google-Smtp-Source: ABdhPJwnxizOfbHA99L0C9C5CYh7NuAGf6k0iUB5I3uIpeSE7VLGq+fNjjflC+rUjzTd8qVZN+rTwg==
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr23128617ejb.91.1597096481879;
        Mon, 10 Aug 2020 14:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/7] doc: make the sidebar more compact
Date:   Mon, 10 Aug 2020 23:53:31 +0200
Message-Id: <20200810215336.76070-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There is generous spacing in the sidebar, too generous.

So, reduce it to something more compact, which will also
allow more entries without scrolling.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/sphinx/static/theme_overrides.css | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/static/theme_overrides.css b/Documentation/sphinx/static/theme_overrides.css
index 8d6246e4202c..8791046c9013 100644
--- a/Documentation/sphinx/static/theme_overrides.css
+++ b/Documentation/sphinx/static/theme_overrides.css
@@ -1,3 +1,7 @@
+.wy-menu-vertical a, .wy-menu-vertical li.current > a, .wy-menu-vertical p.caption {
+	padding: 0.2em 1.2em;
+}
+
 .wy-side-nav-search > a img.logo {
 	width: 60%;
 }
-- 
2.28.0

