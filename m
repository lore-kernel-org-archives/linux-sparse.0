From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/4] sparse, llvm: Fix resulting type of store address calculations
Date: Sat, 18 May 2013 19:52:04 +0200
Message-ID: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:50098 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab3ERRwl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 13:52:41 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lobhc-1U1eH70RsQ-00gUsm for
 <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 19:52:39 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xi Wang <xi.wang@gmail.com>

Use the fix from d5bd3662 ("sparse, llvm: Fix type of loaded values").

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c                   |    2 +-
 validation/backend/store-type.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/store-type.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6f2fbd6..837a96f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -640,7 +640,7 @@ static void output_op_store(struct function *fn, st=
ruct instruction *insn)
=20
 	/* convert address back to pointer */
 	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
-				 LLVMPointerType(int_type, 0), "addr");
+				 LLVMTypeOf(src_p), "addr");
=20
 	target_in =3D pseudo_to_value(fn, insn, insn->target);
=20
diff --git a/validation/backend/store-type.c b/validation/backend/store=
-type.c
new file mode 100644
index 0000000..9e2ce73
--- /dev/null
+++ b/validation/backend/store-type.c
@@ -0,0 +1,12 @@
+struct foo;
+static struct foo *var;
+
+static void set(struct foo *f)
+{
+       var =3D f;
+}
+
+/*
+ * check-name: Type of stored objects
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
