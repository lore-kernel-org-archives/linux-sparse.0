From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 1 Sep 2017 08:00:29 -0400
Message-ID: <CANeU7QmhK=7qJy1JpcQ6tJFYjOgqTtHYBYQHt_ig8P9Jq_AOtA@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com> <20170901070212.7xurrbentxybdhfx@x>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35328 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdIAMAa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Sep 2017 08:00:30 -0400
Received: by mail-yw0-f176.google.com with SMTP id s187so43374ywf.2
        for <linux-sparse@vger.kernel.org>; Fri, 01 Sep 2017 05:00:30 -0700 (PDT)
In-Reply-To: <20170901070212.7xurrbentxybdhfx@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Fri, Sep 1, 2017 at 3:02 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>> First of all. It is not very trivial to teach sparse about the architecture
>> stuff. To my mind, we need to move all the cgcc logic into sparse.
>
> Related to that: while it would mean we couldn't necessarily just rely
> entirely on GCC's definitions for a target platform, I think in an ideal
> world we could have a sparse binary that understood *all* target
> platforms at once, such that you could ask Sparse on x86_64 to "compile"

Yes, that is what I want to have. It is list as one of the project in
project idea document as well. I have  a related question. How do we
test the different architecture handling without actually run sparse
on different platform? I am thinking maybe using gcc cross platform
compiler and compare some macro against the sparse one.

> as though targeting any arbitrary architecture. That would also have the
> major advantage of making it easy to run the Sparse testsuite for
> *every* target architecture without needing compilers for every such
> architecture.

Another way to fix the test suite for now would be let testsuite
specify using cgcc instead of sparse directly, for the test source
that needs it. That will buy us some time. Fixing sparse properly
in the long term obvious would be better.

Chris
