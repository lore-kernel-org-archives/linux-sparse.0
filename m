From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 20:11:25 +0200
Message-ID: <1208801485.26186.131.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <20080410132617.720109000@sipsolutions.net>  <480CD736.601@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9sSsGwdy1A5kVRtdk0/T"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:54111 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbYDUSL7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 14:11:59 -0400
In-Reply-To: <480CD736.601@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org


--=-9sSsGwdy1A5kVRtdk0/T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >     static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)
> >             __acquires(dev_base_lock)
> >     {
> >             [...]
> >             __acquire__(dev_base_lock);
> >             read_lock(&dev_base_lock);
> >             [...]
> >     }
>=20
> I don't understand why you count this as wrong.  read_lock should
> handle acquiring the context itself, either via an __acquires
> annotation if written as a function, or via an __acquire__ statement
> if written as a macro.  Callers of read_lock shouldn't need to
> explicitly call __acquire__.

Well, the question is how you want to name things. What I did is that
the context identifier is just a name and bears no other relation to the
code. Hence, read_lock() can't say that it acquires 'dev_base_lock'
because it doesn't know what the name should be.

With a slightly different sparse patch than mine you could declare
read_lock() something like this:

#define read_lock(x) do { \
	__acquire__(x); \
	__read_lock((x)); \
} while (0)

but then you'd have different names everywhere, say somebody passed
'&dev_base_lock' and somebody else used

readlock_t *dbl =3D &dev_base_lock;
read_lock(dbl)

and you'd end up with one context named "dbl" and another one named
"&dev_base_lock".

If you have suggestions on how to solve this I'm all ears, so far I
decided it wasn't worth it and opted for explicitly naming all the
contexts.

(with my patch the above would just create a context called "x")

johannes

--=-9sSsGwdy1A5kVRtdk0/T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASAzYzKVg1VMiehFYAQJCjA/+JrujuELoJCNPxj4CLIptdHKYNXIPb2/R
SHFvDE/fVcMAXuHjNFjJ9k/y/KriILvoFy75WPNrToZcGT19QRR+5xL7cg0bWwLU
erVsrVFYcPtsPScILpd2aQU1/PZ86MOPWkQQiJ9wG9dU1n79omuHC0oPdcSrZtV5
mPt49QfiKLWiOZU5KDkyIAvd13G/413lo5QViKeHn++J8G33AqopT1DRep7QeOuG
oKhDOR95+wwuVyI0TiiyFrrut6PHj0HBtmCSepihwS9bWa4z0ckwhQro3VKaNY3h
2MPkLfZQTqRHQn7ij6BwXzHZKj/unvzNVRhQTLJaAIZDvKpGiN6a+jbEwAC8dQSD
Z2eiuaXbkMcQltMKEJUUKQ2o/pctbWnkdioTxic3lG3ZfITFbqdPz/GkEYSC5zpP
KLmGLNxfkhkF/Dyv1EMg2WeAbbdWXVefsZDuIWoR4W96kabzzvPW1NE/hjeXHx2p
RZOD8OBiuT+ij4nN9d7JhYZGOKhJOty5Hdlqy/zXA6cyrM+3yIaAvTin80QY3tOg
uJo/rWD1IdyggxjvHkfBdS/n5vAmIrVvy7einUTL6a9L/c/xbPn+yAN1XCRPsKYt
EUoIw5lRmsZHJ3RYr5UKs9cVF0H6PCXuoSDwxb/Bx+mM5yPDkOzVB18tVQwbB3Py
vbME/e5bf+o=
=O+oa
-----END PGP SIGNATURE-----

--=-9sSsGwdy1A5kVRtdk0/T--

