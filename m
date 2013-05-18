From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH 3/4] sparse, llvm: base load/store address type on insn_symbol_type()
Date: Sat, 18 May 2013 18:45:18 -0400
Message-ID: <5198047E.5000806@gmail.com>
References: <1368899527-2350-1-git-send-email-j.neuschaefer@gmx.net> <1368899527-2350-3-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f178.google.com ([209.85.160.178]:32916 "EHLO
	mail-gh0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab3ERWpV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 18:45:21 -0400
Received: by mail-gh0-f178.google.com with SMTP id g15so311588ghb.37
        for <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 15:45:20 -0700 (PDT)
In-Reply-To: <1368899527-2350-3-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 05/18/2013 01:52 PM, Jonathan Neusch=C3=A4fer wrote:
>   	/* convert address back to pointer */
> -	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
> -				 LLVMTypeOf(src_p), "addr");
> +	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i, addr_type, "addr");

Actually, we shouldn't convert pointers to integers in the first place.
This effectively disables pointer analysis and future optimizations.

A better way is to use LLVM's GEP for pointer arithmetic, by converting
pointers to `char *', rather than integers.

See more examples here:
http://www.spinics.net/lists/linux-sparse/msg02768.html

Jonathan, how about this version using `char *' based on your patchset?

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 00ace6e..a01c4b7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -541,24 +541,47 @@ static void output_op_ret(struct function *fn, st=
ruct instruction *insn)
 		LLVMBuildRetVoid(fn->builder);
 }
=20
-static void output_op_load(struct function *fn, struct instruction *in=
sn)
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
+	/* convert base back to the actual pointer type */
+	addr =3D LLVMBuildPointerCast(builder, addr, type, "");
+	return addr;
+}
+
+static LLVMValueRef calc_memop_addr(struct function *fn, struct instru=
ction *insn)
 {
-	LLVMTypeRef int_type;
-	LLVMValueRef src_p, src_i, ofs_i, addr_i, addr, target;
+	LLVMTypeRef addr_type, int_type;
+	LLVMValueRef src, base, off, addr;
+	unsigned int as;
+
+	src =3D pseudo_to_value(fn, insn, insn->src);
+	as =3D LLVMGetPointerAddressSpace(LLVMTypeOf(src));
+	addr_type =3D LLVMPointerType(insn_symbol_type(fn->module, insn), as)=
;
+	base =3D LLVMBuildPointerCast(fn->builder, src, addr_type, "");
=20
 	/* int type large enough to hold a pointer */
 	int_type =3D LLVMIntType(bits_in_pointer);
+	off =3D LLVMConstInt(int_type, insn->offset, 0);
+
+	addr =3D calc_gep(fn->builder, base, off);
+	return addr;
+}
=20
-	/* convert to integer, add src + offset */
-	src_p =3D pseudo_to_value(fn, insn, insn->src);
-	src_i =3D LLVMBuildPtrToInt(fn->builder, src_p, int_type, "src_i");
=20
-	ofs_i =3D LLVMConstInt(int_type, insn->offset, 0);
-	addr_i =3D LLVMBuildAdd(fn->builder, src_i, ofs_i, "addr_i");
+static void output_op_load(struct function *fn, struct instruction *in=
sn)
+{
+	LLVMValueRef addr, target;
=20
-	/* convert address back to pointer */
-	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
-				 LLVMTypeOf(src_p), "addr");
+	addr =3D calc_memop_addr(fn, insn);
=20
 	/* perform load */
 	target =3D LLVMBuildLoad(fn->builder, addr, "load_target");
@@ -568,22 +591,9 @@ static void output_op_load(struct function *fn, st=
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
-
-	ofs_i =3D LLVMConstInt(int_type, insn->offset, 0);
-	addr_i =3D LLVMBuildAdd(fn->builder, src_i, ofs_i, "addr_i");
+	LLVMValueRef addr, target, target_in;
=20
-	/* convert address back to pointer */
-	addr =3D LLVMBuildIntToPtr(fn->builder, addr_i,
-				 LLVMPointerType(int_type, 0), "addr");
+	addr =3D calc_memop_addr(fn, insn);
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
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
