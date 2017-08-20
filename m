From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 17:26:09 +0100
Message-ID: <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local> <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
 <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34374 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdHTQ0K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:26:10 -0400
Received: by mail-vk0-f43.google.com with SMTP id n125so44365032vke.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:26:10 -0700 (PDT)
In-Reply-To: <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 20 August 2017 at 17:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Aug 20, 2017 at 9:12 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Okay the linear output above seems SSA if we consider how it is shown
>> in the output. But in the code, access to 0[a] occurs via a pseudo -
>> of type PSEUDO_SYM. We see multiple stores happening to this pseudo.
>
> No. There are no stores _to_ the pseudo.
>

Okay I see.

> The PSEUDO_SYM is an *address*. It's not changed. A "store" does not
> assign a value to a pseudo, it writes to *memory*, and the pseudo
> gives the address. It's purely a read of the pseudo.
>
>> So then is it more accurate to say that PSEUDO_SYM and possibly
>> PSEUDO_ARG too - represent memory access, and are just a proxy for
>> stack allocated memory?
>
> No. All pseudos are strictly write-once (after the SSA conversion).
> Memory operations don't write to pseudos. They only use pseudos for
> addresses.
>

Thanks. So does that mean that pseudos are SSA from the initial
linearization phase, and therefore the baseline linear output is
already SSA? By SSA conversion are you referring to the subsequent
phase when memory accesses are converted to pseudos where possible?

Regards
Dibyendu
