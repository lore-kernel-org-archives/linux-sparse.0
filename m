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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960CC433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8D7206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD7UwhO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHJVyu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgHJVyr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85686C061787
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so10910899ejx.12
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+bRI7gklBgcfuIh8mPjPrpgZq3OU1dsJquvdnGMjdI=;
        b=QD7UwhO7LLoH8YE5kZ6lxnGbEWrJbg6rpnrY2+B6UJPT1pxKLZG6fnHwR/SZI4j3CO
         z1emUbXq/6ePGRrxUlhtWDjBaC7EmNb0m95mOu9bnDrdo8IYxiII/t6FU9P/h+3rj5qr
         Lcc+74Cw7XWAbOmf/3Wctlq2cxv4nzwOC15MBXppqmhk40sm4+MTxYGoUqQHeBTmGi2e
         HkIVMCp+UIIffDzzxCe9+ASp1FUHXxGHYPyseJsWqZavI3fAEqesB+TVB2RagwaasFv1
         o8/xyjuBXmfSmXuq+4eBAOlH6ICTRVDjsS7GZANKdgNkej2IOun7Iu3UAkZpnOd+D7x8
         EgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+bRI7gklBgcfuIh8mPjPrpgZq3OU1dsJquvdnGMjdI=;
        b=pEGYxUl41QfAixM6FnY5w+TNyv/Y533yYRQhr6/kwB3+yn8kKyPKlEjpOI0lziEGJf
         /sb+o0VlAoMPYUKwYH0wA9uFLiRRaPpcALWbW/Jr2gLP38tJeVv9XR6cAvC5+O5CndtT
         ylTzF7LUGFxwtmpHZ53p3lYztWPVhlNEab0aqarAeSB1mvazSapLWkx+jLACjg3UhYIg
         l4kSAgB5x8hwBeT6OH/y3xDK1hzUJ4AFufDTzTdiogkLCOfw+wd/Z2b+Cj0kForqCDMF
         o+oa6xasqZ0GBiT4I+jLyABaMWtr0eStAg/+j54DveCLurmrvMil+c6WWdgEdEPUbVxf
         WQYw==
X-Gm-Message-State: AOAM53005Ffp5GBwb1vDquMFPiwp2eQCsoTjhnu0uoAiddDiaSSqQquG
        z5HMe1LdfogOSJzI1JLX+QcIm2/b
X-Google-Smtp-Source: ABdhPJxYixNF6Yi/A95Wdc1TZj14fdamkVnD8HO+FPhpksd5n7IKvxRJp/7c7TcFI9YdnwMbNneXQA==
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr23966659ejr.336.1597096485005;
        Mon, 10 Aug 2020 14:54:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/7] doc: reorganize the table of content
Date:   Mon, 10 Aug 2020 23:53:34 +0200
Message-Id: <20200810215336.76070-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Reorganize the table of of content with user documentation first
then all documentation useful for development on sparse itself.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 321a947ec9c5..4bca8c7e47f3 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -64,22 +64,22 @@ Bugs can also be reported and tracked via the `Linux kernel's bugzilla for spars
 
 
 .. toctree::
-   :caption: Documentation
+   :caption: User Documentation
    :maxdepth: 1
 
    annotations
-   dev-options
-   types
-   api
-   IR
-   test-suite
-   doc-guide
 
 .. toctree::
-   :caption: How to contribute
+   :caption: Development
    :maxdepth: 1
 
    submitting-patches
+   types
+   api
+   dev-options
+   IR
+   test-suite
+   doc-guide
    TODO
 
 .. toctree::
-- 
2.28.0

