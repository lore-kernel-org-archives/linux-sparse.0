From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] debug build of sparse v4
Date: Sun, 5 Nov 2017 15:24:57 +0800
Message-ID: <CANeU7Q=D2GVN+XzQa=y=zsN8pyQ+CAPJeAmAp_UZ9JC=7AY2Gw@mail.gmail.com>
References: <CANeU7QmUzmvhTVpiKmET76qgoZf60yxM3_URAt-auiR12trh4A@mail.gmail.com>
 <CAMHZB6Eg33Hg-ozFcVuBzp4HgHBeFApT2es4Bd0D=LuzLEw0MQ@mail.gmail.com>
 <CANeU7QmArhzduMQd-bBbCVeKpTAxROUA2OxJ+8K2v+A2Oug8yg@mail.gmail.com> <CAMHZB6G_1NkgucsVN1oiw2na_9BZKCOgqS9yggEL517LPsFFcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:52788 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdKEHY7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 02:24:59 -0500
Received: by mail-yw0-f170.google.com with SMTP id w2so5551438ywa.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 00:24:59 -0700 (PDT)
In-Reply-To: <CAMHZB6G_1NkgucsVN1oiw2na_9BZKCOgqS9yggEL517LPsFFcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>

On Fri, Oct 20, 2017 at 3:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> My point is: if "when needed" means "when sparse developpers
> need to debug something" then I really think all this is not needed
> as the dev can very well build the executable he needs, with the
> options he needs, use his own workflow, ...
>
>> Take the ptrlist ref count checking for example. I image have
>> sparse --check-ptrlist, which will invoke dbg-sparse to do the
>> checking. I expect the distro will include dbg-sparse as part
>> of the sparse package as well.
>
> Really? Are the distros interested in this sort of things? Is there
> a real need for it? Who do you really think will use this?

To get back on this. I think we user report sparse bugs.
We can ask them to run debug version of sparse to report
or catch more bugs.

For example. The default version of sparse does not have
the ptrlist nest modify detect feature. The debug version of
sparse has. It is actually hard to ask user to check out a git
version of sparse, build it with debug options, then run the
test again.

With debug version of sparse shipped as part of sparse, this
can be simplified.

>
>> The end result is that. The user of sparse, not sparse developers,
>> can invoke sparse with those extra verification (at cost of slow
>> down sparse) on the custom input source without modify and
>> recompile sparse.
>
> Yes *can* ... but will they?
> Why isn't there a dbg-gcc, dbg-bash, ... ?

If we install debug version and invoke them properly, I don't see
why distro will not take it.

Debug version of clang exist. It just not everybody use it.
I don't see a need to for debug version of bash. Because sparse
doing optimization and transformation etc. It is very delicate.
As long as the debug version does provide some value, I think
it is fine to include them as part of the binary.

>
> If you have a sort of config file, or anything allowing to adapt things
> to your needs, you want at least to have a dot file for it.
> But for a project using git, you also want that the file doesn't interfer
> with git status but also with git clean (including git clean -x).

I think that is why local.mk was in .gitignore. For my usage
case, there is clearly need that I want some per host
config to plug into the Makefile.


> Yes *can* ...
> Same questions: who will use this and when? Are extra binaries and
> duplicated build rules a good answer for this?

Again, it is for the user who report sparse bugs.

> More broadly: what problem do you try to solve with these patches?

I want to include the ptrlist nest  modify detect patch into sparse.

> What values do these patches bring to sparse?

See above.

> Does sparse need these patches?

I think so.


Chris
