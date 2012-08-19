From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] sparse, llvm: convert the condition of branch/select to bool
Date: Sun, 19 Aug 2012 16:52:16 +0200
Message-ID: <1345387936-25817-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:37537 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752747Ab2HSOy3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 10:54:29 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

LLVM expects the first argument of "br" and "select" to be of type i1,
so add an "icmp ne <srcty> %src, 0" for other types.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c                 |   13 +++++++++++--
 validation/backend/int-cond.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 validation/backend/int-cond.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 213d42d..e4929e9 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -650,10 +650,19 @@ static void output_op_store(struct function *fn, =
struct instruction *insn)
 	insn->target->priv =3D target;
 }
=20
+static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value=
)
+{
+	if (LLVMTypeOf(value) !=3D LLVMInt1Type())
+		value =3D LLVMBuildIsNotNull(fn->builder, value, "cond");
+
+	return value;
+}
+
 static void output_op_br(struct function *fn, struct instruction *br)
 {
 	if (br->cond) {
-		LLVMValueRef cond =3D pseudo_to_value(fn, br, br->cond);
+		LLVMValueRef cond =3D bool_value(fn,
+				pseudo_to_value(fn, br, br->cond));
=20
 		LLVMBuildCondBr(fn->builder, cond,
 				br->bb_true->priv,
@@ -668,7 +677,7 @@ static void output_op_sel(struct function *fn, stru=
ct instruction *insn)
 {
 	LLVMValueRef target, src1, src2, src3;
=20
-	src1 =3D pseudo_to_value(fn, insn, insn->src1);
+	src1 =3D bool_value(fn, pseudo_to_value(fn, insn, insn->src1));
 	src2 =3D pseudo_to_value(fn, insn, insn->src2);
 	src3 =3D pseudo_to_value(fn, insn, insn->src3);
=20
diff --git a/validation/backend/int-cond.c b/validation/backend/int-con=
d.c
new file mode 100644
index 0000000..48b25a7
--- /dev/null
+++ b/validation/backend/int-cond.c
@@ -0,0 +1,30 @@
+static long foo(long a, long b, long c)
+{
+	return a? b:c;
+}
+
+static long foo_bool(_Bool a, long b, long c)
+{
+	return a? b:c;
+}
+
+static long bar(long a, long b, long c)
+{
+	if (a)
+		return b;
+	else
+		return b + c;
+}
+
+static long bar_bool(_Bool a, long b, long c)
+{
+	if (a)
+		return b;
+	else
+		return b + c;
+}
+
+/*
+ * check-name: Non-bool condition values in branch/select
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
