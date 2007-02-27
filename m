From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] dissect: simplify lookup_member()
Date: Tue, 27 Feb 2007 10:40:38 -0800
Message-ID: <45E47B26.8010006@freedesktop.org>
References: <20061214213715.GB422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0A890C89307AFA9E50B8FCA9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:34897 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXB0Skm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 13:40:42 -0500
In-Reply-To: <20061214213715.GB422@tv-sign.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0A890C89307AFA9E50B8FCA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oleg Nesterov wrote:
> Change examine_sym_node() to recursively inspect the members of SYM_STR=
UCT.
> This allows us to simplify lookup_member(): no need to do examine_sym_n=
ode(),
> the member was already examined.
>=20
> This is also good because now ->r_symdef(member) is called on declarati=
on,
> not when dissect detects the first usage of ->member.
>=20
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Applied.

- Josh Triplett



--------------enig0A890C89307AFA9E50B8FCA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5HsmGJuZRtD+evsRAk5vAJ4zxjmchvhxnf+W5vkeFqp3LoHs6ACfXfXM
cT7movajs0v7QfTyXNMoHDs=
=tMEQ
-----END PGP SIGNATURE-----

--------------enig0A890C89307AFA9E50B8FCA9--
