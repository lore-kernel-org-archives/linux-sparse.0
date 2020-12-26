Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C85C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441D720809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLZRyA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgLZRx7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4CC0617A1
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y23so5686320wmi.1
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUrPYZ873WnY7bYzHZqUSa1HoojKkdIB+hKlsBQ7CUM=;
        b=nNcGda73XlEdsIbwF8AM/wj6RrBytspHYEhERzGfEV8gyXsOH/VUhRpMJ+sM2U+KO2
         qxgx6jH9ms2s3Tx2hr34vjBmVoBOErE2sODGJLW8w2FETO7YIQ6r3jQpOJCBq9nGXp4D
         z2eBgMbmjyiBaBCkq0tNp5BG2BHEw4pt/XhVJub2D527P42ynAgVdRj+DNqYFfgnCmIe
         B+Dm369TZZFUALHlm7y8ocPlxmptg6gP24MbRvMiq9PyPJY8ooRyzLX1FwaKq33FCU+/
         ltlv0crLNly+gD/CkCdGw7uN+yGlULtczYIxzTYgH/9IIzIIk+fL6iF2Xf7OJuS0sytf
         tZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUrPYZ873WnY7bYzHZqUSa1HoojKkdIB+hKlsBQ7CUM=;
        b=gq/o3ZtSrq28hmDBLfz/tySOsEbOnU5QY1giaMRBR86d8cFIAmZ1t2MMV4PSuoP0Ow
         IU6t51QpIc8UIZ+ETxGQkOa8HH1VVJBPQDDptIytyngQXJ53WE3XojC3ZO+gikFptUFN
         xuBAjK8LE11ZNipZeqJlqIsFCKffUck9YH1M9qCvVb43SWwExqNMpgSbdec2C54hVahd
         4zjwZClay1hbUlg/O9Yj+5++SxRTguDsPf6A/+1PQR+ENlNBgl9LWFMsT1NFe0ticT1l
         lFUS/oyZ3xD9KXn2TCuXslcnfbTSr17VLyYLQU6DunMXz9AFKAIdxYywc4YIk68VCm6K
         Gwxg==
X-Gm-Message-State: AOAM531/+LaEEk4/Uu2AkDfnHswz9EkVwtxAuE4+Lf+tVQR/hRPtx7Tf
        mjS7O3SJh8G5znnFfVvWXIg4BMc/uNE=
X-Google-Smtp-Source: ABdhPJyIOSdMbo7kCjaroK2Y05ZMMtrFYLxa5cfsywqop7IraUeewsB7P4JgaR8u5YpDhChcqancOA==
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr13345932wmi.143.1609005130915;
        Sat, 26 Dec 2020 09:52:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:10 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 16/16] packed: add support for __packed struct
Date:   Sat, 26 Dec 2020 18:51:29 +0100
Message-Id: <20201226175129.9621-17-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, the attribute 'packed' is ignored
---
 parse.c                       |  5 ++++-
 symbol.c                      | 12 +++++++++---
 symbol.h                      |  1 +
 validation/packed-bitfield0.c |  1 -
 validation/packed-bitfield1.c |  1 -
 validation/packed-bitfield2.c |  1 -
 validation/packed-bitfield5.c |  1 -
 validation/packed-deref0.c    |  1 -
 validation/packed-struct.c    |  1 -
 9 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/parse.c b/parse.c
index 0fd2bb473a47..42e48620bd5e 100644
--- a/parse.c
+++ b/parse.c
@@ -764,6 +764,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	attr.ctype.base_type = sym;
 	token = handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
+	sym->packed = attr.packed;
 
 	// Mark the structure as needing re-examination
 	sym->examined = 0;
@@ -1088,8 +1089,10 @@ static struct token *ignore_attribute(struct token *token, struct symbol *attr,
 
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
index 907500dedbf0..6d92fb2862eb 100644
--- a/validation/packed-bitfield0.c
+++ b/validation/packed-bitfield0.c
@@ -63,5 +63,4 @@ int main(void)
 
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
index 5039be4d0b45..253750063ffd 100644
--- a/validation/packed-struct.c
+++ b/validation/packed-struct.c
@@ -29,5 +29,4 @@ _Static_assert(   sizeof(struct c) == 6, "size struct");
 
 /*
  * check-name: packed-struct
- * check-known-to-fail
  */
-- 
2.29.2

