Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD4CC4361B
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 13:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C54423E24
	for <linux-sparse@archiver.kernel.org>; Fri, 11 Dec 2020 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436584AbgLKNHS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393478AbgLKNHF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Dec 2020 08:07:05 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4ACC0613CF
        for <linux-sparse@vger.kernel.org>; Fri, 11 Dec 2020 05:06:24 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id b9so12278309ejy.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Dec 2020 05:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agf7baCfcHbCjX+ivHtaYPZtN1jf7IfvzhDVpIQIwzI=;
        b=hCV4Qlg21RjGIpQVSWlCskj4dLwil5TLjwfGK1+bVW3yjVc7szr+tr1feN6wRLhXVc
         VApYtIXMweIiq7nZwVk9/xdpZL7MjObklBN+6NqJBRdqu70JpHnzoDX7i75Gz/eY4RVj
         3B7yQ0YhzsQ5BtGE/gL7mEYvjy55XLHxZHpGCZ/5B/5Z1zyubmIv7j/y9El/fDS6ohBv
         khst9OXMg14u/oHuRef43dYTl62vT+qOznp0xkKtQVYgWa1Vg9QLWXVJHIEBLNuSywWx
         hiCp94DMtPols2Iew04dcWoeNsFvKuD/F5+GeY/wzStu3xNTjD+Ji2FjbLKpGHjr9FIV
         Utxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=agf7baCfcHbCjX+ivHtaYPZtN1jf7IfvzhDVpIQIwzI=;
        b=aI/nfTnYrB5ojz2UXuG1F1HgIKJAo1KjwCGp8BTOlKZQLRk2P4hBP/RQIl8A4OH/Qu
         8+HWmJjxS2NmKrtVc22AUekFKsd0qbeGroYW6NttXrjV63j9qxdRBdLRRl0cgF1/6iQm
         cqOaO8OKWnakVjwd75WfoBj/L30Yosd5ACg+Gr9icSHKjn+xLxT4ldjxsodV+Gia874h
         hr7omvXJQd//r16Q4eDTsrlvD8oIDSkmvQtOTlUYMHCuJXKMxvZKwZsPEBgBvDmb4A3p
         1IgS/DstfVO4ZmuOFpbfCTw9d/PlpNCQYDwhNOadzHTATJLWIcruvOuVjMiL/FVukqea
         APPw==
X-Gm-Message-State: AOAM5329uE7nKm/yE2rzRzDirPDwj+8VF1YD5t9IA4TfHIgRs87/PUNt
        QxlNbQu1d2hpE3gSjM0rVun1lmGBO1I=
X-Google-Smtp-Source: ABdhPJy8/otf+ZdldoPfqowGycSYka77/Zz4LJyhkXgbXrjxerf+vNftoU4c2HxJ0iwcu0nfehqg8A==
X-Received: by 2002:a17:906:941a:: with SMTP id q26mr10876146ejx.227.1607691983314;
        Fri, 11 Dec 2020 05:06:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:35e8:5147:5f47:7ab1])
        by smtp.gmail.com with ESMTPSA id s26sm7360739edc.33.2020.12.11.05.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:06:22 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: fix parsing of tags used in the testcases
Date:   Fri, 11 Dec 2020 14:06:19 +0100
Message-Id: <20201211130619.71317-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In testcases' tags, if a value contains 'check-' then this
value will be used as the tagname instead of the value.

Fix this by adding a bit more context in the regexp used for parsing these.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 6935d40cee51..1b05c75e9f74 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -84,8 +84,8 @@ get_tag_value()
 	check_assert=""
 	check_cpp_if=""
 
-	lines=$(grep 'check-[a-z-]*' $1 | \
-		sed -e 's/^.*\(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
+	lines=$(grep '^ \* check-[a-z-]*' $1 | \
+		sed -e 's/^ \* \(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
 
 	while read tag val; do
 		#echo "-> tag: '$tag'"
-- 
2.29.2

