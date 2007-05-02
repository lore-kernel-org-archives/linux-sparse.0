From: Josh Triplett <josh@freedesktop.org>
Subject: Re: barrier macro
Date: Wed, 02 May 2007 11:11:00 -0700
Message-ID: <4638D434.7010205@freedesktop.org>
References: <20070501153448.a65c81c2.rdunlap@xenotime.net> <463802E1.4030303@freedesktop.org> <46381269.9090305@freedesktop.org> <46382387.4010903@freedesktop.org> <20070502072056.GA9889@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36A6F2E5487DD508909105F2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:45104 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767082AbXEBSLE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 14:11:04 -0400
In-Reply-To: <20070502072056.GA9889@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36A6F2E5487DD508909105F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, May 01, 2007 at 10:37:11PM -0700, Josh Triplett wrote:
>> Fixed in current Git.
>=20
> May I purpose a slightly different fix?
>=20
> The reason I use bit mask in the keyword so that it can allow
> select a sub set of keywords. If we want, We can fine tune exactly
> what keyword is allowed. It also makes the caller of handle_attributes
> show exactly what kind of attribute it takes.

Applied, with a minor fix: a bitmask of values from "enum keyword" does n=
ot
have type "enum keyword", so I made the argument an unsigned int.

- Josh Triplett


--------------enig36A6F2E5487DD508909105F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGONQ0GJuZRtD+evsRAhWfAKCGPYVJcQBYOkUt8oVLrwT3Wdxc0QCgoYMs
es+YcOmhyorZKUkOE5VqEMM=
=pCru
-----END PGP SIGNATURE-----

--------------enig36A6F2E5487DD508909105F2--
