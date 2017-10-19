From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Thu, 19 Oct 2017 21:39:08 +0200
Message-ID: <CAMHZB6G_1NkgucsVN1oiw2na_9BZKCOgqS9yggEL517LPsFFcg@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <CAMHZB6Eg33Hg-ozFcVuBzp4HgHBeFApT2es4Bd0D=LuzLEw0MQ@mail.gmail.com> <CANeU7QmArhzduMQd-bBbCVeKpTAxROUA2OxJ+8K2v+A2Oug8yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:52793 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbdJSTjK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 15:39:10 -0400
Received: by mail-vk0-f68.google.com with SMTP id 126so6049523vkj.9
        for <linux-sparse@vger.kernel.org>; Thu, 19 Oct 2017 12:39:09 -0700 (PDT)
In-Reply-To: <CANeU7QmArhzduMQd-bBbCVeKpTAxROUA2OxJ+8K2v+A2Oug8yg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>

On Thu, Oct 19, 2017 at 6:39 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Oct 18, 2017 at 3:18 PM, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>> No real objections but I have some doubts about all the debug part.
>> I think that people hacking on sparse and who need to debug know
>> what they need and want to debug.
>
> Right, this change is to allow a separate debug binary let say "dbg-sparse",
> to be execute from "sparse" when needed.

My point is: if "when needed" means "when sparse developpers
need to debug something" then I really think all this is not needed
as the dev can very well build the executable he needs, with the
options he needs, use his own workflow, ...

> Take the ptrlist ref count checking for example. I image have
> sparse --check-ptrlist, which will invoke dbg-sparse to do the
> checking. I expect the distro will include dbg-sparse as part
> of the sparse package as well.

Really? Are the distros interested in this sort of things? Is there
a real need for it? Who do you really think will use this?

> The end result is that. The user of sparse, not sparse developers,
> can invoke sparse with those extra verification (at cost of slow
> down sparse) on the custom input source without modify and
> recompile sparse.

Yes *can* ... but will they?
Why isn't there a dbg-gcc, dbg-bash, ... ?

>> For example, the OPT=0 is, IMO, useless as you generally need
>> others flags too. Also, when you debug, you generally need to rerun
>> things several times, so using extra options on the command line is
>> not ideal (a mechanism like local.mk is better suited but local.mk
>> itself is not).
>
> In that case, you can just OPT=0 into local.mk and problem solved?
> Even if you do that, you still need to provide OPT variable for overwrite
> purpose. Append and reset the whole variable is easy.
> Partial modify the content of variable from one to another is harder and
> annoying.
>
> Can you clarify "but local.mk itself is not".

If you have a sort of config file, or anything allowing to adapt things
to your needs, you want at least to have a dot file for it.
But for a project using git, you also want that the file doesn't interfer
with git status but also with git clean (including git clean -x).

>> Also, what's the real need for dbgbuild/ & debug/ ?
>> IMO, it's a big complexification of all the rules with plenty of
>> duplicated things for very few, if any, benefits.
>
> Provide extra verification on user input files. Another candidate
> of those verification can be, the sorting of ptrlist.

> There is function  verify_seq_sorted () verify the list is indeed sorted.
> But that function currently is not turn on in sparse. Presumably
> it is used in the development phase of the ptr list sorting.
> That verification function can be turn on in the debug build for example.

Yes *can* ...
Same questions: who will use this and when? Are extra binaries and
duplicated build rules a good answer for this?

More broadly: what problem do you try to solve with these patches?
What values do these patches bring to sparse?
Does sparse need these patches?

-- Luc
