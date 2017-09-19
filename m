From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
Date: Tue, 19 Sep 2017 16:41:24 +0200
Message-ID: <a8abb58e-e95c-0d76-3b2c-8786a3325c9e@kleine-koenig.org>
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IuL1vgBdCHNG3uSQ71pEnOiGFDf9bQD7F"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51326 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750864AbdISOld (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 Sep 2017 10:41:33 -0400
In-Reply-To: <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IuL1vgBdCHNG3uSQ71pEnOiGFDf9bQD7F
Content-Type: multipart/mixed; boundary="guhqDbOgSW3O2c6kuNvNL0qbOH8dea3pE";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Chris Li <christ.li@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>
Message-ID: <a8abb58e-e95c-0d76-3b2c-8786a3325c9e@kleine-koenig.org>
Subject: Re: [PATCH] cgcc: teach cgcc about GNU/kFreeBSD
References: <20170914200327.15129-1-uwe@kleine-koenig.org>
 <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>
In-Reply-To: <CANeU7QndhpsDA5YzVzPBvoKNrYuHutJeYF9A=+Dyx=sJ_fi+OQ@mail.gmail.com>

--guhqDbOgSW3O2c6kuNvNL0qbOH8dea3pE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Chris,

On 09/19/2017 02:25 PM, Chris Li wrote:
> On Thu, Sep 14, 2017 at 4:03 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koen=
ig.org> wrote:
>> ---
>>  cgcc | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/cgcc b/cgcc
>> index a8d7b4f217fe..0ab54f943578 100755
>> --- a/cgcc
>> +++ b/cgcc
>> @@ -235,6 +235,9 @@ sub add_specs {
>>      } elsif ($spec eq 'linux') {
>>         return &add_specs ('unix') .
>>             ' -D__linux__=3D1 -D__linux=3D1 -Dlinux=3Dlinux';
>> +    } elsif ($spec eq 'gnu/kfreebsd') {
>> +       return &add_specs ('unix') .
>> +           ' -D__FreeBSD_kernel__=3D1'
>=20
> Catching up my back logs. I just find out that this patch
> is missing a SOB. Send you send one to the mailing list?

I didn't add a Sob on purpose. It is not specified what this means and I
refuse follow an unformalized formalism. Without a respective document
in sparse I really doubt it has any significance anyhow.

Best regards
Uwe


--guhqDbOgSW3O2c6kuNvNL0qbOH8dea3pE--

--IuL1vgBdCHNG3uSQ71pEnOiGFDf9bQD7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlnBLJgACgkQwfwUeK3K
7AlKEQgAiUZAh7sN/SEpeZjRj6N5+t8JhOfb4H3QSz9gJDMvPMZreItcFR3rPuIW
z2v9EYBQTe9koBmT/AFqGko0LUHSF6enPZfXHoZFT2yNO+wtIc5SXHq/tBUzXXaU
cbsC/FIvXrIk2eunCixXovubPDnyN0NdYmTzSg2nml/Y1I/ngb7vqd+bTlMeJ+zi
GTP/km5tNQEUtNlTRs8U1ROFcB1ojPtTlKWyyNxo4xAfiPVh3oV2d+mA92ohOff5
ZzGDEUjNPGr/z0z4WVh6aMnX5qcnqlfC4JWP+SfFNkXCNkeTls8tESJKTQUGFBgw
AGiJxqqyGHN2HVN7Z0g76kRQqP9nuw==
=urhh
-----END PGP SIGNATURE-----

--IuL1vgBdCHNG3uSQ71pEnOiGFDf9bQD7F--
