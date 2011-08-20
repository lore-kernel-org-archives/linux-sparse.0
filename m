From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] FAQ: fix a typo ("because or")
Date: Sat, 20 Aug 2011 17:02:58 +0200
Message-ID: <1313852579-14468-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:45945 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752861Ab1HTPDI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 20 Aug 2011 11:03:08 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 FAQ |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/FAQ b/FAQ
index 3bfcb71..4cad826 100644
--- a/FAQ
+++ b/FAQ
@@ -5,7 +5,7 @@ Q.  Why not just use gcc?
 A.  Gcc is big, complex, and the gcc maintainers are not interested in
     other uses of the gcc front-end.  In fact, gcc has explicitly
     resisted splitting up the front and back ends and having some comm=
on
-    intermediate language because or religious license issues - you ca=
n
+    intermediate language because of religious license issues - you ca=
n
     have multiple front ends and back ends, but they all have to be pa=
rt
     of gcc and licensed under the GPL.=20
=20
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
