Return-Path: <SRS0=QtWi=BE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85422C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 25 Jul 2020 20:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2FE206C1
	for <linux-sparse@archiver.kernel.org>; Sat, 25 Jul 2020 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGRIeYUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgGYU5L (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 25 Jul 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGYU5L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Jul 2020 16:57:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A3C08C5C0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Jul 2020 13:57:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so6112595edv.4
        for <linux-sparse@vger.kernel.org>; Sat, 25 Jul 2020 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k31jlxRYdK+vhx7SxiSoEFATjAKnuyn7CMJYqdf7bJI=;
        b=CGRIeYUXOv9tRwFiMS1idXqYEE+pC0eegEYb+rCTPgHx02ntqfeAdW5U+oYVfH/ViR
         06ON7kNv/Ut5ikjv1wjDOB1SJ9bHJQ3LS23L5tlG1FLDrzFUI1G2SD6CtnUuiYQCI8oC
         Tbk0L1BI5u/0MqjEVgsDiOZ+DncY6WfKD7sOidL/Lconw/rOG5x9Z5YOB5/5mNG0YNVB
         ZCGzDOFNgRSTRRkATjxPqb8xskNq7G3eDcktmzjqwuUxr+Zfce/ADtHtl7YVRPdciUrX
         /4Q7l+Vu1913mlZotsAYcsGnibvndSXQkFDlGu3JutvaUNzGRI5JbKA1UzcTfQ1HypFO
         6VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k31jlxRYdK+vhx7SxiSoEFATjAKnuyn7CMJYqdf7bJI=;
        b=OvJEcITKPiXlDIbNqAeKbVsbxX914wpyfLIGoBEsMHqplpt3j5D96NRe7V5Jggyzay
         q2BbhqH1Sw6hSz7H7l32tsRaJ/9vhP66ieZo8rWmwogELFzpfrtBEa+FtsD3wkwIJ785
         461GNhn/1cZji+LXWNIQcbPFhmYlJcP7xWx2FWykSnwQg3y0f14xmtnlo3AghB6DmZNg
         9ALjyB9QxqYoVjt1QSouaYCkeMRM8uVfXIv+/oVow63CQT5z5rUcxOcv14NKdEAIBTqa
         K/lqL61syDkEbZKVKZtWZyRRcNelcnddRs/oR366XttBFzNt35TE6mYcA4van8AW3nrd
         kPrw==
X-Gm-Message-State: AOAM533VJqzon1gq0/GjsFq6IBIvNFXqQq/Qq481o/1gVsl6eSyJZz2/
        CTIe+P0rFWWnptBtGFO7ey3ap5+O
X-Google-Smtp-Source: ABdhPJyd1OCOWDkBEy35wbmAF2pV2UxYUynTWiuFtJ3IkQPA1ljvDGTJcHznNePgNNHOES/KPASmCw==
X-Received: by 2002:a05:6402:1bdd:: with SMTP id ch29mr14828295edb.134.1595710629737;
        Sat, 25 Jul 2020 13:57:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:385e:d385:2556:4c62])
        by smtp.gmail.com with ESMTPSA id s7sm3748838edr.57.2020.07.25.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 13:57:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unsed field for EXPR_GENERIC
Date:   Sat, 25 Jul 2020 22:56:39 +0200
Message-Id: <20200725205639.73715-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The field 'result' have been committed by inadvertence in the
initial commit. Remove it now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/expression.h b/expression.h
index 07fe8502e15e..3e9e9d852c27 100644
--- a/expression.h
+++ b/expression.h
@@ -261,7 +261,6 @@ struct expression {
 			struct expression *control;
 			struct expression *def;
 			struct type_expression *map;
-			struct expression *result;
 		};
 	};
 };
-- 
2.27.0

