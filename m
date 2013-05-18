From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 4/4] sparse, llvm: add a struct access test case
Date: Sat, 18 May 2013 19:52:07 +0200
Message-ID: <1368899527-2350-4-git-send-email-j.neuschaefer@gmx.net>
References: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:64688 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab3ERRwq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 13:52:46 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0M3PXK-1UM5rp0Qoy-00r1wY for
 <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 19:52:45 +0200
In-Reply-To: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xi Wang <xi.wang@gmail.com>

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 validation/backend/struct-access.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 validation/backend/struct-access.c

diff --git a/validation/backend/struct-access.c b/validation/backend/st=
ruct-access.c
new file mode 100644
index 0000000..884b470
--- /dev/null
+++ b/validation/backend/struct-access.c
@@ -0,0 +1,28 @@
+struct st {
+	int i, *d;
+};
+
+static int load_i(struct st *st)
+{
+	return st->i;
+}
+
+static void store_i(struct st *st, int i)
+{
+	st->i =3D i;
+}
+
+static int *load_d(struct st *st)
+{
+	return st->d;
+}
+
+static void store_d(struct st *st, int *d)
+{
+	st->d =3D d;
+}
+
+/*
+ * check-name: struct access code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
