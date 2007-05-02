From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Variable "combinations" in tokenize.c and token.h
Date: Tue, 01 May 2007 21:56:24 -0700
Message-ID: <463819F8.6060707@freedesktop.org>
References: <4637B126.7050100@freedesktop.org> <20070501212753.GA8539@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1747E8FA9B69BB37B964B2C9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:34544 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030433AbXEBE41 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 00:56:27 -0400
In-Reply-To: <20070501212753.GA8539@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1747E8FA9B69BB37B964B2C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, May 01, 2007 at 02:29:10PM -0700, Josh Triplett wrote:
>> Apart from triggering a -Wshadow warning, this seems somewhat wasteful=
=2E
>> The reason appears to relate to the presence or absence of a '\0'
>> terminator at the end of each item.  Does that matter?  Could
>> show_special change somehow to avoid the duplication?  Alternatively,
>> could the global version just include '\0' terminators?
>>
>> - Josh Triplett
>>
>=20
> You mean some thing like that?
[snip patch]

Perfect, thanks.  Applied.

- Josh Triplett



--------------enig1747E8FA9B69BB37B964B2C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOBn4GJuZRtD+evsRAq+PAJ0QFDZQT49hFoxhw0TxamBegW0yGgCfVIGW
UiSZVZEHdwlhjZe6RM84JS4=
=als2
-----END PGP SIGNATURE-----

--------------enig1747E8FA9B69BB37B964B2C9--
