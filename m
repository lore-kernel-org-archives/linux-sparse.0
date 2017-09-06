From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 6 Sep 2017 11:18:04 -0400
Message-ID: <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x> <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org> <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
 <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34911 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbdIFPSF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 11:18:05 -0400
Received: by mail-yw0-f173.google.com with SMTP id x144so22737908ywg.2
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 08:18:05 -0700 (PDT)
In-Reply-To: <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Wed, Sep 6, 2017 at 10:44 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> and while it's ok to test the core stuff and not wanting the system
> includes to interfere, there should also be tests that check "ordinary"
> userspace programs which naturally depend on the system headers.
>

There is one. The "selfcheck" target was checking sparse on its own
source file. That will definitively use the system header file. However,
there are some warning trigger in the system header file can't be fixed
in the sparse source code. It need to change the system header to make
some warning go away, or disable that warning.

>
> No, it's not solved. But given that it is somehow known that sparse
> (without cgcc) fails to work well on userspace stuff, I think the
> following would be fine for the Debian side:
>
>  a) let horst use cgcc instead of sparse
>  b) downgrade bug to important or even normal pointing out that cgcc
>     should be used for userspace programs

That seems to be the right thing to do for now. That is until
sparse are smarter on user space header regarding architecture stuff.

> For sparse it would be cool to:
>
>  c) drop the #weak_define of __amd64__ to make this "problem" more
>     apparent. (Assuming this doesn't break e.g. a kernel build.)

You mean remove define of "__x86_64__".

It will likely break some other stuff. For the record the "selfcheck" targe=
t
already using cgcc. We still need to fix the breakage.

Any suggestion how to test sparse running on other platform headfile
without have to get access to ppc64 for example? I think that is the bigges=
t
obstacle right now. I can make some changes, but I don't have a good way
to test it other than x86 platform.

>  d) fix the test suite, at least mark the tests that are expected to
>     fail on !x86 as such to make $(make check) succeed. (Otherwise I'd
>     have to disable or ignore the testsuite which isn't that great.)

We can make the test-suite not depend on system header files.
That seems to be the right think to do. I also send out a patch
to let the llvm back end test-suite use cgcc last week. Removing
system header usage in test suite is better.

Chris
