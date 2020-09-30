Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61D3C4727F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A9F2076A
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbbaRumx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgI3XSv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgI3XSq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:18:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF27C0613D2
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so3570997wrs.5
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUHPvqTQBUJT7n0W3kOTdVjHQlKrWX1qMDvyZQ81Rbc=;
        b=WbbaRumxtyUz7LrxjfqtxUVTiJW4UwLne9zbUPK7c+5qlWFKVkoPy8b0QnOp+8Q4co
         9yWYXZneewImDVEHrvXoU+NgHmVDKH0pL8ZzKoKOLYsBnSlIpqMyvvbcbTlvhazSGHrl
         JhNA5wMJPHFSY6njAoHyWxu6glVDp0Qv5al1/NzCy0P7qhe0pDT9xt544YnD7RUXDC8X
         z4q896sL9BTW5Xbzhuc7U8oTZZHpczzTiT+qn7otNg0B5niIaLytUbirQ35nFzRBc98+
         xisNxz0aAG0TBpW1pmi2fYvkkhz6vUDTB4atxJB1Qrk1YcdN5BadJs3/hZk1Mo8soQRU
         uiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUHPvqTQBUJT7n0W3kOTdVjHQlKrWX1qMDvyZQ81Rbc=;
        b=LyHb1HB52tPLPKzPV3UVpxEuDUgOX8cBqLPI4UyVvRWFv3eQEHsCX5wVdK+8pR3blf
         6x2cadeUcFhZONDecFwhoZktgfGxHvqnBqNR/tq70XTFXqEQ6ghmAVltBh+PXFbJapuq
         fCb++/U3xp1Dx20ggGf05PQW5AOaUTtpIqeY9RiN1VaTGIwcAc9U+OPcRPYu9rgU4tXt
         dfw2xbNM3S8gwSj4imtGABKv9AoAUHC1o28tSezGLzFCCDNKmDORCwkdWhALZiQ+0rK3
         Qx0PCbzOIiuWE6w3YJjmw7m6+xw+zs2lcqoiGAO046lbJP7td7PLjXkRyP1FWIy6c184
         fW2A==
X-Gm-Message-State: AOAM531qqyb/s6AVPPbGngdUQSnttUCjSJ9KnZobvYl9SO5eYyNivBPQ
        qUlyCyD7EcVH9LHscaNlQQAALWoOAoE=
X-Google-Smtp-Source: ABdhPJx6bBAAGaUUXBVGgW6QmOD8qbo87NufzLZN7t7F21XA3dKk+YKUKy1uN+QbORTOiTb0er4BPw==
X-Received: by 2002:adf:f290:: with SMTP id k16mr5862638wro.124.1601507924172;
        Wed, 30 Sep 2020 16:18:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id l8sm5460065wrx.22.2020.09.30.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:18:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/13] flex-array: warn when a flexible array member has some padding
Date:   Thu,  1 Oct 2020 01:18:28 +0200
Message-Id: <20200930231828.66751-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If some padding is added because of the presence of a flexible
array member, the size of the structure will be greater than
the offset of this flexible array which can cause some
problems if the assumption is made that these 2 size must be
identical (which is easy to do since such flexible arrays are
conceptually 'after' the structure itself).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 options.c                       | 2 ++
 options.h                       | 1 +
 sparse.1                        | 6 ++++++
 symbol.c                        | 2 ++
 validation/flex-array-padding.c | 1 -
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/options.c b/options.c
index b46900b973a6..92d64e6ab64e 100644
--- a/options.c
+++ b/options.c
@@ -102,6 +102,7 @@ int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
 int Wflexible_array_array = 1;
 int Wflexible_array_nested = 0;
+int Wflexible_array_padding = 0;
 int Wflexible_array_sizeof = 0;
 int Wimplicit_int = 1;
 int Winit_cstring = 0;
@@ -845,6 +846,7 @@ static const struct flag warnings[] = {
 	{ "external-function-has-definition", &Wexternal_function_has_definition },
 	{ "flexible-array-array", &Wflexible_array_array },
 	{ "flexible-array-nested", &Wflexible_array_nested },
+	{ "flexible-array-padding", &Wflexible_array_padding },
 	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
 	{ "implicit-int", &Wimplicit_int },
 	{ "init-cstring", &Winit_cstring },
diff --git a/options.h b/options.h
index d23ed472eaac..31d9c5859977 100644
--- a/options.h
+++ b/options.h
@@ -101,6 +101,7 @@ extern int Wenum_mismatch;
 extern int Wexternal_function_has_definition;
 extern int Wflexible_array_array;
 extern int Wflexible_array_nested;
+extern int Wflexible_array_padding;
 extern int Wflexible_array_sizeof;
 extern int Wimplicit_int;
 extern int Winit_cstring;
diff --git a/sparse.1 b/sparse.1
index 9b1a59c6b9d4..8c61e869dc57 100644
--- a/sparse.1
+++ b/sparse.1
@@ -268,6 +268,12 @@ Sparse issues these warnings by default. To turn them off, use
 Warn about structures containing a flexible array being contained into
 another structure, union or array.
 
+Sparse does not issue these warnings by default.
+.
+.TP
+.B -Wflexible-array-padding
+Warn about padding alignments caused by the presence of a flexible array member.
+
 Sparse does not issue these warnings by default.
 .
 .TP
diff --git a/symbol.c b/symbol.c
index a9f646eb053f..eabb2226651f 100644
--- a/symbol.c
+++ b/symbol.c
@@ -213,6 +213,8 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 	}
 	if (info.flex_array) {
 		info.has_flex_array = 1;
+		if (sym->offset != bits_to_bytes(bit_size) && Wflexible_array_padding)
+			warning(info.flex_array->pos, "flexible array member has padding");
 	}
 	if (info.has_flex_array)
 		sym->has_flex_array = 1;
diff --git a/validation/flex-array-padding.c b/validation/flex-array-padding.c
index 2ba77971266e..95b349e1199a 100644
--- a/validation/flex-array-padding.c
+++ b/validation/flex-array-padding.c
@@ -12,7 +12,6 @@ static int foo(struct s *s)
 /*
  * check-name: flex-array-padding
  * check-command: test-linearize -Wflexible-array-padding $file
- * check-known-to-fail
  *
  * check-output-ignore
  *
-- 
2.28.0

