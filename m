Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3306C432BE
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D18960ED4
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhG2VVG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233832AbhG2VVG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 081A8604D7;
        Thu, 29 Jul 2021 21:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627593662;
        bh=MZlTmP/R5JDvGn92H3J1GaaR3ZvW/p9+EXCYZrx1zKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNAWh+vYQ4F/dFFu1RyihzQF1+WQ+pSX0wAjExf0Wix2gAqibpiesFXtZ+oFUG9iM
         0Dc8gTVSBLnqGViG+7rrWXZQyx/QSuqN+7LVCTvQUvTIRfA1IbjqvAt1uUzl/W887c
         m0En16InMwfK1SU2eVKKsKaikesAHst1sGal5frA3k26keqyq0GtYYGOFl/gVIR8sO
         FBw/jT3GA5//YhSlf4anZKhViEnxN5sRfOyfVrZLxCO1v0zr32f00eFQ7BKdCI55+v
         7eWTj3UEALp5g4iaW8kc2/MMgg143aWyVGaBXvOypyOGPsU95Ardq1zN5EP36q43HE
         qD2hyx9r46jHA==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] scheck: constants are untyped
Date:   Thu, 29 Jul 2021 23:20:52 +0200
Message-Id: <20210729212054.34327-4-lucvoo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729212054.34327-1-lucvoo@kernel.org>
References: <20210729212054.34327-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

in sparse, constants (PSEUDO_VALs) are not typed, so the same pseudo
can be used to represent 1-bit 0, 8-bit 0, 16-bit 0, ...

That's incompatible with the bit vectors used here, so we can't associate
a PSEUDO_VAL with its own bitvector like it's done for PSEUDO_REGs.
A fresh one is needed for each occurrence (we could use a small table
but won't bother).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scheck.c b/scheck.c
index d3ebddd6c2f5..5e2b60abb163 100644
--- a/scheck.c
+++ b/scheck.c
@@ -53,15 +53,14 @@ static BoolectorNode *mkvar(Btor *btor, BoolectorSort s, pseudo_t pseudo)
 	static char buff[33];
 	BoolectorNode *n;
 
-	if (pseudo->priv)
-		return pseudo->priv;
-
 	switch (pseudo->type) {
 	case PSEUDO_VAL:
 		sprintf(buff, "%llx", pseudo->value);
 		return boolector_consth(btor, s, buff);
 	case PSEUDO_ARG:
 	case PSEUDO_REG:
+		if (pseudo->priv)
+			return pseudo->priv;
 		n = boolector_var(btor, s, show_pseudo(pseudo));
 		break;
 	default:
-- 
2.32.0

