From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm array size computation issue
Date: Wed, 29 Mar 2017 17:21:58 +0100
Message-ID: <CACXZuxeRuqdinWsLXuxwwZgsMs0vHhphDk3rsC3qzww2d6SXEg@mail.gmail.com>
References: <CACXZuxdBRB+mvRJf3VGLK2Po8w9gvSXkjTnt3=UCfoa2Wqm5Ew@mail.gmail.com>
 <CACXZuxd5cgfdE-cPZ4mkLnzy=MNn5B9EJNAYaazV3VV9o1_QKQ@mail.gmail.com>
 <CAExDi1QupTRLhPDh8PmieMQh1zr2nV59JjjQHKd4r9ab4nTu0w@mail.gmail.com>
 <CACXZuxcnxYvqM8=kDe=AkWuYB=TmU9mwd9gKc9_veZhbD0z1Xw@mail.gmail.com>
 <CACXZuxcozbUcY9Bot65eSXjSxCDTzVbGSqTqJwgRCit24zisWA@mail.gmail.com>
 <20170328213300.zfa7yecafqvalt5u@macpro.local> <CACXZuxf3nuNV61MDoTGx7oiBGBUn+Gcw4B=BaVvRW_N-GydW4Q@mail.gmail.com>
 <20170328222124.kjtgzrhzsnsxdtq2@macpro.local> <CACXZuxcU6ehjm=ahXJTjrA0O2TL3+yO1dCNL6-XbyAqwPfFDjA@mail.gmail.com>
 <CACXZuxcYqojtsQEU4t4Kvf1FARj8W1c__6DHXWFxzubEq9Wpjg@mail.gmail.com> <CAMHZB6FgpmkNbfcNWb-QjLghkAOZo6=1O0YafZXWFk4O70Neew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38856 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdC2QWA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Mar 2017 12:22:00 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so61415979itc.1
        for <linux-sparse@vger.kernel.org>; Wed, 29 Mar 2017 09:21:59 -0700 (PDT)
In-Reply-To: <CAMHZB6FgpmkNbfcNWb-QjLghkAOZo6=1O0YafZXWFk4O70Neew@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 29 March 2017 at 16:10, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> there are other infos stored in the SYM_NODE that *can't* be
> stored in the symbol underneath it. I'm thinking about the exact type,
> the modifiers, for example. You will soon or later need to handle
> the SYM_NODE anyway; stripping it and trying to directly use the
> base type under is in general wrong.
>

I am trying out an approach. If a SYM_NODE has a base type of SYM_NODE
then which of the nodes should be used as the source for information
you mention?

Thanks and Regards
Dibyendu
