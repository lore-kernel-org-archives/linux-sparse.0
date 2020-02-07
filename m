From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 12:34:02 +0100
Message-ID: <f41aa7cb-399d-277b-eda8-4173f45d7123@kleine-koenig.org>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
 <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
 <20200207082954.majgsx5trepwb46n@kafai-mbp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LlxRfBtahlRkvYG2CUF6c6z5PJDiKYYN9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:48150 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGLeQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 06:34:16 -0500
In-Reply-To: <20200207082954.majgsx5trepwb46n@kafai-mbp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin KaFai Lau <kafai@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Arthur Fabre <afabre@cloudflare.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LlxRfBtahlRkvYG2CUF6c6z5PJDiKYYN9
Content-Type: multipart/mixed; boundary="GHZ1oiJy43tcZR4VdWFa65UUn8FYa0NlI";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Martin KaFai Lau <kafai@fb.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux-Sparse <linux-sparse@vger.kernel.org>,
 Arthur Fabre <afabre@cloudflare.com>
Message-ID: <f41aa7cb-399d-277b-eda8-4173f45d7123@kleine-koenig.org>
Subject: Re: sparse problem with Linux kernel v5.5
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
 <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
 <20200207082954.majgsx5trepwb46n@kafai-mbp>
In-Reply-To: <20200207082954.majgsx5trepwb46n@kafai-mbp>

--GHZ1oiJy43tcZR4VdWFa65UUn8FYa0NlI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 2/7/20 9:29 AM, Martin KaFai Lau wrote:
> On Fri, Feb 07, 2020 at 07:34:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> On 2/7/20 12:47 AM, Linus Torvalds wrote:
>>> Instead, it could just calculate the nbuckets first, and then do the
>>> "log2()" on that:
>>>
>>>         /* Use at least 2 buckets, select_bucket() is undefined
>>> behavior with 1 bucket */
>>>         nbuckets =3D max_t(u32, 2, roundup_pow_of_two(num_possible_cp=
us()));
>>>         smap->bucket_log =3D ilog2(buckets);
>>
>>
>> Isn't it kind of ineffective to first round to a power of two and then=

>> take the ilog2 of it?
>>
>> At a first glance I'd say that
>>
>> 	ilog2(roundup_pow_of_two(x)) =3D=3D ilog(x - 1) + 1
>>
>> for x > 1. (Maybe even for x =3D=3D 1? Didn't care to check, I think i=
t
>> doesn't matter for the case at hand.)
>>
>> This RHS might be easier to optimize for the compiler?!
> I believe x =3D=3D 1 needs an extra case since ilog2(0) won't work.
>=20
> Since this function (map creation) is not on the fast path,
> I currently opt for Linus's suggestion which its code is more
> self-explanatory.

If you put my suggestion in a macro that is called for example

	ilog2_roundup()

you might have both: easier code and self-explanation.

Best regards
Uwe


--GHZ1oiJy43tcZR4VdWFa65UUn8FYa0NlI--

--LlxRfBtahlRkvYG2CUF6c6z5PJDiKYYN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl49SyoACgkQwfwUeK3K
7AmDlwf6Ar397E1N47GSbIJSiECWJYHxmkpu/s7Qr3K9/Bu3zlkgS7tssaD9bl+T
6jfZ2n+6Qfuyre1orOeMT1DzeZ4IwPpAxzIijElhA+mUFU96KHpOBYTVjuD0FjDx
9aLpy5YfKea1v6KbYO/+MGRjX8oz6mWq7FBPwTIFXjsJ+ZQF4ogsuJpqDL66iqRZ
tNusnIqwjenzJwT2FVIUpCfbND2xfu/V5a5qm2Js1i1TQ3+5HTEbrx84/rEemP7u
NeuXGRyxV5sDCM5lrdbVALto2jz08pZfpLIqQ+qSyn6VefraHsMDvPHSMpr6fw5m
6vrNSRDYA2hgrsCib9tPy2nlOdz4yQ==
=Ic8m
-----END PGP SIGNATURE-----

--LlxRfBtahlRkvYG2CUF6c6z5PJDiKYYN9--
