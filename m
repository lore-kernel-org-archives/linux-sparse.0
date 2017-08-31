From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 30 Aug 2017 20:11:49 -0400
Message-ID: <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com> <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36535 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbdHaALu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Aug 2017 20:11:50 -0400
Received: by mail-yw0-f174.google.com with SMTP id h127so38622700ywf.3
        for <linux-sparse@vger.kernel.org>; Wed, 30 Aug 2017 17:11:50 -0700 (PDT)
In-Reply-To: <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Wed, Aug 30, 2017 at 1:36 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>> >
>> > diff --git a/validation/backend/sum.c b/validation/backend/sum.c
>> > index 0604299..d0be8dd 100644
>> > --- a/validation/backend/sum.c
>> > +++ b/validation/backend/sum.c
>> > @@ -1,3 +1,5 @@
>> > +#define __powerpc64__
>> > +#define _CALL_ELF 2
>> >  #include <stdio.h>
>> >  #include <stdlib.h>
>> >
>> >
>>
>> Yep, sparse/sparsec do not define various macros that gcc/clang define
>> by default on a given architecture. This is a known problem (that I have
>> been meaning to fix ...). The 'workaround' for the time being is to use
>> the cgcc front-end to sparse. (for example 'make CC=3Dcgcc', or perhaps
>> 'cgcc -no-compile').
>>
>> [You didn't mention your usage - is this for a kernel build?]
>
> This problem became visible during the make check phase when creating pac=
kaged
> on the listed archs for horst[1]. You can see a build logs at
>
>         https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Ds39=
0x&ver=3D5.0-1&stamp=3D1503905687&raw=3D0
>         https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Dppc=
64el&ver=3D5.0-1&stamp=3D1503906226&raw=3D0
>
> The error message looks identical (I checked the ppc64el log) to the
> problem with backend/sum.c:
>
>         sparse -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR>>=3D. -fstack-p=
rotector-strong -Wformat -Werror=3Dformat-security -std=3Dgnu99 -Wall -Wext=
ra -g -I. -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
>         /usr/include/powerpc64le-linux-gnu/gnu/stubs.h:8:12: error: unabl=
e to open 'gnu/stubs-32.h'

That is very much like on x86_64 missing define "#weak_define __x86_64__ 1"

Does cgcc work for you? In the future we do want to move the archetecture
related define from cgcc into sparse by itself. For now you can set
"sparse" as "cgcc -no-compile"

Chris
