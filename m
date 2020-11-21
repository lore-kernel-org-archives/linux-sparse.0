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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE4C5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B6C2151B
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQgiBRQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgKUWrI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgKUWrG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 17:47:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31809C0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:05 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so12498093wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tY7/tg7wZv9pqyo6giYc6RgkS8nugtwDnV41JEj1PR4=;
        b=WQgiBRQ9z54ls7nYUOV2hB5OCcj5BtR0vr9iBnWMYEz9Z1o2Q/QseDOO3Ceafzl3TS
         PxJHCF0v3qb886lzOIISjemJ7n4CwhfQHGp3UCUV5Z5iBSd+T2If5b5ZdMJQIkQ2pxPg
         sMNfWFA6iLNDORHbfOT06uNOl3KuRI1KXlDz9PA1fJnKXFraOTKOnEU+qJU76NAPxTxm
         0Hn2n7P/P6Hpn7E0hUjCwHN5prZrrg0MQNkSn+9qIRxb2hztfLo6wM7zh+CXKJWLrxCm
         fIBo6tay4yilsjM4fdeZ7y2h2wPaWlyeY+hSE5F+WWh8PFyr3auh7/FgCDgdi9DQ1/xR
         sYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tY7/tg7wZv9pqyo6giYc6RgkS8nugtwDnV41JEj1PR4=;
        b=BFEQnP8wHYOR2HC3EZoAZAWt8NlB55Q8954OJL/P+HxQK0Sye+AY4kP+CRVj6nbkl6
         Z2j16q/lqYlg4lmAKGR22w6oqwhqCXRAn/qd0lSZ3slCoTvTLqkfKUIyjifPWbOC+0vZ
         qEjpyzsL6R5cuY1BYcdTn3f52soE59XhKR723ulbn1FjtcrgSX8fnZMvhUsumVYMVUBL
         D0Tnrv3svUmXJVVB7huMSVoZ5/XNm2XPSfkH1FSzkLQABHxKlqmDF1LC2/9L1CuCJRED
         tjumPOX1poU2B5nSwB/YlIPsW87fFgPRfFdVc90oVQWMBGa0iQ1o4ocL5mMPqs3afkG7
         NvBw==
X-Gm-Message-State: AOAM530UGbUr6cMcKZuld9a8nLkvaLS0247yevZ3FXEMXmMy6kpw+7LM
        UlcF+x+BASCF/1xFVViduoWNPr9TWHk=
X-Google-Smtp-Source: ABdhPJyUWB+6rO32lAnWEQDnPSPq8ziVqWB4WwCMNnEFTMa3c77ey7ZuB55dNyt1oZFzOg0Y7kB4aA==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr16421701wmi.146.1605998823747;
        Sat, 21 Nov 2020 14:47:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:4ce2:b4ff:20e6:17bc])
        by smtp.gmail.com with ESMTPSA id l14sm4830406wmi.33.2020.11.21.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 14:47:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] simplify kill_insn() of unops and unop-ish instructions
Date:   Sat, 21 Nov 2020 23:46:57 +0100
Message-Id: <20201121224657.96038-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121224657.96038-1-luc.vanoostenryck@gmail.com>
References: <20201121224657.96038-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In instructions, the first pseudo operands exist under different
names (.src1, .src, .cond, .phi_src) all aliased to each other.

Use this to simplify unops and others instructions with a single
pseudo operand.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/simplify.c b/simplify.c
index 465624f72677..4508c6d54386 100644
--- a/simplify.c
+++ b/simplify.c
@@ -324,24 +324,16 @@ int kill_insn(struct instruction *insn, int force)
 
 	case OP_UNOP ... OP_UNOP_END:
 	case OP_SLICE:
-		kill_use(&insn->src1);
-		break;
-
-	case OP_PHI:
-		kill_use_list(insn->phi_list);
-		break;
 	case OP_PHISOURCE:
-		kill_use(&insn->phi_src);
-		break;
-
 	case OP_SYMADDR:
-		kill_use(&insn->src);
-		break;
-
 	case OP_CBR:
 	case OP_SWITCH:
 	case OP_COMPUTEDGOTO:
-		kill_use(&insn->cond);
+		kill_use(&insn->src1);
+		break;
+
+	case OP_PHI:
+		kill_use_list(insn->phi_list);
 		break;
 
 	case OP_CALL:
-- 
2.29.2

