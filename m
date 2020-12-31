Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2CC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0093D207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgLaKMm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLaKMm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE6C0617AA
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m5so19666909wrx.9
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGW6FJwES63xtm07iFWxDQNsy+/z0YE7i/K5kFahARI=;
        b=aRod3xk9euYzMx6gs8ArSIxz6O52q2GHEd3DVXTS12gJ7VpJnt6nRaoUzrLbX13c7Q
         Uhj7xtEvCBAv79BVgt+UbypfO0x3GVL1gLhO9/w+BcIwkHW5PVeAnW+L1EYbH/Q5yb1u
         +i9RBkLDJQHjqZJsofjAFI5kFSYXt25vmZbgXsg8W00VgjBiCh9xiZoQPlh1/Tq5v0Mj
         QCy8VZyls7bAlsww+wkqN/gV+iRucvN+ViHVuHZkpSjDVAF6noxbrz+1HNi4+P2p0MHO
         SOkHAMzDTOH7wWFdrr3hT1a0NjL1p6WgYHXtc9JAL9F5t8/mHZNdaeWOalTGCDTaSBPr
         f95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGW6FJwES63xtm07iFWxDQNsy+/z0YE7i/K5kFahARI=;
        b=eSZwuuLnqgov/VBM2xiRHpgl8znKn3CufZCZRCRVhEBvLTA4Kos6XdUSzkNcY0voVd
         YWJbovxzDscWCiq31n9js3oShi0ulaaDwhK/VkQzqYTTkVS+WXuBlf/eg8Gxdn2BgW9f
         8Ba8iCm1KomOai7fTrs6VlhxWj40hafI4cNB8eJmHeWMttJT/kQotLSas9YfNVURl6l0
         +bGCz7IpJ+h35FSlVV5pYBkR7QE69Eg1fHqmcWtPonnaOz313GdSbZVxJorTmGqZPzSk
         sMrLpI4jSRKLMOh0FhoDM3QtGjqA+vyAFexoeqBQZS2mes6ae/u+b1Dg/2q91Y6qZKiS
         wl4Q==
X-Gm-Message-State: AOAM533BYGMLE8FRePyJxclt43GBU3ETdixcLmAlG3ZvOJIk/wg87s4u
        sxxfByERrsbMyG0TPw2SZeJqAWelAsQ=
X-Google-Smtp-Source: ABdhPJw4p7hD+iZXrj7Opn7qOawAZSAmpWCAC1XlB8GfNWXgA7hnaBcto2x6JFRUXC6LWXfgON+2Vg==
X-Received: by 2002:adf:82c8:: with SMTP id 66mr63377683wrc.420.1609409454461;
        Thu, 31 Dec 2020 02:10:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:54 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 16/16] packed: add support for __packed struct
Date:   Thu, 31 Dec 2020 11:10:34 +0100
Message-Id: <20201231101034.59978-17-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that the 'packed' attribute is parsed and propagated into
the type system, adapt the layout of structures.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/TODO.md         |  3 ---
 parse.c                       |  5 ++++-
 symbol.c                      | 12 +++++++++---
 symbol.h                      |  1 +
 validation/packed-bitfield0.c |  1 -
 validation/packed-bitfield1.c |  1 -
 validation/packed-bitfield2.c |  1 -
 validation/packed-bitfield5.c |  1 -
 validation/packed-deref0.c    |  1 -
 validation/packed-struct.c    |  1 -
 10 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/TODO.md b/Documentation/TODO.md
index 4dc9e63ab207..3f00bb1104d1 100644
--- a/Documentation/TODO.md
+++ b/Documentation/TODO.md
@@ -4,9 +4,6 @@ TODO
 Essential
 ---------
 * SSA is broken by simplify_loads() & branches rewriting/simplification
-* attributes of struct, union & enums are ignored (and maybe others too).
-  This requires correct support for __packed which itself needs partial
-  and unaligned loads & stores (wip)
 * add support for bitwise enums (wip)
 
 Documentation
diff --git a/parse.c b/parse.c
index 338e525f46b9..70be616c45ae 100644
--- a/parse.c
+++ b/parse.c
@@ -767,6 +767,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	attr.ctype.base_type = sym;
 	token = handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
+	sym->packed = attr.packed;
 
 	sym->endpos = token->pos;
 
@@ -1089,8 +1090,10 @@ static struct token *ignore_attribute(struct token *token, struct symbol *attr,
 
 static struct token *attribute_packed(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	if (!ctx->ctype.alignment)
+	if (!ctx->ctype.alignment) {
 		ctx->ctype.alignment = 1;
+		ctx->packed = 1;
+	}
 	return token;
 }
 
diff --git a/symbol.c b/symbol.c
index 1a083fb8432c..aa02c8c5ad80 100644
--- a/symbol.c
+++ b/symbol.c
@@ -88,6 +88,7 @@ struct struct_union_info {
 	unsigned long bit_size;
 	int align_size;
 	char has_flex_array;
+	bool packed;
 	struct symbol *flex_array;
 };
 
@@ -120,6 +121,7 @@ static int bitfield_base_size(struct symbol *sym)
 static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 {
 	unsigned long bit_size, align_bit_mask;
+	unsigned long alignment;
 	int base_size;
 
 	bit_size = info->bit_size;
@@ -136,7 +138,8 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 		info->flex_array = sym;
 	}
 
-	align_bit_mask = bytes_to_bits(sym->ctype.alignment) - 1;
+	alignment = info->packed ? 1 : sym->ctype.alignment;
+	align_bit_mask = bytes_to_bits(alignment) - 1;
 
 	/*
 	 * Bitfields have some very special rules..
@@ -147,7 +150,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 		// Zero-width fields just fill up the unit.
 		int width = base_size ? : (bit_offset ? room : 0);
 
-		if (width > room) {
+		if (width > room && !info->packed) {
 			bit_size = (bit_size + align_bit_mask) & ~align_bit_mask;
 			bit_offset = 0;
 		}
@@ -157,6 +160,8 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 		info->bit_size = bit_size + width;
 		// warning (sym->pos, "bitfield: offset=%d:%d  size=:%d", sym->offset, sym->bit_offset, width);
 
+		if (info->packed && sym->type == SYM_NODE)
+			sym->packed = 1;
 		return;
 	}
 
@@ -173,6 +178,7 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 static struct symbol * examine_struct_union_type(struct symbol *sym, int advance)
 {
 	struct struct_union_info info = {
+		.packed = sym->packed,
 		.max_align = 1,
 		.bit_size = 0,
 		.align_size = 1
@@ -191,7 +197,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 			sparse_error(info.flex_array->pos, "flexible array member '%s' is not last", show_ident(info.flex_array->ident));
 		examine_symbol_type(member);
 
-		if (member->ctype.alignment > info.max_align) {
+		if (member->ctype.alignment > info.max_align && !sym->packed) {
 			// Unnamed bitfields do not affect alignment.
 			if (member->ident || !is_bitfield_type(member))
 				info.max_align = member->ctype.alignment;
diff --git a/symbol.h b/symbol.h
index 866d57522f49..15b21452c934 100644
--- a/symbol.h
+++ b/symbol.h
@@ -112,6 +112,7 @@ struct decl_state {
 	unsigned char prefer_abstract;
 	unsigned char autotype;
 	unsigned char forced;
+	unsigned char packed;
 };
 
 struct pseudo;
diff --git a/validation/packed-bitfield0.c b/validation/packed-bitfield0.c
index f84e7b904a82..2e20916176f1 100644
--- a/validation/packed-bitfield0.c
+++ b/validation/packed-bitfield0.c
@@ -55,5 +55,4 @@ int main(void)
 
 /*
  * check-name: packed-bitfield0
- * check-known-to-fail
  */
diff --git a/validation/packed-bitfield1.c b/validation/packed-bitfield1.c
index 208a3dc5127c..b7b575ce6922 100644
--- a/validation/packed-bitfield1.c
+++ b/validation/packed-bitfield1.c
@@ -24,5 +24,4 @@ static int foo(struct s *ptr)
 
 /*
  * check-name: packed-bitfield1
- * check-known-to-fail
  */
diff --git a/validation/packed-bitfield2.c b/validation/packed-bitfield2.c
index 4587ebec5c90..244204c2dd35 100644
--- a/validation/packed-bitfield2.c
+++ b/validation/packed-bitfield2.c
@@ -12,5 +12,4 @@ _Static_assert(sizeof(struct bf2) == 8);
 
 /*
  * check-name: packed-bitfield2
- * check-known-to-fail
  */
diff --git a/validation/packed-bitfield5.c b/validation/packed-bitfield5.c
index 8f44d4c2c277..87dbf9c221a1 100644
--- a/validation/packed-bitfield5.c
+++ b/validation/packed-bitfield5.c
@@ -17,5 +17,4 @@ static int ld(struct s *s)
 /*
  * check-name: packed-bitfield5
  * check-description: is check_access() OK with 'overlapping' packed bitfields?
- * check-known-to-fail
  */
diff --git a/validation/packed-deref0.c b/validation/packed-deref0.c
index 865ad68a4f37..d48ad1ac7505 100644
--- a/validation/packed-deref0.c
+++ b/validation/packed-deref0.c
@@ -20,5 +20,4 @@ static void bar(obj_t o)
 
 /*
  * check-name: packed-deref0
- * check-known-to-fail
  */
diff --git a/validation/packed-struct.c b/validation/packed-struct.c
index e21d11538639..dad22791060b 100644
--- a/validation/packed-struct.c
+++ b/validation/packed-struct.c
@@ -29,5 +29,4 @@ _Static_assert(   sizeof(struct c) == 6, "size struct");
 
 /*
  * check-name: packed-struct
- * check-known-to-fail
  */
-- 
2.29.2

