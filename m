From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] sparse: option to print compound global data symbol info
Date: Wed, 24 Jan 2018 22:15:32 -0800
Message-ID: <6c5e4947-0ca7-0ca7-17fa-42c8162e4556@infradead.org>
References: <80f9f805-fb35-65d6-4a86-ebe0b740fe58@infradead.org>
 <20180121042702.sinboahtsdngkojv@ltop.local>
 <CANeU7Qk=WERUJY9Px1NE__AxxXKMzGMbP1CRLYEUQF8C3KGpJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55843 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeAYGPe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Jan 2018 01:15:34 -0500
In-Reply-To: <CANeU7Qk=WERUJY9Px1NE__AxxXKMzGMbP1CRLYEUQF8C3KGpJw@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 01/23/2018 02:46 AM, Christopher Li wrote:
> On Sat, Jan 20, 2018 at 8:27 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Sat, Jan 20, 2018 at 07:36:24PM -0800, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>> with help from Linus. (many moons ago)
>>>
>>> sparse addition to print all compound/composite global data symbols
>>> with their sizes and alignment.
>>>
>>> usage: -list-symbols
>>> Example: (in kernel tree)
>>>   make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
>>>   arch/x86/kernel/smpboot.c:99:1: struct cpuinfo_x86 [addressable] [noderef] [toplevel] <asn:3>cpu_info: compound size 240, alignment 8
>>
>> If this only lists compound symbols, it seems a bit strange to me
>> to use '-list-symbols' as the option name. Maybe you could go one
>> step further an have '-list-symbols=compound' and if needed it can
>> be extended to '-list-symbols=all'.
> 
> I think maybe it can be group with the "-v<debug>" options. e.g. "-vcompound".
> After all it is showing some debug information very similar to "-ventry".
> 

OK, thanks for that.  I was a bit hung up on where to go with that.

>>
>> Not really needed as it's already included indirectly but it
>> won't hurt, of course.
>> ...
>>
>> Not needed since already declared in lib.h.
> 
> Agree here and other Luc's feedback, so I skip the duplication.
> 
>>
>>> +static void list_all_symbols(struct symbol_list *list)
>>> +{
>>> +     struct symbol *sym;
>>> +
>>> +     FOR_EACH_PTR(list, sym) {
>>> +             /* Only show arrays, structures, unions, enums, & typedefs */
> 
> This comment is a bit confusing for me. It mention "Only show ... *enums*"
> 
>>
>>> +             if (sym->type == SYM_FN || sym->type == SYM_ENUM)
>>> +                     continue;
>>> +             if (!sym->ctype.base_type)
>>> +                     continue;
>>> +             if (sym->ctype.base_type->type == SYM_FN)
>>> +                     continue;
>>> +             if (sym->ctype.base_type->type == SYM_ENUM)
>>> +                     continue;
> 
> Here it skips enums. Not consistent with previous comment
> about showing enums. Am I missing something obvious?

Nope.  I have already corrected that locally a few days ago.

thanks.
-- 
~Randy
