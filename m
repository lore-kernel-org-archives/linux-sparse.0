From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] sparse, llvm: Fix type of loaded values
Date: Wed, 10 Oct 2012 01:34:36 +0200
Message-ID: <1349825676-1713-2-git-send-email-j.neuschaefer@gmx.net>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59067 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751387Ab2JIXfL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 19:35:11 -0400
In-Reply-To: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Instead of making the computed address a pointer to an int type
large enough to hold a pointer, make it a pointer to the memory
object being loaded.  This fixes another LLVM warning.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c                  |    2 +-
 validation/backend/load-type.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/load-type.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 2048a1b..7f45dc0 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -615,7 +615,7 @@ static void output_op_load(struct function *fn, str=
uct instruction *insn)
=20
 	/* convert address back to pointer */
 	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
-				 LLVMPointerType(int_type, 0), "addr");
+				 LLVMTypeOf(src_p), "addr");
=20
 	/* perform load */
 	target =3D LLVMBuildLoad(fn->builder, addr, "load_target");
diff --git a/validation/backend/load-type.c b/validation/backend/load-t=
ype.c
new file mode 100644
index 0000000..80416ca
--- /dev/null
+++ b/validation/backend/load-type.c
@@ -0,0 +1,12 @@
+extern struct _IO_FILE *stdin;
+
+static void sub(struct _IO_FILE *in) {}
+
+static void test(void) {
+        sub(stdin);
+}
+
+/*
+ * check-name: Type of loaded objects
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
