From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Thu, 31 Aug 2017 20:50:42 -0400
Message-ID: <CANeU7QkTtrhCtsNM=YtZMOiRt7L6Odvbh1xY_SNcT9HySYT2kg@mail.gmail.com>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org> <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35284 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdIAAun (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 20:50:43 -0400
Received: by mail-yw0-f173.google.com with SMTP id s187so5988554ywf.2
        for <linux-sparse@vger.kernel.org>; Thu, 31 Aug 2017 17:50:43 -0700 (PDT)
In-Reply-To: <c0e4a9fe-05ff-1280-f1ee-0c757ba3310b@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Thu, Aug 31, 2017 at 6:43 PM, Ramsay Jones
>>  - move sparse to /usr/lib
>>  - teach cgcc about the move of sparse
>>  - make /usr/bin/sparse call cgcc -no-compile "$@"
>
> Hmm, I don't think that would be a good idea ...
>

Agree.

>
> Anyway, if you were to un-install llvm, sparse-llvm etc., would not
> be built, and the tests would not be run ... ;-)

I think Uwe already confirm using cgcc to invoke sparse will
fix the problem.

In this test, we just need to use cgcc to invoke sparse-llvm.
I have a patch to fix the usage in test-suite in the other email.

Chris
