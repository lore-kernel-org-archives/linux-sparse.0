From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 22:21:23 +0200
Message-ID: <CAMHZB6EQq-KV=QXF0VK=G5v6wX+SViWwt-JRph03FV+McEBavg@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org> <1508339545.4628.4.camel@poochiereds.net>
 <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com> <1508356857.4628.17.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:54374 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdJRUVZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 16:21:25 -0400
Received: by mail-ua0-f182.google.com with SMTP id n38so4467969uai.11
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 13:21:24 -0700 (PDT)
In-Reply-To: <1508356857.4628.17.camel@poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 10:00 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> On Wed, 2017-10-18 at 21:41 +0200, Luc Van Oostenryck wrote:
>> On Wed, Oct 18, 2017 at 5:12 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>> >
>> >     The fedora packaging tools want to override $CFLAGS when building
>> >     sparse, but that fails on a couple of targets.
>> >
>> >     There are a couple of build targets in the makefile that want to add
>> >     options to $CFLAGS. When we do a build though, we pass $ALL_CFLAGS to
>> >     the compiler, and that ends up without those extra options, if CFLAGS=
>> >     was specified on the command line.
>> >
>> >     I'm not sure if this is a recursive variable expansion bug in make, but
>>
>> I think it's just an effect of CFLAGS being then used as a
>> target-specific variable
>>
>> -- Luc
>
> Ahh ok...so this is probably the correct fix then?

I guess so but I don't really know how and what you're overriding.
Something like:
    make CFLAGS="-O3 -some-others-flags"

To be honest, I don't like much sparse's makefile and I don't see the real need
for BASIC_CFLAGS & ALL_CFLAGS.
On the other hand, I understand very well the need for an explicit mechanism for
adding or changing some CFLAGS's flags

> Thanks for looking!

You're most welcome
-- Luc
