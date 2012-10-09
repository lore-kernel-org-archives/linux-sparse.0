From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Wed, 10 Oct 2012 01:34:35 +0200
Message-ID: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:59004 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751335Ab2JIXfK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 19:35:10 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This is required for producing valid LLVM bitcode.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c              |   17 ++++++++++++++++-
 validation/backend/loop2.c |   13 +++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/loop2.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 0fc0dae..2048a1b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1111,16 +1111,31 @@ static void output_insn(struct function *fn, st=
ruct instruction *insn)
 static void output_bb(struct function *fn, struct basic_block *bb, uns=
igned long generation)
 {
 	struct instruction *insn;
+	struct instruction_list *remaining =3D NULL;
=20
 	bb->generation =3D generation;
=20
+	/*
+	 * LLVM requires the phi instructions to be grouped at the top of eac=
h
+	 * basic block.
+	 */
+
 	FOR_EACH_PTR(bb->insns, insn) {
 		if (!insn->bb)
 			continue;
=20
-		output_insn(fn, insn);
+		if (insn->opcode =3D=3D OP_PHI)
+			output_insn(fn, insn);
+		else
+			add_instruction(&remaining, insn);
 	}
 	END_FOR_EACH_PTR(insn);
+
+	FOR_EACH_PTR(remaining, insn) {
+		output_insn(fn, insn);
+	} END_FOR_EACH_PTR(insn);
+
+	free_ptr_list(&remaining);
 }
=20
 #define MAX_ARGS	64
diff --git a/validation/backend/loop2.c b/validation/backend/loop2.c
new file mode 100644
index 0000000..4e44a15
--- /dev/null
+++ b/validation/backend/loop2.c
@@ -0,0 +1,13 @@
+extern int op(void);
+
+static void test(void) {
+	int i;
+	for (i =3D 0; ; i++) {
+		op();
+	}
+}
+
+/*
+ * check-name: Loops with unused counter
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
