From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Debian package; trivial fixes
Date: Tue, 21 Nov 2006 08:51:15 -0800
Message-ID: <45632E83.80509@freedesktop.org>
References: <20061109151912.GC8508@bee.dooz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE90B6DF75F178ED9CB6C580C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:52631 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1031106AbWKUQvS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 Nov 2006 11:51:18 -0500
In-Reply-To: <20061109151912.GC8508@bee.dooz.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?TG/Dr2MgTWluaWVy?= <lool+kernel@via.ecp.fr>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE90B6DF75F178ED9CB6C580C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Lo=C3=AFc Minier wrote:
>  I've prepared and uploaded a Debian package for sparse 0.1:
>     <http://people.dooz.org/~lool/debian/sparse/0.1-1/sid-pbuilder/>

Thanks!

>  Please find attached a trivial fix for .gitignore where "check" wasn't=

>  renamed to "sparse".
>
>  It would also be more convenient to create BINDIR automatically on mak=
e
>  install.

Thanks for these two fixes.

Sparse follows the same Signed-off-by convention as Linux, so coud you
please supply a Signed-off-by for your patches?  See <http://kernel.org/g=
it/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob;hb=3DHEAD;f=3DDo=
cumentation/SubmittingPatches>
for details on the Signed-off-by process and the Developer's Certificate =
of
Origin.

You might find git convenient for submitting patches.  If you have change=
s to
Sparse in a git repository, you can create patch mails with "git
format-patch".  git also makes Signed-off-by as simple as adding -s to th=
e
"git commit" or "cg commit" command line.

Thanks,
Josh Triplett


--------------enigE90B6DF75F178ED9CB6C580C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFYy6DGJuZRtD+evsRAtUoAJsHPJ0ZBY1JC/ZPZPS7g7tspo+/0QCfQq3Z
awGILfUe+fCSgTMu8P3UB4M=
=jK8k
-----END PGP SIGNATURE-----

--------------enigE90B6DF75F178ED9CB6C580C--
