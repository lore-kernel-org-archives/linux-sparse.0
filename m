From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Thu, 22 Feb 2007 18:25:30 -0800
Message-ID: <45DE509A.4040002@freedesktop.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk> <20070214172905.GA17959@chrisli.org> <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org> <20070214195447.GA18753@chrisli.org> <20070214201855.GC18753@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig086CD6A19DAFEA85E3A6CADC"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.10] ([69.17.117.10]:57010 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750720AbXBWC0Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 21:26:24 -0500
In-Reply-To: <20070214201855.GC18753@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig086CD6A19DAFEA85E3A6CADC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Wed, Feb 14, 2007 at 11:54:47AM -0800, Christopher Li wrote:
>> On Wed, Feb 14, 2007 at 10:24:09AM -0800, Linus Torvalds wrote:
>>> Actually, it's often better to just explicitly make "ctype" be=20
>>> "&bad_ctype" instead.
>>>
>>> It's nice if a NULL type means "type has not been evaluated yet", and=
 then=20
>>> using "&bad_ctype" to mean "type evaluated to crap".
>> Good idea. Some of the code already doing that. I am making it as a se=
parate
>> patch because touch a lot of code.
>=20
> This is very messy. The current evaluate_* functions are assuming NULL =
means for
> "some error happen in this expression, I can't get the ctype". It is al=
l over the
> place.

In that case, I will go ahead and apply your patch to eliminate the segfa=
ult, and
I can merge a new patch that uses &bad_ctype later.

- Josh Triplett


--------------enig086CD6A19DAFEA85E3A6CADC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3lCaGJuZRtD+evsRAsSjAKCChxNuMiEQedy5p03nO/Sw5/uJEACfYefN
TWt3D/RZ8MJzeEqOMC8oGIE=
=xxni
-----END PGP SIGNATURE-----

--------------enig086CD6A19DAFEA85E3A6CADC--
