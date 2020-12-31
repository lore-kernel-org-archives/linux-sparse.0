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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF9C433DB
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC83B207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgLaKMR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLaKMR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:17 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9681C0617A9
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d13so19674071wrc.13
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hjiJHB3wV4XVzP2HATK56U+TgeS3+lb5sAu2Ag4G5+I=;
        b=lmyij2dqgsFB+zkd3myTvVZ5whrc5Rxa6fucakzvNCAunJtgbzgiEPPFjhT6aILJCu
         MMqSuD29sgDaKmGanPex0zT71Uz563I6vpGvjr8wjabrsdNY0M/huYsMNmoyto7OMEj0
         JJpevPyghJk36ydUMrL1nmAIhH0+mS0rWY6Yg7FYmxl4AgCD98bJ84/8FJ5RCnuGWz8Y
         1smkpzL12DgmuR5kma/hTHQRXZJzjca6TYJLAwRnSxL8woQyfCGmIv7Q5tJe8sEx+1c2
         Hx0oUYLPGBrGxrlgnzJmETRwCwxWXoi09NZdatoonx/GnusKjUqOxYFQ1z+6HhBfe5gt
         Y8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hjiJHB3wV4XVzP2HATK56U+TgeS3+lb5sAu2Ag4G5+I=;
        b=IzmvUh9q3zp0VMxk3iZgX68+lv9sJ1dTEpcVU3Sm1XFRpp2gNvr2TaBZCZT+lPXQbs
         atVTskPDOp5QkEah6ritcujTiEBprjsEf6QhdyraFIjMC3HckuucdSVdhZGVjZLivlEU
         QR64ZuybN3w7YSpUHkzWoQ7zzVOVaWhQRU5XJennTCuxVbOxv+Q0FXZp/8zxAi1jPORR
         GFoLQAhLPqleqr8yVCcgeXks6PLhY/04R/enJm9eGNCJEcc6P6jxvL+z0cFnAkzWyASw
         UEG80MiHI1Z3Y4yJMCeC/7Ndh4PHfQbNAL2y49YbXkBXUa6VZ1oJPQoj4zj5w67Tyb6V
         dKng==
X-Gm-Message-State: AOAM532i5PyuSz1d3metjDTmbzId4J8KnOt2U/RCD02ZNldsXMCsgX44
        i7dlGoIAZkRWlJiZLX9Qv5EOwfRm3n4=
X-Google-Smtp-Source: ABdhPJz7SMwnuzHaC3AFIUx9iX/vMzeTBtGWtIuHyxzPqOE2+rQI5srJmuIvExAwtAGjgLSHw4riKQ==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr64668782wrt.425.1609409453527;
        Thu, 31 Dec 2020 02:10:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:53 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 15/16] packed: no out-of-bound access of packed bitfields
Date:   Thu, 31 Dec 2020 11:10:33 +0100
Message-Id: <20201231101034.59978-16-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

There is (at least) 2 ways by which packed bitfields doesn't
follow normal layout/access rules and as consequence can't (always)
be accessed the usual way (load the whole underlying word, then shift
and mask to isolate the bitfield).

At least two different cases are a concern:
1) there is no padding at the end of a bitfield sequence. For example,
   the following struct is only 3 bytes width:
	struct s {
		int f:24;
	} __packed;
   So, trying to access the bitfield by first doing a 32-bit load
   will create an out-of-bound access.

2) a bitfield smaller than one word may need more than one word to be
   accessed. For example, with the following struct
	struct {
		int a:5;
		int f:30;
		int z:5;
	} __packed;
   the bitfield 'f', while smaller than one 32-bit word, can't be accessed
   with a single 32-bit access.

At machine level, these bitfields should be accessed with several, possibly
smaller, loads and their corresponding values reconstructed from these,
making things much more complicated than for non-packed bitfields.

But at IR level, things can be a little more flexible and things can stay
simple by using sub-word or super-word accesses (until these need to
be lowered to be usable at machine level). In other words, the example here
can be safely accessed with respectively a 24-bit and a 40-bit load.
This is what is done in this patch.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 13 +++++++++++--
 symbol.h    |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 0250c6bb17ef..e80715ab2458 100644
--- a/linearize.c
+++ b/linearize.c
@@ -977,8 +977,17 @@ static struct symbol *bitfield_base_type(struct symbol *sym)
 	if (sym) {
 		if (sym->type == SYM_NODE)
 			base = base->ctype.base_type;
-		if (base->type == SYM_BITFIELD)
-			return base->ctype.base_type;
+		if (base->type == SYM_BITFIELD) {
+			base = base->ctype.base_type;
+			if (sym->packed) {
+				int size = bits_to_bytes(sym->bit_offset + sym->bit_size);
+				sym = __alloc_symbol(0);
+				*sym = *base;
+				sym->bit_size = bytes_to_bits(size);
+				return sym;
+			}
+			return base;
+		}
 	}
 	return sym;
 }
diff --git a/symbol.h b/symbol.h
index 5c5a7f12affa..866d57522f49 100644
--- a/symbol.h
+++ b/symbol.h
@@ -192,6 +192,7 @@ struct symbol {
 					accessed:1,
 					builtin:1,
 					torename:1,
+					packed:1,
 					transparent_union:1;
 			int		rank:3;	// arithmetic's rank
 			struct expression *array_size;
-- 
2.29.2

