From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Wed, 18 Oct 2017 17:08:15 -0400
Message-ID: <1508360895.4628.45.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
         <1508339545.4628.4.camel@poochiereds.net>
         <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com>
         <1508356857.4628.17.camel@poochiereds.net>
         <CAMHZB6EQq-KV=QXF0VK=G5v6wX+SViWwt-JRph03FV+McEBavg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:47358 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdJRVIT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 17:08:19 -0400
Received: by mail-yw0-f174.google.com with SMTP id a12so1769326ywm.4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 14:08:19 -0700 (PDT)
In-Reply-To: <CAMHZB6EQq-KV=QXF0VK=G5v6wX+SViWwt-JRph03FV+McEBavg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, 2017-10-18 at 22:21 +0200, Luc Van Oostenryck wrote:
> On Wed, Oct 18, 2017 at 10:00 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> > On Wed, 2017-10-18 at 21:41 +0200, Luc Van Oostenryck wrote:
> > > On Wed, Oct 18, 2017 at 5:12 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> > > > 
> > > >     The fedora packaging tools want to override $CFLAGS when building
> > > >     sparse, but that fails on a couple of targets.
> > > > 
> > > >     There are a couple of build targets in the makefile that want to add
> > > >     options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS to
> > > >     the compiler, and that ends up without those extra options, if CFLAGS=
> > > >     was specified on the command line.
> > > > 
> > > >     I'm not sure if this is a recursive variable expansion bug in make, but
> > > 
> > > I think it's just an effect of CFLAGS being then used as a
> > > target-specific variable
> > > 
> > > -- Luc
> > 
> > Ahh ok...so this is probably the correct fix then?
> 
> I guess so but I don't really know how and what you're overriding.
> Something like:
>     make CFLAGS="-O3 -some-others-flags"
> 

Yes, quite similar to that.

Overriding is probably the wrong word. We just want to pass in a
baseline set of CFLAGS and then make can add that on to whatever it likes.

IIUC, the CFLAGS variable is sort of an autotools-ism. We could call it
something else, but that's sort of the bog-standard way that this is
done.

FWIW, the weird bit here is that the ALL_CFLAGS variable gets reexpanded
like you'd expect when you don't pass in CFLAGS on the command line.
It's only when we do that this thing seems to break.

That seems sort of unexpected, IMO, but since we're passing ALL_CFLAGS
to gcc, it makes sense to add these extra options on there in the
makefile.


> To be honest, I don't like much sparse's makefile and I don't see the real need
> for BASIC_CFLAGS & ALL_CFLAGS.
> On the other hand, I understand very well the need for an explicit mechanism for
> adding or changing some CFLAGS's flags
> 

Yeah, even though it's a pretty simple program, using something like
autotools or cmake would give all of this the benefit of better
familiarity for packaging. That also tends to be lower maintenance over
the long haul of a project in my experience.
-- 
Jeff Layton <jlayton@poochiereds.net>
