Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F027C4361B
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4B622515
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 18:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgLOSQX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:16:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:50546 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbgLOSQW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Dec 2020 13:16:22 -0500
IronPort-SDR: ePnZqkYDgZvjo6ELoafDone508wfmipAlOSSCdYfU19atIn5S2/QTGfszz8NWed1foYyAwUQDD
 LLtjiN3f3gEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="154734719"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="154734719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 10:15:39 -0800
IronPort-SDR: VykVEpqdMrav/0g0t2yuCFlyvHg6veV+lfgb/ndEg6BuIKEJY/VgqhOP1KlgD0KvJnG73d1z9Z
 YNnHzzPYkQ3Q==
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="487980604"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.209.14.218]) ([10.209.14.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 10:15:38 -0800
To:     linux-sparse@vger.kernel.org
From:   Jacob Keller <jacob.e.keller@intel.com>
Subject: sparse attribute packed on structures
Organization: Intel Corporation
Message-ID: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
Date:   Tue, 15 Dec 2020 10:15:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi,

I'm looking into an issue with sparse not calculating the size of a
packed structure correctly, causing some static assertions to fail due
to an incorrect size.

With a structure like this:

struct a {
	uint32_t a;
	uint8_t b;
	uint8_t c;
} __attribute__ ((packed));

The packed attribute doesn't seem to get applied to the whole structure.
Thus, the sparse sizeof evaluation for this results in 8 bytes (64
bits), when GCC would produce a structure of size 6 bytes (48 bits).

If I use something instead like this:

struct a {
	uint32_t a __attribute__ ((packed));
	uint8_t b __attribute__ ((packed));
	uint8_t c __attribute__ ((packed));
} __attribute__ ((packed));

Then the size is calculated correctly.

I saw that there is support in parse.c for parsing attribute packed, but
it doesn't seem to have a way to propagate from a structure down to its
members.

I thought it would be relatively straight forward to implement by adding
a MOD_PACKED, but that doesn't seem to actually get assigned to the
struct symbol, so when I tried that it didn't work.

I would very much like to help get structure size packing to work properly.

The following diff is what I tried initially, but it doesn't actually
work as expected. I'm not sure what is wrong, or what is the best method
to actually get the packed modifier to save into the structure symbol so
that it can be checked when determining the structure size.

Help would be appreciated.

Thanks,
Jake

---

diff --git i/parse.c w/parse.c
index 0b2685707b82..96beae80c300 100644
--- i/parse.c
+++ w/parse.c
@@ -1086,13 +1086,6 @@ static struct token *ignore_attribute(struct
token *token, struct symbol *attr,
        return token;
 }

-static struct token *attribute_packed(struct token *token, struct
symbol *attr, struct decl_state *ctx)
-{
-       if (!ctx->ctype.alignment)
-               ctx->ctype.alignment = 1;
-       return token;
-}
-
 static struct token *attribute_aligned(struct token *token, struct
symbol *attr, struct decl_state *ctx)
 {
        int alignment = max_alignment;
@@ -1142,6 +1135,14 @@ static struct token *attribute_bitwise(struct
token *token, struct symbol *attr,
        return token;
 }

+static struct token *attribute_packed(struct token *token, struct
symbol *attr, struct decl_state *ctx)
+{
+       apply_mod(&token->pos, &ctx->ctype.modifiers, MOD_PACKED);
+       if (!ctx->ctype.alignment)
+               ctx->ctype.alignment = 1;
+       return token;
+}
+
 static struct ident *numerical_address_space(int asn)
 {
        char buff[32];
diff --git i/symbol.c w/symbol.c
index 1a083fb8432c..6e0d3ba74bd6 100644
--- i/symbol.c
+++ w/symbol.c
@@ -88,6 +88,7 @@ struct struct_union_info {
        unsigned long bit_size;
        int align_size;
        char has_flex_array;
+       char is_packed;
        struct symbol *flex_array;
 };

@@ -136,7 +137,10 @@ static void lay_out_struct(struct symbol *sym,
struct struct_union_info *info)
                info->flex_array = sym;
        }

-       align_bit_mask = bytes_to_bits(sym->ctype.alignment) - 1;
+       if (info->is_packed)
+               align_bit_mask = bytes_to_bits(1) - 1;
+       else
+               align_bit_mask = bytes_to_bits(sym->ctype.alignment) - 1;

        /*
         * Bitfields have some very special rules..
@@ -181,6 +185,8 @@ static struct symbol *
examine_struct_union_type(struct symbol *sym, int advance
        void (*fn)(struct symbol *, struct struct_union_info *);
        struct symbol *member;

+       info.is_packed = sym->ctype.modifiers & MOD_PACKED ? 1 : 0;
+
        fn = advance ? lay_out_struct : lay_out_union;
        FOR_EACH_PTR(sym->symbol_list, member) {
                if (member->ctype.base_type == &autotype_ctype) {
diff --git i/symbol.h w/symbol.h
index 5c5a7f12affa..172b70257d20 100644
--- i/symbol.h
+++ w/symbol.h
@@ -242,7 +242,7 @@ struct symbol {

 #define MOD_GNU_INLINE         0x00010000
 #define MOD_USERTYPE           0x00020000
-     // MOD UNUSED             0x00040000
+#define MOD_PACKED             0x00040000
      // MOD UNUSED             0x00080000
      // MOD UNUSED             0x00100000
      // MOD UNUSED             0x00200000

