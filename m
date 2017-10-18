From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Wed, 18 Oct 2017 11:12:25 -0400
Message-ID: <1508339545.4628.4.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:49811 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdJRPM2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 11:12:28 -0400
Received: by mail-yw0-f169.google.com with SMTP id n189so817668ywd.6
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 08:12:28 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com. [71.70.156.158])
        by smtp.gmail.com with ESMTPSA id v38sm9855824ywh.36.2017.10.18.08.12.26
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Oct 2017 08:12:26 -0700 (PDT)
In-Reply-To: <20171018150727.26821-1-jlayton@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Wed, 2017-10-18 at 11:07 -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> The fedora packaging tools want to override $CFLAGS when building
> sparse, but that fails on a couple of targets.
> 
> There are a couple of build targets in the makefile that want to add
> options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS
> to the compiler, and that ends up not getting options passed in
> via $CFLAGS on the command line.
> 
> Fix the two specific build targets to add the options to $ALL_CFLAGS
> instead of $CFLAGS.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>


I had revised this and still sent out the old version. That patch
description should read:

    build: assign extra flags to ALL_CFLAGS instead of CFLAGS
    
    The fedora packaging tools want to override $CFLAGS when building
    sparse, but that fails on a couple of targets.
    
    There are a couple of build targets in the makefile that want to add
    options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS to
    the compiler, and that ends up without those extra options, if CFLAGS=
    was specified on the command line.
    
    I'm not sure if this is a recursive variable expansion bug in make, but
    we can work around it either way. Fix the two specific build targets to
    add the options to $ALL_CFLAGS instead of $CFLAGS.
    
    Signed-off-by: Jeff Layton <jlayton@redhat.com>


Let me know if you'd like me to resend it.

> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d0341764158e..b24680b885fe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -83,7 +83,7 @@ PROGRAMS += test-inspect
>  INST_PROGRAMS += test-inspect
>  test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
>  test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
> -$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
> +$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): ALL_CFLAGS += $(GTK_CFLAGS)
>  test-inspect_EXTRA_OBJS := $(GTK_LIBS)
>  else
>  $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
> @@ -208,7 +208,7 @@ ifneq ($(DEP_FILES),)
>  include $(DEP_FILES)
>  endif
>  
> -c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
> +c2xml.o c2xml.sc: ALL_CFLAGS += $(LIBXML_CFLAGS)
>  
>  pre-process.sc: CHECKER_FLAGS += -Wno-vla
>  

-- 
Jeff Layton <jlayton@poochiereds.net>
