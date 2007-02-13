From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 00:22:44 -0800
Message-ID: <45D17554.5010000@freedesktop.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <20070212191434.GA1041@chrisli.org> <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk> <20070213014657.GA2922@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5CAA32827314F38408E7E7A4"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:58288 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXBMIWs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 03:22:48 -0500
In-Reply-To: <20070213014657.GA2922@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CAA32827314F38408E7E7A4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, Feb 13, 2007 at 12:15:56AM +0000, Anton Altaparmakov wrote:
>> I applied this patch to the current spares git code and reran my test =
and=20
>> now we have two warnings:
>>
>>   CHECK   fs/ntfs/file.c
>> fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8 (differen=
t=20
>> signedness)
>> fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype] =

>> get_block )( ... )
>> fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel] *<noide=
nt>=20
>> )( ... )
>> include/linux/fs.h:1791:14: warning: incorrect type in argument 8=20
>> (different signedness)
>> include/linux/fs.h:1791:14:    expected int [signed] ( [signed] [usert=
ype]=20
>> get_block )( ... )
>> include/linux/fs.h:1791:14:    got int [signed] ( *get_block )( ... )
>>
>> Best regards,
>>
>=20
> I see. In evaluate_call().
> evaluate_arguments() is called before target function arguments
> are converted into pointers.
>=20
> Can you please try this patch instead?

Anton reported success with this revision of your patch, so I'd like to a=
pply
it to the sparse tree; could you please supply a Signed-off-by so I can d=
o so?

The same goes for several of the patches in your -cl2 tree, which I would=

eagerly like to apply.  Your patches look quite excellent, and greatly ad=
vance
the capabilities of Sparse in directions I've wanted to see it progress i=
n.
I'd prefer to pull your patches in as a block, to avoid inconveniencing y=
ou by
pulling them in piecemeal and forcing you to rebase the remaining patches=
=2E

- Josh Triplett


--------------enig5CAA32827314F38408E7E7A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0XVVGJuZRtD+evsRAlTqAJwJWeER7xgGlafPz6jepKYKdgMyjwCdGQgC
fI1mIyD6X8UWtY0b3CsDKJk=
=xZ2Z
-----END PGP SIGNATURE-----

--------------enig5CAA32827314F38408E7E7A4--
