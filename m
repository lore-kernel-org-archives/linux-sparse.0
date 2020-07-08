Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162BC433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D43820720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmWXontO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGHXmF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGHXmF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:42:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD096C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:42:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so290190ejb.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MwYT+K8CPak7eAG9O80REIBHq9Bu9cj9U8vLzHAgso=;
        b=RmWXontOv9x5V3gUes3BZnjOXnFuAFZHV/cXReaeN54NQPdKg+ffv1C/xtjOY7XArr
         xqxY1eew3PxkL0KBvZ0j53YxHQJ+MZZX6wxFqvZPtA21tzKQqhsEzU3vG0Euiud9U9Dg
         AoZVtQf/5Rmtj+ZMoDBRpNeCBx3SPnVnp1VXeUFpjrlSRLJh/KhW7z3cepHPpg3Sr5y9
         +k/svd43G5bVl2KxXk0BqWPik3nt/uSTU0I9/mFEPxe9rkNRK+tYphFFTgvxDsGuk04m
         PclDX5v+12K/Azzch69MYlO4uG5nergFavop4l1XxMdFn2g/jgoFDKX9sYssu/Mx4Joq
         hxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MwYT+K8CPak7eAG9O80REIBHq9Bu9cj9U8vLzHAgso=;
        b=c1VZrUJl5tDF/SPSvh9k+OnvR141q9u7YYrrzkAC3uIJYqadWzEFlZRMzEhaPlpI35
         PdhzaO3aUsRpTknsKW/Uj7Z3SZkydts6ThCVQDWGezcPId1/7KkhRvCIyDtlWhRjEQRC
         Lnl7ASu345JAZfr2IX0avb706JF9SCqg+KXDuODuiafu9Fd6wSiX7ME7MP2widvDn14H
         MLdBQCN8M8fLiZH5q+Ui0TdIAas1TXEVUWBfF96LUz/KxqRtwH+3Eg6SyCTWOCjWOjHN
         Q8gIZ98z3VTD4/IjD/ZdgDYuwB5tTH4bl/4x4KiMVl4xi5OAq9y71Zh5BE2tXaGoHM4b
         fi8A==
X-Gm-Message-State: AOAM532AtkBJu19GdXCKl6HLeLxvW6eIfntBH18qmZoRXoP+bqU5x5VU
        vchQvzic7CGqw5kSevRz9Kr4eru/
X-Google-Smtp-Source: ABdhPJzixdvE5oycYmwrCsQk877YC5XemIkS8JJbVQJI1fMac9ce9HwHKIy0heo937EOoCT015Ioog==
X-Received: by 2002:a17:906:7247:: with SMTP id n7mr54127414ejk.105.1594251723380;
        Wed, 08 Jul 2020 16:42:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:42:02 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] arch: add predefines for OS identification
Date:   Thu,  9 Jul 2020 01:41:49 +0200
Message-Id: <20200708234151.57845-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Predefine macros like '__OpenBSD__', ... for the three BSDs,
CygWin and Darwin (those for Linus and SunOS were already defined).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/predefine.c b/predefine.c
index 7583b1afc32e..0f36f7ef56d2 100644
--- a/predefine.c
+++ b/predefine.c
@@ -217,10 +217,29 @@ void predefined_macros(void)
 	}
 
 	switch (arch_os) {
+	case OS_CYGWIN:
+		predefine("__CYGWIN__", 1, "1");
+		if (arch_m64 == ARCH_LP32)
+			predefine("__CYGWIN32__", 1, "1");
+		break;
+	case OS_DARWIN:
+		predefine("__APPLE__", 1, "1");
+		predefine("__APPLE_CC__", 1, "1");
+		predefine("__MACH__", 1, "1");
+		break;
+	case OS_FREEBSD:
+		predefine("__FreeBSD__", 1, "1");
+		break;
 	case OS_LINUX:
 		predefine("__linux__", 1, "1");
 		predefine("__linux", 1, "1");
 		break;
+	case OS_NETBSD:
+		predefine("__NetBSD__", 1, "1");
+		break;
+	case OS_OPENBSD:
+		predefine("__OpenBSD__", 1, "1");
+		break;
 	case OS_SUNOS:
 		predefine("__sun__", 1, "1");
 		predefine("__sun", 1, "1");
-- 
2.27.0

