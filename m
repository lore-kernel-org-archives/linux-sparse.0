From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 09:39:37 -0700
Message-ID: <CANeU7QmArhzduMQd-bBbCVeKpTAxROUA2OxJ+8K2v+A2Oug8yg@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <CAMHZB6Eg33Hg-ozFcVuBzp4HgHBeFApT2es4Bd0D=LuzLEw0MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:56022 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdJSQji (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 12:39:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id t11so4025212ywg.12
        for <linux-sparse@vger.kernel.org>; Thu, 19 Oct 2017 09:39:38 -0700 (PDT)
In-Reply-To: <CAMHZB6Eg33Hg-ozFcVuBzp4HgHBeFApT2es4Bd0D=LuzLEw0MQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>

On Wed, Oct 18, 2017 at 3:18 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> No real objections but I have some doubts about all the debug part.
> I think that people hacking on sparse and who need to debug know
> what they need and want to debug.

Right, this change is to allow a separate debug binary let say "dbg-sparse",
to be execute from "sparse" when needed.

Take the ptrlist ref count checking for example. I image have
sparse --check-ptrlist, which will invoke dbg-sparse to do the
checking. I expect the distro will include dbg-sparse as part
of the sparse package as well.

The end result is that. The user of sparse, not sparse developers,
can invoke sparse with those extra verification (at cost of slow
down sparse) on the custom input source without modify and
recompile sparse.

> For example, the OPT=0 is, IMO, useless as you generally need
> others flags too. Also, when you debug, you generally need to rerun
> things several times, so using extra options on the command line is
> not ideal (a mechanism like local.mk is better suited but local.mk
> itself is not).

In that case, you can just OPT=0 into local.mk and problem solved?
Even if you do that, you still need to provide OPT variable for overwrite
purpose. Append and reset the whole variable is easy.
Partial modify the content of variable from one to another is harder and
annoying.

Can you clarify "but local.mk itself is not".

> Also, what's the real need for dbgbuild/ & debug/ ?
> IMO, it's a big complexification of all the rules with plenty of
> duplicated things for very few, if any, benefits.

Provide extra verification on user input files. Another candidate
of those verification can be, the sorting of ptrlist.
There is function  verify_seq_sorted () verify the list is indeed sorted.
But that function currently is not turn on in sparse. Presumably
it is used in the development phase of the ptr list sorting.
That verification function can be turn on in the debug build for example.

Chris
