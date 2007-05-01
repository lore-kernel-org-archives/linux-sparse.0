From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Style checking
Date: Tue, 01 May 2007 11:09:58 -0700
Message-ID: <46378276.8060307@freedesktop.org>
References: <c38fc0de0704300030x6ab610acge10482904056d1db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE468B29D7D6014600CD522E0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:57282 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbXEASKB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 14:10:01 -0400
In-Reply-To: <c38fc0de0704300030x6ab610acge10482904056d1db@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Goodwin <mike.goodwin@cantab.net>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE468B29D7D6014600CD522E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Mike Goodwin wrote:
> I have begun modifying sparse (read: adding in various hooks to the
> preprocessing and parsing stages) in order to be able to use it as a
> style checker. Checking rules such as order of includes, function and
> variable naming ... etc.
>=20
> The style checking is intended to be for linux/driver modules and as
> far as I am aware the only two freely available c parsers which can
> parse all the headers in the linux kernel are those that are part of
> sparse and gcc. As sparse is a lot simpler to modify it seems the
> logical choice
>=20
> So I was wondering:-
>  1) if anyone had used sparse similarly?

Not that I know of.

>  2) would it ever be desirable to have this kind of feature as a part o=
f sparse?

Yes!  I'd love to see the frontend save enough information to do things
like this, such as saving the tree of "#include"s.  I don't know if these=

kinds of rules should go in the Sparse backend or in another backend usin=
g
libsparse; if the former, you'll need to include options to turn these
checks on, and they should likely default to "off" because they will vary=

between projects.

In addition to the warnings you suggest, I'd love to see a warning for "H=
eader
not self-contained": a header does not #include all the headers it needs,=
 and
instead relied on the inclusion of another header first.

>  3) is there anything wrong with this approach?!

Not that I can see; I look forward to seeing your patches.

- Josh Triplett


--------------enigE468B29D7D6014600CD522E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN4J2GJuZRtD+evsRApUuAJ9RyI4e4V8/1rA+YsR36Jb+7x9PogCguZ/K
rNaUgOcuGnP/z2aB9AjWVNs=
=wwGq
-----END PGP SIGNATURE-----

--------------enigE468B29D7D6014600CD522E0--
