From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] unssa: track use of newly added pseudo
Date: Thu, 03 May 2012 16:59:11 +0200
Message-ID: <4FA29D3F.3000905@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep22.mx.upcmail.net ([62.179.121.42]:49015 "EHLO
	fep22.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab2ECPPi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2012 11:15:38 -0400
Received: from edge04.upcmail.net ([192.168.13.239])
          by viefep14-int.chello.at
          (InterMail vM.8.01.05.04 201-2260-151-105-20111014) with ESMTP
          id <20120503145910.TSLP8105.viefep14-int.chello.at@edge04.upcmail.net>
          for <linux-sparse@vger.kernel.org>;
          Thu, 3 May 2012 16:59:10 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Currently, it is a completely "isolated island" from backend
point of view as it also lacks pseudo->def information.

Signed-off-by: Jan Pokorn=FD <pokorny_jan@seznam.cz>
---
 unssa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unssa.c b/unssa.c
index 3eea9b2..382095d 100644
--- a/unssa.c
+++ b/unssa.c
@@ -55,7 +55,7 @@ static void replace_phi_node(struct instruction *phi)
 	track_phi_uses(phi);
=20
 	phi->opcode =3D OP_COPY;
-	phi->src =3D tmp;
+	use_pseudo(phi, tmp, &phi->src);
=20
 	// FIXME: free phi->phi_list;
 }
--=20
1.7.3.4
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
