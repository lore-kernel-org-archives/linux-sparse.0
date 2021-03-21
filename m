Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD8C433E1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0606194D
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCUMfX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCUMfQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC19BC061765
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bf3so16078867edb.6
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgZWRMMMccH1TaVlZWXps4EsQ2idiMl3HOLRc5102a0=;
        b=X98In7gC6nagS4Xy+FdFAhO8MOSXiXTFxR4LiFTudX8DDZ41LQxKJLKk5Zx5REQ/OA
         d+OJLQdd8cII0zD3iAfP1JvtXS3b31kEEwGYoOM811aNV1vXozNgXWOT1QX+SRc5FxxN
         QRu3IsdBsCpYzvOEHYvG7P+ltLUYhsBU/npqmIcXT8FAXFRi71rKbzz6FlHdsxV+kzL6
         hY4rkmklXHs+2yEWBr6IdQQ7u122ZgDq0YP3NVOalLqvWi0TbeNbvKPl26mE1WlFF8u0
         tHgA3FnMiEGsxvBOpdnXUq/luK1sLHQrmu2Wxo4KkBSwRZk8QghRPrs4LxVpXZFyYf5U
         sVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgZWRMMMccH1TaVlZWXps4EsQ2idiMl3HOLRc5102a0=;
        b=trJ1HYPgSQxK3LdJyWMoop9BXGOKBVueeySm/+sHV2dp3uQcXfhqxUTcn3huXJg3yy
         OH38P6iTA6vbH1ENYZfCQkEZ0fhPrmBZrdD9+V42baEa3ZHeF3b1DoOIHtDrIeh3fXW6
         k8FXBsalbV7YTvKUtyJJ7+LDHA3gibKVEQcTARR0wVdVFYjDTiLwvZRw3xKMhm7SuLwi
         wi3ym3iM90I/kPXBk8KySqxpgzD0IYT1oZ+EWdHNoKTObKuUSBFojv4db5aGnf3Yp+iq
         Kx2j8WB1dlUdHYXFsVUmaa2Zikqd2bqq3IHPL1F5GK8HD18PeouWQkaSVYOJb74AUFbk
         sK4w==
X-Gm-Message-State: AOAM532ki/9bqoa1ZApOZRTHIiXzUev/+uJVJHVGVP3rWFpSpKJGl0i0
        zwfYBGdrmnD/Vy0k5JmfvmqQVStH2Jo=
X-Google-Smtp-Source: ABdhPJweeT2THNIeLA/w3lYDmR6JOBxfVwiUR9rOW2k8ABcH/QGmFzD/txFqZX8MPWTs9ZzZFhWafA==
X-Received: by 2002:aa7:cb97:: with SMTP id r23mr20028353edt.106.1616330114469;
        Sun, 21 Mar 2021 05:35:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/13] simplify remove_parent()
Date:   Sun, 21 Mar 2021 13:34:56 +0100
Message-Id: <20210321123505.27993-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

remove_parent() is a simple wrapper around remove_bb_from_list()
which also set REPEAT_CFG_CLEANUP if the list becomes empty.
But its only user, insert_branch(), doesn't need REPEAT_CFG_CLEANUP
to be set.

So, simplify this wrapper by keeping only the call to remove_bb_from_list().
---
 linearize.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index ebb03217c9d9..6bb1287efcb0 100644
--- a/linearize.c
+++ b/linearize.c
@@ -695,8 +695,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 static void remove_parent(struct basic_block *child, struct basic_block *parent)
 {
 	remove_bb_from_list(&child->parents, parent, 1);
-	if (!child->parents)
-		repeat_phase |= REPEAT_CFG_CLEANUP;
 }
 
 /* Change a "switch" or a conditional branch into a branch */
-- 
2.31.0

