From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 23:25:45 +0200
Message-ID: <CAMHZB6HSkswB1Kar-JDYZXu5=NvQ9gQgkdEL_zVNBtzgs+teqA@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org> <1508339545.4628.4.camel@poochiereds.net>
 <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com>
 <1508356857.4628.17.camel@poochiereds.net> <CAMHZB6EQq-KV=QXF0VK=G5v6wX+SViWwt-JRph03FV+McEBavg@mail.gmail.com>
 <1508360895.4628.45.camel@poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:49658 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdJRVZq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 17:25:46 -0400
Received: by mail-vk0-f65.google.com with SMTP id r82so4193688vke.6
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 14:25:46 -0700 (PDT)
In-Reply-To: <1508360895.4628.45.camel@poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 11:08 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> On Wed, 2017-10-18 at 22:21 +0200, Luc Van Oostenryck wrote:
>> On Wed, Oct 18, 2017 at 10:00 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
>> >
>> > Ahh ok...so this is probably the correct fix then?
>>
>> I guess so but I don't really know how and what you're overriding.
>> Something like:
>>     make CFLAGS="-O3 -some-others-flags"
>>
>
> Yes, quite similar to that.

Yes, I saw in your other email.

> Overriding is probably the wrong word. We just want to pass in a
> baseline set of CFLAGS and then make can add that on to whatever it likes.

Yes, very usual.

> IIUC, the CFLAGS variable is sort of an autotools-ism. We could call it
> something else, but that's sort of the bog-standard way that this is
> done.

I tend to avoid autotool but CFLAGS and friends are used with (g)make
builtin rules, so yes, very standard (and probably predate autotool).

> FWIW, the weird bit here is that the ALL_CFLAGS variable gets reexpanded
> like you'd expect when you don't pass in CFLAGS on the command line.
> It's only when we do that this thing seems to break.
>
> That seems sort of unexpected, IMO, but since we're passing ALL_CFLAGS
> to gcc, it makes sense to add these extra options on there in the
> makefile.
>
>
>> To be honest, I don't like much sparse's makefile and I don't see the real need
>> for BASIC_CFLAGS & ALL_CFLAGS.
>> On the other hand, I understand very well the need for an explicit mechanism for
>> adding or changing some CFLAGS's flags
>>
>
> Yeah, even though it's a pretty simple program, using something like
> autotools or cmake would give all of this the benefit of better
> familiarity for packaging. That also tends to be lower maintenance over
> the long haul of a project in my experience.

It's really not the way I would go but, yes, some cleanups and standardization
would be very welcome.

-- Luc
