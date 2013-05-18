From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 3/4] sparse, llvm: base load/store address type on insn_symbol_type()
Date: Sat, 18 May 2013 19:52:06 +0200
Message-ID: <1368899527-2350-3-git-send-email-j.neuschaefer@gmx.net>
References: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:62433 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab3ERRwo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 13:52:44 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LfDle-1UAxvf1BdY-00omUq for
 <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 19:52:43 +0200
In-Reply-To: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xi Wang <xi.wang@gmail.com>

LLVM needs to be correctly told about the type of the object
being accessed.

This patch also fixes code generation for struct accesses.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 sparse-llvm.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8573eda..a8ebeab 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -600,7 +600,7 @@ static void output_op_ret(struct function *fn, stru=
ct instruction *insn)
=20
 static LLVMValueRef calc_memop_addr(struct function *fn, struct instru=
ction *insn)
 {
-	LLVMTypeRef int_type;
+	LLVMTypeRef int_type, addr_type;
 	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr;
=20
 	/* int type large enough to hold a pointer */
@@ -613,9 +613,10 @@ static LLVMValueRef calc_memop_addr(struct functio=
n *fn, struct instruction *ins
 	ofs_i =3D LLVMConstInt(int_type, insn->offset, 0);
 	addr_i =3D LLVMBuildAdd(fn->builder, src_i, ofs_i, "addr_i");
=20
+	addr_type =3D LLVMPointerType(insn_symbol_type(fn->module, insn), 0);
+
 	/* convert address back to pointer */
-	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
-				 LLVMTypeOf(src_p), "addr");
+	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i, addr_type, "addr");
=20
 	return addr;
 }
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
