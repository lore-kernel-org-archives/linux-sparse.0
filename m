From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Sun, 3 Sep 2017 23:14:36 +0200
Message-ID: <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com> <20170901070212.7xurrbentxybdhfx@x>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35760 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbdICVOh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 3 Sep 2017 17:14:37 -0400
Received: by mail-vk0-f42.google.com with SMTP id z187so10507011vkd.2
        for <linux-sparse@vger.kernel.org>; Sun, 03 Sep 2017 14:14:37 -0700 (PDT)
In-Reply-To: <20170901070212.7xurrbentxybdhfx@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Fri, Sep 1, 2017 at 9:02 AM, Josh Triplett <josh@joshtriplett.org> wrote=
:
> On Thu, Aug 31, 2017 at 08:47:55PM -0400, Christopher Li wrote:
>> On Thu, Aug 31, 2017 at 4:55 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-> Yes
>> that works. So to address the Debian bug I can do:
>> >
>> >  - move sparse to /usr/lib
>> >  - teach cgcc about the move of sparse
>> >  - make /usr/bin/sparse call cgcc -no-compile "$@"
>>
>> I don't like that. It means the user can't invoke sparse directly.
>>
>> >
>> > or is it easier to teach sparse about the architecture stuff?
>>
>> First of all. It is not very trivial to teach sparse about the architect=
ure
>> stuff. To my mind, we need to move all the cgcc logic into sparse.
>
> Related to that: while it would mean we couldn't necessarily just rely
> entirely on GCC's definitions for a target platform, I think in an ideal
> world we could have a sparse binary that understood *all* target
> platforms at once, such that you could ask Sparse on x86_64 to "compile"
> as though targeting any arbitrary architecture. That would also have the
> major advantage of making it easy to run the Sparse testsuite for
> *every* target architecture without needing compilers for every such
> architecture.

I really think that the testsuite should not depend on system or library
header.

Otherwise, I'm not at all opposed to sparse being universal but I would lik=
e
to note that things can become very quickly very very messy.
For example, for the current problem here I understood that it was
at least partially based on the lack of a definition of _CALL_ELF
but do we need to define it to 1 or to 2, in other words, do we need
to support the ELFv1 ABI or the ELFv2? GCC has some flags for this
(-mabi=3Delfv[12]) but what default value do we want? ELFv1 is the default
for big-endian platform and ELFv2 for little-endian platform, so yes,
we need a flag for the endianness but which endianness we want as default?
And so on.

Things become even more fun when taking in account the difference
between GCC version. Do we want to be universal there too (and thus
have some flags for to specify which gcc's version we want to mimick)?
What about other compilers?


I think that part of the needed info can be auto-extracted from GCC
when doing a native build. Using some sort of spec file or a .sparserc
can help too.

I also note that currently, sparse is already largely universal *because*
it *doesn't* need those platform details (or only the very minimal: word si=
ze).

-- Luc Van Oostenryck
