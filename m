From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Wed, 29 Mar 2017 15:41:54 +0100
Message-ID: <CACXZuxcYqojtsQEU4t4Kvf1FARj8W1c__6DHXWFxzubEq9Wpjg@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
 <20170328213300.zfa7yecafqvalt5u@macpro.local> <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
 <20170328222124.kjtgzrhzsnsxdtq2@macpro.local> <CACXZuxcU6ehjm=ahXJTjrA0O2TL3+yO1dCNL6-XbyAqwPfFDjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35397 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbdC2Ol4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Mar 2017 10:41:56 -0400
Received: by mail-io0-f172.google.com with SMTP id z13so89068iof.2
        for <linux-sparse@vger.kernel.org>; Wed, 29 Mar 2017 07:41:55 -0700 (PDT)
In-Reply-To: <CACXZuxcU6ehjm=ahXJTjrA0O2TL3+yO1dCNL6-XbyAqwPfFDjA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 29 March 2017 at 12:32, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 28 March 2017 at 23:21, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>> >> I think that there is a bug in examine_node_type() in symbol.c - it
>>> >> should set the base_type's bit_size perhaps? See the line marked as
>>> >> FIX below,
>>> >>
>>> >> /* Unsized array? The size might come from the initializer.. */
>>> >> if (bit_size < 0 && base_type->type == SYM_ARRAY) {
>>> >> struct expression *initializer = get_symbol_initializer(sym);
>>> >> if (initializer) {
>>> >> struct symbol *node_type = base_type->ctype.base_type;
>>> >> int count = count_array_initializer(S, node_type, initializer);
>>> >>
>>> >> if (node_type && node_type->bit_size >= 0)
>>> >> bit_size = array_element_offset(S->C->target, node_type->bit_size, count);
>>> >> base_type->bit_size = bit_size;   /*** FIX set base_type->bit_size ***/
>>> >> }
>>> >> }
>>> >
>>> > I'm far from sure.
>>> > Yes, here it will works but in general you have no idea who else is
>>> > using the base_type. For other users it may be legitimally still
>>> > be unsized.
>>> >
>>>
>>> I saw that if I set the array size in the C code then
>>> base_type->bit_size gets set. So my reasoning was that this is okay,
>>> as only the way the size is determined is changed, but the array still
>>> has a size. What do you think?
>>
>> Yes, that's normal.
>> The SYM_ARRAY has its size set if the size is given.
>>
>> Otherwise the size will:
>> -) stay unsized. For example, extern int array[] in an include
>>    Most files will just see it and use it like this, and only
>>    a single file will define the array and give it a size.
>> -) will receive a size later, at the end of the initialization.
>>    In this case, the array is given a SYM_NODE and the size
>>    is set there.
>>
>> Important information is stored in the SYM_NODE and it's wrong
>> to just jump over it.
>>
>
> Okay thank you for the insight. It seems then that sparse-llvm is not
> handing this correctly.
>

I looked at this again briefly today. I think that not having the size
information on the array type poses some problems.

+ will instructions have access to the SYM_NODE always? It doesn't
appear to be the case.
+ sparse-llvm caches the symbol's type in symbol->aux. For array
types, we would still need to do this - storing the type against
SYM_NODE objects is probably not correct.

So I feel that given that the size is an integral part of the array
type then it makes sense that it should be present on the array type.
In the testing I have done so far, this appears to work fine (although
I have not yet run the sparse tests - only my own tests).

Thanks and Regards
Dibyendu
