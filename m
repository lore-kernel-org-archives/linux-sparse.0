Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79821C433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A5B22AAB
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgLDRT1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbgLDRT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 12:19:27 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAAC08E860
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 09:18:33 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so9787731ejb.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJwgM3oQ+P5nUFcGusT0HtF+7Asc2JuZzm2oyToWMCc=;
        b=Husy+omZFa2DMFjfI18nR1O1y1uQEL4p9968tW1LqrE27vOCQ3ID1BxCtdec0KzeH7
         zWxjXFfGXNzHS2BHHPV3wqageRnBpbq9XyDCvPqKUIp4hv4xiYMJAaudyiPrlUn717Gi
         Q5vQyqcG57zfzQ81q5YDHR2NKUgImg1o6JgctvEYbE80koWZokQnGA5IMXUH5ilQsQmo
         v7YbttnCDFMQgJsIeMucw4LdWpdW6mN5iABmjrm3EM4qL3q1jrpzO/6ynX4Cm/FyCVi9
         FOQYSJa5YiFZDdesRS0SHl4bOWHxbnkQBpNXXL9bDW5C1qDxB9WZ6FCPQHQBIqyRioUC
         jrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJwgM3oQ+P5nUFcGusT0HtF+7Asc2JuZzm2oyToWMCc=;
        b=Fb4YLx1t8VIt9aeyIvTKG6ZiSjxJTxwNFWpDfIpAUSoYQt5g57YMeivyjFw/rn5uiy
         bbZehET8nhYEUEIvp7qScyJd/45DK7w98N8+Lfmfk/uDnEfUVnQhfxQFtOODEfhZ/any
         fhE/suqGFEJbxKBi8nsNXSAHpmQZkHlx++KDABhQGNlHLBn4Jjd2EkQQXjuTnDG0DY/y
         lWG2mfE2L3ObBhk73dYFgMWDWA6NqJYHh8WmJOjVqUgGauIkAmPLiEYczeJCcYlbPIGN
         QCpmQ4VhSYZKzcxfMWdP9UORq5ut1q4gjKJc+X0NNXrxnszR8vYo0RfGqqhpqzXXt9jy
         sEHQ==
X-Gm-Message-State: AOAM531DNObhBxnZGSu9z0WbngGvexcrM3AYRQr1mKiFN+SPF2HgUz/6
        H2IM4SE9UaeZajUoMwwXrNLjlqlOdTY=
X-Google-Smtp-Source: ABdhPJw/6AjVF9Btq+23jSODqh1BJ8BsTU8JiuiC5gmxwQ1x5JT9d9YH6SgPkrPWC4IUxCYEOFjGug==
X-Received: by 2002:a17:906:3ec8:: with SMTP id d8mr8195343ejj.32.1607102312248;
        Fri, 04 Dec 2020 09:18:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id p35sm4024188edd.58.2020.12.04.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:18:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] flowgraph: add a function to calculate the Lowest Common Denominator
Date:   Fri,  4 Dec 2020 18:16:03 +0100
Message-Id: <20201204171604.69635-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204171604.69635-1-luc.vanoostenryck@gmail.com>
References: <20201204171604.69635-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The lowest dominator common to two given BBs is useful to know for
some optimizations like the placement of common sub-expressions.

So, add a function calculating it using the info from the dominator tree.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flowgraph.c | 15 +++++++++++++++
 flowgraph.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/flowgraph.c b/flowgraph.c
index 73c29fc9f894..7db0290da31c 100644
--- a/flowgraph.c
+++ b/flowgraph.c
@@ -221,3 +221,18 @@ bool domtree_dominates(struct basic_block *a, struct basic_block *b)
 	}
 	return false;
 }
+
+struct basic_block *bb_common_dominator(struct basic_block *a, struct basic_block *b)
+{
+	// walk op the domtree until the levels *and* the BBs match
+	while (a != b) {
+		int la = a->dom_level;
+		int lb = b->dom_level;
+
+		if (la >= lb)
+			a = a->idom;
+		if (lb >= la)
+			b = b->idom;
+	}
+	return a;
+}
diff --git a/flowgraph.h b/flowgraph.h
index 5a9c26073554..15f3156fdd4a 100644
--- a/flowgraph.h
+++ b/flowgraph.h
@@ -30,4 +30,8 @@ void domtree_build(struct entrypoint *ep);
 // @return: ``true`` if @a dominates @b, ``false`` otherwise.
 bool domtree_dominates(struct basic_block *a, struct basic_block *b);
 
+///
+// Find the lowest common dominator of two basic blocks.
+struct basic_block *bb_common_dominator(struct basic_block *a, struct basic_block *b);
+
 #endif
-- 
2.29.2

