From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 15:01:00 -0800
Message-ID: <45D2432C.6020002@freedesktop.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <20070212191434.GA1041@chrisli.org> <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk> <20070213014657.GA2922@chrisli.org> <45D17554.5010000@freedesktop.org> <20070213190400.GA9989@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3DDD83FE20EE1C70FC87860"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:59903 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbXBMXBD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 18:01:03 -0500
In-Reply-To: <20070213190400.GA9989@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Anton Altaparmakov <aia21@cam.ac.uk>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3DDD83FE20EE1C70FC87860
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, Feb 13, 2007 at 12:22:44AM -0800, Josh Triplett wrote:
>> Anton reported success with this revision of your patch, so I'd like t=
o apply
>> it to the sparse tree; could you please supply a Signed-off-by so I ca=
n do so?
>=20
> Bug fix in pointer modifiers inherent at function degeneration.
>=20
> In reply to Randy's email:
>=20
> The following case cause warning about different signedness of pointer.=

> The pointer should not have signedness at all.
>=20
> struct sk_buff;
> struct sock;
>=20
> extern int skb_append_datato_frags(struct sock *sk, struct sk_buff *skb=
,
> 			int getfrag(void *from, char *to, int offset,
> 			int len,int odd, struct sk_buff *skb),
> 			void *from, int length);
>=20
> int skb_append_datato_frags(struct sock *sk, struct sk_buff *skb,
> 			int (*getfrag)(void *from, char *to, int offset,
> 			int len,int odd, struct sk_buff *skb),
> 			void *from, int length)
>=20
> {
> 	return 0;
> }
>=20
> Singed-Off-By: Christopher Li <sparse@chrisli.org>
> Acked-By: Linus Torvalds <torvalds@linux-foundation.org>

Applied.  I also added this test case to the validation directory.

Thanks.

- Josh Triplett


--------------enigD3DDD83FE20EE1C70FC87860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0kMsGJuZRtD+evsRAob8AJoC9S7+NQ7jC8HANqox7OYvPzOCdQCeMll+
GToZ/5LDMSZSjywJHrXbo+E=
=YdHT
-----END PGP SIGNATURE-----

--------------enigD3DDD83FE20EE1C70FC87860--
