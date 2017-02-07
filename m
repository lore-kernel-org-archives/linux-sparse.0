From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/3] allow builtins to have prototype and evaluate/expand
 methods
Date: Tue, 7 Feb 2017 22:34:49 +0100
Message-ID: <20170207213448.ah3tjuifg6iwpahg@macpro.local>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
 <20170123213728.89900-3-luc.vanoostenryck@gmail.com>
 <CANeU7QkTLwcVq4Spv4CcZjpjuZybW1=39Z5hU=5Qu6jYGB8=EA@mail.gmail.com>
 <20170207201253.4i2ye6inqwma65rf@macpro.local>
 <CANeU7QnfuFjr_bZRqeED8Q54xcm-yeo9-=R8vVHbhvt8ukjxTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36608 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbdBGVew (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 16:34:52 -0500
Received: by mail-wr0-f196.google.com with SMTP id k90so6657934wrc.3
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 13:34:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnfuFjr_bZRqeED8Q54xcm-yeo9-=R8vVHbhvt8ukjxTQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Feb 08, 2017 at 04:32:08AM +0800, Christopher Li wrote:
> On Wed, Feb 8, 2017 at 4:12 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I'm very well aware of this bug/problem, it creates all sort of complications
> > but I vaguely understood it was a design choice. To be 100%, you're talking
> > the fact that each declaration create a new symbol only related by their
> > identifier chain, right?
> 
> Yes. I don't see a way not creating the symbol for each declaration.
> However, we can make a better job at migrating the bits between each
> declaration.

I see roughly a way how we could do that but I'm far from being
convinced it would be a good idea.
The problem is not that we have one symbol per declaration, it's
even not that we have several symbols for the same object, it's
that we don't have a central place holding the information about
the object.  Like, for example, we can't answer something essential
like "what is the type of this function" because we have as much
types as we have declarations. So yes, verification of the
comptability between the declarations and consolidate them is what
is missing.


Luc
