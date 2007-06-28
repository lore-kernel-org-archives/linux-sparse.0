From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Wed, 27 Jun 2007 23:05:20 -0700
Message-ID: <46834FA0.8010201@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig837D566836789D684B6EB669"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:43916 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbXF1GFW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:05:22 -0400
In-Reply-To: <20070628055850.GE21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig837D566836789D684B6EB669
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Thu, Jun 28, 2007 at 01:39:59AM -0400, Pavel Roskin wrote:
>> Use the actual sizeof values at the compile time to describe the defau=
lt
>> target.  If sparse is compiled on a 64-bit system, it will default to =
a
>> 64-bit system now.
>>
>> To force 32-bit operation on 64-bit systems, recognize -m32.  Reject
>> machine options other than -m32 and -m64.
>=20
> NAK.  That makes life very painful for cross-builds.

And the current approach of hard-coding all the sizes doesn't?

While I agree that I'd like a better approach (specifically, I want any S=
parse
build to support any target arch), I don't yet have a solution for that, =
and
this patch does at least seem like an improvement over the current hardco=
ded
values.

- Josh Triplett



--------------enig837D566836789D684B6EB669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg0+gGJuZRtD+evsRAsn3AKCeiH/F+sevt56LlsvaruAJGi+9zwCgo5Ge
EP1CaE+iQLcB3TP7XsEM4AQ=
=H/Le
-----END PGP SIGNATURE-----

--------------enig837D566836789D684B6EB669--
