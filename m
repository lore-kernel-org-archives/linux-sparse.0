From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/4] sparse, llvm: de-duplicate load/store address calculation code
Date: Sat, 18 May 2013 19:52:05 +0200
Message-ID: <1368899527-2350-2-git-send-email-j.neuschaefer@gmx.net>
References: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58937 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab3ERRwm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 13:52:42 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lg2yr-1UA8aB3gHD-00pav4 for
 <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 19:52:40 +0200
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
 sparse-llvm.c |   31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 837a96f..8573eda 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -598,10 +598,10 @@ static void output_op_ret(struct function *fn, st=
ruct instruction *insn)
 		LLVMBuildRetVoid(fn->builder);
 }
=20
-static void output_op_load(struct function *fn, struct instruction *in=
sn)
+static LLVMValueRef calc_memop_addr(struct function *fn, struct instru=
ction *insn)
 {
 	LLVMTypeRef int_type;
-	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr, target;
+	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr;
=20
 	/* int type large enough to hold a pointer */
 	int_type =3D LLVMIntType(bits_in_pointer);
@@ -617,6 +617,16 @@ static void output_op_load(struct function *fn, st=
ruct instruction *insn)
 	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
 				 LLVMTypeOf(src_p), "addr");
=20
+	return addr;
+}
+
+
+static void output_op_load(struct function *fn, struct instruction *in=
sn)
+{
+	LLVMValueRef addr, target;
+
+	addr =3D calc_memop_addr(fn, insn);
+
 	/* perform load */
 	target =3D LLVMBuildLoad(fn->builder, addr, "load_target");
=20
@@ -625,22 +635,9 @@ static void output_op_load(struct function *fn, st=
ruct instruction *insn)
=20
 static void output_op_store(struct function *fn, struct instruction *i=
nsn)
 {
-	LLVMTypeRef int_type;
-	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr, target, target_in;
-
-	/* int type large enough to hold a pointer */
-	int_type =3D LLVMIntType(bits_in_pointer);
-
-	/* convert to integer, add src + offset */
-	src_p =3D pseudo_to_value(fn, insn, insn->src);
-	src_i =3D LLVMBuildPtrToInt(fn->builder, src_p, int_type, "src_i");
+	LLVMValueRef addr, target, target_in;
=20
-	ofs_i =3D LLVMConstInt(int_type, insn->offset, 0);
-	addr_i =3D LLVMBuildAdd(fn->builder, src_i, ofs_i, "addr_i");
