From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 0/5] keyword driven parsing
Date: Wed, 07 Mar 2007 22:55:07 -0800
Message-ID: <45EFB34B.6030101@freedesktop.org>
References: <20070307100109.GA10577@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig252D306692A8E1D2C2964973"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:52913 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535AbXCHGzM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 01:55:12 -0500
In-Reply-To: <20070307100109.GA10577@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig252D306692A8E1D2C2964973
Content-Type: multipart/mixed;
 boundary="------------070109080502000806030206"

This is a multi-part message in MIME format.
--------------070109080502000806030206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Here is an attempt to use keyword driven parsing.
>=20
> The effect is that, we don't need to keep on adding keyword to
> ident-list any more.

Beautiful!  Looks far more elegant and maintainable; thanks.

I've applied the first four patches in this series.  The fifth causes a
regression in validation/context.c; see the attached diff of the output f=
rom
the fourth to the fifth patches.

- Josh Triplett


--------------070109080502000806030206
Content-Type: text/plain;
 name="sparse-validation-output.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="sparse-validation-output.diff"

--- sparse-validation-output-4	2007-03-07 22:06:53.000000000 -0800
+++ sparse-validation-output-5	2007-03-07 22:06:29.000000000 -0800
@@ -49,20 +49,40 @@
 validation/choose_expr.c:4:17: warning: division by zero
 validation/cond_expr.c:10:9: error: incompatible types for operation (~)=

 validation/cond_expr.c:10:9:    argument has type double=20
-validation/context.c:69:13: warning: context imbalance in 'warn_lock1' -=
 wrong count at exit
-validation/context.c:74:13: warning: context imbalance in 'warn_lock2' -=
 wrong count at exit
-validation/context.c:81:13: warning: context imbalance in 'warn_lock3' -=
 wrong count at exit
-validation/context.c:88:13: warning: context imbalance in 'warn_unlock1'=
 - unexpected unlock
+validation/context.c:3:13: warning: context imbalance in 'a' - wrong cou=
nt at exit
+validation/context.c:8:13: warning: context imbalance in 'r' - unexpecte=
d unlock
+validation/context.c:16:13: warning: context imbalance in 'good_paired1'=
 - unexpected unlock
+validation/context.c:22:13: warning: context imbalance in 'good_paired2'=
 - unexpected unlock
+validation/context.c:30:13: warning: context imbalance in 'good_paired3'=
 - unexpected unlock
+validation/context.c:43:13: warning: context imbalance in 'good_lock2' -=
 unexpected unlock
+validation/context.c:50:13: warning: context imbalance in 'good_lock3' -=
 unexpected unlock
+validation/context.c:62:13: warning: context imbalance in 'good_unlock2'=
 - unexpected unlock
+validation/context.c:69:13: warning: context imbalance in 'warn_lock1' -=
 unexpected unlock
+validation/context.c:74:13: warning: context imbalance in 'warn_lock2' -=
 unexpected unlock
+validation/context.c:81:13: warning: context imbalance in 'warn_lock3' -=
 unexpected unlock
 validation/context.c:93:13: warning: context imbalance in 'warn_unlock2'=
 - unexpected unlock
-validation/context.c:131:12: warning: context imbalance in 'warn_if1' - =
wrong count at exit
-validation/context.c:140:12: warning: context imbalance in 'warn_if2' - =
different lock contexts for basic block
-validation/context.c:202:2: warning: context imbalance in 'warn_while1' =
- different lock contexts for basic block
-validation/context.c:210:3: warning: context imbalance in 'warn_while2' =
- unexpected unlock
-validation/context.c:216:2: warning: context imbalance in 'warn_while3' =
- wrong count at exit
-validation/context.c:274:13: warning: context imbalance in 'warn_goto1' =
- wrong count at exit
-validation/context.c:283:13: warning: context imbalance in 'warn_goto2' =
- wrong count at exit
-validation/context.c:300:5: warning: context imbalance in 'warn_goto3' -=
 different lock contexts for basic block
-validation/context.c:315:5: warning: context imbalance in 'warn_cond_loc=
k1' - different lock contexts for basic block
+validation/context.c:102:12: warning: context imbalance in 'good_if1' - =
unexpected unlock
+validation/context.c:116:3: warning: context imbalance in 'good_if2' - u=
nexpected unlock
+validation/context.c:121:13: warning: context imbalance in 'good_if3' - =
unexpected unlock
+validation/context.c:131:12: warning: context imbalance in 'warn_if1' - =
unexpected unlock
+validation/context.c:140:12: warning: context imbalance in 'warn_if2' - =
unexpected unlock
+validation/context.c:150:13: warning: context imbalance in 'good_while1'=
 - unexpected unlock
+validation/context.c:161:3: warning: context imbalance in 'good_while2' =
- unexpected unlock
+validation/context.c:169:3: warning: context imbalance in 'good_while3' =
- unexpected unlock
+validation/context.c:178:13: warning: context imbalance in 'good_while4'=
 - unexpected unlock
+validation/context.c:189:13: warning: context imbalance in 'good_while5'=
 - unexpected unlock
+validation/context.c:203:3: warning: context imbalance in 'warn_while1' =
- unexpected unlock
+validation/context.c:217:3: warning: context imbalance in 'warn_while3' =
- unexpected unlock
+validation/context.c:224:13: warning: context imbalance in 'good_goto1' =
- unexpected unlock
+validation/context.c:232:13: warning: context imbalance in 'good_goto2' =
- unexpected unlock
+validation/context.c:242:13: warning: context imbalance in 'good_goto3' =
- unexpected unlock
+validation/context.c:257:5: warning: context imbalance in 'good_goto4' -=
 unexpected unlock
+validation/context.c:263:13: warning: context imbalance in 'good_goto5' =
- unexpected unlock
+validation/context.c:274:13: warning: context imbalance in 'warn_goto1' =
- unexpected unlock
+validation/context.c:283:13: warning: context imbalance in 'warn_goto2' =
- unexpected unlock
+validation/context.c:293:13: warning: context imbalance in 'warn_goto3' =
- unexpected unlock
+validation/context.c:305:5: warning: context imbalance in 'good_cond_loc=
k1' - wrong count at exit
+validation/context.c:315:5: warning: context imbalance in 'warn_cond_loc=
k1' - wrong count at exit
 /usr/include/features.h:265:5: warning: undefined preprocessor identifie=
r '_FORTIFY_SOURCE'
 /usr/include/string.h:420:6: warning: undefined preprocessor identifier =
'__USE_FORTIFY_LEVEL'
 validation/foul-bitwise.c:9:9: warning: restricted degrades to integer

--------------070109080502000806030206--

--------------enig252D306692A8E1D2C2964973
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF77NLGJuZRtD+evsRAiseAKCiz9RLScu1A6V0fTZPcwjkoHo6HwCfVrT0
MZ6WLx6JbZ0xSZwRQ8YJPwU=
=ZRTA
-----END PGP SIGNATURE-----

--------------enig252D306692A8E1D2C2964973--
