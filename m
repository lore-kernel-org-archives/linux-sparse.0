From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: context imbalance false positive sparse warnings
Date: Wed, 10 Sep 2008 09:47:11 +0200
Message-ID: <1221032831.12266.8.camel@johannes.berg>
References: <524f69650808191447o62a421c3n65f3938c9fc28dd7@mail.gmail.com>
	 <8cef9d540808191500n10fa910eo674c8b8f2dd5b612@mail.gmail.com>
	 <524f69650808191522r21fc4babqaf173c9df558afc1@mail.gmail.com>
	 <1219184769.17033.95.camel@brick> (sfid-20080820_002610_629541_77E70AA8)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HeyPaPgrJcGGC+Eka914"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:47141 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYIJHrS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 03:47:18 -0400
In-Reply-To: <1219184769.17033.95.camel@brick> (sfid-20080820_002610_629541_77E70AA8)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Stalin Kenny <stalinlinux@gmail.com>, linux-sparse@vger.kernel.org


--=-HeyPaPgrJcGGC+Eka914
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-08-19 at 15:26 -0700, Harvey Harrison wrote:
> On Tue, 2008-08-19 at 17:22 -0500, Steve French wrote:
> > On Tue, Aug 19, 2008 at 5:00 PM, Stalin Kenny <stalinlinux@gmail.com> w=
rote:
> > >> Even the simplest use cases throw this error e.g. fs/super.c line 16=
2-164:
> > >>
> > >> static void put_super(struct super_block *sb)
> > >> {
> > >>       spin_lock(&sb_lock);
> > >>       __put_super(sb);
> > >>       spin_unlock(&sb_lock);
> > >> }
> > >
> > > What is the sparse error when you call this function ?
> > CHECK   fs/super.c
> > fs/super.c:164:2: warning: context imbalance in 'put_super': wrong coun=
t at exit
> > fs/super.c:164:2:    context 'lock': wanted 0, got 1
> >=20
> >=20
>=20
> Johannes Berg had a 9-patch series that improved this somewhat, but they =
had
> some bugs in them (crashes).  But I've been running with them anyway as t=
hey
> do improve cases like this significantly.

I've just sent out a fixed version and with it I get no errors on
fs/super.c when I apply this small fixup:

diff --git a/fs/super.c b/fs/super.c
index e931ae9..6810845 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL(deactivate_super);
  *	success, 0 if we had failed (superblock contents was already dead or
  *	dying when grab_super() had been called).
  */
-static int grab_super(struct super_block *s) __releases(sb_lock)
+static int grab_super(struct super_block *s) __releases(&sb_lock)
 {
 	s->s_count++;
 	spin_unlock(&sb_lock);

johannes

--=-HeyPaPgrJcGGC+Eka914
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIx3t7AAoJEKVg1VMiehFYSKMP/0I+EvSTYrmnC9beBQ4MFEn1
F1LQttZ5AKuMPvjygJLlGeWj6XbVfWTMXeqcTpLutvgoZanmI7LP4Mnr4bdZ81sU
ekApB4wqf8DTTb4tIHoRkoxPOzuesLAM6KNl9YI9lC85LvIEa/Sa4ShSfsB4Qnr8
pnFU/lcegFXBHwfT60nJ4jkJpMdSXibYMIXhul5eJsP8LHYu7CscuUT9PFNsHTT0
X/SG6FR0W5NEudwO3/6Atu9WI2yIGfhWqH/o9ThqQmHeb28e8YQHNNwTPQp+HFfx
i4NiZW4ztNWGiLPxRgmS65FaW6VzL8ZoQEUSYJ2N8wAzz3/dvn+oLHV1ObqAXYNj
uVoNn32x0cXOjf94GQnf9dyVTgazFgER5U2zNa0Gp9XJigN+j70k9a2oDWI+4QL5
i5B9N+eeWi3qi5+XBg8s8XydTJeqck5mCWoKGHNTBu+c0QPZBxsmxgTWG5idOqXO
stGXO/PUpQGo3pczKS5MCDwnu3NqIvM4M5ivMcWRrmewcQRr1aTn2xNoRk4tCPa4
7JoYgwNNJ87vwe1qMpDAy9dKke1AuD72lOuIX+EuJkjJtcl9+VvXw4kZSWf7H7Vj
taicUL+NuKydpkHZ3OAug2mxNFaU02ySZJmDtsmOa7o7eUZaH/KWByBfkZSaSEh5
tsy4JuFBW5xxjOtBw+/P
=6rRF
-----END PGP SIGNATURE-----

--=-HeyPaPgrJcGGC+Eka914--

