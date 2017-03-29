From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Wed, 29 Mar 2017 19:12:16 +0100
Message-ID: <CACXZuxdmV+KGKMEPOmjcyipArp1czg-gpDeXZi7NUfcdkJ-ZHw@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
 <20170328213300.zfa7yecafqvalt5u@macpro.local> <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
 <20170328222124.kjtgzrhzsnsxdtq2@macpro.local> <CACXZuxcU6ehjm=ahXJTjrA0O2TL3+yO1dCNL6-XbyAqwPfFDjA@mail.gmail.com>
 <CACXZuxcYqojtsQEU4t4Kvf1FARj8W1c__6DHXWFxzubEq9Wpjg@mail.gmail.com>
 <CAMHZB6FgpmkNbfcNWb-QjLghkAOZo6=1O0YafZXWFk4O70Neew@mail.gmail.com>
 <CACXZuxeRuqdinWsLXuxwwZgsMs0vHhphDk3rsC3qzww2d6SXEg@mail.gmail.com> <CA+55aFyD9NJBHONUqw2RAu0YLZ-ZeLj71gq7WYdkFRjFkvhA7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33762 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdC2SMS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Mar 2017 14:12:18 -0400
Received: by mail-io0-f175.google.com with SMTP id f84so4232384ioj.0
        for <linux-sparse@vger.kernel.org>; Wed, 29 Mar 2017 11:12:17 -0700 (PDT)
In-Reply-To: <CA+55aFyD9NJBHONUqw2RAu0YLZ-ZeLj71gq7WYdkFRjFkvhA7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 29 March 2017 at 17:41, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, Mar 29, 2017 at 9:21 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I am trying out an approach. If a SYM_NODE has a base type of SYM_NODE
>> then which of the nodes should be used as the source for information
>> you mention?
>
> Does that actually happen? It shouldn't. A symbol node contains the C
> name of the symbol, but you should never have a SYM_NODE that points
> to another SYM_NODE, it always points to some actual type (ie ptr,
> whatever).
>
> So the rule should be that the node can have specific information
> about that particular named symbol (so: name, array size, modifiers,
> address space, initializer etc), and then the node->ctype.base_type
> should point to a non-NODE symbol describing the base type.
>

Okay thank you - that's good to know. It wasn't obvious to me looking
at the code, and I thought I had seen an example where a node
contained another node ... but I cannot find this now, so I may have
been mistaken.

I will add an assertion in sparse-llvm to check this - hopefully that
way if any instance occurs I will see it.

Thanks and Regards
Dibyendu
