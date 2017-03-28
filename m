From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Tue, 28 Mar 2017 22:43:54 +0100
Message-ID: <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com> <20170328213300.zfa7yecafqvalt5u@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36865 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbdC1Vn4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 17:43:56 -0400
Received: by mail-it0-f49.google.com with SMTP id 190so35324477itm.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 14:43:55 -0700 (PDT)
In-Reply-To: <20170328213300.zfa7yecafqvalt5u@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 28 March 2017 at 22:33, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Mar 28, 2017 at 10:14:43PM +0100, Dibyendu Majumdar wrote:
>
>> I think that there is a bug in examine_node_type() in symbol.c - it
>> should set the base_type's bit_size perhaps? See the line marked as
>> FIX below,
>>
>> /* Unsized array? The size might come from the initializer.. */
>> if (bit_size < 0 && base_type->type == SYM_ARRAY) {
>> struct expression *initializer = get_symbol_initializer(sym);
>> if (initializer) {
>> struct symbol *node_type = base_type->ctype.base_type;
>> int count = count_array_initializer(S, node_type, initializer);
>>
>> if (node_type && node_type->bit_size >= 0)
>> bit_size = array_element_offset(S->C->target, node_type->bit_size, count);
>> base_type->bit_size = bit_size;   /*** FIX set base_type->bit_size ***/
>> }
>> }
>
> I'm far from sure.
> Yes, here it will works but in general you have no idea who else is
> using the base_type. For other users it may be legitimally still
> be unsized.
>

I saw that if I set the array size in the C code then
base_type->bit_size gets set. So my reasoning was that this is okay,
as only the way the size is determined is changed, but the array still
has a size. What do you think?

Regards
Dibyendu
