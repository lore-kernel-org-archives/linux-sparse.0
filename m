From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse memset warnings
Date: Tue, 01 May 2007 23:28:41 -0700
Message-ID: <46382F99.1000104@freedesktop.org>
References: <20061129101026.8aeb47ac.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF3950DD7F5F635FE8D76D695"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:42817 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030664AbXEBG2p (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 02:28:45 -0400
In-Reply-To: <20061129101026.8aeb47ac.randy.dunlap@oracle.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3950DD7F5F635FE8D76D695
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Randy Dunlap wrote:
> in 2.6.19-rc6-mm2, kvm:
>=20
> drivers/kvm/kvm_main.c:632:9: error: too many arguments for function me=
mset
> drivers/kvm/kvm_main.c:647:9: error: too many arguments for function me=
mset
> drivers/kvm/kvm_main.c:733:9: error: too many arguments for function me=
mset
> drivers/kvm/kvm_main.c:1866:8: error: too many arguments for function m=
emset
>=20
> I don't see the problem...

I just rechecked 2.6.19-rc6-mm2 with current Sparse from Git (commit
6b595d01c196bb013d6d95fc297ae2cb07c1fce7), and after commenting out line =
739
to get rid of this error suppressing the warnings:

drivers/kvm/kvm_main.c:739:18: error: macro "flush_tlb" passed 1 argument=
s, but takes just 0

, I looked through the list of warnings and did not see any about memset.=
  I
suspect your bug got fixed, either intentionally or unintentionally. :)

- Josh Triplett


--------------enigF3950DD7F5F635FE8D76D695
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOC+aGJuZRtD+evsRAqUjAKCoFI1jf+HIWhJFGLi2XPim7KNHQACfSymd
BdNzhrzSVAdy5UnC9Cx762k=
=TgBr
-----END PGP SIGNATURE-----

--------------enigF3950DD7F5F635FE8D76D695--
