From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix compilation warning on 64 bits platforms
Date: Tue, 22 May 2007 14:20:14 -0700
Message-ID: <46535E8E.10504@freedesktop.org>
References: <11797058752907-git-send-email-damien.lespiau@gmail.com>	 <4650E7B5.4030207@freedesktop.org>	 <20070521003318.GB4095@ftp.linux.org.uk>	 <4650E990.3020305@freedesktop.org> <cbf3148c0705221106n68cacf3g82faeba38d964945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3CC447EA13ACE77FB52EFA25"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:46818 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbXEVVU5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 17:20:57 -0400
In-Reply-To: <cbf3148c0705221106n68cacf3g82faeba38d964945@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Damien Lespiau <damien.lespiau@gmail.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3CC447EA13ACE77FB52EFA25
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Damien Lespiau wrote:
>> Al Viro wrote:
>>> Not just glibc; it's in C99.  So yes, I'd say we should use %td here.=

>=20
> Much better than my ugly cast. I feel stupid to "sign" a one letter pat=
ch
> that is not mine, but I guess you expect me to resend it.

Don't worry about it.  I went ahead and made the change:

=46rom 3195f83203cfd6d05cd56829c02c16b5dc5c274d Mon Sep 17 00:00:00 2001
From: Josh Triplett <josh@freedesktop.org>
Date: Tue, 22 May 2007 14:18:28 -0700
Subject: [PATCH] Use %td when printing a ptrdiff_t to avoid problems on 6=
4-bit platforms

Thanks to Damien Lespiau for reporting the problem.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 linearize.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/linearize.c b/linearize.c
index d428d92..c38dd7d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *insn=
)
 	}
=20
 	if (buf >=3D buffer + sizeof(buffer))
-		die("instruction buffer overflowed %d\n", buf - buffer);
+		die("instruction buffer overflowed %td\n", buf - buffer);
 	do { --buf; } while (*buf =3D=3D ' ');
 	*++buf =3D 0;
 	return buffer;

- Josh Triplett


--------------enig3CC447EA13ACE77FB52EFA25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU16OGJuZRtD+evsRAoYmAJ9k2Xg/3J/MSbyKgadybCtrNBmDlwCgn6P3
ljgm9ZLDM5mMULelXsDSBtI=
=c1P9
-----END PGP SIGNATURE-----

--------------enig3CC447EA13ACE77FB52EFA25--
