From: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Subject: sparse using insane amounts of memory
Date: Thu, 08 Mar 2007 03:02:36 +0100
Message-ID: <1173319356.3546.54.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HHSjVGf5etuwmb4lfJNz"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org


--=-HHSjVGf5etuwmb4lfJNz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I was running make C=3D2 over the current wireless-dev tree (as of commit
4533da881f2d8c3e0dbb5b3dbc7a919e12438a8a) and reached
drivers/net/wireless/mac80211/rt2x00/rt2400pci.c when sparse started
using more and more memory. It went up to about 1 GB. Now I don't know
whether to blame sparse or if something's wrong with that file but it
does seem to be a bit excessive... Similar with all the other driver
files in that directory, yet I've not seen such a case before.

johannes

--=-HHSjVGf5etuwmb4lfJNz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF7267/ETPhpq3jKURAvQpAJ4oBRF1odAQrZx7cQzHifDWHqZfxwCgo0/N
c5i7hd0s5+/CaDTjrogefKE=
=WFjz
-----END PGP SIGNATURE-----

--=-HHSjVGf5etuwmb4lfJNz--
