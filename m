From: Josh Triplett <josh@kernel.org>
Subject: Re: four sparse patches
Date: Sat, 05 Apr 2008 03:13:30 -0700
Message-ID: <47F750CA.1090307@kernel.org>
References: <9356e4460803300752y6c1416bfh680b68fd3c42c19a@mail.gmail.com>	 <47F07F78.5030405@kernel.org>	 <9356e4460803311222v4b09df5fk76268fb5c7e71971@mail.gmail.com> <32e600e90803311236g4caf05c9t8dd3a3ab03dcd5bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9AA6AB33AF9873DD839D65D4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:50562 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYDEKN1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 Apr 2008 06:13:27 -0400
In-Reply-To: <32e600e90803311236g4caf05c9t8dd3a3ab03dcd5bc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Geoff Johnstone <geoffsheep.johnstonefrog@googlemail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AA6AB33AF9873DD839D65D4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Geoff Johnstone wrote:
>>> I've attached four patches that I've written for sparse to
>>> use it for a userland project.

Regarding Wmix-decl-code.diff, I agree that that warning definitely
needs an option controlling it. but GCC already has that option and
calls it "-Wdeclaration-after-statement", so matching GCC's name seems
potentially useful.  (However, I can imagine corner cases where it
might prove problematic, such as wanting to pass that option to GCC
and not Sparse or vice versa.)  Also, I agree that the default should
depend on the C standard in use, and I see no compatibility reason why
the warning should remain for code that explicitly asks for C99.
Thus, I haven't applied this version of the patch.  I'd love to apply
an updated version with those two changes.

Regarding incomplete structs, your patch seems reasonable as far as I
know, and it doesn't break the test suite, so I've applied and pushed
it.  Per your concerns, if this patch doesn't represent the correct
fix, the code can change later when we have a test case that breaks
with this patch.  Please do consider writing a patch for a new test
case based on your example.

Your argument parsing for -ansi and -std=3D looks great to me.  Applied
and pushed.

The new builtins for fortify handling seem fine.  Applied and pushed.

Thanks for your patches.

- Josh Triplett


--------------enig9AA6AB33AF9873DD839D65D4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH91DKGJuZRtD+evsRApxQAKCjI7iB7S5iCfr4daxAXTShpo6R9gCfa+hi
1Ztyf/EUGxyqUgnwYu3CL5s=
=xAnQ
-----END PGP SIGNATURE-----

--------------enig9AA6AB33AF9873DD839D65D4--
