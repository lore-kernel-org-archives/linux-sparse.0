From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] c2xml
Date: Fri, 13 Jul 2007 23:24:38 -0700
Message-ID: <46986C26.9040804@freedesktop.org>
References: <46826B68.5040302@codethink.co.uk>	 <1182970187.8970.145.camel@josh-work.beaverton.ibm.com>	 <4688F05A.5010801@codethink.co.uk>  <46979F4B.9050307@codethink.co.uk> <1184349348.2616.34.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6A9A10F414CFE08261A09E44"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:32789 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbXGNGZJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jul 2007 02:25:09 -0400
In-Reply-To: <1184349348.2616.34.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Rob Taylor <rob.taylor@codethink.co.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A9A10F414CFE08261A09E44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Josh Triplett wrote:
> On Fri, 2007-07-13 at 16:50 +0100, Rob Taylor wrote:
>> Any followups on this?
>=20
> I actually committed the first three patches this morning, before you
> sent this.  I would like to commit the fourth patch this evening.  I
> want to think a bit about how to address one issue: I'd really love to
> avoid constructs specific to GNU make, such as ifeq and $(shell).  I
> managed to find a way to do that for the patch adding clean kernel-styl=
e
> build output, by using the text substitution feature of make variable
> expansion.  However, I haven't yet figured out a way to avoid $(shell)
> with this patch.  The c2xml target can just always exist, so no
> conditionals needed there.  However, without $(shell), I don't see any
> way to handle adding c2xml to PROGRAMS and INST_PROGRAMS without
> $(shell); backquotes will only work in the commands of a target, not th=
e
> prerequisites.  (Obviously, just leaving c2xml out of the all and
> install targets would solve the problem, but that seems quite
> suboptimal.)  I want to think about this problem for a bit, and if I
> don't come up with anything and don't get any good suggestions, I may
> just go ahead and require GNU make.

OK, forget it.  Anyone who wants Sparse to work with non-GNU make gets to=
 rack
*their* brain thinking about how to do without useful GNU make features.
Patch applied...

> Also, you didn't update the dtd for the changes to the position
> handling; it doesn't have end-file, and it still has start and end
> rather than {start,end}-{line,col}.

=2E.. and I fixed this myself.

Thanks again for some most impressive work.

- Josh Triplett


--------------enig6A9A10F414CFE08261A09E44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGmGw1GJuZRtD+evsRAoRPAKC6hRtewg992uo/RRt7iWpETU2cGwCggf7w
shdw/kpRJ2bVVRkjzTvXDS4=
=Pz4E
-----END PGP SIGNATURE-----

--------------enig6A9A10F414CFE08261A09E44--
