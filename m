From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Fri, 30 May 2008 01:15:46 +0200
Message-ID: <1212102946.10109.16.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
	 <1212101465.28403.156.camel@brick>
	 (sfid-20080530_005109_203270_E4619B0E)  <1212101645.10109.7.camel@johannes.berg>
	 <1212102199.4265.46.camel@dv>  <1212102414.10109.11.camel@johannes.berg>
	 (sfid-20080530_010810_225034_159FE69C)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r/YyCLMEHqaodRrcDXsO"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:36513 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYE2XQz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:16:55 -0400
In-Reply-To: <1212102414.10109.11.camel@johannes.berg> (sfid-20080530_010810_225034_159FE69C)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-r/YyCLMEHqaodRrcDXsO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-30 at 01:06 +0200, Johannes Berg wrote:
> On Thu, 2008-05-29 at 19:03 -0400, Pavel Roskin wrote:
> > On Fri, 2008-05-30 at 00:54 +0200, Johannes Berg wrote:
> > > > > What sort? Right now, it seems to go into a dead loop on
> > > > > fs/minix/itree_v1.c for me?!
> > > > >=20
> > > >=20
> > > > It's a problem introduced with 9/9 explicitly checking inlines.
> > >=20
> > > Cool, thanks, I'm just looking at it.
> >=20
> > You may want to look at this:
> > http://marc.info/?t=3D120287346100007&r=3D1&w=3D2
> > http://marc.info/?l=3Dlinux-sparse&m=3D120370800715845&w=3D2
> >=20
> > It was happening in ndiswrapper because a typedef was forcing an inline
> > function to be linearized twice.
>=20
> Ah, thanks for the pointers, that might be the case. Wonder why it's
> being linearized twice, and I see it even without the linearization I
> force...? will take a look tomorrow.

No, I'm just confused. That updated patch fixes it for me.

johannes

--=-r/YyCLMEHqaodRrcDXsO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD85IaVg1VMiehFYAQJqTBAAnAUX3Vri2UmkptmhQUc7A5CD8HC3wcqX
ZG129oLsynfW2+XZVPW9NhbSzDrCz4q8txZR/vNsMrMAdJWL8lMsZagYH6R+ob/L
qSZUGsj9yiWrl6cx6KWwy7GOc2PeqLLNmdv5R8/EuUQXHuUiYIw5jUI2KvmxLp+s
/LcpHw5M32tK/PcjmOCHtcJwWQb0TGNvlTIlNlfKe5OSeYS/s31G4G/yJOO5kYmq
63Q6DKNhnlKq94pHzkN/wHsBtcKQBBoqEsnM04HeAK8kExxsVRkm2JfnkuCtPgSU
1tT5l50XCvnjRuA0LJWu7+kYWzGmeASgWGfbqjqw0nEpXeesFoqNVAOX3RCnhcnu
+ffrxKdO1P3VaEPV6J2RUZzNsIC3sxNeAJstnwLapE5cJnyR2cPwymAR+4MQ9pi0
jDSvhDg6Nlkv/GG1v9vVBdcI1E+Zto1rIwx9EPMQ0cLo9+Owm9QAp6z+Ed30e4Zr
gZ9r5HmL7DXMnV0cp96tJ+tpi62mPoFzlgsqOQk/ViZgivCiVmBtsbXi35ebrOUn
A0QzYe1Mi+yojfEBuv7O3hJcKbjIYKwvh+rYKqPXnRVW4aRHPptlk/URyueUilsp
J3olYa2JN6QSHSf74Shw8IN3mJDL5pJ5iPZW68auid2f4/EoRSIg2hnUreCoMxNY
ytVhHl9ivPY=
=3MIu
-----END PGP SIGNATURE-----

--=-r/YyCLMEHqaodRrcDXsO--

