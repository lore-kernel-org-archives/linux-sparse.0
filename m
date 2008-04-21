From: Josh Triplett <josh@kernel.org>
Subject: Re: four sparse patches
Date: Mon, 21 Apr 2008 12:12:30 -0700
Message-ID: <480CE71E.5050608@kernel.org>
References: <9356e4460803300752y6c1416bfh680b68fd3c42c19a@mail.gmail.com>	 <47F07F78.5030405@kernel.org>	 <9356e4460803311222v4b09df5fk76268fb5c7e71971@mail.gmail.com>	 <32e600e90803311236g4caf05c9t8dd3a3ab03dcd5bc@mail.gmail.com>	 <47F750CA.1090307@kernel.org> <32e600e90804120357k5923dd47xfcb253bf1c390225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13257A6340ABC52EB09DAB01"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:55939 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758412AbYDUTMQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 15:12:16 -0400
In-Reply-To: <32e600e90804120357k5923dd47xfcb253bf1c390225@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Geoff Johnstone <geoffsheep.johnstonefrog@googlemail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13257A6340ABC52EB09DAB01
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Geoff Johnstone wrote:
>>  Regarding Wmix-decl-code.diff, I agree that that warning definitely
>>  needs an option controlling it. but GCC already has that option and
>>  calls it "-Wdeclaration-after-statement", so matching GCC's name
>>  seems potentially useful. (However, I can imagine corner cases
>>  where it might prove problematic, such as wanting to pass that
>>  option to GCC and not Sparse or vice versa.) Also, I agree that the
>>  default should depend on the C standard in use, and I see no
>>  compatibility reason why the warning should remain for code that
>>  explicitly asks for C99.  Thus, I haven't applied this version of
>>  the patch.
>=20
> I've attached a revised version of the patch that:
>  - Renames the option to -Wdeclaration-after-statement, as per GCC
>    (wasn't hitherto aware of that gcc option).
>  - Defaults based on chosen C dialect.
>  - Adds a few tests. (I'll do a separate patch for tests for the
>    incomplete struct patch.)
>  - Was made wrt the git trunk at about 11:30 UTC on 12th April.

Looks good; applied and pushed.  Thanks!

- Josh Triplett



--------------enig13257A6340ABC52EB09DAB01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDOcfGJuZRtD+evsRAspDAJ9KAmTt/507p+ylqNFRrd0YfC8zAQCfbA4X
Kh8dyA/ZMvLidVX/HG+rWFY=
=IkIF
-----END PGP SIGNATURE-----

--------------enig13257A6340ABC52EB09DAB01--
