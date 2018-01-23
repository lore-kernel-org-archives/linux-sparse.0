From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: option to print compound global data symbol info
Date: Tue, 23 Jan 2018 02:46:05 -0800
Message-ID: <CANeU7Qk=WERUJY9Px1NE__AxxXKMzGMbP1CRLYEUQF8C3KGpJw@mail.gmail.com>
References: <80f9f805-fb35-65d6-4a86-ebe0b740fe58@infradead.org> <20180121042702.sinboahtsdngkojv@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41516 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeAWKqG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Jan 2018 05:46:06 -0500
Received: by mail-qt0-f193.google.com with SMTP id i1so42381qtj.8
        for <linux-sparse@vger.kernel.org>; Tue, 23 Jan 2018 02:46:06 -0800 (PST)
In-Reply-To: <20180121042702.sinboahtsdngkojv@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jan 20, 2018 at 8:27 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Jan 20, 2018 at 07:36:24PM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>> with help from Linus. (many moons ago)
>>
>> sparse addition to print all compound/composite global data symbols
>> with their sizes and alignment.
>>
>> usage: -list-symbols
>> Example: (in kernel tree)
>>   make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
>>   arch/x86/kernel/smpboot.c:99:1: struct cpuinfo_x86 [addressable] [noderef] [toplevel] <asn:3>cpu_info: compound size 240, alignment 8
>
> If this only lists compound symbols, it seems a bit strange to me
> to use '-list-symbols' as the option name. Maybe you could go one
> step further an have '-list-symbols=compound' and if needed it can
> be extended to '-list-symbols=all'.

I think maybe it can be group with the "-v<debug>" options. e.g. "-vcompound".
After all it is showing some debug information very similar to "-ventry".

>
> Not really needed as it's already included indirectly but it
> won't hurt, of course.
>...
>
> Not needed since already declared in lib.h.

Agree here and other Luc's feedback, so I skip the duplication.

>
>> +static void list_all_symbols(struct symbol_list *list)
>> +{
>> +     struct symbol *sym;
>> +
>> +     FOR_EACH_PTR(list, sym) {
>> +             /* Only show arrays, structures, unions, enums, & typedefs */

This comment is a bit confusing for me. It mention "Only show ... *enums*"

>
>> +             if (sym->type == SYM_FN || sym->type == SYM_ENUM)
>> +                     continue;
>> +             if (!sym->ctype.base_type)
>> +                     continue;
>> +             if (sym->ctype.base_type->type == SYM_FN)
>> +                     continue;
>> +             if (sym->ctype.base_type->type == SYM_ENUM)
>> +                     continue;

Here it skips enums. Not consistent with previous comment
about showing enums. Am I missing something obvious?

Chris
