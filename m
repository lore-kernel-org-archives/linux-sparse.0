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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D19C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CA8206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqAMbnD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgHJVyn (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVym (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34386C061756
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so7513598edv.11
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NORwqAl8vhsQqDRGGWtrgGgmrCJbU6kdYr/O3c6qfs8=;
        b=lqAMbnD9U21irzhW8Cc4aPwAGR/54ItHY3DcLbo8oplI3MaDcDJfx36mNt8K9kNp99
         IXM4l4hDlKc04QhjehzlJc47irIlo0gUrZaIGN3I8Ccxn8YgkV906cPqZdksJZ7zlN8Q
         rO1r63uYSFmsRDa38DTXBYGEtNXcBmxkHm4nxPeoR+hFJjOAAU88QjvbhycVozAL5A3t
         En9vr0pjUP3Dz0k8sgGLS14Rmnequl5a0QmUie2xpEJnRzmD1KbFKztAAI7BDDEI58JE
         bjIEc+wbRu3MOCVuyf6pJYl///f6vkdcQhzHyj/157iJ/gbmevLAD0X0yihkBfQwZHcC
         KZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NORwqAl8vhsQqDRGGWtrgGgmrCJbU6kdYr/O3c6qfs8=;
        b=fKUQOHEwwQcqLDF/SrMvQQ/mD9WVRHPh5c3O6njl/6R/FGbJ2JhZBRZp22GCNV+Fym
         eGDvBx3n+T47Yv05VeLDCU2NRHyV4X+QPZvd4WcLs2AC0R+vqsWfesY9ecEfaG1VDq6w
         Wa9FCVdwa0sWzwQGuGWtSjl4D1JMpsKcdk68HEuJ+ZDKjW8weqNXUxtEORhzczISVPqF
         MToIPKCp+RmwL9gwY8B3IJ+Ed/Fr7/NEAgvqc9OXfWPkDuvdW4xoYWw3e5PCJwN4Rz5n
         QqIrODJ4HdV/22Tvzm+s605NJCszMTQCBNdM+Xjoss6jj4eeq9H7mPL+cC8xe1YiPmBr
         lcGA==
X-Gm-Message-State: AOAM532dkao5teTLaT5cpmioKlMmXNmePi3JowVWGfavglZOi6fBQ/fS
        B33Zbk9fxb2s3ahkIlNIfmEjQ7/F
X-Google-Smtp-Source: ABdhPJy+UuI9b+PrI8TweC7Q/damhzlwCSfm8jxNsLp94HCaUZyDZLidf7vqs1DXHn+2z3wqFX2WSw==
X-Received: by 2002:a05:6402:1457:: with SMTP id d23mr23286954edx.149.1597096480659;
        Mon, 10 Aug 2020 14:54:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/7] doc: use a smaller logo in the sidebar
Date:   Mon, 10 Aug 2020 23:53:30 +0200
Message-Id: <20200810215336.76070-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The logo takes quite a bit height in the sidebar and so
pushes the table of content too much at the bottom.

Fix this by reducing the logo to 50%.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/conf.py                           | 8 +++++++-
 Documentation/sphinx/static/theme_overrides.css | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 89ba3d785c7a..affa907346c0 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -113,7 +113,13 @@ except:
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
-# html_static_path = ['sphinx/static']
+html_static_path = ['sphinx/static']
+
+html_context = {
+    'css_files': [
+        '_static/theme_overrides.css',
+    ],
+}
 
 # Custom sidebar templates, must be a dictionary that maps document names
 # to template names.
diff --git a/Documentation/sphinx/static/theme_overrides.css b/Documentation/sphinx/static/theme_overrides.css
new file mode 100644
index 000000000000..8d6246e4202c
--- /dev/null
+++ b/Documentation/sphinx/static/theme_overrides.css
@@ -0,0 +1,3 @@
+.wy-side-nav-search > a img.logo {
+	width: 60%;
+}
-- 
2.28.0

