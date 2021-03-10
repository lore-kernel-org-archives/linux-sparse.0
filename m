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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C5C43381
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A9E64FC9
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCJWLO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhCJWLE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F2C061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t1so95480eds.7
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEMYXmUNr/t1XuFCn4KA85j2yUZiAEd59KILiE7RemI=;
        b=pu91w+OB2fSbcKPsvS9lYPinfxCPak20Xj96HnpZvwwN8ANQAiNwoUYK9KRKRI+9se
         gyo+P9D6xEFPtdRQy1/ip40VQrD4UChpZPMI22AnTKXbKP45wAwngsP4IxhMp/jMWXKs
         Kaz26mt8w0zXBfhqQ1aWLJDQ/9I6DUwX0WDYVgZin8jALHMO7ksSF3N5Vw8XafYT6kXs
         FqL4/7Xv2Gg6xNNtx+2DcLcPgJAYdUJOHHWMktTEsR3uyg6jcp3bBnVhRGAqmIZsUVIq
         g3ef8HEACY8iyFCyOCgojngbnOKWqauVBsp8n7fNZEfDdCugeuM56Kufx70wTQ72NBjl
         16UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEMYXmUNr/t1XuFCn4KA85j2yUZiAEd59KILiE7RemI=;
        b=sLc565BdmztYfrudrcmGWr3f+6bdwZEHBCPq4089+xVK/UnW/tv5MaFS5Uwz1sxibb
         3VElV4FasHbcuNEU5PllyvcG4XV0YhsPyY3tifsp9LV+cHVdDu7gWUXluZ+Dvl2aghzx
         yWf/hzpSl+42sQIvX7EPsthjEh/DkIz2g34jFlWGB2oBC3yxDjri1MLp0il6lVFO3SJz
         uwff9NW333DeZvaiA2GcH0IJlpjHMOoTkcwYaAsOEpG+f1BsJf6XKOyoHX2N69o01lZh
         V9P+q96GMyQxDFat+urECZp5H1gWZYVBJXtwYGsCavg3zM27OivgHJfNVZ6eW19p4vup
         12jw==
X-Gm-Message-State: AOAM5307lTu+afnGVuowYw+QSsqlsRpiNgbM9koIGqHjVWXd9OjYmIEm
        dHxInpE+JXyr0yP0rNcoFRMstFvJvFI=
X-Google-Smtp-Source: ABdhPJzDUySDnNp2XfUEWE4RTk2B1x9VRmoznlaRx+wutGVqtbCULSV7hJwvVT1a2+DaNJIGIxJ2nw==
X-Received: by 2002:a50:f391:: with SMTP id g17mr5567955edm.26.1615414263010;
        Wed, 10 Mar 2021 14:11:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] simplify (x & M) cmpu C
Date:   Wed, 10 Mar 2021 22:49:45 +0100
Message-Id: <20210310214950.84192-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   | 16 ++++++++++++++++
 validation/optim/cmpu-and0.c |  1 -
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 90b0c5ba0127..ee29c9619bdc 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1281,6 +1281,22 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if (value >= (long long)bits)
 				return replace_with_value(insn, 0);
 			break;
+		case OP_SET_B:
+			if (value > bits)
+				return replace_with_value(insn, 1);
+			break;
+		case OP_SET_BE:
+			if (value >= bits)
+				return replace_with_value(insn, 1);
+			break;
+		case OP_SET_AE:
+			if (value > bits)
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_A:
+			if (value >= bits)
+				return replace_with_value(insn, 0);
+			break;
 		}
 		break;
 	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
diff --git a/validation/optim/cmpu-and0.c b/validation/optim/cmpu-and0.c
index 253212941779..927b9fb65f52 100644
--- a/validation/optim/cmpu-and0.c
+++ b/validation/optim/cmpu-and0.c
@@ -11,7 +11,6 @@ int cmps_and_gtu_eq(int a) { return ((a & MASK) >  (MASK + 0)) + 1; }
 /*
  * check-name: cmpu-and0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

