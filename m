From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: make PREFIX overwritable on the commandline
Date: Tue, 3 Oct 2017 00:38:05 -0400
Message-ID: <CANeU7Q=KhrFivJ5DriRDX_R102uvN=4UteMbSwsxGHvaeatPLA@mail.gmail.com>
References: <20170922212524.8095-1-uwe@kleine-koenig.org> <CANeU7QnCU7qfFzRGMC-v=Q5onaJgSUvAqiUWJT0FaKHc_Qp2RQ@mail.gmail.com>
 <20170923183153.i4mt4zlsniv22jbv@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:54361 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdJCEiG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Oct 2017 00:38:06 -0400
Received: by mail-qt0-f177.google.com with SMTP id i13so10878579qtc.11
        for <linux-sparse@vger.kernel.org>; Mon, 02 Oct 2017 21:38:06 -0700 (PDT)
In-Reply-To: <20170923183153.i4mt4zlsniv22jbv@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Sep 23, 2017 at 2:31 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>> Are you sure you need this patch to use "make install PREFIX=3D/usr" ?
>
> Oh, you're right. I pass PREFIX via the environment. But as there are
> already other things I pass on the command line I can also pass PREFIX
> there. I still consider ?=3D as the right thing to do there, but it's not
> important any more. If you still consider the patch fine, I can update
> the commit log accordingly.

Sorry for the delay. I am catching up with the patches.
I don't mind having the patch if you want to pass PREFIX from the
environment.

Please update the comments.

Thanks

Chris
