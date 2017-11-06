From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
Date: Mon, 6 Nov 2017 09:55:26 +0100
Message-ID: <CAExDi1SXfthzUonmiXCDosWyxi-snqK_+fDVMdJe_yoo_yqR0w@mail.gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com> <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
 <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com> <a91d5505-54a2-c8da-dbb3-af44f0c5f264@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:47984 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdKFIz1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 03:55:27 -0500
Received: by mail-io0-f173.google.com with SMTP id h70so14911057ioi.4
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 00:55:27 -0800 (PST)
In-Reply-To: <a91d5505-54a2-c8da-dbb3-af44f0c5f264@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 6, 2017 at 9:44 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> On 11/06/2017 09:28 AM, Luc Van Oostenryck wrote:
>> On Mon, Nov 6, 2017 at 9:15 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig=
.org> wrote:
>>> Hello Luc,
>>>
>>> On 11/05/2017 05:25 PM, Luc Van Oostenryck wrote:
>>>> @@ -175,10 +168,12 @@ ldflags +=3D $($(@)_LDFLAGS) $(LDFLAGS)
>>>>  ldlibs  +=3D $($(@)_LDLIBS)  $(LDLIBS)
>>>>  $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
>>>>  $(PROGRAMS): % : %.o $(LIBS)
>>>> -     $(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>>>> +     @echo "  LD      $@"
>>>> +     $(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>>>
>>> Is it intended that you introduce changed behaviour here? Now you get
>>> the pretty printed output when building with V=3D1.
>>
>> It was not the intention as such but, yes, I knew the behaviour changed.
>> I don't think the new behaviour is a problem, on the contrary, but if it=
 is
>> a problem it can be changed back.
>
> I don't consider it problematic, the added benefit is that it becomes
> easier to relate a V=3D1 build with a V=3D0 build.

Indeed.

> But IMHO this should not
> be sold as "simpler logic" without any further comment.

Yes. It's not the only patch in this series which commit message
should be improved.

-- Luc
