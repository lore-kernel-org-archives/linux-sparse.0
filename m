From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Tue, 19 Sep 2017 16:11:21 -0400
Message-ID: <CANeU7Qm5F7-OJz9URvxXwu7Uwy4JV-pP7C5k1dGkGxkOxxjN9g@mail.gmail.com>
References: <20170914184540.26650-1-uwe@kleine-koenig.org> <CANeU7QnQ-fFvvUfqjCjXfUT5Dn-+vEY-u0KxnNPML3G3iuNBZw@mail.gmail.com>
 <8d555c9d-6eb0-85a2-5f78-999aaf0b12e7@kleine-koenig.org> <CANeU7Q=+pM5=Lezf1Wo750ULaKGvLTOMCvTMp6zvPdiKzu_S3w@mail.gmail.com>
 <20170919181907.aa2pk5o2exa5e63c@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:43211 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdISULX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 16:11:23 -0400
Received: by mail-yw0-f172.google.com with SMTP id s62so549548ywg.0
        for <linux-sparse@vger.kernel.org>; Tue, 19 Sep 2017 13:11:23 -0700 (PDT)
In-Reply-To: <20170919181907.aa2pk5o2exa5e63c@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 19, 2017 at 2:19 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>              CC       pre-process.o
>              CC       symbol.o
>              CC       lib.o
>         lib.c:46:10: fatal error: version.h: No such file or directory
>          #include "version.h"
>                   ^~~~~~~~~~~
>         compilation terminated.
>         Makefile:212: recipe for target 'lib.o' failed
>         make: *** [lib.o] Error 1
>
> I'd say this is not correct behaviour. The problem is that as is done now=
,
> version.h is created while make parses the Makefile and doesn't really
> know about the dependencies (yet). As a consequence make doesn't notice
> that version.h is missing while compiling lib.c.

No, that is not what is happening. What is happen is that, your "make clean=
 all"
is incorrect command in the sense that, "clean" and "all" does not have
dependency and order between them. So it is just a race condition which get
to run first in the parallel build environment.

In your case, there is only one job. Clean runs first.

But if there is more than one job, even you specify the
lib.o depend on version.h. It is still not safe.
It can happen in the order of:

1) job1 "create version.h",
2) job2 "clean" remove version.h
3) job1 compile lib.o -> missing version.h

The root of the evil is that, your "make clean all" does not make
sense. It does not specify order between "clean" vs "all".
make can invoke it whichever order it see fit.
You get it working it is just because you are on the lucky path.

> So here are needlessly two things mixed: parsing the Makefile and
> generating version.h. It all gets easier if Makefile is parsed first
> without caring about version.h as something special and then treat the
> header just like every other target.

You should not mix clean with other target. Period.
Try to support that create a lot of complexity and corner cases.

>> Plus in the make check case, it will only look at the version.h,
>> it will not regenerate it if data is the same.
>
> That's shared with my approach.

it is slightly different in the sense that, the checking is all done
in GNU make function instead of invoking external shell. Granted, we
can use $(file ) function to remove the $(sell cat ) part.

It is slightly harder to do that inside the rule section.

Your patch will always update the version.h and force it to
run the command section. Which has a few shell commands.

>
> I cannot follow here. lib.c depends on version.h and always when you
> update version.h you want to recompile lib.c, don't you? Checking

Yes, of course.

> timestamps is what make is good at (and there for), so I don't
> understand your concern. And conditionally updating a target to keep the
> old file if no update is needed is a usual approach.

As I said, you need to use order only prerequisites to do it properly.
Otherwise it is kind of conflicting view version.h is updated or not.
From the rules point of view, the version.h is updated, the command
section gets executed. From the time stamp point of view, it is not.

>
> Another "problem" with the current approach is that version.h is
> generated synchronously and so it is not parallelized as it should.
> (IMHO doesn't matter much because build time is short enough, but IMHO
> still a good hint that the construct is broken.)

That is not a problem at all. I consider version.h at the bottom of
the dependency chain, so there is no paralleled when every body
depend on it.

The most common case, the version.h does not need to get
updated.

>
> Do you still think that after the failure reported above?

I think that failure is "user error". Should not try to mix "clean"
with other targets. Nothing good can come out of it.

>> Then there is another thing I consider slightly unclean.
>> The check rules will optionally update another target "version.h" withou=
t
>> specificity in its rules.
>
> I don't understand that.
>
>> We can use order only rules for check target. The whole thing seems
>> gets more complicated than it needs to.

The conflicting view is version.h gets updated or not.
I think the cleaner way to do it is some thing like:

check_version:
             <update version.h only if needed>

version.h: | check_version

Because I don't plan to support mixing clean vs
other targets. I think using $(MAKECMDGOALS)
is simpler and faster, no need to execute external
shells for the common case.

Chris
