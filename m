From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] fix a memory leak in compile-i386.c
Date: Tue,  9 Aug 2011 14:20:23 +0200
Message-ID: <1312892423-5178-1-git-send-email-j.neuschaefer@gmx.net>
References: <20110809115554.GH7659@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:46602 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752970Ab1HIMUn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Aug 2011 08:20:43 -0400
In-Reply-To: <20110809115554.GH7659@shale.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Don't allocate val twice in emit_divide.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 compile-i386.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index abe9313..da3ee49 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1302,7 +1302,6 @@ static struct storage *emit_divide(struct express=
ion *expr, struct storage *left
 	eax_edx =3D get_hardreg(hardreg_storage_table + EAX_EDX, 1);
=20
 	/* init EDX to 0 */
-	val =3D new_storage(STOR_VALUE);
 	val->flags =3D STOR_WANTS_FREE;
 	emit_move(val, REG_EDX, NULL, NULL);
=20
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
