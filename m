From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse problem with Linux kernel v5.5
Date: Fri, 7 Feb 2020 07:34:57 +0100
Message-ID: <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vUSs11wPwhSDFirf79TH6zS1B4IDPrDmL"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:35728 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGGmm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 01:42:42 -0500
In-Reply-To: <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, Arthur Fabre <afabre@cloudflare.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vUSs11wPwhSDFirf79TH6zS1B4IDPrDmL
Content-Type: multipart/mixed; boundary="acogQGp72xlxDbDrziOdgvlMtlcKKL8ci";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Linux-Sparse <linux-sparse@vger.kernel.org>, Martin KaFai Lau
 <kafai@fb.com>, Arthur Fabre <afabre@cloudflare.com>
Message-ID: <b6d24fd2-e5b8-7010-86b5-c46f65536eef@kleine-koenig.org>
Subject: Re: sparse problem with Linux kernel v5.5
References: <6ee65b69-9ffc-78c6-66b7-3ce586687d74@infradead.org>
 <CAHk-=wgQM29j0BJ-b0fTfwA9nc_fiS09Mi2oO8hX34oRxR6+xA@mail.gmail.com>
 <20200206114619.bfszxgs6jmdgroo6@ltop.local>
 <3b68ba4b-f16a-8404-4e07-27788ebbfce3@infradead.org>
 <20200206200610.7ktqp2yzriw7zurx@ltop.local>
 <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>
In-Reply-To: <CAHk-=whEFcgPW8oD=rGGyDiML_7AaCP0DGdW=WXjvF9zAv6Vrg@mail.gmail.com>

--acogQGp72xlxDbDrziOdgvlMtlcKKL8ci
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 2/7/20 12:47 AM, Linus Torvalds wrote:
> Instead, it could just calculate the nbuckets first, and then do the
> "log2()" on that:
>=20
>         /* Use at least 2 buckets, select_bucket() is undefined
> behavior with 1 bucket */
>         nbuckets =3D max_t(u32, 2, roundup_pow_of_two(num_possible_cpus=
()));
>         smap->bucket_log =3D ilog2(buckets);


Isn't it kind of ineffective to first round to a power of two and then
take the ilog2 of it?

At a first glance I'd say that

	ilog2(roundup_pow_of_two(x)) =3D=3D ilog(x - 1) + 1

for x > 1. (Maybe even for x =3D=3D 1? Didn't care to check, I think it
doesn't matter for the case at hand.)

This RHS might be easier to optimize for the compiler?!

Best regards
Uwe


--acogQGp72xlxDbDrziOdgvlMtlcKKL8ci--

--vUSs11wPwhSDFirf79TH6zS1B4IDPrDmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl49BRUACgkQwfwUeK3K
7AnAHQgAmB3inJoqwIbxVUp5mDThs78UM5ywTO4PrJMdb9duLWEfwMhD1MJTh/5I
3MT2tB271jhFsaB+O2CmHYVcamEKLhCXn9e5fxCm+4iYkx9L6ylTSjN67bg/Xbvw
XEseS0kOm6c9d3WFxYjK1h74RUMN9Kd7NODqty9RCpizDx0yzjqoo6DG4b0ZyAUK
AytscKJdews5O/LZQfTfES063hFl/vVmk28zmrEfFGD5p51cDRAsd8lgvBX5dzv3
rmT35eofvzuXkvdQHYAF+TPfzKvZ7xXMNnwnobLpzNzvgDmQ053AqzbZKy+Z3z2T
g0KdxCZ4uLPlx1SvHIVswopaYMNs+A==
=WWnX
-----END PGP SIGNATURE-----

--vUSs11wPwhSDFirf79TH6zS1B4IDPrDmL--
