From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] sparse, llvm: fix phi generation
Date: Thu, 16 May 2013 02:33:46 -0400
Message-ID: <1368686026-10206-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58084 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab3EPGf5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 May 2013 02:35:57 -0400
Received: by mail-vb0-f46.google.com with SMTP id 10so1127426vbe.33
        for <linux-sparse@vger.kernel.org>; Wed, 15 May 2013 23:35:56 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

PHI in LLVM is different from that in sparse.  LLVM requires PHI "for
each predecessor basic block of the current block" even if the current
block doesn't use it.  It's tricky to correctly place PHI.

This patch implements a simpler and safer strategy:
1) allocate an alloca for each phi, and
2) translate phi/phisrc to load/store alloca.
LLVM optimizations will promote load/store to registers.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
See also
https://patchwork.kernel.org/patch/1571821/
---
 sparse-llvm.c              | 131 ++++++++++++++-----------------------=
--------
 validation/backend/loop2.c |  14 +++++
 2 files changed, 54 insertions(+), 91 deletions(-)
 create mode 100644 validation/backend/loop2.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6f2fbd6..81ac764 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -18,21 +18,11 @@
 #include "linearize.h"
 #include "flow.h"
=20
-struct phi_fwd {
-	struct phi_fwd			*next;
-
-	LLVMValueRef			phi;
-	pseudo_t			pseudo;
-	bool				resolved;
-};
-
 struct function {
 	LLVMBuilderRef			builder;
 	LLVMTypeRef			type;
 	LLVMValueRef			fn;
 	LLVMModuleRef			module;
-
-	struct phi_fwd			*fwd_list;
 };
=20
 static inline bool symbol_is_fp_type(struct symbol *sym)
@@ -839,100 +829,39 @@ static void output_op_call(struct function *fn, =
struct instruction *insn)
 	insn->target->priv =3D target;
 }
=20
-static void store_phi_fwd(struct function *fn, LLVMValueRef phi,
-			  pseudo_t pseudo)
-{
-	struct phi_fwd *fwd;
-
-	fwd =3D calloc(1, sizeof(*fwd));
-	fwd->phi =3D phi;
-	fwd->pseudo =3D pseudo;
-
-	/* append fwd ref to function-wide list */
-	if (!fn->fwd_list)
-		fn->fwd_list =3D fwd;
-	else {
-		struct phi_fwd *last =3D fn->fwd_list;
-
-		while (last->next)
-			last =3D last->next;
-		last->next =3D fwd;
-	}
-}
-
-static void output_phi_fwd(struct function *fn, pseudo_t pseudo, LLVMV=
alueRef v)
-{
-	struct phi_fwd *fwd =3D fn->fwd_list;
-
-	while (fwd) {
-		struct phi_fwd *tmp;
-
-		tmp =3D fwd;
-		fwd =3D fwd->next;
-
-		if (tmp->pseudo =3D=3D pseudo && !tmp->resolved) {
-			LLVMValueRef phi_vals[1];
-			LLVMBasicBlockRef phi_blks[1];
-
-			phi_vals[0] =3D v;
-			phi_blks[0] =3D pseudo->def->bb->priv;
-
-			LLVMAddIncoming(tmp->phi, phi_vals, phi_blks, 1);
-
-			tmp->resolved =3D true;
-		}
-	}
-}
-
 static void output_op_phisrc(struct function *fn, struct instruction *=
insn)
 {
 	LLVMValueRef v;
+	struct instruction *phi;
=20
 	assert(insn->target->priv =3D=3D NULL);
=20
 	/* target =3D src */
 	v =3D pseudo_to_value(fn, insn, insn->phi_src);
-	insn->target->priv =3D v;
=20
-	assert(insn->target->priv !=3D NULL);
+	FOR_EACH_PTR(insn->phi_users, phi) {
+		LLVMValueRef load, ptr;
=20
-	/* resolve forward references to this phi source, if present */
-	output_phi_fwd(fn, insn->target, v);
+		assert(phi->opcode =3D=3D OP_PHI);
+		/* phi must be load from alloca */
+		load =3D phi->target->priv;
+		assert(LLVMGetInstructionOpcode(load) =3D=3D LLVMLoad);
+		ptr =3D LLVMGetOperand(load, 0);
+		/* store v to alloca */
+		LLVMBuildStore(fn->builder, v, ptr);
+	} END_FOR_EACH_PTR(phi);
 }
=20
 static void output_op_phi(struct function *fn, struct instruction *ins=
n)
 {
-	pseudo_t phi;
-	LLVMValueRef target;
-
-	target =3D LLVMBuildPhi(fn->builder, insn_symbol_type(fn->module, ins=
n),
-				"phi");
-	int pll =3D 0;
-	FOR_EACH_PTR(insn->phi_list, phi) {
-		if (pseudo_to_value(fn, insn, phi))	/* skip VOID, fwd refs*/
-			pll++;
-	} END_FOR_EACH_PTR(phi);
-
-	LLVMValueRef *phi_vals =3D calloc(pll, sizeof(LLVMValueRef));
-	LLVMBasicBlockRef *phi_blks =3D calloc(pll, sizeof(LLVMBasicBlockRef)=
);
-
-	int idx =3D 0;
-	FOR_EACH_PTR(insn->phi_list, phi) {
-		LLVMValueRef v;
-
-		v =3D pseudo_to_value(fn, insn, phi);
-		if (v) {			/* skip VOID, fwd refs */
-			phi_vals[idx] =3D v;
-			phi_blks[idx] =3D phi->def->bb->priv;
-			idx++;
-		}
-		else if (phi->type =3D=3D PSEUDO_PHI)	/* fwd ref */
-			store_phi_fwd(fn, target, phi);
-	} END_FOR_EACH_PTR(phi);
-
-	LLVMAddIncoming(target, phi_vals, phi_blks, pll);
-
-	insn->target->priv =3D target;
+	LLVMValueRef load =3D insn->target->priv;
+
+	/* forward load */
+	assert(LLVMGetInstructionOpcode(load) =3D=3D LLVMLoad);
+	/* forward load has no parent block */
+	assert(!LLVMGetInstructionParent(load));
+	/* finalize load in current block  */
+	LLVMInsertIntoBuilder(fn->builder, load);
 }
=20
 static void output_op_ptrcast(struct function *fn, struct instruction =
*insn)
@@ -1095,7 +1024,6 @@ static void output_insn(struct function *fn, stru=
ct instruction *insn)
 		assert(0);
 		break;
 	case OP_DEATHNOTE:
-		assert(0);
 		break;
 	case OP_ASM:
 		assert(0);
@@ -1174,11 +1102,30 @@ static void output_fn(LLVMModuleRef module, str=
uct entrypoint *ep)
=20
 		LLVMBasicBlockRef bbr;
 		char bbname[32];
+		struct instruction *insn;
=20
 		sprintf(bbname, "L%d", nr_bb++);
 		bbr =3D LLVMAppendBasicBlock(function.fn, bbname);
=20
 		bb->priv =3D bbr;
+
+		/* allocate alloca for each phi */
+		FOR_EACH_PTR(bb->insns, insn) {
+			LLVMBasicBlockRef entrybbr;
+			LLVMTypeRef phi_type;
+			LLVMValueRef ptr;
+
+			if (!insn->bb || insn->opcode !=3D OP_PHI)
+				continue;
+			/* insert alloca into entry block */
+			entrybbr =3D LLVMGetEntryBasicBlock(function.fn);
+			LLVMPositionBuilderAtEnd(function.builder, entrybbr);
+			phi_type =3D insn_symbol_type(module, insn);
+			ptr =3D LLVMBuildAlloca(function.builder, phi_type, "");
+			/* emit forward load for phi */
+			LLVMClearInsertionPosition(function.builder);
+			insn->target->priv =3D LLVMBuildLoad(function.builder, ptr, "phi");
+		} END_FOR_EACH_PTR(insn);
 	}
 	END_FOR_EACH_PTR(bb);
=20
@@ -1267,6 +1214,8 @@ int main(int argc, char **argv)
=20
 	compile(module, sparse_initialize(argc, argv, &filelist));
=20
+	/* need ->phi_users */
+	dbg_dead =3D 1;
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		compile(module, sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
diff --git a/validation/backend/loop2.c b/validation/backend/loop2.c
new file mode 100644
index 0000000..279af21
--- /dev/null
+++ b/validation/backend/loop2.c
@@ -0,0 +1,14 @@
+extern int op(void);
+
+static void test(void)
+{
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
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
