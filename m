Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256433;
	b=vVl527p/a+Miyfq8/3+51c76hdQ8dg68HTRhz1dWt/NfF8WzQe6olabXPUKrgcplm7ad
	 su2CTFqsgu8dspvzPgcLv2HMs6fZg/KdL0Ug2reKTD25unPN8wZXTplTSRMVMbSSBqLKo
	 L5OzOhGk6m2m3SkqxIhIRcJkgtwUpTiB1nezjvH01KVtFK624XrCtRSWwD5UBMF788eb+
	 KI7m5dnBk3XeVCPw4ql9gBm+PwQJgCpdGJustXkR3Z5I0u87mGy4IIzgiBZDz0/FAOjWL
	 bhkqYyIARZSNHrNgo3ifW/BoUtYpUZzJo8vl0nWisIdHNoIvwY784SgBBbz5SzK38Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=vodV/bpT8NhZ1bz2GXrf7lHRrHnOCFWm7KGm38tCy1I=;
	b=XRwS/kiq66drxNnAxsYAaBqrkXp89Wzkv+k3Kb918/NbfOouDSwqCwSereRTvO6x9VsZ
	 m0V5Ft6N380BwsFxCjlThmCjO7++utYgt54WqC40kOG5kRV7KM3o+Qq8pI0UnDItDDxPd
	 ASXjhkoJ3en2Em4jdY9Be5FFUf5MweUGO9S4GA3SBgUTv7frWDCqcIV0ymIF3YtqBCGMV
	 oPwACrCmZFib9vx4kyRKLBGjLJ0ObEvvJVsXgNQ+9avF5hlAD2oOIpasU/NxjzyV8LTb4
	 QHWxhc/6TYjtmFNGbYkXtZt+tx4Xe39xIWTNDcnWCwvcx/WwaoeCvRkAAH3xvpbSTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Mfwrvc3o;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B3606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Mfwrvc3o
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMF4B4qz1XMYJS;
	Mon,  9 Nov 2026 20:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256412; x=1796848413; bh=vodV/
	bpT8NhZ1bz2GXrf7lHRrHnOCFWm7KGm38tCy1I=; b=Mfwrvc3oToptbW3UQvwUi
	jc115XHp//5MJ1Yl6hTm5uCXMTLkdyLrx13z0iOztefFdHs4+VrsQffpSBN99P/X
	43HnTvcp/07Uv7fBCR0UgkNgO3UDoJyZUTS8lrAu64jjqUGiHXZ4gmsruMGjxRKO
	RAaSQ/femef/lTJrGZpmaD66DIdB4Ud4GMlIRgBZDFo+2Fi9GiRqLqLrAnCTE5NB
	E52/uP+n10FINVjK5G8U5I689jlEYraqOWRWm7AOBFlJSlpA/G94nZV8dzAhB6+U
	uxc9z8+8V9S225JfZ1G0vWSVPBOk9LGKOox2fPlu1xpxT0v7uIagvG2FJAW0iDjI
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fWYi0QECRpjV; Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLw0PRyz1XMFxH;
	Mon,  9 Nov 2026 20:33:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 17/73] simplify: Prevent overflow on LLONG_MIN negation and fix simplifications
Date: Mon,  9 Nov 2026 12:32:03 -0800
Message-ID: <20261109203259.362845-18-bvanassche@acm.org>
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

Avoid undefined integer overflow and invalid IR transformations in
linearize.h and simplify.c:
- Check that operand and instruction sizes do not exceed 64 bits before
  evaluating 64-bit constant simplifications or calling eval_op() and
  eval_unop().
- Use bits_mask(), sign_extend(), and zero_extend() instead of open-coded
  64-bit shifts to avoid undefined shift overflow on 64-bit types.
- Check for null pseudo pointers in DEF_OPCODE(), canonical_order(), and
  simplification helpers before dereferencing operands.
- Update CFG edges and phi sources accurately in simplify_cgoto().
- Add regression test validation/optim/simplify-memops-ssa-fixes.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 linearize.h                                  |   2 +-
 simplify.c                                   | 225 ++++++++++++++-----
 validation/optim/simplify-memops-ssa-fixes.c | 103 +++++++++
 3 files changed, 278 insertions(+), 52 deletions(-)
 create mode 100644 validation/optim/simplify-memops-ssa-fixes.c

diff --git a/linearize.h b/linearize.h
index cac6082fc886..3412494edbef 100644
--- a/linearize.h
+++ b/linearize.h
@@ -187,7 +187,7 @@ struct basic_block {
 // and OP_BADOP if not. It also assigns the defining instruction
 // to ``DEF``.
 #define DEF_OPCODE(DEF, SRC)	\
-	(((SRC)->type =3D=3D PSEUDO_REG && (DEF =3D (SRC)->def)) ? DEF->opcode =
: OP_BADOP)
+	(((SRC) && (SRC)->type =3D=3D PSEUDO_REG && (DEF =3D (SRC)->def)) ? DEF=
->opcode : OP_BADOP)
=20
=20
 static inline void add_bb(struct basic_block_list **list, struct basic_b=
lock *bb)
diff --git a/simplify.c b/simplify.c
index f20b6f1a9881..2ddaf1c619a8 100644
--- a/simplify.c
+++ b/simplify.c
@@ -57,7 +57,7 @@
 // check if a pseudo is a power of 2
 static inline bool is_pow2(pseudo_t src)
 {
-	if (src->type !=3D PSEUDO_VAL)
+	if (!src || src->type !=3D PSEUDO_VAL)
 		return false;
 	return is_power_of_2(src->value);
 }
@@ -315,6 +315,9 @@ static void kill_asm(struct instruction *insn)
 	FOR_EACH_PTR(insn->asm_rules->inputs, con) {
 		kill_use(&con->pseudo);
 	} END_FOR_EACH_PTR(con);
+	FOR_EACH_PTR(insn->asm_rules->outputs, con) {
+		kill_use(&con->pseudo);
+	} END_FOR_EACH_PTR(con);
 }
=20
 ///
@@ -428,7 +431,7 @@ void remove_dead_insns(struct entrypoint *ep)
=20
 static inline int constant(pseudo_t pseudo)
 {
-	return pseudo->type =3D=3D PSEUDO_VAL;
+	return pseudo && pseudo->type =3D=3D PSEUDO_VAL;
 }
=20
 ///
@@ -444,7 +447,7 @@ static inline pseudo_t is_same_op(pseudo_t src, int o=
p, unsigned osize)
 {
 	struct instruction *def;
=20
-	if (src->type !=3D PSEUDO_REG)
+	if (!src || src->type !=3D PSEUDO_REG)
 		return NULL;
 	def =3D src->def;
 	if (def->opcode !=3D op)
@@ -582,7 +585,7 @@ static int swap_select(struct instruction *out, struc=
t instruction *in, pseudo_t
=20
 static inline int def_opcode(pseudo_t p)
 {
-	if (p->type !=3D PSEUDO_REG)
+	if (!p || p->type !=3D PSEUDO_REG)
 		return OP_BADOP;
 	return p->def->opcode;
 }
@@ -629,12 +632,18 @@ static unsigned int operand_size(struct instruction=
 *insn, pseudo_t pseudo)
 static pseudo_t eval_op(int op, unsigned size, pseudo_t src1, pseudo_t s=
rc2)
 {
 	/* FIXME! Verify signs and sizes!! */
-	long long left =3D src1->value;
-	long long right =3D src2->value;
+	long long left;
+	long long right;
 	unsigned long long ul, ur;
 	long long res;
 	unsigned long long mask, bits;
=20
+	if (!size || size > 64)
+		return NULL;
+
+	left =3D src1->value;
+	right =3D src2->value;
+
 	mask =3D sign_bit(size);
 	bits =3D bits_mask(size);
=20
@@ -670,7 +679,7 @@ static pseudo_t eval_op(int op, unsigned size, pseudo=
_t src1, pseudo_t src2)
 	case OP_DIVS:
 		if (!right)
 			goto undef;
-		if (left =3D=3D mask && right =3D=3D -1)
+		if (ul =3D=3D mask && right =3D=3D -1)
 			goto undef;
 		res =3D left / right;
 		break;
@@ -682,7 +691,7 @@ static pseudo_t eval_op(int op, unsigned size, pseudo=
_t src1, pseudo_t src2)
 	case OP_MODS:
 		if (!right)
 			goto undef;
-		if (left =3D=3D mask && right =3D=3D -1)
+		if (ul =3D=3D mask && right =3D=3D -1)
 			goto undef;
 		res =3D left % right;
 		break;
@@ -1136,10 +1145,14 @@ static int simplify_seteq_setne(struct instructio=
n *insn, long long value)
 		return REPEAT_CSE;
=20
 	case OP_SEXT:
+		if (!def->orig_type)
+			break;
 		if (value && (def->orig_type->bit_size =3D=3D 1))
 			break;
 		/* Fall through */
 	case OP_ZEXT:
+		if (!def->orig_type)
+			break;
 		// Convert:
 		//	*ext.m	%s <- (1) %a
 		//	setne.1 %r <- %s, $0
@@ -1149,7 +1162,8 @@ static int simplify_seteq_setne(struct instruction =
*insn, long long value)
 		insn->itype =3D def->orig_type;
 		return replace_pseudo(insn, &insn->src1, def->src);
 	case OP_TRUNC:
-		if (!one_use(old))
+		if (!one_use(old) || !def->orig_type ||
+		    def->orig_type->bit_size > 64 || def->size >=3D 64)
 			break;
 		// convert
 		//	trunc.n	%s <- (o) %a
@@ -1159,6 +1173,7 @@ static int simplify_seteq_setne(struct instruction =
*insn, long long value)
 		//	setne.m %r <- %s, $0
 		// and same for setne/eq ... 0/1
 		osize =3D def->size;
+		insn->itype =3D def->orig_type;
 		def->opcode =3D OP_AND;
 		def->type =3D def->orig_type;
 		def->size =3D def->type->bit_size;
@@ -1208,12 +1223,16 @@ static int simplify_unsigned_zero_compare(struct =
instruction *insn, int result)
 static int simplify_compare_constant(struct instruction *insn, long long=
 value)
 {
 	unsigned size =3D insn->itype->bit_size;
-	unsigned long long bits =3D bits_mask(size);
+	unsigned long long bits;
 	struct instruction *def;
 	pseudo_t src1, src2;
 	unsigned int osize;
 	int changed =3D 0;
=20
+	if (!size || size > 64)
+		return 0;
+	bits =3D bits_mask(size);
+
 	switch (insn->opcode) {
 	case OP_SET_LT:
 		if (!value)
@@ -1457,6 +1476,8 @@ static int simplify_compare_constant(struct instruc=
tion *insn, long long value)
 		}
 		break;
 	case OP_TRUNC:
+		if (!def->orig_type || def->orig_type->bit_size > 64 || size >=3D 64)
+			break;
 		osize =3D def->orig_type->bit_size;
 		switch (insn->opcode) {
 		case OP_SET_EQ: case OP_SET_NE:
@@ -1547,7 +1568,12 @@ static int simplify_const_rightadd(struct instruct=
ion *def, struct instruction *
 	switch (def->opcode) {
 	case OP_SUB:
 		if (constant(def->src1)) { // (C - y) + D --> eval(C+D) - y
-			pseudo_t val =3D eval_op(OP_ADD, size, def->src1, src2);
+			pseudo_t val;
+			if (size > 64)
+				break;
+			val =3D eval_op(OP_ADD, size, def->src1, src2);
+			if (!val)
+				break;
 			insn->opcode =3D OP_SUB;
 			use_pseudo(insn, def->src2, &insn->src2);
 			return replace_pseudo(insn, &insn->src1, val);
@@ -1560,9 +1586,13 @@ static int simplify_const_rightadd(struct instruct=
ion *def, struct instruction *
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value =3D insn->src2->value;
-	unsigned long long bits =3D bits_mask(insn->size);
+	unsigned long long bits;
 	int changed =3D 0;
=20
+	if (insn->size > 64)
+		return 0;
+	bits =3D bits_mask(insn->size);
+
 	switch (insn->opcode) {
 	case OP_OR:
 		if ((value & bits) =3D=3D bits)
@@ -1632,13 +1662,24 @@ static int simplify_const_leftsub(struct instruct=
ion *insn, struct instruction *
 	switch (def->opcode) {
 	case OP_ADD:
 		if (constant(def->src2)) { // C - (y + D) --> eval(C-D) - y
-			insn->src1 =3D eval_op(OP_SUB, size, src1, def->src2);
+			pseudo_t val;
+			if (size > 64)
+				break;
+			val =3D eval_op(OP_SUB, size, src1, def->src2);
+			if (!val)
+				break;
+			insn->src1 =3D val;
 			return replace_pseudo(insn, &insn->src2, def->src1);
 		}
 		break;
 	case OP_SUB:
 		if (constant(def->src1)) { // C - (D - z) --> z + eval(C-D)
-			pseudo_t val =3D eval_op(OP_SUB, size, src1, def->src1);
+			pseudo_t val;
+			if (size > 64)
+				break;
+			val =3D eval_op(OP_SUB, size, src1, def->src1);
+			if (!val)
+				break;
 			insn->opcode =3D OP_ADD;
 			use_pseudo(insn, def->src2, &insn->src1);
 			return replace_pseudo(insn, &insn->src2, val);
@@ -1650,7 +1691,11 @@ static int simplify_const_leftsub(struct instructi=
on *insn, struct instruction *
=20
 static int simplify_constant_leftside(struct instruction *insn)
 {
-	long long value =3D insn->src1->value;
+	long long value;
+
+	if (!insn->src1 || !insn->src2 || insn->size > 64)
+		return 0;
+	value =3D insn->src1->value;
=20
 	switch (insn->opcode) {
 	case OP_ADD: case OP_OR: case OP_XOR:
@@ -1717,6 +1762,8 @@ static int simplify_binop_same_args(struct instruct=
ion *insn, pseudo_t arg)
=20
 static int simplify_binop(struct instruction *insn)
 {
+	if (!insn->src1 || !insn->src2)
+		return 0;
 	if (constant(insn->src1)) {
 		if (constant(insn->src2))
 			return simplify_constant_binop(insn);
@@ -1753,8 +1800,12 @@ static int switch_pseudo(struct instruction *insn1=
, pseudo_t *pp1, struct instru
 //	* VOID, UNDEF and PHI are uninteresting (but VOID should have type 0)
 static int canonical_order(pseudo_t p1, pseudo_t p2)
 {
-	int t1 =3D p1->type;
-	int t2 =3D p2->type;
+	int t1, t2;
+
+	if (!p1 || !p2)
+		return 1;
+	t1 =3D p1->type;
+	t2 =3D p2->type;
=20
 	/* symbol/constants on the right */
 	if (t1 < t2)
@@ -1793,7 +1844,7 @@ static int canonicalize_compare(struct instruction =
*insn)
=20
 static inline int simple_pseudo(pseudo_t pseudo)
 {
-	return pseudo->type =3D=3D PSEUDO_VAL || pseudo->type =3D=3D PSEUDO_SYM=
;
+	return pseudo && (pseudo->type =3D=3D PSEUDO_VAL || pseudo->type =3D=3D=
 PSEUDO_SYM);
 }
=20
 ///
@@ -1820,7 +1871,7 @@ static inline bool can_move_to(pseudo_t src, struct=
 instruction *dst)
=20
 	if (!one_use(dst->target))
 		return false;
-	if (src->type !=3D PSEUDO_REG)
+	if (!src || src->type !=3D PSEUDO_REG)
 		return true;
=20
 	def =3D src->def;
@@ -1851,8 +1902,14 @@ static int simplify_associative_binop(struct instr=
uction *insn)
 	if (!simple_pseudo(def->src2))
 		return 0;
 	if (constant(def->src2) && constant(insn->src2)) {
+		pseudo_t val;
+		if (insn->size > 64)
+			return 0;
+		val =3D eval_op(insn->opcode, insn->size, insn->src2, def->src2);
+		if (!val)
+			return 0;
 		// (x # C) # K --> x # eval(C # K)
-		insn->src2 =3D eval_op(insn->opcode, insn->size, insn->src2, def->src2=
);
+		insn->src2 =3D val;
 		return replace_pseudo(insn, &insn->src1, def->src1);
 	}
=20
@@ -1873,12 +1930,12 @@ static int simplify_add_one_side(struct instructi=
on *insn, pseudo_t *p1, pseudo_
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_MUL:
 		if (DEF_OPCODE(defr, *p2) =3D=3D OP_MUL) {
-			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src2, defr)) {
+			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src1, defr)) {
 				// ((x * z) + (y * z)) into ((x + y) * z)
 				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
 				return REPEAT_CSE;
 			}
-			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src1, defr)) {
+			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src2, defr)) {
 				// ((z * x) + (z * y)) into ((x + y) * z)
 				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
 				return REPEAT_CSE;
@@ -1991,12 +2048,12 @@ static int simplify_and_one_side(struct instructi=
on *insn, pseudo_t *p1, pseudo_
 		break;
 	case OP_OR:
 		if (DEF_OPCODE(defr, *p2) =3D=3D OP_OR) {
-			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src2, defr)) {
+			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src1, defr)) {
 				// ((x | z) & (y | z)) into ((x & y) | z)
 				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
 				return REPEAT_CSE;
 			}
-			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src1, defr)) {
+			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src2, defr)) {
 				// ((z | x) & (z | y)) into ((x & y) | z)
 				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
 				return REPEAT_CSE;
@@ -2035,12 +2092,12 @@ static int simplify_ior_one_side(struct instructi=
on *insn, pseudo_t *p1, pseudo_
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_AND:
 		if (DEF_OPCODE(defr, *p2) =3D=3D OP_AND) {
-			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src2, defr)) {
+			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src1, defr)) {
 				// ((x & z) | (y & z)) into ((x | y) & z)
 				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
 				return REPEAT_CSE;
 			}
-			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src1, defr)) {
+			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src2, defr)) {
 				// ((z & x) | (z & y)) into ((x | y) & z)
 				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
 				return REPEAT_CSE;
@@ -2053,6 +2110,8 @@ static int simplify_ior_one_side(struct instruction=
 *insn, pseudo_t *p1, pseudo_
 		}
 		break;
 	case OP_NOT:
+		if (insn->size > 64)
+			break;
 		if (def->src =3D=3D *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
 		break;
@@ -2089,12 +2148,12 @@ static int simplify_xor_one_side(struct instructi=
on *insn, pseudo_t *p1, pseudo_
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_AND:
 		if (DEF_OPCODE(defr, *p2) =3D=3D OP_AND) {
-			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src2, defr)) {
+			if (defr->src2 =3D=3D def->src2 && can_move_to(def->src1, defr)) {
 				// ((x & z) ^ (y & z)) into ((x ^ y) & z)
 				swap_insn(insn, defr, def->src1, defr->src1, def->src2);
 				return REPEAT_CSE;
 			}
-			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src1, defr)) {
+			if (defr->src1 =3D=3D def->src1 && can_move_to(def->src2, defr)) {
 				// ((z & x) ^ (z & y)) into ((x ^ y) & z)
 				swap_insn(insn, defr, def->src2, defr->src2, def->src1);
 				return REPEAT_CSE;
@@ -2107,6 +2166,8 @@ static int simplify_xor_one_side(struct instruction=
 *insn, pseudo_t *p1, pseudo_
 		}
 		break;
 	case OP_NOT:
+		if (insn->size > 64)
+			break;
 		if (def->src =3D=3D *p2)
 			return replace_with_value(insn, bits_mask(insn->size));
 		break;
@@ -2137,8 +2198,11 @@ static int simplify_xor(struct instruction *insn)
=20
 static int simplify_constant_unop(struct instruction *insn)
 {
-	long long val =3D insn->src1->value;
-	unsigned long long res, mask;
+	unsigned long long val =3D insn->src1->value;
+	unsigned long long res;
+
+	if (!insn->size || insn->size > 64)
+		return 0;
=20
 	switch (insn->opcode) {
 	case OP_NOT:
@@ -2148,18 +2212,24 @@ static int simplify_constant_unop(struct instruct=
ion *insn)
 		res =3D -(unsigned long long)val;
 		break;
 	case OP_SEXT:
-		mask =3D sign_bit(insn->orig_type->bit_size);
-		if (val & mask)
-			val |=3D ~bits_mask(insn->orig_type->bit_size);
-		/* fall through */
+		if (!insn->orig_type || insn->orig_type->bit_size > 64)
+			return 0;
+		res =3D sign_extend(val, insn->orig_type->bit_size);
+		break;
 	case OP_ZEXT:
+		if (!insn->orig_type || insn->orig_type->bit_size > 64)
+			return 0;
+		val =3D zero_extend(val, insn->orig_type->bit_size);
+		/* fall through */
 	case OP_TRUNC:
+		if (!insn->orig_type || insn->orig_type->bit_size > 64)
+			return 0;
 		res =3D val;
 		break;
 	default:
 		return 0;
 	}
-	res &=3D bits_mask(insn->size);
+	res =3D zero_extend(res, insn->size);
 =09
 	return replace_with_value(insn, res);
 }
@@ -2176,7 +2246,7 @@ static int simplify_unop(struct instruction *insn)
 	case OP_NOT:
 		switch (DEF_OPCODE(def, src)) {
 		case OP_ADD:
-			if (!constant(def->src2))
+			if (insn->size > 64 || !constant(def->src2))
 				break;
 			insn->opcode =3D OP_SUB;	// ~(x + C) --> ~C - x
 			src =3D eval_unop(OP_NOT, insn->size, def->src2);
@@ -2189,13 +2259,13 @@ static int simplify_unop(struct instruction *insn=
)
 		case OP_NOT:			// ~(~x) --> x
 			return replace_with_pseudo(insn, def->src);
 		case OP_SUB:
-			if (!constant(def->src1))
+			if (insn->size > 64 || !constant(def->src1))
 				break;
 			insn->opcode =3D OP_ADD;	// ~(C - x) --> x + ~C
 			insn->src2 =3D eval_unop(OP_NOT, insn->size, def->src1);
 			return replace_pseudo(insn, &insn->src1, def->src2);
 		case OP_XOR:
-			if (!constant(def->src2))
+			if (insn->size > 64 || !constant(def->src2))
 				break;
 			insn->opcode =3D OP_XOR;	// ~(x ^ C) --> x ^ ~C
 			insn->src2 =3D eval_unop(OP_NOT, insn->size, def->src2);
@@ -2205,7 +2275,7 @@ static int simplify_unop(struct instruction *insn)
 	case OP_NEG:
 		switch (DEF_OPCODE(def, src)) {
 		case OP_ADD:
-			if (!constant(def->src2))
+			if (insn->size > 64 || !constant(def->src2))
 				break;
 			insn->opcode =3D OP_SUB;	// -(x + C) --> (-C - x)
 			src =3D eval_unop(OP_NEG, insn->size, def->src2);
@@ -2314,7 +2384,7 @@ static int simplify_cast(struct instruction *insn)
 	switch (def_opcode(src)) {
 	case OP_AND:
 		val =3D def->src2;
-		if (val->type !=3D PSEUDO_VAL)
+		if (!constant(val) || size > 64 || def->size > 64)
 			break;
 		/* A cast of a AND might be a no-op.. */
 		switch (insn->opcode) {
@@ -2395,13 +2465,15 @@ static int simplify_cast(struct instruction *insn=
)
 	case OP_OR:
 		switch (insn->opcode) {
 		case OP_TRUNC:
+			if (size > 64 || def->size > 64)
+				break;
 			mask =3D bits_mask(insn->size);
 			return simplify_mask_or(insn, mask, def);
 		}
 		break;
 	case OP_LSR:
 	case OP_SHL:
-		if (insn->opcode !=3D OP_TRUNC)
+		if (insn->opcode !=3D OP_TRUNC || size > 64 || def->size > 64)
 			break;
 		mask =3D bits_mask(insn->size);
 		return simplify_mask_shift(def, mask);
@@ -2411,7 +2483,7 @@ static int simplify_cast(struct instruction *insn)
 			insn->orig_type =3D def->orig_type;
 			return replace_pseudo(insn, &insn->src1, def->src);
 		case OP_SEXT:
-			if (size !=3D def->orig_type->bit_size)
+			if (!def->orig_type || size > 64 || size !=3D def->orig_type->bit_siz=
e)
 				break;
 			if (DEF_OPCODE(def2, def->src) !=3D OP_LSR)
 				break;
@@ -2422,7 +2494,8 @@ static int simplify_cast(struct instruction *insn)
 			insn->src2 =3D def2->src2;
 			return replace_pseudo(insn, &insn->src1, def2->src1);
 		case OP_ZEXT:
-			if (size !=3D def->orig_type->bit_size)
+			if (!def->orig_type || size > 64 || def->size >=3D 64 ||
+			    size !=3D def->orig_type->bit_size)
 				break;
 			insn->opcode =3D OP_AND;
 			insn->src2 =3D value_pseudo(bits_mask(def->size));
@@ -2451,6 +2524,10 @@ static int simplify_cast(struct instruction *insn)
 			return replace_pseudo(insn, &insn->src, def->src);
 		}
 		switch (insn->opcode) {
+		case OP_ZEXT:
+			if (insn->orig_type !=3D def->orig_type)
+				break;
+			/* fall through */
 		case OP_SEXT:
 			insn->orig_type =3D def->orig_type;
 			return replace_pseudo(insn, &insn->src, def->src);
@@ -2691,6 +2768,10 @@ static int simplify_switch(struct instruction *ins=
n)
 	if (!constant(cond))
 		return 0;
 	val =3D insn->cond->value;
+	if (insn->type && insn->size > 0) {
+		bool is_signed =3D !(insn->type->ctype.modifiers & MOD_UNSIGNED);
+		val =3D bits_extend(val, insn->size, is_signed);
+	}
=20
 	FOR_EACH_PTR(insn->multijmp_list, jmp) {
 		/* Default case */
@@ -2717,34 +2798,76 @@ static struct basic_block *is_label(pseudo_t pseu=
do)
=20
 static int simplify_cgoto(struct instruction *insn)
 {
-	struct basic_block *target, *bb =3D insn->bb;
-	struct basic_block *bbt, *bbf;
+	struct basic_block *target, *orig_target, *bb =3D insn->bb;
+	struct basic_block *bbt, *bbf, *orig_bbt, *orig_bbf;
 	struct instruction *def;
 	struct multijmp *jmp;
=20
 	switch (DEF_OPCODE(def, insn->src)) {
 	case OP_SEL:	// CGOTO(SEL(x, L1, L2)) --> CBR x, L1, L2
 		if ((bbt =3D is_label(def->src2)) && (bbf =3D is_label(def->src3))) {
+			if (!bbt->ep || !bbf->ep)
+				return 0;
+			if (bbt =3D=3D bbf) {
+				target =3D bbt;
+				goto convert_to_br;
+			}
+			orig_bbt =3D bbt;
+			orig_bbf =3D bbf;
+			FOR_EACH_PTR(insn->multijmp_list, jmp) {
+				if (jmp->target =3D=3D bbt) {
+					bbt =3D NULL;
+					continue;
+				}
+				if (jmp->target =3D=3D bbf) {
+					bbf =3D NULL;
+					continue;
+				}
+				remove_bb_from_list(&jmp->target->parents, bb, 1);
+				remove_bb_from_list(&bb->children, jmp->target, 1);
+				remove_phisources(bb, jmp->target);
+			} END_FOR_EACH_PTR(jmp);
+			free_ptr_list(&insn->multijmp_list);
 			insn->opcode =3D OP_CBR;
-			insn->bb_true =3D bbt;
-			insn->bb_false =3D bbf;
-			return replace_pseudo(insn, &insn->src1, def->cond);
+			insn->bb_true =3D orig_bbt;
+			insn->bb_false =3D orig_bbf;
+			if (bbt) {
+				add_bb(&orig_bbt->parents, bb);
+				add_bb(&bb->children, orig_bbt);
+			}
+			if (bbf) {
+				add_bb(&orig_bbf->parents, bb);
+				add_bb(&bb->children, orig_bbf);
+			}
+			replace_pseudo(insn, &insn->src1, def->cond);
+			return REPEAT_CSE|REPEAT_CFG_CLEANUP;
 		}
 		break;
 	case OP_LABEL:
 		target =3D def->bb_true;
 		if (!target->ep)
 			return 0;
+	convert_to_br:
+		orig_target =3D target;
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
-			if (jmp->target =3D=3D target)
+			if (jmp->target =3D=3D target) {
+				target =3D NULL;
 				continue;
+			}
 			remove_bb_from_list(&jmp->target->parents, bb, 1);
 			remove_bb_from_list(&bb->children, jmp->target, 1);
-			DELETE_CURRENT_PTR(jmp);
+			remove_phisources(bb, jmp->target);
 		} END_FOR_EACH_PTR(jmp);
+		free_ptr_list(&insn->multijmp_list);
+		if (target) {
+			add_bb(&orig_target->parents, bb);
+			add_bb(&bb->children, orig_target);
+		}
 		kill_use(&insn->src);
+		insn->cond =3D NULL;
 		insn->opcode =3D OP_BR;
-		insn->bb_true =3D target;
+		insn->bb_true =3D orig_target;
+		insn->bb_false =3D NULL;
 		return REPEAT_CSE|REPEAT_CFG_CLEANUP;
 	}
 	return 0;
diff --git a/validation/optim/simplify-memops-ssa-fixes.c b/validation/op=
tim/simplify-memops-ssa-fixes.c
new file mode 100644
index 000000000000..b94e0182902e
--- /dev/null
+++ b/validation/optim/simplify-memops-ssa-fixes.c
@@ -0,0 +1,103 @@
+/* 1. Negation of LLONG_MIN */
+static long long test_neg_llong_min(void)
+{
+	return -(-9223372036854775807LL - 1LL);
+}
+
+/* 2. Signed bitfield post-increment assigned to another bitfield */
+struct sbf {
+	signed int a:3;
+	signed int b:3;
+	signed int c:3;
+};
+
+int bf_postinc_const(void)
+{
+	struct sbf s =3D { -1, 0, 0 };
+	s.b =3D s.a++;
+	return s.c;
+}
+
+/* 3. ((x & mask) | bits) =3D=3D C with bits outside mask */
+int and_or_equ(unsigned x)
+{
+	return ((x & 0xf0) | 0x01) =3D=3D 0x11;
+}
+
+/* 4. Commuted (x + 1U) - x */
+unsigned add_sub_cancel(unsigned x)
+{
+	return (x + 1U) - x;
+}
+
+/* 5. 0 / non-constant */
+int zero_div(int x)
+{
+	return 0 / (x ? 1 : 2);
+}
+
+/* 6. Computed goto OP_SEL with identical targets and live PHI */
+int cgoto_same_target_phi(int c, int d)
+{
+	void *p =3D c ? &&L1 : &&L1;
+	int r =3D 1;
+	if (d) {
+		r =3D 2;
+		goto L2;
+	}
+	goto *p;
+L2:
+	r =3D 3;
+L1:
+	return r;
+}
+
+/* 7. Computed goto OP_LABEL deduplication with live PHI */
+int cgoto_label_dedup(int c)
+{
+	void *p =3D &&L1;
+	int r =3D 1;
+	if (c) {
+		r =3D 2;
+		goto L2;
+	}
+	goto *p;
+L2:
+	r =3D 3;
+L1:
+	return r;
+}
+
+/* 8. 128-bit zero-extension and addition above 64-bit width */
+__int128 zext_u64_to_s128(void)
+{
+	return (__int128)0x8000000000000000ULL;
+}
+
+unsigned __int128 add_u128_carry(void)
+{
+	return (unsigned __int128)0x8000000000000000ULL + 0x8000000000000000ULL=
;
+}
+
+/* 9. ZEXT of SEXT with distinct source widths */
+unsigned long long zext_sext_char(signed char c)
+{
+	return (unsigned long long)(unsigned int)(int)c;
+}
+
+/*
+ * check-name: simplify-memops-ssa-fixes
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: VOID
+ * check-output-contains: ret\\.64.*\\$0x8000000000000000
+ * check-output-contains: zext\\.128
+ * check-output-contains: add\\.128
+ * check-output-contains: sext\\.32
+ * check-output-contains: zext\\.64
+ *
+ * check-error-start
+optim/simplify-memops-ssa-fixes.c:4:16: warning: constant integer operat=
ion overflow
+ * check-error-end
+ */
