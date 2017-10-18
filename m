From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 00:18:58 +0200
Message-ID: <CAMHZB6Eg33Hg-ozFcVuBzp4HgHBeFApT2es4Bd0D=LuzLEw0MQ@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:50275 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdJRWTA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 18:19:00 -0400
Received: by mail-ua0-f195.google.com with SMTP id v27so4665755uav.7
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 15:18:59 -0700 (PDT)
In-Reply-To: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>

On Wed, Oct 18, 2017 at 11:26 PM, Christopher Li <sparse@chrisli.org> wrote:
> Hi,
>
> This is the V4 version of the debug build change.
>
> https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=debug-target-v4
>
> This change allow sparse to build debug version of sparse
> along side of the release version. The debug build of sparse
> can be used by patches like ptrlist ref count to check the nest
> loop modify usage. The debug build can add other verification feature
> that might slow down sparse.
>
> I plan to merge that to master. If there is other objections, it is
> a good time to raise it now.

No real objections but I have some doubts about all the debug part.
I think that people hacking on sparse and who need to debug know
what they need and want to debug.
For example, the OPT=0 is, IMO, useless as you generally need
others flags too. Also, when you debug, you generally need to rerun
things several times, so using extra options on the command line is
not ideal (a mechanism like local.mk is better suited but local.mk
itself is not).

Also, what's the real need for dbgbuild/ & debug/ ?
IMO, it's a big complexification of all the rules with plenty of
duplicated things for very few, if any, benefits.

-- Luc
