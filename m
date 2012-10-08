From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] lib: rename die_if_error to error_happened
Date: Tue,  9 Oct 2012 01:17:57 +0200
Message-ID: <1349738279-13253-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59886 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751148Ab2JHXSj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Oct 2012 19:18:39 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Mitesh Shah <mshah@teja.com>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

The variable in question is set when an error message is output,
and doesn't control termination at all, so I think the new name
matches the semantics better.

Cc: Mitesh Shah <mshah@teja.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 lib.c |    4 ++--
 lib.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index b4d3944..1172dc2 100644
--- a/lib.c
+++ b/lib.c
@@ -29,7 +29,7 @@
 #include "target.h"
=20
 int verbose, optimize, optimize_size, preprocessing;
-int die_if_error =3D 0;
+int error_happened =3D 0;
=20
 #ifndef __GNUC__
 # define __GNUC__ 2
@@ -131,7 +131,7 @@ void warning(struct position pos, const char * fmt,=
 ...)
 static void do_error(struct position pos, const char * fmt, va_list ar=
gs)
 {
 	static int errors =3D 0;
-        die_if_error =3D 1;
+	error_happened =3D 1;
 	show_info =3D 1;
 	/* Shut up warnings after an error */
 	max_warnings =3D 0;
diff --git a/lib.h b/lib.h
index 2cea252..7cde9c2 100644
--- a/lib.h
+++ b/lib.h
@@ -25,7 +25,7 @@
 #endif
=20
 extern int verbose, optimize, optimize_size, preprocessing;
-extern int die_if_error;
+extern int error_happened;
 extern int repeat_phase, merge_phi_sources;
 extern int gcc_major, gcc_minor, gcc_patchlevel;
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
