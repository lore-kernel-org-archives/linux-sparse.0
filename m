From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] lib: rename die_if_error to error_happened
Date: Tue, 21 May 2013 18:49:04 +0200
Message-ID: <1369154944-11352-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:57104 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab3EUQuH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 12:50:07 -0400
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M3PbS-1UNALt0mrg-00qxZz for
 <linux-sparse@vger.kernel.org>; Tue, 21 May 2013 18:50:05 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Xi Wang <xi.wang@gmail.com>

The variable in question is set when an error message is output,
and doesn't control termination at all, so I think the new name
matches the semantics better.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
Updated version: rebase on Xi's patch "sparse, llvm: die if error".
---
 lib.c         |    4 ++--
 lib.h         |    2 +-
 sparse-llvm.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib.c b/lib.c
index 7e822eb..4ed08e0 100644
--- a/lib.c
+++ b/lib.c
@@ -30,7 +30,7 @@
 #include "version.h"
=20
 int verbose, optimize, optimize_size, preprocessing;
-int die_if_error =3D 0;
+int error_happened =3D 0;
=20
 #ifndef __GNUC__
 # define __GNUC__ 2
@@ -132,7 +132,7 @@ void warning(struct position pos, const char * fmt,=
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
index 5ab2bd9..67c6465 100644
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
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 7219290..6ab12ff 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1147,7 +1147,7 @@ int main(int argc, char **argv)
 	dbg_dead =3D 1;
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		symlist =3D sparse(file);
-		if (die_if_error)
+		if (error_happened)
 			return 1;
 		compile(module, symlist);
 	} END_FOR_EACH_PTR_NOTAG(file);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
