Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432618;
	b=1xbcZaasYmLk/Ty1MhBMNhidKDjE5RqT/gptWyTLVTuKFJNioKdphG72d8LGgOcQ4F35
	 KzuHRgFQBffbbUT2Z33SqaXYclGCBPLi8tebwYUxG34zmcauBt7mtFxZeDbkPWCaW+qyO
	 4W3wiqTJ9HhZsAYlF9k2H0I4pcPhUFjSH8Lul/QvvXno65IeKInWmZI6zRF++KMqBrGyB
	 gKB/VRnPn3IgdVTsyZO8edLgOMFcF4xiLMqe9peuYkkDJ2/XehFdmngpuHaEGrncxEFeI
	 WJ/Jx/AukfhzUDkQ8CEBj2G1RgnWLvgljeWWfgFNpzX/pFGVPon3LrsUV827THmyyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jp98lNPVWUzBRpzcOfQAOOKfwjsNxudkkjUZ8h6tbJQ=;
	b=DsDru2PuyvgO06jIOXWRvy/2CLnL4WSP73n2qInzQid/OJCakYVZKlZE8gDWzTAnQlsP
	 yN+QkO+C3DefGJf7BAUqY7ml4IG7tMO3NXR2mZsopHijC00sdOwCmbhtbviWFXhNcb/l5
	 ChI5FxevxAOZz9aqmIxczF9UTHEYfNefvfYhTfDl533IUFD/cq+eyxD24HiWo56Ie5Ij0
	 twy30mUorPgcxytVB170Setg5dbwOnuL/G6qKH0FS5buG/ep8VhvC5HpEDJ1IYkxueqvd
	 CH59cLDcDQrUxx9hCP5bcjB3zGaWQVZ4D/d9Yusl8nskiexyxUgqxtxtNyFwGQR3i8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=zJk0hY+n;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819A606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3819A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=zJk0hY+n
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jst1pfpz1XM6Hv;
	Mon, 19 Oct 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432607; x=1795024608; bh=jp98l
	NPVWUzBRpzcOfQAOOKfwjsNxudkkjUZ8h6tbJQ=; b=zJk0hY+nqRjDdXRMVdSoB
	Ibn/R7AgbjvRJtnIfSXc1QV90KtmgurnPnDHAvMPOkDalBXGc1EEwopnoTxGVs3R
	U/Zx0HXdMM7RkmYQ9OWvtxdTVHV1f4OEIH+WsXG0DEHEaUWfInrQ++jQqxtq7Yfz
	j5jrJ+dZA+8ycuHF8xn+XpQ+WdEafZZ7GXc8ycz+IWia7c82EfwCftg3NRJENX/R
	Dw0+E5A2CBQDqCzH0Po78gb2JhQKciBSILNiI91N8QkMI0jZSLjmduO1yrReiD0T
	oYsWNPxf2Moni36ooD5YZMp2E8tcjo0t24S6ryLhqMlkJ6XSUzmLm7BKqmpp4KK1
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DeMXeUNiigAd; Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsp5pQRz1XM30w;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 19/20] llvm: Use explicit LLVMContextRef instead of global context
Date: Mon, 19 Oct 2026 10:56:32 -0700
Message-ID: <20261019175633.415493-20-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create and dispose of an explicit LLVMContextRef using
LLVMContextCreate() and LLVMContextDispose(), and use the
LLVM*InContext() API variants for types and constants instead of relying
on the deprecated implicit global context.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse-llvm.c | 73 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 70e0ff6f58a4..facce6f745ff 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -26,6 +26,17 @@ struct function {
 	LLVMModuleRef			module;
 };
=20
+static LLVMContextRef context;
+
+static inline LLVMValueRef const_string(const char *str, size_t len)
+{
+#if LLVM_VERSION_MAJOR > 18
+	return LLVMConstStringInContext2(context, str, len, true);
+#else
+	return LLVMConstStringInContext(context, str, len, true);
+#endif
+}
+
 static LLVMTypeRef symbol_type(struct symbol *sym);
=20
 static LLVMTypeRef func_return_type(struct symbol *sym)
@@ -96,7 +107,7 @@ static LLVMTypeRef sym_struct_type(struct symbol *sym)
 	unsigned nr =3D 0;
=20
 	snprintf(buffer, sizeof(buffer), "struct.%s", sym->ident ? sym->ident->=
name : "anno");
-	ret =3D LLVMStructCreateNamed(LLVMGetGlobalContext(), buffer);
+	ret =3D LLVMStructCreateNamed(context, buffer);
 	/* set ->aux to avoid recursion */
 	sym->aux =3D ret;
=20
@@ -126,9 +137,9 @@ static LLVMTypeRef sym_union_type(struct symbol *sym)
 	 */
 	union_size =3D sym->bit_size / 8;
=20
-	elements =3D LLVMArrayType(LLVMInt8Type(), union_size);
+	elements =3D LLVMArrayType(LLVMInt8TypeInContext(context), union_size);
=20
-	return LLVMStructType(&elements, 1, 0 /* packed? */);
+	return LLVMStructTypeInContext(context, &elements, 1, 0 /* packed? */);
 }
=20
 static LLVMTypeRef sym_ptr_type(struct symbol *sym)
@@ -137,7 +148,7 @@ static LLVMTypeRef sym_ptr_type(struct symbol *sym)
=20
 	/* 'void *' is treated like 'char *' */
 	if (is_void_type(sym->ctype.base_type))
-		type =3D LLVMInt8Type();
+		type =3D LLVMInt8TypeInContext(context);
 	else
 		type =3D symbol_type(sym->ctype.base_type);
=20
@@ -151,13 +162,13 @@ static LLVMTypeRef sym_basetype_type(struct symbol =
*sym)
 	if (is_float_type(sym)) {
 		switch (sym->bit_size) {
 		case 32:
-			ret =3D LLVMFloatType();
+			ret =3D LLVMFloatTypeInContext(context);
 			break;
 		case 64:
-			ret =3D LLVMDoubleType();
+			ret =3D LLVMDoubleTypeInContext(context);
 			break;
 		case 80:
-			ret =3D LLVMX86FP80Type();
+			ret =3D LLVMX86FP80TypeInContext(context);
 			break;
 		default:
 			die("invalid bit size %d for type %d", sym->bit_size, sym->type);
@@ -166,22 +177,22 @@ static LLVMTypeRef sym_basetype_type(struct symbol =
*sym)
 	} else {
 		switch (sym->bit_size) {
 		case -1:
-			ret =3D LLVMVoidType();
+			ret =3D LLVMVoidTypeInContext(context);
 			break;
 		case 1:
-			ret =3D LLVMInt1Type();
+			ret =3D LLVMInt1TypeInContext(context);
 			break;
 		case 8:
-			ret =3D LLVMInt8Type();
+			ret =3D LLVMInt8TypeInContext(context);
 			break;
 		case 16:
-			ret =3D LLVMInt16Type();
+			ret =3D LLVMInt16TypeInContext(context);
 			break;
 		case 32:
-			ret =3D LLVMInt32Type();
+			ret =3D LLVMInt32TypeInContext(context);
 			break;
 		case 64:
-			ret =3D LLVMInt64Type();
+			ret =3D LLVMInt64TypeInContext(context);
 			break;
 		default:
 			die("invalid bit size %d for type %d", sym->bit_size, sym->type);
@@ -205,7 +216,7 @@ static LLVMTypeRef symbol_type(struct symbol *sym)
=20
 	switch (sym->type) {
 	case SYM_BITFIELD:
-		ret =3D LLVMIntType(sym->bit_size);
+		ret =3D LLVMIntTypeInContext(context, sym->bit_size);
 		break;
 	case SYM_RESTRICT:
 	case SYM_ENUM:
@@ -244,10 +255,10 @@ static LLVMTypeRef insn_symbol_type(struct instruct=
ion *insn)
 		return symbol_type(insn->type);
=20
 	switch (insn->size) {
-		case 8:		return LLVMInt8Type();
-		case 16:	return LLVMInt16Type();
-		case 32:	return LLVMInt32Type();
-		case 64:	return LLVMInt64Type();
+		case 8:		return LLVMInt8TypeInContext(context);
+		case 16:	return LLVMInt16TypeInContext(context);
+		case 32:	return LLVMInt32TypeInContext(context);
+		case 64:	return LLVMInt64TypeInContext(context);
=20
 		default:
 			die("invalid bit size %d", insn->size);
@@ -316,14 +327,14 @@ static LLVMValueRef get_sym_value(LLVMModuleRef mod=
ule, struct symbol *sym)
 			const char *s =3D expr->string->data;
 			size_t len =3D expr->string->length;
 #if LLVM_VERSION_MAJOR <=3D 14
-			LLVMValueRef indices[] =3D { LLVMConstInt(LLVMInt64Type(), 0, 0), LLV=
MConstInt(LLVMInt64Type(), 0, 0) };
+			LLVMValueRef indices[] =3D { LLVMConstInt(LLVMInt64TypeInContext(cont=
ext), 0, 0), LLVMConstInt(LLVMInt64TypeInContext(context), 0, 0) };
 #endif
 			LLVMValueRef data;
=20
-			data =3D LLVMAddGlobal(module, LLVMArrayType(LLVMInt8Type(), len), ".=
str");
+			data =3D LLVMAddGlobal(module, LLVMArrayType(LLVMInt8TypeInContext(co=
ntext), len), ".str");
 			LLVMSetLinkage(data, LLVMPrivateLinkage);
 			LLVMSetGlobalConstant(data, 1);
-			LLVMSetInitializer(data, LLVMConstString(s, len, true));
+			LLVMSetInitializer(data, const_string(s, len));
=20
 #if LLVM_VERSION_MAJOR > 14
 			result =3D data;
@@ -357,7 +368,7 @@ static LLVMValueRef constant_value(unsigned long long=
 val, LLVMTypeRef dtype)
 	switch (LLVMGetTypeKind(dtype)) {
 	case LLVMPointerTypeKind:
 		if (val !=3D 0) {	 // for example: ... =3D (void*) 0x123;
-			LLVMTypeRef itype =3D LLVMIntType(bits_in_pointer);
+			LLVMTypeRef itype =3D LLVMIntTypeInContext(context, bits_in_pointer);
 			result =3D LLVMConstInt(itype, val, 1);
 			result =3D LLVMConstIntToPtr(result, dtype);
 		} else {
@@ -443,7 +454,7 @@ static LLVMValueRef value_to_ivalue(struct function *=
fn, struct symbol *ctype, L
 	LLVMTypeRef dtype =3D symbol_type(ctype);
=20
 	if (LLVMGetTypeKind(LLVMTypeOf(val)) =3D=3D LLVMPointerTypeKind) {
-		LLVMTypeRef dtype =3D LLVMIntType(bits_in_pointer);
+		LLVMTypeRef dtype =3D LLVMIntTypeInContext(context, bits_in_pointer);
 		val =3D LLVMBuildPtrToInt(fn->builder, val, dtype, name);
 	}
 	if (ctype && is_int_type(ctype)) {
@@ -505,7 +516,7 @@ static LLVMValueRef calc_gep(LLVMBuilderRef builder, =
LLVMValueRef base, LLVMValu
 {
 	LLVMTypeRef type =3D LLVMTypeOf(base);
 	unsigned int as =3D LLVMGetPointerAddressSpace(type);
-	LLVMTypeRef bytep =3D LLVMPointerType(LLVMInt8Type(), as);
+	LLVMTypeRef bytep =3D LLVMPointerType(LLVMInt8TypeInContext(context), a=
s);
 	LLVMValueRef addr;
 	const char *name =3D LLVMGetValueName(off);
=20
@@ -718,7 +729,7 @@ static LLVMValueRef calc_memop_addr(struct function *=
fn, struct instruction *ins
 	unsigned int as;
=20
 	/* int type large enough to hold a pointer */
-	int_type =3D LLVMIntType(bits_in_pointer);
+	int_type =3D LLVMIntTypeInContext(context, bits_in_pointer);
 	off =3D LLVMConstInt(int_type, insn->offset, 0);
=20
 	/* convert src to the effective pointer type */
@@ -765,7 +776,7 @@ static void output_op_store(struct function *fn, stru=
ct instruction *insn)
=20
 static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
 {
-	if (LLVMTypeOf(value) !=3D LLVMInt1Type())
+	if (LLVMTypeOf(value) !=3D LLVMInt1TypeInContext(context))
 		value =3D LLVMBuildIsNotNull(fn->builder, value, LLVMGetValueName(valu=
e));
=20
 	return value;
@@ -1171,7 +1182,7 @@ static void output_fn(LLVMModuleRef module, struct =
entrypoint *ep)
 	LLVMSetFunctionCallConv(function.fn, LLVMCCallConv);
 	LLVMSetLinkage(function.fn, function_linkage(sym));
=20
-	function.builder =3D LLVMCreateBuilder();
+	function.builder =3D LLVMCreateBuilderInContext(context);
=20
 	/* give a name to each argument */
 	nr_args =3D symbol_list_size(base_type->arguments);
@@ -1191,7 +1202,7 @@ static void output_fn(LLVMModuleRef module, struct =
entrypoint *ep)
 		char bbname[32];
=20
 		sprintf(bbname, "L%d", nr_bb++);
-		bbr =3D LLVMAppendBasicBlock(function.fn, bbname);
+		bbr =3D LLVMAppendBasicBlockInContext(context, function.fn, bbname);
=20
 		bb->priv =3D bbr;
 	}
@@ -1259,7 +1270,7 @@ static LLVMValueRef output_data(LLVMModuleRef modul=
e, struct symbol *sym)
 			const char *s =3D initializer->string->data;
 			size_t len =3D initializer->string->length;
=20
-			initial_value =3D LLVMConstString(s, len, true);
+			initial_value =3D const_string(s, len);
 			break;
 		}
 		default:
@@ -1384,7 +1395,8 @@ int main(int argc, char **argv)
=20
 	symlist =3D sparse_initialize(argc, argv, &filelist);
=20
-	module =3D LLVMModuleCreateWithName("sparse");
+	context =3D LLVMContextCreate();
+	module =3D LLVMModuleCreateWithNameInContext("sparse", context);
 	set_target(module);
=20
 	compile(module, symlist);
@@ -1404,6 +1416,7 @@ int main(int argc, char **argv)
=20
 out:
 	LLVMDisposeModule(module);
+	LLVMContextDispose(context);
=20
 	report_stats();
 	return ret;
