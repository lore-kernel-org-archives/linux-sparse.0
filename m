From: Josh Triplett <josh@freedesktop.org>
Subject: Git mirror delay
Date: Tue, 27 Feb 2007 18:55:42 -0800
Message-ID: <45E4EF2E.4050101@freedesktop.org>
References: <20061214213715.GB422@tv-sign.ru>	 <45E47B26.8010006@freedesktop.org> <1172625480.2363.21.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6115B4874904AD417E3FEEB5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:57733 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbXB1Czp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 21:55:45 -0500
In-Reply-To: <1172625480.2363.21.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6115B4874904AD417E3FEEB5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> On Tue, 2007-02-27 at 10:40 -0800, Josh Triplett wrote:
>> Oleg Nesterov wrote:
>>> Change examine_sym_node() to recursively inspect the members of SYM_S=
TRUCT.
>>> This allows us to simplify lookup_member(): no need to do examine_sym=
_node(),
>>> the member was already examined.
>>>
>>> This is also good because now ->r_symdef(member) is called on declara=
tion,
>>> not when dissect detects the first usage of ->member.
>>>
>>> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>> Applied.
>=20
> Josh, I'll really appreciate if you push your changes to the publicly
> available repository as soon as you post "applied".  This way, when I
> have some time for sparse, I read the list, see your post, update spars=
e
> and see how it's affecting my projects.
>=20
> If the changes are only available the next day, I'll probably be busy
> with other things.

To the best of my knowledge, I always push out changes before I send the
corresponding "applied" mail.  However, I often send the mail a few momen=
ts
after pushing out the change, and the kernel.org mirroring processes do n=
ot
run the instant I push changes out.  In particular, I just confirmed that=
 a
fresh clone of git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.=
git
did not include the changes I've pushed about 8 hours ago today.

The new git.kernel.org server may help alleviate some of the issues that =
lead
to this high mirroring delay.

- Josh Triplett


--------------enig6115B4874904AD417E3FEEB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5O8uGJuZRtD+evsRAtT7AJ41Wr+NzYCFHwGxkYKDK/oaG17JBwCgjS1v
hR4Mr74CgGthqRQufdAp9d4=
=b2Dz
-----END PGP SIGNATURE-----

--------------enig6115B4874904AD417E3FEEB5--
