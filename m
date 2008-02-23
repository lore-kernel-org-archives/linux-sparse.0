From: Pierre Habouzit <madcoder@debian.org>
Subject: feature-request
Date: Sat, 23 Feb 2008 14:39:45 +0100
Message-ID: <20080223133945.GB10967@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="TRYliJ5NKNqkz5bu";
	protocol="application/pgp-signature"; micalg=SHA1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pan.madism.org ([88.191.52.104]:49375 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233AbYBWNjt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 23 Feb 2008 08:39:49 -0500
Received: from madism.org (ctse16.ulb.ac.be [164.15.3.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 198C71E42D
	for <linux-sparse@vger.kernel.org>; Sat, 23 Feb 2008 14:39:48 +0100 (CET)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  While I'm at it, there is this feature I'd like to see in sparse: I'd
love to be able to ask it to ignore errors that are located in some
specific paths (like /usr/include e.g.). For now I'm doing that through
a custom script, but it'd be simpler for me if it does it natively.  The
reason is that I don't want to patch third party libraries headers.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwCIhvGr7W6HudhwRAvsjAJ95pQBHAv+PbQSWcyx3kRoiVx7TdgCePMiI
QQn5ish66oM/1fEq/Xo3Xj8=
=CX3q
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
