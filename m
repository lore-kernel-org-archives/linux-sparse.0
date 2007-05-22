From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 0/2] Improved flow graphs
Date: Tue, 22 May 2007 15:11:50 -0700
Message-ID: <46536AA6.20604@freedesktop.org>
References: <1179310281.31308.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig16A6B52E7B2B3821DD060D7A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:48508 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761444AbXEVWMd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:12:33 -0400
In-Reply-To: <1179310281.31308.54.camel@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Sheridan <djs@postman.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16A6B52E7B2B3821DD060D7A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dan Sheridan wrote:
> These two patches are the first of several implementing improved graph
> generation for Sparse.

Very nice work.  I've applied both patches in this series.

I also added shebangs to the gvpr scripts and made them executable, so yo=
u
can just run graph ... | gvpr/return-paths | dot ...

I noticed one minor issue: gvpr/return-paths seems to turn some internal
edges in functions into dotted-line return paths.

Also, unprocessed graphs have now become far more messy; for instance,
graphing validation/context.c generates numerous edges to a() and r().  A=
ny
way you could prevent these edges from crossing other subgraphs?  Any way=
 to
make these edges just point to a separate node "a()" and let people look =
up
a() themselves, removing the excess edges?  Perhaps with a gvpr script?

> Initially, I am dealing with straight-forward
> control flow. Forthcoming patches will add program dependency graphs (a=

> control and data flow representation suitable for program slicing) and
> simple pointer alias analysis (for handling indirect calls).

I look forward to seeing these future enhancements.  Pointer alias analys=
is
would help greatly with many other things in Sparse.

> I've tried to keep the C part of the flow graph relatively simple, and
> put the hard stuff (like return edges and subgraph processing) in
> post-processing scripts.=20
>=20
> Example graph can be seen at
> http://www.postman.org.uk/djs52/example.png, generated with
>=20
>   ./graph validation/context.c | gvpr -f gvpr/return-paths | \
>     gvpr -f gvpr/subg-fwd -a good_while3 | dot -Tpng > /tmp/example.png=


Impressive work.

- Josh Triplett


--------------enig16A6B52E7B2B3821DD060D7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU2qmGJuZRtD+evsRAh/HAJ9HrNRpSYtOt0hSBuN/RSUoPu12NACglDW3
KRGCRa8hTXz3k35LxgustaA=
=1NvT
-----END PGP SIGNATURE-----

--------------enig16A6B52E7B2B3821DD060D7A--
