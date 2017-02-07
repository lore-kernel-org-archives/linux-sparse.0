From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 4/5] simplify '(x / -1)' to '-x' (but only for signed
 division)
Date: Tue, 7 Feb 2017 21:28:06 +0100
Message-ID: <20170207202805.vtpnn3w5nyt4xwp7@macpro.local>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
 <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
 <20170207190028.24343-5-luc.vanoostenryck@gmail.com>
 <87mvdx4wph.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32877 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbdBGU2O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:28:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so30352730wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:28:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87mvdx4wph.fsf@rasmusvillemoes.dk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Tue, Feb 07, 2017 at 08:39:22PM +0100, Rasmus Villemoes wrote:
> On Tue, Feb 07 2017, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> 
> >  int smulm1(int a) { return a * -1; }
> >  u32 umulm1(u32 a) { return a * (u32) -1; }
> > +int sdivm1(int a) { return a * -1; }
> 
> You probably meant / rather than *.
Indeed, nice catch. Thanks.

> Also, shouldn't you also add a test that
> when a is unsigned, a/-1 does _not_ get transformed to -a?
Hummm , yes but ... well, I'll see what I can do.

Luc
