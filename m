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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108EEC4332D
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50BD64DE5
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhCJWLP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhCJWLH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74AC061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b7so86595edz.8
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNbUUObvWvj/wnufy2aMSRBmJG00h2J6KXs/pLxUg1M=;
        b=EeXuiWL1RqKIxn7HUJrFvWQ3RKfrIYNX1PE4lIZMiDZpLnba09momZT7F4ialCH7WK
         eHLuGWSy/JFF4RurC/6O/OIzsGpTMXjMd0yerWymAFUIMFg0CvZKSta0WX8Ux6TOFiiE
         0uem6gN7+GmHtBxe1oaI1NBQEICngnU/cbSGg+lCHcOVM0CRh0tkR/rusILluCcEf2F4
         VMgU5CZxIb+4fQy1k0N6IqX5/FNHQ25f5HlEN8uvHflCk+AQBiY+pOEoJenqZPrAqz4/
         0SwfPpbpuviTtRY8xckSUVPwXyupnQPD3hSRpR+mV1uDWRFo1/QwkVBiOVgwRuTm2pcQ
         NOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNbUUObvWvj/wnufy2aMSRBmJG00h2J6KXs/pLxUg1M=;
        b=hHsaaVMCQwfo1La2Jn419f9wbWoKodjcKfV9dF9f5TKVGdy5uxv1V0iiRmoP7VGwP4
         zYo6YEbq8ZHSQXYB1dTWDgC1en2q6nMXasi0Q4aRfVisPss9wxPHZY8gGVaRGYrzDBKq
         wdlkqT00Z6U6ZA3bhmvUc8K/8M2D5S8WKfaGwX9GRChybbT1qvfEGRrXq+Hpx0J9wEJf
         6OLoQLU+vpET7zNyrydq52wmVKfVFDBalOosI5fxziK61aGOl5XKJxQ9jDTj8a6vZ2TK
         he0LBZkb50dE2620Qo5lISaZLTWhTMums+M/jS6tr7b0u31Ic8QnUi0/PB6kfU9wzDOB
         1w+Q==
X-Gm-Message-State: AOAM530tsVX0OM77YNZUUof6Hzkyie4N/BMHFCe3EEE0N6zlsTB+KM1l
        02E/l72M31J6kwjlySSTjJZEBcsXMd0=
X-Google-Smtp-Source: ABdhPJzNEOy2tb8AVyGiVSXuIiXjfzDRKwUTxlaOh+75VrdS7ZVm7gUDcejMr5rmIFYBcSy+H3GGIA==
X-Received: by 2002:aa7:d656:: with SMTP id v22mr5461050edr.119.1615414265955;
        Wed, 10 Mar 2021 14:11:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:05 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] simplify (x | M) cmps C
Date:   Wed, 10 Mar 2021 22:49:49 +0100
Message-Id: <20210310214950.84192-9-luc.vanoostenryck@gmail.com>
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
 simplify.c                  | 14 ++++++++++++++
 validation/optim/cmps-or0.c |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 865fadfb590e..e721f9f860a0 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1324,6 +1324,20 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if ((value & bits) != bits)
 				return replace_with_value(insn, 1);
 			break;
+		case OP_SET_LE:
+			value = sign_extend(value, def->size);
+			if (bits & sign_bit(def->size)) {
+				if (value >= -1)
+					return replace_with_value(insn, 1);
+			}
+			break;
+		case OP_SET_GT:
+			value = sign_extend(value, def->size);
+			if (bits & sign_bit(def->size)) {
+				if (value >= -1)
+					return replace_with_value(insn, 0);
+			}
+			break;
 		}
 		break;
 	case OP_SEXT:				// sext(x) cmp C --> x cmp trunc(C)
diff --git a/validation/optim/cmps-or0.c b/validation/optim/cmps-or0.c
index 40a2092c58a4..70fcb024a846 100644
--- a/validation/optim/cmps-or0.c
+++ b/validation/optim/cmps-or0.c
@@ -15,7 +15,6 @@ int cmps_ior_gt_0(int a) { return ((a | MASK) >  0) EQ(0); }
 /*
  * check-name: cmps-or0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

