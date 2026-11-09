Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256421;
	b=IyqL6aXKe71ClUpt64RN6I9oQKquBmCrva2KxbXyp0wAqA5VmAfuCwPECDKNCIPY4PgK
	 aRExCnjS+OnA8XCHz6oFmMtjeEKvAEJsGnZaZfQKvoOImhCWMv+rsKJXtpoSFos0IYIWx
	 n5cqSbGHgsoPwOaTojc3jkkQhKT9Q+Koz2seEUYnKuqKWDW8NR0Q1PrUNQGC+yiz72Fi8
	 ykHgSfQpO9DnXAjAxklR03DeuXwkanGKoHVwh/30lbFKNtm7H8pOqVb9ePlowRJHOrfj8
	 Uc87/vsDaTMEElrlxrX7Djy66CmnPxyCjuAo3ocQva+71kNfscipeCDZkXsxJSD5Ekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rrSE5y5paJhnedVZGmaXfQLTImk2YDKs5kwjDL0BYCE=;
	b=afi3ogLj6oSzRCxdcXj181HdgwED+u9PdChpNHjtNe3gpuMzZLjaCcldzTzebmT1mPfh
	 0DVrM/3Dazw6FWVyHehI4BVItfmoUUXOGPwozfOSOMIfJwPoH2WW/IOr9ehZsDCa6tCKN
	 IHWG5+GJ+XiZ0d+nVh0vwvJRAJO98y+sXxODGATTY/SnegbOeC6Dyan0tAgRSXI5IeLRR
	 KOM5H8btE3poDQlB04nG6rMALY3jIVXWYjVC2MzoulPy4TJOu/UfIalueZFP3Fa0sUal6
	 yDX3S6SzrdNxBNOjE83Ex42RjIU+AdjVTu4s7j7yjUcBb2D7RZo4XZy9NnVjYaWRRAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Ek98STXr;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CC606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A33CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Ek98STXr
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM56c5bz1XMFx6;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=rrSE5
	y5paJhnedVZGmaXfQLTImk2YDKs5kwjDL0BYCE=; b=Ek98STXrVzgWieqwvqeQB
	svhqhnwQLfAFXG5XgJLx1LhVbgbknnk1IgEKnrA7nKd3H6NochtChm7OG71Yq/lV
	egJkjyYE+jeEVTIxCKLbJZ08k0J4tY11B7qvVSud+uI/CZeHDjqGmENzrxHrjZUB
	xqaYaYIaqTX11B5GoOzCNwh2Ma4Oj3jlU5W0nJ6ANemqxsmsrYa04+NDpqXSXWSr
	LhKh0VinQBwjuvf0UVMdesa9OWXEx3CwQkaqoWB+syh/BapBT5ynb8NQfp/BmnnF
	WIv0yXf6x9pMBlx50lukMoVEsiLrXAb3oEUbu3So0bAAh5PWNQKTiaVEG8psGxYI
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xUEiMlxPF6bd; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLy2Srrz1XM0nj;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 27/73] sparse-llvm: Support arbitrary struct member counts and fix operand types
Date: Mon,  9 Nov 2026 12:32:13 -0800
Message-ID: <20261109203259.362845-28-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
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

Fix LLVM IR generation crashes and limits in sparse-llvm.c:
- Dynamically allocate elem_types in sym_struct_type() instead of asserti=
ng
  at 64 members, and handle zero-sized array element types in
  sym_array_type().
- Pass instruction operand types instead of NULL to pseudo_to_value() in
  output_op_compare(), output_op_cbr(), and output_op_sel().
- Read val->label_symbol instead of val->symbol for EXPR_LABEL in
  output_op_setval().
- Add a regression test in validation/backend/struct-large-members.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 sparse-llvm.c                             | 23 +++----
 validation/backend/struct-large-members.c | 83 +++++++++++++++++++++++
 2 files changed, 92 insertions(+), 14 deletions(-)
 create mode 100644 validation/backend/struct-large-members.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c422a13ce2a8..8f37bde1b98d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -86,21 +86,17 @@ static LLVMTypeRef sym_array_type(struct symbol *sym)
 	struct symbol *base_type;
=20
 	base_type =3D sym->ctype.base_type;
-	/* empty struct is undefined [6.7.2.1(8)] */
-	assert(base_type->bit_size > 0);
-
 	elem_type =3D symbol_type(base_type);
 	if (!elem_type)
 		return NULL;
=20
-	return LLVMArrayType(elem_type, sym->bit_size / base_type->bit_size);
+	return LLVMArrayType(elem_type, base_type->bit_size > 0 ? sym->bit_size=
 / base_type->bit_size : 0);
 }
=20
-#define MAX_STRUCT_MEMBERS 64
-
 static LLVMTypeRef sym_struct_type(struct symbol *sym)
 {
-	LLVMTypeRef elem_types[MAX_STRUCT_MEMBERS];
+	unsigned n_memb =3D symbol_list_size(sym->symbol_list);
+	LLVMTypeRef *elem_types =3D calloc(n_memb, sizeof(LLVMTypeRef));
 	struct symbol *member;
 	char buffer[256];
 	LLVMTypeRef ret;
@@ -114,14 +110,13 @@ static LLVMTypeRef sym_struct_type(struct symbol *s=
ym)
 	FOR_EACH_PTR(sym->symbol_list, member) {
 		LLVMTypeRef member_type;
=20
-		assert(nr < MAX_STRUCT_MEMBERS);
-
 		member_type =3D symbol_type(member);
=20
 		elem_types[nr++] =3D member_type;=20
 	} END_FOR_EACH_PTR(member);
=20
 	LLVMStructSetBody(ret, elem_types, nr, 0 /* packed? */);=20
+	free(elem_types);
 	return ret;
 }
=20
@@ -663,11 +658,11 @@ static void output_op_compare(struct function *fn, =
struct instruction *insn)
 	LLVMValueRef lhs, rhs, target;
 	char target_name[64];
=20
-	lhs =3D pseudo_to_value(fn, NULL, insn->src1);
+	lhs =3D pseudo_to_value(fn, insn->itype, insn->src1);
 	if (insn->src2->type =3D=3D PSEUDO_VAL)
 		rhs =3D constant_value(insn->src2->value, LLVMTypeOf(lhs));
 	else
-		rhs =3D pseudo_to_value(fn, NULL, insn->src2);
+		rhs =3D pseudo_to_value(fn, insn->itype, insn->src2);
 	if (!rhs)
 		rhs =3D LLVMGetUndef(symbol_type(insn->type));
=20
@@ -785,7 +780,7 @@ static LLVMValueRef bool_value(struct function *fn, L=
LVMValueRef value)
 static void output_op_cbr(struct function *fn, struct instruction *br)
 {
 	LLVMValueRef cond =3D bool_value(fn,
-			pseudo_to_value(fn, NULL, br->cond));
+			pseudo_to_value(fn, br->type ? br->type : &int_ctype, br->cond));
=20
 	LLVMBuildCondBr(fn->builder, cond,
 			br->bb_true->priv,
@@ -802,7 +797,7 @@ static void output_op_sel(struct function *fn, struct=
 instruction *insn)
 	LLVMValueRef target, src1, src2, src3;
 	char name[MAX_PSEUDO_NAME];
=20
-	src1 =3D bool_value(fn, pseudo_to_value(fn, NULL, insn->src1));
+	src1 =3D bool_value(fn, pseudo_to_value(fn, insn->itype ? insn->itype :=
 insn->type, insn->src1));
 	src2 =3D get_operand(fn, insn->type, insn->src2);
 	src3 =3D get_operand(fn, insn->type, insn->src3);
=20
@@ -1001,7 +996,7 @@ static void output_op_setval(struct function *fn, st=
ruct instruction *insn)
=20
 	switch (val->type) {
 	case EXPR_LABEL:
-		target =3D LLVMBlockAddress(fn->fn, val->symbol->bb_target->priv);
+		target =3D LLVMBlockAddress(fn->fn, val->label_symbol->bb_target->priv=
);
 		break;
 	default:
 		assert(0);
diff --git a/validation/backend/struct-large-members.c b/validation/backe=
nd/struct-large-members.c
new file mode 100644
index 000000000000..65f382194d5d
--- /dev/null
+++ b/validation/backend/struct-large-members.c
@@ -0,0 +1,83 @@
+struct big_struct {
+	int f0;
+	int f1;
+	int f2;
+	int f3;
+	int f4;
+	int f5;
+	int f6;
+	int f7;
+	int f8;
+	int f9;
+	int f10;
+	int f11;
+	int f12;
+	int f13;
+	int f14;
+	int f15;
+	int f16;
+	int f17;
+	int f18;
+	int f19;
+	int f20;
+	int f21;
+	int f22;
+	int f23;
+	int f24;
+	int f25;
+	int f26;
+	int f27;
+	int f28;
+	int f29;
+	int f30;
+	int f31;
+	int f32;
+	int f33;
+	int f34;
+	int f35;
+	int f36;
+	int f37;
+	int f38;
+	int f39;
+	int f40;
+	int f41;
+	int f42;
+	int f43;
+	int f44;
+	int f45;
+	int f46;
+	int f47;
+	int f48;
+	int f49;
+	int f50;
+	int f51;
+	int f52;
+	int f53;
+	int f54;
+	int f55;
+	int f56;
+	int f57;
+	int f58;
+	int f59;
+	int f60;
+	int f61;
+	int f62;
+	int f63;
+	int f64;
+	int f65;
+	int f66;
+	int f67;
+	int f68;
+	int f69;
+};
+
+static struct big_struct s;
+static int get_f69(void)
+{
+	return s.f69;
+}
+
+/*
+ * check-name: struct-large-members
+ * check-command: sparsec -c $file -o tmp.o
+ */
