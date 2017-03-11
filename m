From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 18:08:04 +0000
Message-ID: <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local> <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local> <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com> <20170311155135.kjxkiymcn7jo2ez2@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:35775 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755416AbdCKSIG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 13:08:06 -0500
Received: by mail-it0-f47.google.com with SMTP id m27so11808785iti.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 10:08:05 -0800 (PST)
In-Reply-To: <20170311155135.kjxkiymcn7jo2ez2@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On 11 March 2017 at 15:51, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 10:10:27AM -0500, Jeff Garzik wrote:
>> On Sat, Mar 11, 2017 at 9:16 AM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>> > I still think pseudo values should have a type - then we won't need
>> > all the complexity!
>>
>> Yep, agreed - giving pseudos a type is both natural and intentional -
>> it is a natural outcome of the operation, and should be available
>> without any further lookups.  Giving pseudos a type actually
>> simplifies complexity and makes tree manipulation (optimizer) easier.
>>
>>  ...of course we need to maintain that type information correctly in
>> all cases and through all transformations...
>
> OK. The mini-serie I just posted *should* give (correct?) type
> information to all PSEUDO_VALs.
>
> Dibyendu, can you look if we can make good use of it?
>

Sure. We may need to rework some of the previous changes but one case
comes straight to mind - that of variadic functions such as printf.

Regards
