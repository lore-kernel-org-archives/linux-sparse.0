From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Ignore the cdecl and stdcall attributes for now.
Date: Tue, 22 May 2007 15:39:16 -0700
Message-ID: <46537114.50109@freedesktop.org>
References: <20070515220536.GA23923@redhat.com> <464AA57B.3010205@freedesktop.org> <464AE8BE.9020805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35DC84B008BCD1E5C2DF5FA9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:39654 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762459AbXEVWj5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:39:57 -0400
In-Reply-To: <464AE8BE.9020805@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35DC84B008BCD1E5C2DF5FA9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Stefaniuc wrote:
> The output is still big. But i have a test case for the next big proble=
m=20
> generator in Wine. It's attached as a git patch to=20
> validate/calling-convention-attributes.c (I can send it separately to=20
> the linux-sparse mailing list if you want). Sparse gives:
> calling-convention-attributes.c:7:12: error: Expected ; at end of=20
> declaration
> calling-convention-attributes.c:7:12: error: got f5ptr

I just applied a patch from Ramsay Jones which fixes this test case, and =
I've
applied your test case patch.

- Josh Triplett


--------------enig35DC84B008BCD1E5C2DF5FA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU3EUGJuZRtD+evsRAh71AJ9FMYVV9pDeNMnUR0arVI5Aqe1bnACgoo3K
ywOePQaaz6p7pkTFxUM+xZo=
=PzjO
-----END PGP SIGNATURE-----

--------------enig35DC84B008BCD1E5C2DF5FA9--
