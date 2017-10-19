From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Wed, 18 Oct 2017 21:47:43 -0400
Message-ID: <1508377663.19876.20.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
         <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
         <1508358019.4628.35.camel@poochiereds.net>
         <CANeU7QnRU7EgQTX1DiDHQj7JZBeKs2ZAeHKKSJNQxhKPXwoKjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:54863 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdJSBrr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 21:47:47 -0400
Received: by mail-yw0-f181.google.com with SMTP id w5so2238087ywg.11
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 18:47:47 -0700 (PDT)
In-Reply-To: <CANeU7QnRU7EgQTX1DiDHQj7JZBeKs2ZAeHKKSJNQxhKPXwoKjA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jlayton@kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, 2017-10-18 at 15:14 -0700, Christopher Li wrote:
> On Wed, Oct 18, 2017 at 1:20 PM, Jeff Layton <jlayton@poochiereds.net
> > wrote:
> > 
> > Fedora, Red Hat, etc., define some macros that are considered
> > "standard"
> > build options during packaging. These get passed into "make" and
> > make is
> > expected to add to that list as necessary.
> 
> Does all open source package follow this convention or that is a
> result
> of a lot of open source project using autotools
> 

Both. Most open source packages use autotools for historical reasons.

> > 
> > Here's what the make command looks like when called by rpmbuild
> > with the
> > fedora package (built out of my homedir):
> > 
> >     $ make DESTDIR=/home/jlayton/rpmbuild/BUILDROOT/sparse-0.5.1-
> > 1.fc26.x86_64 PREFIX=/usr BINDIR=/usr/bin LIBDIR=/usr/lib64
> > INCLUDEDIR=/usr/include PKGCONFIGDIR=/usr/lib64/pkgconfig -j16
> > 'CFLAGS=-O2 -g -pipe -Wall -Werror=format-security -Wp,-
> > D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --
> > param=ssp-buffer-size=4 -grecord-gcc-switches
> > -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic'
> > HAVE_LLVM=no
> 
> So here by specifying CFLAGS, the original assign for CFLAGS:
> 
> CFLAGS = -O$(OPT) -finline-functions -fno-strict-aliasing -g
> 
> The above assignment will be ignored. Is that intentional?
> 
> Put it in a different way, Now " -finline-functions
> -fno-strict-aliasing" are no longer
> pass to gcc when compile sparse files any more.
> 

No, it wasn't intentional. Could we just turn that into a +=
assignment?

> > 
> > This is how things like FORTIFY_SOURCE end up being widespread in
> > distros without having to touch every program.
> > 
> > 
> > > It seems wrong to overwrite CFLAGS from command line. That are
> > > other flags store in the CFLAGS will get overwritten.
> > > 
> > 
> > I'm not sure I understand the objection here. Basically we just
> > want to
> > pass in a "base" set of CFLAGS and then let make add others as it
> > sees
> > fit.
> 
> So your intention is just adding arguments. No removing existing
> CFLAG
> arguments. e.g. removing " -finline-functions -fno-strict-aliasing"
> from
> your invocation is just accident.
> 

Yes.

> > > We have add some variable in the ALL_CFLAGS list for overwrite
> > > purpose  e.g. CFLAGS_CMD then have command line over write that?
> > > 
> > 
> > FWIW, I inherited this specfile long ago and have only tweaked it
> > since.
> > It could probably be better, but I'd like to make it less of a
> > special
> > snowflake over the long haul. Hand rolled makefiles are generally a
> > pain
> > in this regard.
> 
> Well, sparse is not using autotools. So it is always be special if
> you consider
> autotools the norm.
> 
> If your goal is just add some baseline compile options to gcc.
> It seems better by provide some thing like CFLAGS_CMD as part of the
> ALL_CFLAGS group. Then you can just add your options there. The
> variable
> name of "CFLAGS_CMD" is subject to discussion. You can make
> suggestions.
> Overwrite the CFLAGS variable from command line does have side effect
> of dropping some options like " -finline-functions -fno-strict-
> aliasing".
> It comes down to is your intend to drop those?
> 
> > 
> > I can certainly adapt the specfile this to pass in some other
> > variable
> > than CFLAGS if you like, but I don't really see how that would
> > improve
> > anything.
> 
> " -finline-functions -fno-strict-aliasing" has impact on the output
> code
> it produce. Unless you are intentionally dropping them. Provide other
> variable
> for you to overwrite can preserve those compile flags.
> 
> You do know that once you specify CFLAGS in the make command line,
> by default all other assign to CFLAGS from the Makefile will be
> ignored.
> 

Got it, thanks. Basically I just need a way to pass in a basic set of
flags to gcc, that are either appended or prepended to whatever you
need to have in there. If we need to call it something other than
CFLAGS, then that's fine.

Thanks,
-- 
Jeff Layton <jlayton@poochiereds.net>
