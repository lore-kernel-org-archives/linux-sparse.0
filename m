From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Tue, 12 Sep 2017 02:36:09 -0400
Message-ID: <CANeU7QmRmP-7_L7zNF63E6vw9rr3bRDnTsrsj7r8SFUJWmMwTA@mail.gmail.com>
References: <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x> <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org> <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
 <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
 <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com>
 <20170906153603.v2m3e6mqg62htwmg@taurus.defre.kleine-koenig.org>
 <CANeU7Q=7VAN26GvJSf7ApTt6Y5ArQOnEJ7kASes9Suo67t_Rvg@mail.gmail.com> <20170912062710.rd6jzjx3535l3agv@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33248 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdILGgL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 02:36:11 -0400
Received: by mail-yw0-f169.google.com with SMTP id s62so26279231ywg.0
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 23:36:11 -0700 (PDT)
In-Reply-To: <20170912062710.rd6jzjx3535l3agv@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Tue, Sep 12, 2017 at 2:27 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>> BTW, if I want to get a PPC64 machine for Linux testing purpose, is the
>> used apple G5 a good place to start?
>
> Honestly I don't know. https://wiki.debian.org/ppc64el tells
>
>         Debian/ppc64el requires, at minimum, a POWER8 processor machine.
>         Although Debian was initially bootstrapped on a POWER7 set of
>         servers. this class of server is not supported anymore, and you
>         are not able to run Debian/ppc64el on a POWER7 processor without
>         hitting an illegal instruction fault.
>
> Hm https://en.wikipedia.org/wiki/POWER8 tells:
>
>         Systems based on POWER8 became available from IBM in June
>         2014. Systems and POWER8 processor designs made by other
>         OpenPOWER members was available in early 2015.
>
> So I think this rules out a G5.

Thanks for the tip. I am glad I asked before I pull the trigger.

> https://wiki.debian.org/ppc64el/Installation mentions you can run this
> under qemu however.

Good idea. I will give that a try too.

Chris
