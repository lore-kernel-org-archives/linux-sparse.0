From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Wed, 18 Oct 2017 16:00:57 -0400
Message-ID: <1508356857.4628.17.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
         <1508339545.4628.4.camel@poochiereds.net>
         <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:45598 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdJRUBA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 16:01:00 -0400
Received: by mail-yw0-f172.google.com with SMTP id j4so1603608ywb.2
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 13:01:00 -0700 (PDT)
In-Reply-To: <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, 2017-10-18 at 21:41 +0200, Luc Van Oostenryck wrote:
> On Wed, Oct 18, 2017 at 5:12 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> > 
> >     The fedora packaging tools want to override $CFLAGS when building
> >     sparse, but that fails on a couple of targets.
> > 
> >     There are a couple of build targets in the makefile that want to add
> >     options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS to
> >     the compiler, and that ends up without those extra options, if CFLAGS=
> >     was specified on the command line.
> > 
> >     I'm not sure if this is a recursive variable expansion bug in make, but
> 
> I think it's just an effect of CFLAGS being then used as a
> target-specific variable
> 
> -- Luc

Ahh ok...so this is probably the correct fix then?

Thanks for looking!
-- 
Jeff Layton <jlayton@poochiereds.net>
