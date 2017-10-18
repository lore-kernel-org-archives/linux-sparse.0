From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of CFLAGS
Date: Wed, 18 Oct 2017 14:54:55 -0700
Message-ID: <CANeU7Q=GWqR=W0tRWZxewH7F93mfK6hDLiC19RWNFOHxmzbWHA@mail.gmail.com>
References: <20171018150727.26821-1-jlayton@kernel.org> <1508339545.4628.4.camel@poochiereds.net>
 <CAMHZB6FegDPHeNw4tKr59CDz-QXv5NvC-r-+NPto3p7O4BcVmA@mail.gmail.com>
 <1508356857.4628.17.camel@poochiereds.net> <CAMHZB6EQq-KV=QXF0VK=G5v6wX+SViWwt-JRph03FV+McEBavg@mail.gmail.com>
 <1508360895.4628.45.camel@poochiereds.net> <CAMHZB6HSkswB1Kar-JDYZXu5=NvQ9gQgkdEL_zVNBtzgs+teqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45906 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdJRVy4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Oct 2017 17:54:56 -0400
Received: by mail-yw0-f195.google.com with SMTP id j4so1864153ywb.2
        for <linux-sparse@vger.kernel.org>; Wed, 18 Oct 2017 14:54:56 -0700 (PDT)
In-Reply-To: <CAMHZB6HSkswB1Kar-JDYZXu5=NvQ9gQgkdEL_zVNBtzgs+teqA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Layton <jlayton@poochiereds.net>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Oct 18, 2017 at 2:25 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>> Overriding is probably the wrong word. We just want to pass in a
>> baseline set of CFLAGS and then make can add that on to whatever it likes.
>
> Yes, very usual.

If you only want to pass some CFLAGS base line. Maybe some thing like:
make CFLAGS_BASE=xxxx will serve the purpose?

>
>> IIUC, the CFLAGS variable is sort of an autotools-ism. We could call it
>> something else, but that's sort of the bog-standard way that this is
>> done.
>
> I tend to avoid autotool but CFLAGS and friends are used with (g)make
> builtin rules, so yes, very standard (and probably predate autotool).

Using make file builtin rules is discouraged. So there way I see it, there is
no stander CFLAGS usage rule. e.g. Was CFLAGS the variable to pass
in command line or CFLAGS_BASE can serve the same role as well?

Sparse will not use autotool and automake. They make things a lot more
complicate. Directly using GNU make is fine and over all simpler.
If it gets more complicate, I prefer some thing like the Linux kernel config
file.

>
>> FWIW, the weird bit here is that the ALL_CFLAGS variable gets reexpanded
>> like you'd expect when you don't pass in CFLAGS on the command line.
>> It's only when we do that this thing seems to break.
>>
>> That seems sort of unexpected, IMO, but since we're passing ALL_CFLAGS
>> to gcc, it makes sense to add these extra options on there in the
>> makefile.


In my mind, ALL_CFLAGS is there to make normal CFLAGS and BASE_CFLAGS
two separate group. So variable is never directly append to ALL_CFLAGS.
So when ALL_CFLAGS expand, it will show up as:

<normal cflags expanded here> <basic cflags expand here>

Some times the options need to have order in them. In those case, having
the grouping help establish the order.

Because we are not using autotools cmake here. How to use the CFLAGS
just need to be internal consistent with the project.

Chris
