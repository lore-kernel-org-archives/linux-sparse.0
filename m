Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE5C2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E325D206C0
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvFAvcTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIWtK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIWtK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Nov 2020 17:49:10 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9425DC0613CF
        for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2020 14:49:08 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o9so14712292ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 14:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNXqC/C6Yq8ZU6CFAKPIC9pmaE1Pr194dDPVqXuAkaM=;
        b=tvFAvcTIxnbvqC1o2slizX3qW++pirwoa9n4NNRUZs1Rzf0jaI4W1u21tvmttAuHF5
         DJJOk02suGG482g3CtYQ579xpZIKfsgqGvT39owdCb19tf1owoC8TdpaTYNPyzkPkxBY
         gBJDwcC766NiIXCBgaxGHJfs1qyfWr3teMfFK2IkIpMnwhTzbzKH0p2bvGCNZuYGkXbs
         OWyBg4Ea25r57H8YrOZrTsya8vdBFgrD/4lRkXp3+mZPb1xavfwX8sFwRms7z3MbWjq1
         vuhXacqCRMS8D9K7sYVZI7JIuPeT/0qG9kR+Z2a8Bp85XkKZEL8gw/DKYGTDkgCbzCn5
         ts/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNXqC/C6Yq8ZU6CFAKPIC9pmaE1Pr194dDPVqXuAkaM=;
        b=T61Ek9bt12XzjnWFwE2myz9mvtRXGLL6IWwiOhDcE1vrTDnDM9mv0c8Aep/kOxCJKL
         /B+0C4L4IGavCaPlayfctLiV9IwQYy43y7+YSQk02cII2R9iOBUn3KHOjJEav0nqvAJS
         daONyYWKjPnNVCBbDs8ndwNqsu8XBqXI/B6S+jHTjVETOyR9Jkm7SMo4thqFmkAjwb18
         HdFYME61YCdcM1+i9XS7hagOlKzDHgRVJENVXzuAV4Ue3hKXbZohcyztGA7q0oDH6KJo
         WKmWbAXbfkeY5xl0qaGgKQYyLo1iqVRzqAFCsXfoGin5vbh+N6MODEZgcTL2nYQH3uiA
         po9A==
X-Gm-Message-State: AOAM532EXioaSzO1fbDvnHjncREgNFEa88YI+Yed5RxHB9LpRVDZO6+g
        EPVFqS1awwDuhz8dupmlMR2ruuqta34=
X-Google-Smtp-Source: ABdhPJxN1U6Cxnq6oCwP5xrcJgH4YvZNGWivcgAwKdpnCYMtF6YJIEs7AHLX91dxPeqhlGHxq9Srhw==
X-Received: by 2002:a17:906:4807:: with SMTP id w7mr16918584ejq.306.1604962147126;
        Mon, 09 Nov 2020 14:49:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b825:8815:5c02:9524])
        by smtp.gmail.com with ESMTPSA id y1sm9764756edj.76.2020.11.09.14.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:49:06 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix linear_isdigit()'s itype
Date:   Mon,  9 Nov 2020 23:49:03 +0100
Message-Id: <20201109224903.74865-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The merge of the branch with the linear_isdigit() experiment
and the branch giving a type to OP_SETxx's arguments created
a semantic conflict: the compare used for the isidigt() builtin
needed the type too.

Fix this now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linearize.c b/linearize.c
index c1e3455adb67..d3c009b36d22 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2617,6 +2617,7 @@ static pseudo_t linearize_isdigit(struct entrypoint *ep, struct expression *expr
 	use_pseudo(insn, src, &insn->src1);
 	insn->src2 = value_pseudo(9);
 	insn->target = alloc_pseudo(insn);
+	insn->itype = &int_ctype;
 	add_one_insn(ep, insn);
 
 	return insn->target;
-- 
2.29.2

