From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 15:28:44 +0100
Message-ID: <20170311142843.ssfj7xswj2llsepx@macbook.local>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local>
 <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
 <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local>
 <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34877 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934205AbdCKO2t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 09:28:49 -0500
Received: by mail-wr0-f182.google.com with SMTP id g10so80034899wrg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 06:28:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Mar 11, 2017 at 02:16:59PM +0000, Dibyendu Majumdar wrote:
> 
> Good news is that with this fix and by using a function pointer call
> syntax that doesn't use (*f)() - I am able to successfully compile an
> AVL Tree implementation. Whether the generated code is correct is
> still to be checked but this is a big step forward I think - so many
> thanks for the help!

Great. You're welcome.

> > However I'm slowly looking at a more generic solution.
> > For example, it would certainly be easier if there would be a
> > OP_PTRCAST between a constant-value-used-as-a-pointer and its use.
> > The cost would be some missing optimizations, or more complex ones
> > or a sort of normalization pass.
> >
> 
> I still think pseudo values should have a type - then we won't need
> all the complexity!

Yes, but it would need an additional pointer for all pseudos and
it's a cost we won't do (but this just gave me an idea).

-- Luc Van Oostenryck
