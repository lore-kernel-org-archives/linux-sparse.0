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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D9C4742C
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5755D20888
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o63un7LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgKGLme (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKGLmd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 06:42:33 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81BC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 03:42:33 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id a71so3887430edf.9
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2sUtEHvCLrCt/e21J8At3wo4kIFRpgi6Q+W2pGm6ew=;
        b=o63un7LS9vh+v0W2dDDPASbPg2nVYxNt5PEMGAftkh1m6hjBI6vQo2ajCn9oaPzBET
         8QxSDmVBqYyOyrWpxH7+s5z2bwx+YJf/VKHkgwrl6hmlul8g+tPgJRUgJgaY2erO+fd0
         aqVRe9hwIXC2H7gc/zS2vODzgz+uy/pVNJrhETEVyERUFH+k17wl+Cij1XLtbqvszZZJ
         j/epJbNf0qgDTLPmy6XL3/CrtCUIze2vEw3Ngx5FRQJDoq0BPR+nL9jYR/KDIqAmuxXG
         UWLDLh6CNxuHbu7teIgH96fjsa/p1806bSsVESCjhLUZrUsb0tofxLtDSnhCLrwcWaXQ
         qb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2sUtEHvCLrCt/e21J8At3wo4kIFRpgi6Q+W2pGm6ew=;
        b=oyIInWUAqiFrr56NZNaqCoWQr2lxeuhx5JkjTwI3fmVeca9eiCH/OitytvYmNLE4Ry
         Gd5DAgxBPRU3uoM52s/uX9QFUKhw5afwIgARI/4D8UbHRyznAlcbmMBQ3RlbK4fApE1q
         ez1r2IiSOINoNMNCM6/qXNlkyQh+LosI1pfQ7IObB+iXEyHH3a+b3qXB85cjzMLGJy7C
         b6RB4qT5ryKwYTGqizTQQ2/EOhCd/m6sD/Fkkn60EABee13lAOBTIB3oXQ0jTipUA+NU
         DrhLeH1Ebm+81Rp9WlwQBPxi/+RuPJ2FWsqwPBf7J0MyTGJG5tfSA5CLnrByyeryLJEQ
         MVAA==
X-Gm-Message-State: AOAM533/EnQ1IGxfue84NLrDZ5RN9VPRawshB8Sxoc+OQVQBo5TFkkUE
        llyOixUc+x5l77iponrYFQKSFAucYKk=
X-Google-Smtp-Source: ABdhPJwSzUbJLDZJz3pyQKhvEXmBGUMpIVoqhQ1H9tav/O0pYq+qZFgrc4iss+d93koZVJoIkTOqYw==
X-Received: by 2002:a50:eb87:: with SMTP id y7mr6728697edr.187.1604749351859;
        Sat, 07 Nov 2020 03:42:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9030:856f:68be:7b84])
        by smtp.gmail.com with ESMTPSA id s21sm3308311edc.42.2020.11.07.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 03:42:31 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] select: simplify handling of constant cond or src1 == src2
Date:   Sat,  7 Nov 2020 12:42:22 +0100
Message-Id: <20201107114222.11866-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If the operands of a select instruction are identical, then
this select can be replaced by its operand.
If the condition of a select is a constant, the this select
can be replaced by one of its condition, depending on the
truth value of the condition.

This simplification is already done but:
* when src1 == src2, the condition's value is tested although
  it may not be a constant. It's kinda OK because in all case
  one of the operand will be selected and both are identical
  but it's a bit weird and unclean.
* since the instruction will be replaced, the usage of its
  condition and operands must be removed. This is done here but
  the kill_instruction() inside replace_with_pseudo() take
  already care of this.

So, separate the two cases and simply use replace_with_pseudo()
for both without bothering killing the operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/simplify.c b/simplify.c
index 20ea5f1be71a..20ab9b3b3ecf 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1753,14 +1753,12 @@ static int simplify_select(struct instruction *insn)
 	cond = insn->src1;
 	src1 = insn->src2;
 	src2 = insn->src3;
-	if (constant(cond) || src1 == src2) {
-		pseudo_t *kill, take;
-		kill_use(&insn->src1);
-		take = cond->value ? src1 : src2;
-		kill = cond->value ? &insn->src3 : &insn->src2;
-		kill_use(kill);
-		return replace_with_pseudo(insn, take);
-	}
+
+	if (constant(cond))
+		return replace_with_pseudo(insn, cond->value ? src1 : src2);
+	if (src1 == src2)
+		return replace_with_pseudo(insn, src1);
+
 	if (constant(src1) && constant(src2)) {
 		long long val1 = src1->value;
 		long long val2 = src2->value;
-- 
2.29.2

