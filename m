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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D27C433DB
	for <linux-sparse@archiver.kernel.org>; Mon,  1 Mar 2021 00:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0104561481
	for <linux-sparse@archiver.kernel.org>; Mon,  1 Mar 2021 00:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCAApJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 19:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCAApI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 19:45:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D86C06174A
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 16:44:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c6so18554907ede.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 16:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JZz9ddAfvWe/v0G0UOWofPnCbM4V/hhgz/bB+ZQyso=;
        b=OyzLkG7VMkEyBQvA6RJgAANxJqzsc+RSUdb2AQ807HR7Mk/VexlrJRllOknxa6QifQ
         5QpLwakMq6ah+ZrWpt90YuzFQKcEziGW5C9xvk0DgbogdEe0LoOjvoyheq7oFynpAUxm
         3cD8bcp14sh8SIpdadYK6F1bCtH5kHaNxVYF1gMJvdx/z6Uq52SGA+ZLH7yZbA37SbF2
         fPefgDCigyXE4jp1pR2Tpx1RcrcO93xNCra4TKmP67oFcsRN5hzynUYcDMgsZ61LDWN9
         e0s8zfD7QnvJ9QJBEBlnRt+9D0LsanXsbR01lXBY6GSEPu4VHBrTHLF6SB4+BAUOpMxT
         T0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JZz9ddAfvWe/v0G0UOWofPnCbM4V/hhgz/bB+ZQyso=;
        b=g7f+gMJrsySfTbhk5+5DXQnyaNUeUwD1Xfe2I58McpZksk+2+jfJmssr4kSyfbjwxn
         uDldRFfIvSYBgl06cpXFq1zp8AkRqjMzWdAv/Rov1hMA5KmEr26OwmpogXOGmxr4GYmv
         lr+H5gNXyRm1FOiiPjV120zt6KSh8BQWukcf6BTG6r6Zog0KSMuvBK9O64EAw/KdtpCO
         ycclyqma92qbhe21eknV9EHEMuqhqeGbTyFE91P0W/LrJwGMKo/dEnT8aBKGy7zVOs/l
         R7Y1THo9LbTvDBPYRLbk37gGsxPSPMbBluN9A3WR2DSlIKoEfficjubgBms5fNImmGWl
         +0eg==
X-Gm-Message-State: AOAM530jegOSCo77CZlnYmdDTEDts8nEzFm/VPTI1k/bay5pwcYQ0nEZ
        TSbzDGblLkZsHFk4MVMvDOimZIds3Gs=
X-Google-Smtp-Source: ABdhPJwABSSc7+9aJgjun2FnzvZVcIFu1dN2MpsBu2AsSjbBiU20DHrowMT68/6sYlvjS7cIK2D3zQ==
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr7870083edu.67.1614559467034;
        Sun, 28 Feb 2021 16:44:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a098:f2e1:a530:fb8])
        by smtp.gmail.com with ESMTPSA id pk5sm11601034ejb.119.2021.02.28.16.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 16:44:26 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] pre-proc: do some path normalization
Date:   Mon,  1 Mar 2021 01:44:23 +0100
Message-Id: <20210301004423.48693-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

An header file like 'header.h':
	#pragma once
	#include "./header.h"

doesn't work because:
1) both filenames are different, so it will be be included anyway
2) after that it will be included again under the name "././header.h"
   and so on until it eventually fails with ENAMETOOLONG.

Prevent this by stripping leading "./"s in the paths.
This is not good enough for testing file equivalence by is enough to
avoid the loop.

Link: https://lore.kernel.org/r/CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pre-process.c b/pre-process.c
index 7a1478f6a0f1..3fb250828fa6 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -884,6 +884,12 @@ static void set_stream_include_path(struct stream *stream)
 			memcpy(m, stream->name, len);
 			m[len] = 0;
 			path = m;
+			/* normalize this path */
+			while (path[0] == '.' && path[1] == '/') {
+				path += 2;
+				while (path[0] == '/')
+					path++;
+			}
 		}
 		stream->path = path;
 	}
-- 
2.30.0

