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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33DC433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB65206B5
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfG4SoyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHJVyu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHJVys (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A8EC061788
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id cq28so7356675edb.10
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XL/7/tQseOiNjRDRu+/qnW5OAn6SZ1VzTvXL39PHrlQ=;
        b=DfG4SoyRLh50T5TDTjYcE/RvS3EUhYKxo1mBeIeBQmIy4VpHX1Kl06sutaT2bZhK6k
         qmR0RFs/cLSBdciKl7vxm5fIexjfrs6pKHQP43g9SwnnJy7hoahG6rFskZjWqLqr7FtE
         4DqTWeMwf6SniyPdvvuoJHVCjyDjIWZk43i7540jpzIwnLz+jWeBIDJO7GnpXAQlVfsI
         m205KTsG+MyJsiIRohuFKaECc70PGFAP1/Q/o3FzPcNfthcHe+fvr1sIS4mMGX0tb6oi
         u02scRznP3jfKuoM+XicRsXnvGPTSs0yLP63/2vyGBCWiwHilz3eNtsVlHacXSwh6o4k
         zBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XL/7/tQseOiNjRDRu+/qnW5OAn6SZ1VzTvXL39PHrlQ=;
        b=CGuvZg+f8w7LZer+KE1yjNV6sfpF6+CYOqDDHLH+lSuY/Fr2LcGumNiZ0+EBtYQXmJ
         EuuB2Pg/qqTpMUzIbkFHYGxAN9zdNSsHF/YM9+JhpYIZrrn5mBBMgTUbbYGC/1IrLWBh
         o3FbmfhxLN4fz1S+CdgzW4uHGbiRo7GDJlq5vUnSB63tAZ1WTQtnkcKpZEm+Bo9Fr64r
         1AsmBwtUkTC/iAeKkkTT3J+384iDlQtjE4NDaSr98PlPvuWxEMcSu26h+rd5dcqnrB5L
         M/h4p3hSHFTSvOCB5XMyoOFcut3zRiszZciKXbhfnFEkm1bcwjMkTdW4zRruovNvggVx
         lG4w==
X-Gm-Message-State: AOAM530v6XqlWO4pnHCfOOhr5A9O5EscF7q2yVRsL99eEfyTvecM6HoH
        kbpgVm7noYqoyZ7P8Ugud27v8PmJ
X-Google-Smtp-Source: ABdhPJw5UWHDksbQHU5ojlOTmnI893SJDdAb+jbXGujAvQIsAmCDyCojB8YAEwbuJkncNl6wc/iXMA==
X-Received: by 2002:a50:d942:: with SMTP id u2mr15881052edj.0.1597096486363;
        Mon, 10 Aug 2020 14:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:45 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/7] doc: use shorter titles
Date:   Mon, 10 Aug 2020 23:53:35 +0200
Message-Id: <20200810215336.76070-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Mainly it's removing 'sparse' from the title.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.rst          | 4 ++--
 Documentation/dev-options.rst | 4 ++--
 Documentation/doc-guide.rst   | 4 ++--
 Documentation/types.rst       | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/IR.rst b/Documentation/IR.rst
index 33a761662fad..97d4b2b27ee3 100644
--- a/Documentation/IR.rst
+++ b/Documentation/IR.rst
@@ -1,7 +1,7 @@
 .. default-domain:: ir
 
-Sparse's Intermediate Representation
-====================================
+Intermediate Representation
+===========================
 
 Instructions
 ~~~~~~~~~~~~
diff --git a/Documentation/dev-options.rst b/Documentation/dev-options.rst
index 23e8096c2cd0..57f9e8d6c4de 100644
--- a/Documentation/dev-options.rst
+++ b/Documentation/dev-options.rst
@@ -1,5 +1,5 @@
-sparse - extra options for developers
-=====================================
+Extra options for developers
+============================
 
 SYNOPSIS
 --------
diff --git a/Documentation/doc-guide.rst b/Documentation/doc-guide.rst
index 8133cb3a59df..29f39aab360a 100644
--- a/Documentation/doc-guide.rst
+++ b/Documentation/doc-guide.rst
@@ -1,5 +1,5 @@
-How to write sparse documentation
-=================================
+Documentation guide
+===================
 
 Introduction
 ------------
diff --git a/Documentation/types.rst b/Documentation/types.rst
index 272f32a0f4ed..974f9861afef 100644
--- a/Documentation/types.rst
+++ b/Documentation/types.rst
@@ -1,6 +1,6 @@
-********************
-Sparse's Type System
-********************
+***********
+Type System
+***********
 
 struct symbol is used to represent symbols & types but
 most parts pertaining to the types are in the field 'ctype'.
-- 
2.28.0

