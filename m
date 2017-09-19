From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Tue, 19 Sep 2017 11:42:30 -0400
Message-ID: <CANeU7Q=+pM5=Lezf1Wo750ULaKGvLTOMCvTMp6zvPdiKzu_S3w@mail.gmail.com>
References: <20170914184540.26650-1-uwe@kleine-koenig.org> <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
 <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:56966 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdISPmc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 11:42:32 -0400
Received: by mail-yw0-f181.google.com with SMTP id w22so280108ywa.13
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 08:42:31 -0700 (PDT)
In-Reply-To: <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 19, 2017 at 10:50 AM, Uwe Kleine-K=C3=B6nig
<uwe@kleine-koenig.org> wrote:
>> You can use "ifneq ($(MAKECMDGOALS),clean)"
>
> So it still triggers when doing
>
>         make clean all

That is the correct behavior. Because "all" require version.h.
It is a silly thing to put clean and all together, but the makefile
actually do the right thing.

>
> Also you don't want to generate it for $(make check).

check is depend on all which depend on version.h.
So that seems acceptable to me.

Plus in the make check case, it will only look at the version.h,
it will not regenerate it if data is the same.

> IMHO that's hardly manageable to get done consistently this way and the
> easiest is a separate rule for version.h that is triggered by make
> dependencies as I suggested

The problem is that, you end up updating the version.h from make's
point of view. Then make detect the version.h's time stamp haven't
change and take a short cut. That is the part I consider not clean.

In other words, if you only look at the make rules and ignore the
time stamp short cut. "version.h" will be force to update every
time. It should also recompile lib.o without the short cut.

>> to wrap it. GNU make document even show that as examples
>> of using $(MAKECMDGOALS).
>
> IMHO that is no prove that the idea is sane.

All the example you give seems give sane result.


>> The above section is not needed if you use the ifneq test on $(MAKECMDGO=
ALS).> I also test it and found the problem that, the version.h was force
>> to obsolete. Two consequent make will always show "GEN version.h"
>> line.
>
> Then maybe split it into
>
>         CHECK version.h
>         GEN   version.h
>
> ? The GEN would be skipped if version.h doesn't need an update.

Then there is another thing I consider slightly unclean.
The check rules will optionally update another target "version.h" without
specificity in its rules.

We can use order only rules for check target. The whole thing seems
gets more complicated than it needs to.

Chris
