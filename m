From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Sun, 10 Sep 2017 11:39:46 +0200
Message-ID: <CAExDi1Ty+4PDgF07nFKiVE4irM8Kbv4FOGmgZq4qfQAThvP0ZQ@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
 <CAExDi1SRgOj8qKvxR6O56hbmXS6mDQbkTEhpSUZkRamJMaaqZw@mail.gmail.com> <df2139ba-8ac3-00c7-5c46-896f15c13671@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:37021 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdIJJjt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 10 Sep 2017 05:39:49 -0400
Received: by mail-lf0-f53.google.com with SMTP id 80so12734008lfy.4
        for <linux-sparse@vger.kernel.org>; Sun, 10 Sep 2017 02:39:48 -0700 (PDT)
In-Reply-To: <df2139ba-8ac3-00c7-5c46-896f15c13671@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Sun, Sep 10, 2017 at 10:43 AM, Uwe Kleine-K=C3=B6nig
<uwe@kleine-koenig.org> wrote:
> On 09/10/2017 03:22 AM, Luc Van Oostenryck wrote:
>>
>> I fully test on x86, x86-64, arm & ARM64 (with LLVM 3.9 or 4.0).
>> I also test on ppc64 but not the LLVM part because the machines I have
>> access to have not LLVM installed and I never bothered to install it mys=
elf.
>>
>> Would it be possible to have access to a machine with the architectures
>> you care about?
>
> Debian provides access to porter boxes for such problems. See
> https://dsa.debian.org/doc/guest-account/.

OK.
I'll first try to install LLVM on what I have already access, it
should be faster.

>> Meanwhile, is it possible to have the build logs but with 'make V=3D1 ..=
.' ?
>> It would also be useful to have:
>> - the output of 'uname -a'
>> - the details about the version of LLVM you're using
>
> Sure, can do. Attached is a build from the ppc64el machine with Chris'
> patch applied. Tell me if it contains everything you need.

Yes, enough to investigate the problem. Thanks.

>> On the other hand, you/us should disable the sparse-llvm part since:
>> - it's something that is bundled and build by default but absolutely not
>>   needed (or even useful) to use sparse.
>> - it hasn't been written for anything else than x86/x86-64 (no 'layout'
>>   for anything else than those architectures.
>
> With your patch applied I get (independent of having Chris' patch
> applied or not):
>
>         Out of 265 tests, 255 passed, 10 failed (10 of them are known to =
fail)

Perfect.
With this, you should be unblocked.

@Chris,
can you apply the patch, please?


Best regards,
-- Luc Van Oostenryck
