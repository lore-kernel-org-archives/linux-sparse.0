From: Josh Triplett <josh@freedesktop.org>
Subject: Re: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 04:23:57 -0800
Message-ID: <45ACC3DD.6050702@freedesktop.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1AEF3778FE39BE9F328FD52D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:57930 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbXAPMYD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 07:24:03 -0500
In-Reply-To: <20070116001735.GA12002@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Mitesh Shah <mshah@teja.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AEF3778FE39BE9F328FD52D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> That is the same git repository I am pulling from. There is not
> much update recently. I assume it is the Christmas/New Year holidays.

That combined with the back-to-school crunch and work on a research grant=
=2E
The grant helps further my work on Sparse, though. :)

I've followed all the patches on linux-sparse, and I have tested several =
of
them in local git; I just haven't pushed out new bits.  I particularly lo=
ok
forward to integrating your NULL pointer checking code, and I think I can=

adapt some of the dataflow analysis code for lock context checking as wel=
l.  I
also know at least one likely customer for the smarter Sparse-based ctags=
, and
I plan to look into generating cscope information as well (sparscope).  E=
xpect
bits soon.

Also, some of the patches came with disclaimers along the lines of "don't=
 use
this, I plan to rewrite". :) For those, I wanted to wait a bit and see wh=
ere
they go; however, given the usefulness of some of those patches, I may go=

ahead and merge them anyway.

- Josh Triplett

> Chris
>=20
> On Mon, Jan 15, 2007 at 03:48:26PM -0800, Mitesh Shah wrote:
>> Hi,
>>
>> How do I get the latest version of sparse? The git repository from the=

>> sparse home page
>> (http://kernel.org/pub/linux/kernel/people/josh/sparse/) does not show=

>> any update since Dec 05, 2006, while I see few patched submitted after=

>> that.
>>
>> Also the latest tarball URL gives me a version which is not updated
>> since Nov 06
>> (http://www.codemonkey.org.uk/projects/git-snapshots/sparse/sparse-lat=
es
>> t.tar.gz)
>>
>> Is there something I am missing?
>>
>> Thanks,
>>
>> -Mitesh



--------------enig1AEF3778FE39BE9F328FD52D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrMPdGJuZRtD+evsRAjskAJwMgp7epjAzzJbsxA6u3BTk87YzpwCgj9zk
E2dK+udqJTMBgOlYTSlMc+g=
=MGUx
-----END PGP SIGNATURE-----

--------------enig1AEF3778FE39BE9F328FD52D--
