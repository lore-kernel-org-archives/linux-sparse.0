From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Fri, 15 Sep 2017 12:52:19 -0400
Message-ID: <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:46369 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdIOQwU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 12:52:20 -0400
Received: by mail-yw0-f172.google.com with SMTP id v72so1797818ywa.3
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 09:52:20 -0700 (PDT)
In-Reply-To: <20170914184540.26650-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 2:45 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> -# Generating file version.h if current version has changed
>  SPARSE_VERSION:=3D$(shell git describe 2>/dev/null || echo '$(VERSION)')
> -VERSION_H :=3D $(shell cat version.h 2>/dev/null)
> -ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
> -$(info $(shell echo '     GEN      'version.h))
> -$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h)
> -endif

You don't need to move them to into a rule section.

You can use "ifneq ($(MAKECMDGOALS),clean)"
to wrap it. GNU make document even show that as examples
of using $(MAKECMDGOALS).


> +version.h: FORCE
> +       $(QUIET_GEN)echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > v=
ersion.h.tmp; \
> +       if cmp -s version.h version.h.tmp; then \
> +               rm version.h.tmp; \
> +       else \
> +               mv version.h.tmp version.h; \
> +       fi
> +
> +.PHONY: FORCE
> +
> +lib.o: version.h
> +

The above section is not needed if you use the ifneq test on $(MAKECMDGOALS=
).
I also test it and found the problem that, the version.h was force
to obsolete. Two consequent make will always show "GEN version.h"
line.

>  clean: clean-check
> -       rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h spa=
rse.pc
> +       rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h spa=
rse.pc version.h

This line is good.

If you don't mind I am going to apply this (the 3 liner version) after
my debug build patches.
It has conflict with my debug build patch and it is much easier to fix conf=
lict
on this 3 liner patch than the other way around.

Chris
