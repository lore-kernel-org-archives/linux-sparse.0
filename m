From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Official releases?
Date: Tue, 31 Oct 2006 12:36:23 -0800
Message-ID: <4547B3C7.5030608@freedesktop.org>
References: <1162307025.11613.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig609CD12919F61BC1C049DEFC"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:25255 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1423613AbWJaUgZ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 31 Oct 2006 15:36:25 -0500
In-Reply-To: <1162307025.11613.1.camel@zod.rchland.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig609CD12919F61BC1C049DEFC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Boyer wrote:
> I'm just curious if anyone is ever really going to do an "official"
> release of sparse.  We've got daily snapshots provided by Dave Jones,
> and git of course, but will an official release tarball with shiny
> version numbers and everything be created?

Since sparse doesn't use any autofoolery, and doesn't include a version n=
umber
in the source anywhere, making a release should just require running git =
tag
and git archive, and putting the resulting tarball up in an official loca=
tion.
As far as version numbering, it seems reasonable to use the former kernel=

versioning system: major.oddeven.revision, starting from something like 0=
=2E1.0,
and keeping major version 0 until sparse can comfortably provide some
guarantee of backward compatibility for sparse extensions.  Thus, periodi=
c
releases (0.1.1, 0.1.2, ...) wouldn't take much effort at all, and eventu=
ally
calling one "stable" (0.2.0, with crash-fixes an similar backported to pr=
oduce
0.2.1, 0.2.2, ...) would mostly consist of a judgement call.

- Josh Triplett


--------------enig609CD12919F61BC1C049DEFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFR7PHGJuZRtD+evsRAiLZAJ4jcV33Sc493kkVKucJSdaOW4BjHgCbB3xc
OsfObTdrpolbawrP7XQv8Kk=
=eo0f
-----END PGP SIGNATURE-----

--------------enig609CD12919F61BC1C049DEFC--
