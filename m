Return-Path: <SRS0=85YD=DN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9536BC41604
	for <linux-sparse@archiver.kernel.org>; Tue,  6 Oct 2020 16:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF8206F7
	for <linux-sparse@archiver.kernel.org>; Tue,  6 Oct 2020 16:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGjPEge/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgJFQoF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJFQoE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Oct 2020 12:44:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D7BC061755
        for <linux-sparse@vger.kernel.org>; Tue,  6 Oct 2020 09:44:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lw21so14613029ejb.6
        for <linux-sparse@vger.kernel.org>; Tue, 06 Oct 2020 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBcCClvqfVhFNo1WJ1HOsRiwMpHqKShD7omjPXz+JX0=;
        b=MGjPEge/rNiZgHsz7+PgOEdUaT7aNyv/hlXsLlBC0SOL8CDxy6e0kE8VyHf4d4rSQP
         YbZ/HF9j+NrGyW/lOIvu+LfehwoKQ7E2SAALRxKIvJ5T0R9H6kZ5OyGz4YrygrxRw+8P
         UbBzjH4yU9ljcDUSsguE5+/yKjWh7H3wGeuuOHBFQk/557Q9j6D1UA8HYEUyrXV7WrtS
         6ntueH8FibcVOvRWm5UW7ZCUWzkQyxqrUWeH+ANgQQDBGhi1KOggFoRS8KZHK0KLRwcR
         wYM6wwuRzELbp08y6UiFdCNSFFuycwM69Bc0xdn06/fPUFMfiDidCccurib2iFU7BxKj
         Z/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FBcCClvqfVhFNo1WJ1HOsRiwMpHqKShD7omjPXz+JX0=;
        b=Sh2OfXjS/+3oLWL5wN6T00xQ8p+xRc/odUbnuDujWAWZoOaihTG2iaoRO5u8yqcQt3
         vqHHx7eOgHeRL3zc+TSxvlkoenS8ukcHj4FDuGMGdStY6uCejm/k7UuFoa5sDRHVNplF
         /Kg4HU63JpPXPLX0TTOW1q9T5tHCTkIY6g+Egf9JwwnN6EypEl2kn8DJDddtuFfBD0ng
         kQbjSqiP49keZkpum5KArjmYX70t+IE0ip7dIFtuR59BMILZ9OdTz7bYtUSaMpOIavz2
         idzt3Vvc1lHkG5Jg66Swdl4arV8jDLzaPgl4oUBhbuAIv63zUDW6MXQjrB2DR5P/r2Cq
         0NQg==
X-Gm-Message-State: AOAM531XoHveVgL2yHQhwDSOJBS/x86t+lKE9el8ktIpxyzMMSFdD1yq
        GqjhctB4g+LYfucwNw2etiAWuwxa2p0=
X-Google-Smtp-Source: ABdhPJwBjVF52Uj8Jyrz6CN+sGb3R6jjnnVW9JljIi8O6DtayQSqPDJQPm+SNwUeSwdo7Sm3oEWGBw==
X-Received: by 2002:a17:906:490e:: with SMTP id b14mr439861ejq.268.1602002643084;
        Tue, 06 Oct 2020 09:44:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6cd8:b67a:a15c:19eb])
        by smtp.gmail.com with ESMTPSA id y3sm2588734ejk.92.2020.10.06.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:44:02 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] unop: fix access to defining instruction in simplify_unop()
Date:   Tue,  6 Oct 2020 18:43:58 +0200
Message-Id: <20201006164358.37772-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Only pseudos of type PSEUDO_REG have a defining instruction.

However, in commit 5425db10d4d3 ("simplify '~(~x)' and '-(-x)' to 'x'"),
this defining instruction of the 'src' of the outer unop
was accessed without checking the type.

Fixes: 5425db10d4d35895ba3ca390478c624233ec027d
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index 76c0558855a2..15452a585598 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1311,13 +1311,11 @@ static int simplify_unop(struct instruction *insn)
 		struct instruction *def;
 
 	case OP_NOT:
-		def = insn->src->def;
-		if (def && def->opcode == OP_NOT)
+		if (DEF_OPCODE(def, insn->src) == OP_NOT)
 			return replace_with_pseudo(insn, def->src);
 		break;
 	case OP_NEG:
-		def = insn->src->def;
-		if (def && def->opcode == OP_NEG)
+		if (DEF_OPCODE(def, insn->src) == OP_NEG)
 			return replace_with_pseudo(insn, def->src);
 		break;
 	default:
-- 
2.28.0

