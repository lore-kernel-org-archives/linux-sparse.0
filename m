From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Mon, 4 Sep 2017 14:00:56 -0400
Message-ID: <CANeU7Q=fBkQAWfB8sWW0=ZWC8CJV83w8Bo_iHeaRBHKc8vLB-Q@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x> <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36157 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbdIDSA6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 14:00:58 -0400
Received: by mail-yw0-f171.google.com with SMTP id w204so4595445ywg.3
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 11:00:58 -0700 (PDT)
In-Reply-To: <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Sun, Sep 3, 2017 at 5:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I really think that the testsuite should not depend on system or library
> header.

I think that is a good point. We can start cleaning up the system header
file dependency in the existing test suite. See how it goes.

>
> Otherwise, I'm not at all opposed to sparse being universal but I would like
> to note that things can become very quickly very very messy.
> For example, for the current problem here I understood that it was
> at least partially based on the lack of a definition of _CALL_ELF
> but do we need to define it to 1 or to 2, in other words, do we need
> to support the ELFv1 ABI or the ELFv2? GCC has some flags for this
> (-mabi=elfv[12]) but what default value do we want? ELFv1 is the default

I think we can just sparse default to as late as the latest release
version of gcc.

> for big-endian platform and ELFv2 for little-endian platform, so yes,
> we need a flag for the endianness but which endianness we want as default?

I am tempting to make the endianness the same as the host gcc by default.
Then it can be overwrite by architecture flags.

>
> Things become even more fun when taking in account the difference
> between GCC version. Do we want to be universal there too (and thus
> have some flags for to specify which gcc's version we want to mimick)?
> What about other compilers?

I purpose just sync to the latest gcc version (or a late enough version
we can agree on. e.g. the one that supported by kernel compile.) Sparse
current try to sync to the latest gcc attributes already.

> I think that part of the needed info can be auto-extracted from GCC
> when doing a native build. Using some sort of spec file or a .sparserc

Is there a way to do auto-extract? That would be a good starting point.

> I also note that currently, sparse is already largely universal *because*
> it *doesn't* need those platform details (or only the very minimal: word size).

Sparse is not universal, it just support a very small sub set of the C
source file that haven't expose to those platform detail macros. Adding
those architecture macro support will not make it any less universal.
Might slow things down, that is some thing we need to watch out for.

Chris
