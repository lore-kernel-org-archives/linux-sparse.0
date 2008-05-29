From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Fri, 30 May 2008 00:45:02 +0200
Message-ID: <1212101102.10109.5.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick> (sfid-20080530_003519_648056_2583259D)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t5Vn4cXbwXb/g9QWhi7X"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:44101 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYE2WqN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 18:46:13 -0400
In-Reply-To: <1212100516.28403.152.camel@brick> (sfid-20080530_003519_648056_2583259D)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-t5Vn4cXbwXb/g9QWhi7X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-29 at 15:35 -0700, Harvey Harrison wrote:
> On Thu, 2008-05-29 at 10:54 +0200, Johannes Berg wrote:
> > This updates the context tracking, I just explained most of it in the m=
ail
> > "Re: sparse context warning problem ..."
> > (message ID <1212050823.16917.37.camel@johannes.berg>)
> >=20
>=20
> With these applied I get a new error when checking
> fs/minix/itree_common.c

What sort? Right now, it seems to go into a dead loop on
fs/minix/itree_v1.c for me?!

johannes

--=-t5Vn4cXbwXb/g9QWhi7X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD8x7aVg1VMiehFYAQJ3XhAAmVsgV1DEAW0lwTqPvQQCa36z2M6dqFf/
bOJi1CHePHwZuP/ChF0qw8OFLvsMp3Gwczt1+eXI4gRQNXO/OCy0w0FoY+WVoS2V
S53BlMuEIOoV+rO3EI307ma8Vd6wzWVITwfonB7WfKhRrdJCX+KwJMakdiLV8VZg
uf1aQxML/YR0VkEFOlbhI8swbvLeboVwftzG4RyKz93DVlIVZ2LVYvuA9YuYRtkq
R+CFpsI78ZaKMMScSxXLtzNUGWC053eRfMButoshjV7kSkLEcNcpQh0wKGeiSuMZ
B3D9RsMsdgyoM+XaVPts/XnQU3Oj0Rg5xmMBqHsT7JZwisaLb2Y3HDsgF5FgKQW1
gb5F4BFD+MFSm0oMVuOLnEvBkf91yEbGi0kT5Uy3EOtO6thDzcjJDk30NaHwT2iy
oYRdIru8Fo3Mavv2dQ9EpoLA3d63SY//yGmvX+Ev2i64JSCOIZb6VFRUbAcDUZht
d77M2xepj94UbqsPIqa/GBC67S8EAvN6LOBr9nfBMJImVE5kQHja/BrlPMV47IIE
/sCtLEZLiNmNuS9SsdPDuXTPyRF6PVe5FkLDW5gzN2PuyVQ05u5AmbKHVuOg5prp
p0/dkpOguL47jcW+CBXjO54r8NUse2fupHL2XN9J0NYky9m0wgijneuZC6oUO0yQ
Dw+wEm/cfuI=
=mgzv
-----END PGP SIGNATURE-----

--=-t5Vn4cXbwXb/g9QWhi7X--

