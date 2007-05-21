From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix compilation warning on 64 bits platforms
Date: Sun, 20 May 2007 17:36:32 -0700
Message-ID: <4650E990.3020305@freedesktop.org>
References: <11797058752907-git-send-email-damien.lespiau@gmail.com> <4650E7B5.4030207@freedesktop.org> <20070521003318.GB4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig311CED162DC78BF801F3E8FA"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:59441 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398AbXEUAgq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:36:46 -0400
In-Reply-To: <20070521003318.GB4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Damien Lespiau <damien.lespiau@gmail.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig311CED162DC78BF801F3E8FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Sun, May 20, 2007 at 05:28:37PM -0700, Josh Triplett wrote:
>> Damien Lespiau wrote:
>>> Fix: format '%d' expects type 'int', but argument 2 has type 'long in=
t'
>> [...]
>>> @@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *=
insn)
>>>  	}
>>> =20
>>>  	if (buf >=3D buffer + sizeof(buffer))
>>> -		die("instruction buffer overflowed %d\n", buf - buffer);
>>> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
>> A cast doesn't seem like the right fix.  The difference between two po=
inters
>> has type ptrdiff_t.  sizeof(ptrdiff_t) =3D=3D 8 on 64-bit platforms, l=
eading to
>> the legitimate warning you saw.  This cast would truncate the differen=
ce to 32
>> bits.  glibc supplies a "t" length modifier for ptrdiff_t, but I don't=
 think
>> sparse can't portably use that.
>=20
> Not just glibc; it's in C99.  So yes, I'd say we should use %td here.

Ah, perfect.  Yes, we should use %td.

- Josh Triplett



--------------enig311CED162DC78BF801F3E8FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGUOmQGJuZRtD+evsRAqxkAJ9oloEKZNS7WUB00HdXy6KdO+MijQCgqKs7
CNqte2bCdJfof/hsGJ7URO4=
=TvVZ
-----END PGP SIGNATURE-----

--------------enig311CED162DC78BF801F3E8FA--
