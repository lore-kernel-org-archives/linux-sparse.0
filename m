Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1FC55178
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468A120B1F
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 01:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD3ZDCnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKHBVi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 20:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgKHBVh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 20:21:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF722C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 17:21:35 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id za3so7262359ejb.5
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 17:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RPgx3xhhprRiWjOjbrYFOQd++FJ5T9LSZ8rkyhtKwY=;
        b=oD3ZDCnkUj566aO+1S6zPxFtu/rYHM2+pF09OCU9bb8hixIrU1DBWDrqWhsrN4FRO3
         jYKUi4lu0Vz5D4mlsEQEm2uHmCFvIE9WMLfLCZaDnCHLJ9A5/BCG/WWIMTL9+GgzV36y
         LpFfa5pKT98Iaor6QdgWoyyeZNZKFV/+MYQ5QKqqcvd/7Wrx1TzR0R/bZAwRywMhRXRa
         zgbJhUSa2XFBU1osKUgcpSOz+f9xEolvL0v7UCHaqnv0xjvYHnSzhm5mN5v7Io9NgsX8
         rNxfTl0Wd0aA6uhIAtBl/m7Wpb538to6shiwmrjmtcoWYXEZrVfqxtTY7TvyGOTURjB9
         9HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RPgx3xhhprRiWjOjbrYFOQd++FJ5T9LSZ8rkyhtKwY=;
        b=TjKzU/tF0vEiBMfskuHzi9OfNtFj7Erlg4hPdzrnTIfdBXIZXrHY+N8AGoC+PULb8c
         VifW1kp8voNx4Bbb6Y+17sU8RAcm70JE/HU++x0SgT0e4twZvto5oBSt6sQIHhp5aJx6
         vKmczwuyKeOjSV8jHguQsVT77kRp99esggMozk3qS2EibCJKne6sWcS3IIr9RzyfkEZ3
         MFC1eRkOVviQ2qKFPDEsV+LyTCnY8HCu7UmE/8LauHkQ5dr7e2Ll5BjEA3MwBk1TEycR
         2A0etB0o2aeewE4pZQaVpMaGEEL/EHb2ESr9laL6VP0enFmHYt9tC/JSe6VZumm1ehE8
         gqJQ==
X-Gm-Message-State: AOAM531PuA0HLzFIUlw3jXM3cKJAdE9VshNMD6Tr/Yt4HzoWhBHJOt8R
        twNi4XKKJ+MGrJahByHr0o/+FMlWC7Y=
X-Google-Smtp-Source: ABdhPJxD5oJ7tCVZsT8+9TQ3a9hFj4FUHA2TV/9d2OmYCxe0gQKDeL46iFgacHDlsY0AhBwQvhnNYg==
X-Received: by 2002:a17:906:2512:: with SMTP id i18mr9158361ejb.184.1604798493432;
        Sat, 07 Nov 2020 17:21:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:fce6:5cb0:27db:5e8c])
        by smtp.gmail.com with ESMTPSA id u25sm4511426eje.99.2020.11.07.17.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 17:21:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/16] cmp: simplify zext(x) cmps C
Date:   Sun,  8 Nov 2020 02:21:24 +0100
Message-Id: <20201108012126.94339-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
References: <20201108011939.94252-1-luc.vanoostenryck@gmail.com>
 <20201108012126.94339-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A signed compare of a zero-extended value against a constant
outside of the original range is statically known.

Simplify to the corresponding 0/1.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 14 ++++++++++++++
 validation/optim/cmp-zext-simm.c |  1 -
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 8a8b39b81e20..83ae763eac72 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1185,6 +1185,20 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			insn->itype = def->orig_type;
 			return replace_pseudo(insn, &insn->src1, def->src);
 		}
+		switch (insn->opcode) {
+		case OP_SET_LT: case OP_SET_LE:
+			if (sign_extend(value, def->size) > (long long)bits)
+				return replace_with_value(insn, 1);
+			else
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_GE: case OP_SET_GT:
+			if (sign_extend(value, def->size) > (long long)bits)
+				return replace_with_value(insn, 0);
+			else
+				return replace_with_value(insn, 1);
+			break;
+		}
 		break;
 	}
 	return changed;
diff --git a/validation/optim/cmp-zext-simm.c b/validation/optim/cmp-zext-simm.c
index f89f8f8baa62..dda237d7257f 100644
--- a/validation/optim/cmp-zext-simm.c
+++ b/validation/optim/cmp-zext-simm.c
@@ -17,7 +17,6 @@ int zext_lgt(unsigned int x) { return (ZEXT(x) >  -1) == 1; }
 /*
  * check-name: cmp-zext-simm
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.29.2

