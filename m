From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 1/2] sparse, llvm: improve pointer arithmetic handling
Date: Sun, 19 May 2013 08:13:09 -0400
Message-ID: <1368965590-6714-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f181.google.com ([209.85.160.181]:46317 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3ESMOk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 08:14:40 -0400
Received: by mail-gh0-f181.google.com with SMTP id z12so1277096ghb.26
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 05:14:40 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>

Converting pointers to integers for pointer arithmetic effectively
disables pointer analysis and future optimizations.  A better way is to
use LLVM's GEP, by converting pointers to `char *' rather than integers=
=2E

Cc: Pekka Enberg <penberg@kernel.org>
Acked-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
calc_gep() may be useful for fixing array access as well.
---
 sparse-llvm.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 41e0ab7..02f43f7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -370,6 +370,22 @@ static LLVMValueRef pseudo_to_value(struct functio=
n *fn, struct instruction *ins
 	return result;
 }
=20
+static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base=
, LLVMValueRef off)
+{
+	LLVMTypeRef type =3D LLVMTypeOf(base);
+	unsigned int as =3D LLVMGetPointerAddressSpace(type);
+	LLVMTypeRef bytep =3D LLVMPointerType(LLVMInt8Type(), as);
+	LLVMValueRef addr;
+
+	/* convert base to char* type */
+	base =3D LLVMBuildPointerCast(builder, base, bytep, "");
+	/* addr =3D base + off */
+	addr =3D LLVMBuildInBoundsGEP(builder, base, &off, 1, "");
+	/* convert back to the actual pointer type */
+	addr =3D LLVMBuildPointerCast(builder, addr, type, "");
+	return addr;
+}
+
 static LLVMRealPredicate translate_fop(int opcode)
 {
 	static const LLVMRealPredicate trans_tbl[] =3D {
@@ -544,23 +560,21 @@ static void output_op_ret(struct function *fn, st=
ruct instruction *insn)
 static LLVMValueRef calc_memop_addr(struct function *fn, struct instru=
ction *insn)
 {
 	LLVMTypeRef int_type, addr_type;
-	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr;
+	LLVMValueRef src, off, addr;
+	unsigned int as;
=20
 	/* int type large enough to hold a pointer */
 	int_type =3D LLVMIntType(bits_in_pointer);
+	off =3D LLVMConstInt(int_type, insn->offset, 0);
=20
-	/* convert to integer, add src + offset */
-	src_p =3D pseudo_to_value(fn, insn, insn->src);
-	src_i =3D LLVMBuildPtrToInt(fn->builder, src_p, int_type, "src_i");
-
-	ofs_i =3D LLVMConstInt(int_type, insn->offset, 0);
-	addr_i =3D LLVMBuildAdd(fn->builder, src_i, ofs_i, "addr_i");
-
-	addr_type =3D LLVMPointerType(insn_symbol_type(fn->module, insn), 0);
