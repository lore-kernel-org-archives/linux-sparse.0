From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/2] Simplify (and warn about) right shifts that result
 in zero
Date: Thu, 24 Apr 2008 19:32:46 -0700
Message-ID: <481142CE.5030801@freedesktop.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk>  <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org>  <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>  <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org> <1209081131.12561.45.camel@dv> <alpine.LFD.1.10.0804241658520.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig099962893ABBA746D413FDC9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:39688 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbYDYCcn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:32:43 -0400
In-Reply-To: <alpine.LFD.1.10.0804241658520.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Roskin <proski@gnu.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig099962893ABBA746D413FDC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Thu, 24 Apr 2008, Pavel Roskin wrote:
>> So I would suggest a similar warning is this case.  Maybe "right shift=

>> too big (%u) for source type %s" (if the source type is readily
>> available) or "right shift count (%d) >=3D width of type (%d)"
>=20
> That's fine, except we shouldn't talk about "type", since we're really =

> doing some really stupid value analysis (the *type* will generally have=
=20
> been cast to a bigger one by the implicit C type evaluation rules).

Pavel, it sounds like you agree with the semantic of the warning, and
just want an different wording.  Thus, I've applied and pushed the patch;=

feel free to propose a change to the wording in a subsequent patch.

>> By the way, your patch has caught something interesting in
>> net/mac80211/tkip.c:
>>
>>         iv32 =3D data[hdr_len + 4] +
>>                 (data[hdr_len + 5] >> 8) +
>>                 (data[hdr_len + 6] >> 16) +
>>                 (data[hdr_len + 7] >> 24);
>>
>> Wow!
>=20
> Heh. That does look like somebody is shifting the wrong way, and=20
> apparently the new warning was worth something ;)

Nice.

- Josh Triplett



--------------enig099962893ABBA746D413FDC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEULOGJuZRtD+evsRAi03AJ0diViUPSPMeudKYcEnKJE/k8GAPQCeJK2o
xFrKnBFAll3vw6NFBxWS9kc=
=wZqZ
-----END PGP SIGNATURE-----

--------------enig099962893ABBA746D413FDC9--
