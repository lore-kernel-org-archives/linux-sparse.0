From: Josh Triplett <josh@freedesktop.org>
Subject: exposing __attribute__ portability macros in lib.h; any objections?
Date: Sun, 25 Feb 2007 14:45:29 -0800
Message-ID: <45E21189.1060202@freedesktop.org>
References: <1172251518.6229.6.camel@dv> <1172260766.14431.3.camel@dv> <20070223223027.GA5671@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF0F6B131E04194344F0CBC42"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:41437 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965190AbXBYWpc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 Feb 2007 17:45:32 -0500
In-Reply-To: <20070223223027.GA5671@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0F6B131E04194344F0CBC42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Fix a bug that match_idents forget to end with NULL
[...]
> Signed-Off-By: Christopher Li <sparse@chrisli.org>
[...]
> -		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident)) {=

> +		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident, NU=
LL)) {

Applied.

I'd also like to apply a patch to use __attribute__((__sentinel__)) on
match_idents, which would have caught this problem.  In order to do so
portably, I plan to add a portability macro SENTINEL_ATTR, like the
FORMAT_ATTR macro currently in lib.h.  However, lib.h currently defines
FORMAT_ATTR, uses it for a few prototypes, and then undefines it.  Any
objections to defining SENTINEL_ATTR and leaving it defined (and probably=

doing the same for FORMAT_ATTR)?  I don't think those would pollute the
namespace any more than lib.h already does with position, verbose, info, =
and
similar.

- Josh Triplett


--------------enigF0F6B131E04194344F0CBC42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4hGJGJuZRtD+evsRAuAYAJ9o6irCXFE4cEk5we5fTIzJjl4JpACdEghh
ZvrjF25dHtL+/qoioV/0HcA=
=LPxi
-----END PGP SIGNATURE-----

--------------enigF0F6B131E04194344F0CBC42--
