From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Tue, 19 Sep 2017 19:33:47 +0200
Message-ID: <b580c0f7-716d-17b0-7e2b-410530c4a0cf@kleine-koenig.org>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
 <a8abb58e-e95c-0d76-3b2c-8786a3325c9e@kleine-koenig.org>
 <CANeU7Q=S6OENzU_ogLGY0uPUT5E6SvGK1KLmKc37+7CKXV_ogw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Vi1fHsMpuTlUjSWWbAQ7BHLVF2e6sDUuw"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51376 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751585AbdISRdw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 13:33:52 -0400
In-Reply-To: <CANeU7Q=S6OENzU_ogLGY0uPUT5E6SvGK1KLmKc37+7CKXV_ogw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vi1fHsMpuTlUjSWWbAQ7BHLVF2e6sDUuw
Content-Type: multipart/mixed; boundary="WEV2LtVlqw3nlmX2VG7MveswlvQo94gP1";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>
Message-ID: <b580c0f7-716d-17b0-7e2b-410530c4a0cf@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
 <a8abb58e-e95c-0d76-3b2c-8786a3325c9e@kleine-koenig.org>
 <CANeU7Q=S6OENzU_ogLGY0uPUT5E6SvGK1KLmKc37+7CKXV_ogw@mail.gmail.com>
In-Reply-To: <CANeU7Q=S6OENzU_ogLGY0uPUT5E6SvGK1KLmKc37+7CKXV_ogw@mail.gmail.com>

--WEV2LtVlqw3nlmX2VG7MveswlvQo94gP1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 05:15 PM, Chris Li wrote:
> On Tue, Sep 19, 2017 at 10:41 AM, Uwe Kleine-K=C3=B6nig
> <uwe@kleine-koenig.org> wrote:
>> I didn't add a Sob on purpose. It is not specified what this means and=
 I
>> refuse follow an unformalized formalism. Without a respective document=

>> in sparse I really doubt it has any significance anyhow.
>=20
> It did in sparse Documentation/submitting-patches.md.

ah, I missed that. (I wonder if it is sensible to just link to the
respective kernel stuff instead of copying that verbatim into sparse,
but I don't really care.)

I can resend accordingly

Uwe


--WEV2LtVlqw3nlmX2VG7MveswlvQo94gP1--

--Vi1fHsMpuTlUjSWWbAQ7BHLVF2e6sDUuw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnBVPsACgkQwfwUeK3K
7AnUiAf7BnBeJtRnx+5+JmwLC4a3FPAd+DzAFlkJ5SR9F9RW703G27DXGjqS868B
vKIgoIPbn6PtnZ7oGaqDqPu+Hmd8nsBHUww2Z9XeC7HdoUUE0AeBMwaj9jsFN+2L
xcrFNG2de62vb6Yf+CmC+MrEOvkUyEw9D1lefka3X+kuJ+JZgaYtqAUyGTrekKW2
2l0YOVm3nnJ/icg3wdHh0RLMJ3MVo/3j+pM4RZ9fnsulcX4RozelJToKMT1gDfpA
vIGfliu5g75eqLvD89yFQjKmjmW/SM/6yFQWB0sVQh8G8cLyujuZtxiRG0yoFDXx
/efIPskr5fHuKM3EVrQFRT0KjyxYEQ==
=w5Hx
-----END PGP SIGNATURE-----

--Vi1fHsMpuTlUjSWWbAQ7BHLVF2e6sDUuw--
