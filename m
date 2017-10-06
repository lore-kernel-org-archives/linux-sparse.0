From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/6] build: various updates
Date: Fri, 6 Oct 2017 14:30:31 -0700
Message-ID: <CANeU7Q=v5rXzxdtm7_ppW7q=G6qRiymdTQKRzQimXijCsgpR9Q@mail.gmail.com>
References: <20171004132605.24734-1-uwe@kleine-koenig.org> <CANeU7QnYphoaeq1Vi6XdV+8fk0hoC_hdMVu6vOXiMKR93LFVBA@mail.gmail.com>
 <e3d57acc-e699-f51d-6687-e1535db4cd46@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:53239 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbdJFVad (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Oct 2017 17:30:33 -0400
Received: by mail-qt0-f180.google.com with SMTP id o52so33905528qtc.9
        for <linux-sparse@vger.kernel.org>; Fri, 06 Oct 2017 14:30:33 -0700 (PDT)
In-Reply-To: <e3d57acc-e699-f51d-6687-e1535db4cd46@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Oct 6, 2017 at 1:10 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> Note I don't feel strong for most of my changes. There is little user
> visible change intended by them, just making the build system more
> standard by using expected variable names, which might also be subjective=
?!

Exactly. I also CC sparse mailing list.

>
>> Can you give the debug-target-v3 a review?
>
> I don't like
>         Makefile: Adding OPT variable for optmize level

Thanks for the review.

>
> I'd expect a Makefile to do something like that:
>
>         CFLAGS ?=3D -O2 ...
>
> such that I can overrule it by doing
>
>         make CFLAGS=3D"-O0 -g"

I can't see how that will work. CFLAGS has a lot of other options in it.
" -finline-functions -fno-strict-aliasing" just to name a few.
Overwrite the CFLAG
will drop those options as well, which is not desirable.

That is why the OPT variable was needed. Overwrite OPT will just change
the "-O2" an nothing else. Currently over write CFLAGS does not have the sa=
me
effect.

In general, overwrite CFLAGS in command line is a bad idea. Most of
the open source project I saw will not able to handle that properly.

>
> Commit
>
>         Makefile: introduce minimal target
>
> has a typo, s/minial/minimal/. And I wonder why it removes debug from

Thanks for catching that. I will update the V4 soon.

> the dependencies of check. This was added in "Makefile: release and
> debug target" needlessly?

Because this change make "all" depend on "debug" as well.
And "check" depend on "all". That makes "check" implicit depend on
"debug" already.

Before this change, "all" target actually did not build all possible target=
.
That is why I want to change "all" explicit build "release" and "debug" at =
the
same time.


>
> Other than that I don't see the motivation for this series and I'd
> always compile everything and wonder if
>
>         make CFLAGS=3D"-DSPARSE_DEBUG"
>
> would be good enough.

The motivation is speed. For most user that use sparse to run
the kernel checking. We want sparse run as fast as possible.
However, we also want a debug mode of sparse can run more
validation and error diagnostic at the cost of speed.

One patch series I want to use this debug mode is the ptrlist
reference count patch. The ptrlist reference count has running
over head. However, it can catch the "nest loop modify" bug.
If that code path was triggered, it means a possible list
iteration corruption.

I kind of want sparse can have option  that run the debug
version at run time request. In other words, distributios
will ship both the release and debug version of sparse.
The release version of sparse will invoke the debug
options if there is debug option is specified in command line.

Chris
