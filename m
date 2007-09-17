From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] fix install perms of manpages
Date: Mon, 17 Sep 2007 15:30:18 -0400
Message-ID: <200709171530.18669.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6242538.9hroGu3cAe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:41041 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069AbXIQTaU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Sep 2007 15:30:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 3835F65BE2
	for <linux-sparse@vger.kernel.org>; Mon, 17 Sep 2007 19:30:19 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--nextPart6242538.9hroGu3cAe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the install step for manpages currently does not use the -m option which means
perms default to 755 which makes no sense for man pages

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
diff --git a/Makefile b/Makefile
index 2475e12..bd5fb96 100644
--- a/Makefile
+++ b/Makefile
@@ -81,7 +81,7 @@ install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
 		$(QUIET_INST_SH)install -v $$f $(DESTDIR)$(BINDIR)/$$f || exit 1; \
 	done
 	$(Q)for f in $(INST_MAN1); do \
-		$(QUIET_INST_SH)install -v $$f $(DESTDIR)$(MAN1DIR)/$$f || exit 1; \
+		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(MAN1DIR)/$$f || exit 1; \
 	done
 	$(Q)for f in $(LIBS); do \
 		$(QUIET_INST_SH)install -m 644 -v $$f $(DESTDIR)$(LIBDIR)/$$f || exit 1; \

--nextPart6242538.9hroGu3cAe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUARu7VykFjO5/oN/WBAQKahQ/6AioejCEYvtapJI4WKA7sPM+OaP9LfI3V
fsSivEK40RY56eBDwALd1zFJYUP3YAiWKWEkfGhCU3REPFfdo2hhpkYApVK4bL0C
Ef5pUnX4gZVCLDM8fubdv15m0/hbt/7Q8Xeb2pUhfrFUVapz5ngPOrPuk/SH0tbB
0sLDpeU1sxbG5OQK3uJHATj/TI1aEWbAcNUpCAe4+pnfiuwM82XcxeEw5VrE8Fmk
SK38/UEay2aMzXlDqWh4+2kNugMgf5y5s4LV4/YQtwOB02+N1fpuAJpajRtdIwmm
o7NFGB3MAEOyyiBM2oxhMIvAykAdKk58q4ZDFlf/sMIYgO5oZCmc80ASSqd+9grf
fmdwJefMfY7BZ2roY1pBozOI5CLdOm0rMgarOuKxiBi0T3eXW2L5zI96Cd0w6BNV
ybA7qFF0MUI162kZH4tuXhiosMwv7KAC9KQ0WzwbuGHWk7/uzivN9L11/YlqqZ+L
3y0X6KN8wqd+NgD6Pyt/jttfM3s2wLlsuOUQeKi7p/XqWk23R9492O8HogM0/Fow
BZFvQizhwOCB08A+H04EYTxEwkZ0znEdWZyXkpqvGfwL0znxAqBh/lvXXxXITuzD
0sQ1mwRn4kWvhyljXUcyjYTeFQvsFMi8C4w2Vw6aCL9hzu4OC6M4XewkGHfq9PkR
XtBuAAU0iqg=
=35DO
-----END PGP SIGNATURE-----

--nextPart6242538.9hroGu3cAe--
