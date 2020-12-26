Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38199C433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1163620809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLZRxe (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgLZRxe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465AC0617A0
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d26so6635491wrb.12
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DsQLxTrNJcz0R22oO5wwa9iFQjczJUfus8/Hi9D7Q/g=;
        b=c9ESPmhw7d3bOY1heevHY1rZKFGSZTkGZi34bm66vIioFeZ5kr/XQmWbeSFMZJ37Bo
         9BSh15xosVR33LTErnLf5pdXm2GF4rVLcAN586wDcyICKPSKcynWfsHmrdRx98LhqVHo
         H6tZCZWeK2nAVtGJKb8RdXlMqmk3HqY7QAnFKsnFFfAK3dcMIBNtcQu1SfRmwD4lztRU
         xk+e0G0ZUBNNjTr7d0z7/akhzOyFNHETuVFqzfL9zBclQNZ27FyAVfvLPEKi7JtGDyII
         Jc0gZq5OAMw0gN5OJhru0CqLrQgjf0KhAXQbudD5WIIDNe/yA2N/5GYrRqOnKAgC+pAi
         f5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DsQLxTrNJcz0R22oO5wwa9iFQjczJUfus8/Hi9D7Q/g=;
        b=SzsuGzreFeAlUyvA0u7b/BN/KkGPDLtMlZn4DhG6NobluXUo3b27HBxfBGGFZ3dEb9
         PBDQ1Ih+gnGBt34Y5oJuaN3krqHupRuMPcBfaHdvGrMmcb5auG2n2EMzCdbreOD8hjYp
         eWM+lEzmCfQlk5LpILX+5GLTequr/ZZDuNKDfuLrHJioyf1chLBlJUCb8D5Vf4uO/a/6
         r0W9/DqvSTTh4eOHaDZGIbUJF6NE7ODHMxx74QA4yyYIatcr86sUehrwvtvtWJQe8+lC
         9Sf4bchjkDq3f1x37M8E/h41JOFtwN7dp4zFLFnWO3/cEX9k0kfmrpS2qns+ocrBa4i2
         VtGQ==
X-Gm-Message-State: AOAM533hYH+UuEC/XStNl4P5pyyPM9lAJ6U4cgoEG+ohQnvFPB+n/0P8
        es0SEeMNsRaKzrJ1V6Dr+2mEYSwGYVw=
X-Google-Smtp-Source: ABdhPJyK1IoGCCMdt+sjvKOzzcYQT0G3t0Tthnjyf1EjZIc2uxdDrenzbhEz1D/KiSRDD8L/bP/S+Q==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr43769295wrw.419.1609005130163;
        Sat, 26 Dec 2020 09:52:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:09 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 15/16] packed: no out-of-bound access of packed bitfields
Date:   Sat, 26 Dec 2020 18:51:28 +0100
Message-Id: <20201226175129.9621-16-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
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
smaller, loads and their corresponding values reconstructed form these,
making things much more complicated than for non-packed bitfields.

But at IR level, things can be a little more flexible and things can stay
simple by using sub-word or super-word accesses (until these need to
be lowered to be usable at machine level). In other words, the example here
can be safely accessed with respectively a 24-bit and a 40-bit load.
This is what is done in this patch.
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

