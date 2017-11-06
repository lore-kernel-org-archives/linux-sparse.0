From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
Date: Mon, 6 Nov 2017 09:28:46 +0100
Message-ID: <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com> <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:44755 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdKFI2r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 03:28:47 -0500
Received: by mail-io0-f170.google.com with SMTP id m16so14874411iod.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 00:28:47 -0800 (PST)
In-Reply-To: <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 6, 2017 at 9:15 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> Hello Luc,
>
> On 11/05/2017 05:25 PM, Luc Van Oostenryck wrote:
>> @@ -175,10 +168,12 @@ ldflags +=3D $($(@)_LDFLAGS) $(LDFLAGS)
>>  ldlibs  +=3D $($(@)_LDLIBS)  $(LDLIBS)
>>  $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
>>  $(PROGRAMS): % : %.o $(LIBS)
>> -     $(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>> +     @echo "  LD      $@"
>> +     $(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>
> Is it intended that you introduce changed behaviour here? Now you get
> the pretty printed output when building with V=3D1.

It was not the intention as such but, yes, I knew the behaviour changed.
I don't think the new behaviour is a problem, on the contrary, but if it is
a problem it can be changed back.

-- Luc
