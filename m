From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Tue, 12 Sep 2017 01:59:47 -0400
Message-ID: <CANeU7Q=7VAN26GvJSf7ApTt6Y5ArQOnEJ7kASes9Suo67t_Rvg@mail.gmail.com>
References: <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
 <20170901070212.7xurrbentxybdhfx@x> <CAMHZB6En=BeF_6NBfEDr26hdP5rmTt+A4p5Y3Cn=nEzZDaTz9w@mail.gmail.com>
 <715b7059-4ff0-0982-ff92-56c13c4160e7@kleine-koenig.org> <CAMHZB6GHoA6v_RPtKF3WBbX0DPB5pqfz9wLf1iP8MWfUVdbteQ@mail.gmail.com>
 <20170906144450.tsa7dlmpeb4uz2pc@taurus.defre.kleine-koenig.org>
 <CANeU7QmOA4cC55zgiQ-ArySWQWzC-mMQAGF750PYRB=K-_ZPMQ@mail.gmail.com> <20170906153603.v2m3e6mqg62htwmg@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36699 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdILF7t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 01:59:49 -0400
Received: by mail-yw0-f177.google.com with SMTP id v72so23999336ywa.3
        for <linux-sparse@vger.kernel.org>; Mon, 11 Sep 2017 22:59:48 -0700 (PDT)
In-Reply-To: <20170906153603.v2m3e6mqg62htwmg@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>

On Wed, Sep 6, 2017 at 11:36 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
> There is https://dsa.debian.org/doc/guest-account/ which would give you
> the possibility to access some Debian machines. Other than that I intend

Sorry for the delay. Thanks for the pointer of the guest account.

> to upload 0.5.1 to Debian soon and then can provide you links to build
> failures in the build server farm :-) And if you have a patch, I can
> volunteer to make the test monkey for you.

BTW, if I want to get a PPC64 machine for Linux testing purpose, is the
used apple G5 a good place to start?

Chris
