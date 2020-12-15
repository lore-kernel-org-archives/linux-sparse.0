Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E6FC4361B
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28E422D05
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 23:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgLOXQh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 15 Dec 2020 18:16:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:60639 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgLOXQe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Dec 2020 18:16:34 -0500
IronPort-SDR: Bry3yVZ0z53KKFm4Haw5Y4Yc2ncA7eLYzg8U3N6hmB4G3DAnGXO9rxiVeyO69lHKRwGkLq9YOb
 Qgqr/OxKGWbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="162716129"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="162716129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 15:15:51 -0800
IronPort-SDR: 9DaNQ2NRdaj23uyuQEWBlmVwb4Yf4XH4/udFC0iW1nfLZSWhVk3RuTlMbkaRGrj1A18LrePyQ9
 Bu2gDJDdI6+A==
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="368506423"
Received: from jekeller-mobl1.amr.corp.intel.com (HELO [10.209.14.218]) ([10.209.14.218])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 15:15:51 -0800
Subject: Re: sparse attribute packed on structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
 <20201215205618.scarwvtzzhhtdwvk@ltop.local>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <76c27364-e4cb-cdd4-6e55-178dd19c46ba@intel.com>
Date:   Tue, 15 Dec 2020 15:15:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215205618.scarwvtzzhhtdwvk@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/15/2020 12:56 PM, Luc Van Oostenryck wrote:
> On Tue, Dec 15, 2020 at 10:15:35AM -0800, Jacob Keller wrote:
>> Hi,
>>
>> I'm looking into an issue with sparse not calculating the size of a
>> packed structure correctly, causing some static assertions to fail due
>> to an incorrect size.
>>
>> With a structure like this:
>>
>> struct a {
>> 	uint32_t a;
>> 	uint8_t b;
>> 	uint8_t c;
>> } __attribute__ ((packed));
>>
>> The packed attribute doesn't seem to get applied to the whole structure.
>> Thus, the sparse sizeof evaluation for this results in 8 bytes (64
>> bits), when GCC would produce a structure of size 6 bytes (48 bits).
>>
>> If I use something instead like this:
>>
>> struct a {
>> 	uint32_t a __attribute__ ((packed));
>> 	uint8_t b __attribute__ ((packed));
>> 	uint8_t c __attribute__ ((packed));
>> } __attribute__ ((packed));
>>
>> Then the size is calculated correctly.
>>
>> I saw that there is support in parse.c for parsing attribute packed, but
>> it doesn't seem to have a way to propagate from a structure down to its
>> members.
>>
>> I thought it would be relatively straight forward to implement by adding
>> a MOD_PACKED, but that doesn't seem to actually get assigned to the
>> struct symbol, so when I tried that it didn't work.
>>
>> I would very much like to help get structure size packing to work properly.
>>
>> The following diff is what I tried initially, but it doesn't actually
>> work as expected. I'm not sure what is wrong, or what is the best method
>> to actually get the packed modifier to save into the structure symbol so
>> that it can be checked when determining the structure size.
>>
>> Help would be appreciated.
> 
> Hi,
> 
> There is at least 3 issues with the packed attribute:
> 1) at parsing time, types attributes are not applied to the
>    corresponding symbol,
> 2) the size calculation must take the attribute in account,
> 3) the linearization of memory access must be adapted to be able
>    to access unaligned members otherwise the check access complain
>    loudly.
> 
> Sorry, I don't have much time for this now but at first sight your patch
> seems on the right track. I can look at it more closely this WE but
> meanwhile I've pushed a branch 'packed' on
> 	git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git
> 
> This branch contains an unfinished patches but it should more or less
> handle the points 1) & 2) and circumvent point 3) by disabling access
> checking for bitfields.
> 
> I hope this will help you,
> -- Luc
> 

I did find one bug, in your step (3), you have a check against
info->packed on symbol.c:162 in lay_out_struct, but nothing ever set the
packed value. I think you just need to initialized info->packed from
sym_packed at the top of examine_struct_union_type, i.e.


---
diff --git i/symbol.c w/symbol.c
index 4a654eea9cd0..5a2e0fcd1532 100644
--- i/symbol.c
+++ w/symbol.c
@@ -185,6 +185,8 @@ static struct symbol *
examine_struct_union_type(struct symbol *sym, int advance
        void (*fn)(struct symbol *, struct struct_union_info *);
        struct symbol *member;

+       info.packed = sym->packed;
+
        fn = advance ? lay_out_struct : lay_out_union;
        FOR_EACH_PTR(sym->symbol_list, member) {
                if (member->ctype.base_type == &autotype_ctype) {

---

Without this change, bitfield access checks aren't actually suppressed
properly.

Thanks,
Jake
