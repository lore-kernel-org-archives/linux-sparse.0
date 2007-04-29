From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse preprocessing confused
Date: Sat, 28 Apr 2007 23:36:18 -0700
Message-ID: <46343CE2.80403@freedesktop.org>
References: <20070425164355.2c250388.rdunlap@xenotime.net> <118833cc0704251652r28f2431cs145a993e783a58bc@mail.gmail.com> <20070426143852.GB13111@daikokuya.co.uk> <20070429054143.GA15365@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA623D883399C7E9D63A36D72"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:44012 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbXD2Ggh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Apr 2007 02:36:37 -0400
In-Reply-To: <20070429054143.GA15365@tuatara.stupidest.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Neil Booth <neil@daikokuya.co.uk>, Morten Welinder <mwelinder@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA623D883399C7E9D63A36D72
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Chris Wedgwood wrote:
> On Thu, Apr 26, 2007 at 11:38:52PM +0900, Neil Booth wrote:
>>>>        memcpy(data + nhead, skb->head,
>>>> #ifdef NET_SKBUFF_DATA_USES_OFFSET
>>>>                skb->tail);
>>>> #else
>>>>                skb->tail - skb->head);
>>>> #endif
>>> If memcpy happens to be a macro, that is not valid C.
>> It's undefined rather than invalid.  GCC makes an effort to
>> do "what you'd expect".
>=20
> I think I prefer sparse breaking on things like this (so we can find
> such uglies and correct them.).

I tend to agree; however, if GCC accepts the code, I would prefer to have=

Sparse parse it and warn, rather than failing to parse it.  I would gladl=
y
take a clean patch that allows this code to work the same way GCC does.  =
Bonus
if the patch supplies a -Wpreprocessor-conditional-in-macro-arguments or
similar, and I wouldn't object to having such a warning on by default.

- Josh Triplett


--------------enigA623D883399C7E9D63A36D72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNDzyGJuZRtD+evsRAtyPAKC7Vh4m9R4kcvRDqF6zjC5pBBcGkgCgrxDw
X4sHskQOXVse97186Yp900Q=
=bwfj
-----END PGP SIGNATURE-----

--------------enigA623D883399C7E9D63A36D72--
