From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3] fix: add missing degenerate() for logical not
Date: Sun, 10 Dec 2017 18:23:14 +0100
Message-ID: <20171210172314.baxjs6ftebwyyo3v@ltop.local>
References: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
 <20171207171613.34989-4-luc.vanoostenryck@gmail.com>
 <CANeU7QkxL73nNSqaQXu-jprQMXnZFMcD5WbFdmvf4di6N3oiRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:41441 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdLJRXS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 10 Dec 2017 12:23:18 -0500
Received: by mail-wm0-f53.google.com with SMTP id g75so10635309wme.0
        for <linux-sparse@vger.kernel.org>; Sun, 10 Dec 2017 09:23:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkxL73nNSqaQXu-jprQMXnZFMcD5WbFdmvf4di6N3oiRg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Dec 08, 2017 at 09:49:22AM +0800, Christopher Li wrote:
> On Fri, Dec 8, 2017 at 1:16 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Expressions involving the logical-not '!' does not
> > call degenerate().
> >
> > Since the result type is always 'int' and thus independent
> > of the expression being negated, this has no effect on the
> > type-checking but the linearization is wrong.
> > For example, code like:
> >         int foo(void)
> >         {
> >                 if (!arr) return 1;
> >                 return 0;
> >         }
> > generates:
> >         foo:
> >                 load        %r6 <- 0[arr]
> >                 seteq.32    %r7 <- VOID, $0
> >                 ret.32      %r7
> > The 'load' being, obviously wrong.
> >
> > Fix this by adding the missing degenerate().
> 
> Good catch. This series looks good to me.
> 
> Chris

Thanks,
-- Luc
