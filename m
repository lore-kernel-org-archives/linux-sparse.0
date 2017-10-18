From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Wed, 18 Oct 2017 16:20:19 -0400
Message-ID: <1508358019.4628.35.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
         <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:51208 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdJRUUW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 16:20:22 -0400
Received: by mail-yw0-f195.google.com with SMTP id k3so1654712ywk.8
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 13:20:22 -0700 (PDT)
In-Reply-To: <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Jeff Layton <jlayton@kernel.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, 2017-10-18 at 12:36 -0700, Christopher Li wrote:
> On Wed, Oct 18, 2017 at 8:07 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > The fedora packaging tools want to override $CFLAGS when building
> > sparse, but that fails on a couple of targets.
> > 
> > There are a couple of build targets in the makefile that want to add
> > options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS
> > to the compiler, and that ends up not getting options passed in
> > via $CFLAGS on the command line.
> 
> Can you give example of what CFLAGS it passed in the command line?
> Does it append some flags only?
> 

Fedora, Red Hat, etc., define some macros that are considered "standard"
build options during packaging. These get passed into "make" and make is
expected to add to that list as necessary.

Here's what the make command looks like when called by rpmbuild with the
fedora package (built out of my homedir):

    $ make DESTDIR=/home/jlayton/rpmbuild/BUILDROOT/sparse-0.5.1-1.fc26.x86_64 PREFIX=/usr BINDIR=/usr/bin LIBDIR=/usr/lib64 INCLUDEDIR=/usr/include PKGCONFIGDIR=/usr/lib64/pkgconfig -j16 'CFLAGS=-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic' HAVE_LLVM=no

This is how things like FORTIFY_SOURCE end up being widespread in
distros without having to touch every program.


> It seems wrong to overwrite CFLAGS from command line. That are
> other flags store in the CFLAGS will get overwritten.
> 

I'm not sure I understand the objection here. Basically we just want to
pass in a "base" set of CFLAGS and then let make add others as it sees
fit.

> We have add some variable in the ALL_CFLAGS list for overwrite
> purpose  e.g. CFLAGS_CMD then have command line over write that?
> 

FWIW, I inherited this specfile long ago and have only tweaked it since.
It could probably be better, but I'd like to make it less of a special
snowflake over the long haul. Hand rolled makefiles are generally a pain
in this regard.

I can certainly adapt the specfile this to pass in some other variable
than CFLAGS if you like, but I don't really see how that would improve
anything.

-- 
Jeff Layton <jlayton@poochiereds.net>
