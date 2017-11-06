From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
Date: Mon, 6 Nov 2017 09:44:17 +0100
Message-ID: <a91d5505-54a2-c8da-dbb3-af44f0c5f264@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
 <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
 <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3TT3rq6M9rm5i5gjcO1eQrQj0H6gFsWMm"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:60816 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdKFIoW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 03:44:22 -0500
In-Reply-To: <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3TT3rq6M9rm5i5gjcO1eQrQj0H6gFsWMm
Content-Type: multipart/mixed; boundary="TNk78H4qh091DvIrPrcJgHXFQH8HnFPOD";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>
Message-ID: <a91d5505-54a2-c8da-dbb3-af44f0c5f264@kleine-koenig.org>
Subject: Re: [PATCH 33/36] build: simpler logic for quiet commands
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
 <7db4d636-d988-7bb3-e440-0a624317e8b9@kleine-koenig.org>
 <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>
In-Reply-To: <CAExDi1TL3oXH2MZBYRJkzLcGB9O_cSk6u_0UD_JJdchTMvsxAA@mail.gmail.com>

--TNk78H4qh091DvIrPrcJgHXFQH8HnFPOD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 09:28 AM, Luc Van Oostenryck wrote:
> On Mon, Nov 6, 2017 at 9:15 AM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koeni=
g.org> wrote:
>> Hello Luc,
>>
>> On 11/05/2017 05:25 PM, Luc Van Oostenryck wrote:
>>> @@ -175,10 +168,12 @@ ldflags +=3D $($(@)_LDFLAGS) $(LDFLAGS)
>>>  ldlibs  +=3D $($(@)_LDLIBS)  $(LDLIBS)
>>>  $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
>>>  $(PROGRAMS): % : %.o $(LIBS)
>>> -     $(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>>> +     @echo "  LD      $@"
>>> +     $(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@
>>
>> Is it intended that you introduce changed behaviour here? Now you get
>> the pretty printed output when building with V=3D1.
>=20
> It was not the intention as such but, yes, I knew the behaviour changed=
=2E
> I don't think the new behaviour is a problem, on the contrary, but if i=
t is
> a problem it can be changed back.

I don't consider it problematic, the added benefit is that it becomes
easier to relate a V=3D1 build with a V=3D0 build. But IMHO this should n=
ot
be sold as "simpler logic" without any further comment.

Best regards
Uwe


--TNk78H4qh091DvIrPrcJgHXFQH8HnFPOD--

--3TT3rq6M9rm5i5gjcO1eQrQj0H6gFsWMm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAloAIOEACgkQwfwUeK3K
7AkqMwf/bEr5NXfmRC12ROd81HT2cvTihXINcv0Ju+j1AKmenEAQzbi3c2wilqWp
Jh9ITNdx7J+kgH+mDjCH5iaNvPUhnjBkqSfozojM0GZyuXPr8t9WuME5HlcGaZH2
AwNWsK6bihrlBnWHRNB+sccMRZcmuG9NFBWHSSUBGErFNOmdXiOuW2nItzLbtGVE
MuAHZhsQQChJWjGTJ6vh80DRINoeilLaMfpuWDFW55kKcNhYDQPtfLbLY8OAx8a1
dVfKDTlmC1SFfX2eTP81vGYgAIFsuurOHue6XWpnES1pOwujdMR38KuaRm/zwvNw
5IJ8z2SF0qTe730iVuxCjzSLIvMtzA==
=alXD
-----END PGP SIGNATURE-----

--3TT3rq6M9rm5i5gjcO1eQrQj0H6gFsWMm--
