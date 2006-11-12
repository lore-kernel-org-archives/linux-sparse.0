From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse as a compiler front-end
Date: Sat, 11 Nov 2006 17:32:32 -0800
Message-ID: <455679B0.8030106@freedesktop.org>
References: <45564680.8090806@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAC3CEC93C9EB473B8DFEC217"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:36509 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1947394AbWKLBci (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 11 Nov 2006 20:32:38 -0500
In-Reply-To: <45564680.8090806@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC3CEC93C9EB473B8DFEC217
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> I see that sparse made it into Fedora Extras, so that 'yum install'=20
> automatically pulls it down for me.  Yay!  Thanks, Matt.

Thanks indeed.

> Can libsparse.a and necessary includes be packaged as well?

Sure, assuming you don't mind coding against something potentially fluid.=
  The
next release will install the library and headers.  (At the moment, "nece=
ssary
headers" seems to mean "all of them".)

> I have wild ambitions of rewriting compile-i386.c (my int-only x86=20
> pseudo-compiler) using the new basic block stuff, into a proper [if ver=
y=20
> very basic] C99 compiler.

I look forward to seeing that.

- Josh Triplett


--------------enigAC3CEC93C9EB473B8DFEC217
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVnmwGJuZRtD+evsRApkCAJ9Pb1O8c5pB8hajpM35E36J1oFK1wCfY40G
MNAieAEp/JzaaJO/tKpyyl0=
=W0fm
-----END PGP SIGNATURE-----

--------------enigAC3CEC93C9EB473B8DFEC217--
