Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EBC55179
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C5720888
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUpIiWwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKGLmd (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKGLmc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:32 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367FC0613D2
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:31 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id y15so3749265ede.11
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjYjNkgWjmMIc5uso+F56+hNknduB00wPJ4s7Ix2yqk=;
        b=OUpIiWwhOxa+Xee++/LvazYTqphhhzl1UTlzBz0frDs5V2RX4g5iJMMrQCFRLA3LGM
         W+m/vmgHr6WYRHvWRxhrURQVc6M4vaww/aQ2wkG114TnswF4mAGcUQDAsVZrZeUMtHld
         t97M+A+VoGnjeVWSv8/qZ/14rThdJ0TrJA+Cy7Dy0J/DNwL25dboeKM7xoL+f1QIs5HB
         sY7dYZO5lMkH7nUzehg2gj194s93WpQO6zXluRk3qNw5qtEY6GJTzq3z8arVXYSIw4IK
         3yi1oWJ1am8ZNNW9ViwUejii75LsMS/CVhiOYG/xIKKfl4oVdzESeKePJkQjPolZbaHs
         zQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjYjNkgWjmMIc5uso+F56+hNknduB00wPJ4s7Ix2yqk=;
        b=Hqwj8Aymsbd6pG+2ChPB0+CYwZEBkhGtNM9WIgoS6wsFtx1YNnYOkPIrxTVRBrM9zN
         HHD+wYLABeUUxHgWcCdUzVtOTEPt3t5ToUyorqqX2mMq8penKVTCaEv0kKK/E3bwdsL3
         pwPTLZhZJ3oi2mcTEVlM5Ki3ZnoUe7D8dZHR3bfxXo3eP1T9bRvgdyXLyo2in+NQJZOw
         TjHitUV+Kp1p1ZWROEQ+4TeZ0OKsrqNIeZ22hb00jwXHjlmD+7lvKYXPmQQA+Lrhors9
         e35P4ssI6f25tw1xA3+owuRoZqsTDqIOwBXlVxbyd8ELzFiHAXtJIwnRCapb/Pi1dql0
         C94g==
X-Gm-Message-State: AOAM533+l+hhVY08WTo+vldA/JhjIRjEIpZMX8Eb33w25jTcuPXWY1Fy
        ykRhC3Ae6Ul5eA0ci2bLEiUjT2tr51E=
X-Google-Smtp-Source: ABdhPJyie/3rLjRACEGsJfPj4c7UZg0w6rrvD/K8YaJpgetjJ2Ir9MkTiTh/+VMSTW7L7iOEc3gtWg==
X-Received: by 2002:aa7:d2d9:: with SMTP id k25mr6366234edr.310.1604749350164;
        Sat, 07 Nov 2020 03:42:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:29 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] select: simplify SEL(SEL(x, C1, C2), y, z) --> y (with C1, C2 != 0)
Date:   Sat,  7 Nov 2020 12:42:21 +0100
Message-Id: <20201107114222.11866-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the condition of a select is also a select, with constant
but non-zero operands, then the result of this inner select
is always true and the outer select can be replaced by its
second operand.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                                 | 3 +++
 validation/optim/select-select-true-true.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 1fcfc691579a..20ea5f1be71a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1793,6 +1793,7 @@ static int simplify_select(struct instruction *insn)
 			//	SEL(SEL(x, C, 0), y, z) --> SEL(x, y, z)
 			//	SEL(SEL(x, C, 0), C, 0) --> SEL(x, C, 0) == cond
 			//	SEL(SEL(x, 0, C), y, z) --> SEL(x, z, y)
+			//	SEL(SEL(x, C1, C2), y, z) --> y
 			if (!def->src3->value) {
 				if ((src1 == def->src2) && (src2 == def->src3))
 					return replace_with_pseudo(insn, cond);
@@ -1802,6 +1803,8 @@ static int simplify_select(struct instruction *insn)
 				switch_pseudo(insn, &insn->src2, insn, &insn->src3);
 				return replace_pseudo(insn, &insn->cond, def->cond);
 			}
+			// both values must be non-zero
+			return replace_with_pseudo(insn, src1);
 		}
 		break;
 	}
diff --git a/validation/optim/select-select-true-true.c b/validation/optim/select-select-true-true.c
index e6fa2c89febb..c0c26fdd199a 100644
--- a/validation/optim/select-select-true-true.c
+++ b/validation/optim/select-select-true-true.c
@@ -3,7 +3,6 @@ int foo(int p, int a, int b) { return ((p ? 42 : 43) ? a : b) == a ; }
 /*
  * check-name: select-select-true-true
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

