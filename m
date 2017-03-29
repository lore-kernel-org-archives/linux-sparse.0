From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm array size computation issue
Date: Wed, 29 Mar 2017 17:10:25 +0200
Message-ID: <CAMHZB6FgpmkNbfcNWb-QjLghkAOZo6=1O0YafZXWFk4O70Neew@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
 <20170328213300.zfa7yecafqvalt5u@macpro.local> <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
 <20170328222124.kjtgzrhzsnsxdtq2@macpro.local> <CACXZuxcU6ehjm=ahXJTjrA0O2TL3+yO1dCNL6-XbyAqwPfFDjA@mail.gmail.com>
 <CACXZuxcYqojtsQEU4t4Kvf1FARj8W1c__6DHXWFxzubEq9Wpjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35405 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdC2PK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Mar 2017 11:10:27 -0400
Received: by mail-qk0-f176.google.com with SMTP id r142so15513892qke.2
        for <linux-sparse@vger.kernel.org>; Wed, 29 Mar 2017 08:10:26 -0700 (PDT)
In-Reply-To: <CACXZuxcYqojtsQEU4t4Kvf1FARj8W1c__6DHXWFxzubEq9Wpjg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 29, 2017 at 4:41 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
>>
>> Okay thank you for the insight. It seems then that sparse-llvm is not
>> handing this correctly.
>>
>
> I looked at this again briefly today. I think that not having the size
> information on the array type poses some problems.
>
> + will instructions have access to the SYM_NODE always? It doesn't
> appear to be the case.

The SYM_NODE is present/only added when needed.
Of course, it's possible that it's somehow stripped in sparse-llvm.

> + sparse-llvm caches the symbol's type in symbol->aux. For array
> types, we would still need to do this - storing the type against
> SYM_NODE objects is probably not correct.

I don't see why it shouldn't be correct.

> So I feel that given that the size is an integral part of the array
> type then it makes sense that it should be present on the array type.

I feel some sympathy for the argument here but ...
there are other infos stored in the SYM_NODE that *can't* be
stored in the symbol underneath it. I'm thinking about the exact type,
the modifiers, for example. You will soon or later need to handle
the SYM_NODE anyway; stripping it and trying to directly use the
base type under is in general wrong.

-- Luc
