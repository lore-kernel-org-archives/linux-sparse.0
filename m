Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256414;
	b=S4numsn3hoqp8PmEBf9r4q9QMNdIcUEkAN1dwudZC2nhPAGt2sRHXTT8VwQcFaKcw6DX
	 /TdWTYdn7dprLcEgQnUGFwdqOzp1hmiuHUPDwiPCBxdJKclvRk8HxiysvaVI9cITaA92k
	 eY1GzLiGPR+9VE+8eDzwTDWLO0wiR6kNXkXoQUGRzR9PchDmZcCk+j3jYbEZ7QaQ+xta2
	 qptezzq0eFnD8AqyUgkP7vNwzhRY5klSAa1rwvDs19i9bDPZQpnk4yVhjMZ9RmD90Uvmn
	 Vsy5PHiFHAoMdXcql8C6lwqDe13QBnGVfzTSxGsYALSYvnCL9AzkMlI+Rg4CaMlt/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qx188PHlIQFpPGSkrPoY9hpZBtZRrgnYQJs9VGMDs6I=;
	b=ln/RP183JLc/jOcM5KU2Il9JTkPKT7vi5ucQqkuF5nuvFuef0YpCplR4ow64OkcGB3e7
	 9u7Svqr88x7UFZtQvm7JxxMuHKh3vWhgptpGOXY+ZKs9zwR3nR+kP05js9z3aStI2mkCl
	 Qm9gqiSJScqxm23SSFuKDeQ3IVmtKoWDcqlQ+fEzRXgRX+gql56JizoVL3a68Chnv/Gwl
	 1uGWl4V5ETBTugoSnPHGIsE1A8lpU6pDxwcva9JBQGpNNbXsrhsSqvLplmCXJ1PWj30Wa
	 +JUX3Cu2kNm6vcROX1WfpKllfjjtMDntizhnlCdFePgmOQM5S2/S/kfF0aaeF7TFuTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=khfFP61m;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28F606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A28F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=khfFP61m
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM174Y4z1XMYJg;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256410; x=1796848411; bh=qx188
	PHlIQFpPGSkrPoY9hpZBtZRrgnYQJs9VGMDs6I=; b=khfFP61mYfXhpu6tOMeHC
	YrEgKWIksN9+ZknVpXeGUVFRkGryMt7QaZia3aHuzzcqdLOHzohBp62eAW/ZKVU1
	/eiaAwDegpBZv2y/Ucocf7l1vXOKlspiM5CEcnvmb+zG103abPU2F3VB1i+DJh8G
	ywwZnUUzVWl0VdA7joE8sdfy3ocwcCNF0RxXqtS3eVvp07RPoSZjgOhN2tnoFa69
	koPJGbDfyeAqMyblsOxCHPR4fYrj82g/sGY5bNREB3Fs76I9SHxjcKu5CWlUMu9s
	+jXHVltl9F3UZB4NWBOYbcWy1RyU7qhxo+R5Tv0c1yAQTGuqsrdvyiFeJaiPctO+
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hAsfTpnggp-S; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLv1Hzqz1XM6JF;
	Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 13/73] expand: Fix static initializer folding and floating-point casts
Date: Mon,  9 Nov 2026 12:31:59 -0800
Message-ID: <20261109203259.362845-14-bvanassche@acm.org>
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

Fix constant folding and numeric conversions in expand.c:
- Avoid folding writable or volatile static objects and negative offsets
  in constant_symbol_value(), and guard volatile or bitfield dereferences
  in expand_dereference().
- Preserve unsigned integer-to-float and float-to-integer conversions in
  cast_value() while guarding against out-of-range and NaN host casts.
- Add regression test validation/expand-const-and-float.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expand.c                            | 76 ++++++++++++++++++++++++++---
 validation/expand-const-and-float.c | 73 +++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 6 deletions(-)
 create mode 100644 validation/expand-const-and-float.c

diff --git a/expand.c b/expand.c
index bbb30ae605dc..208ce65a2442 100644
--- a/expand.c
+++ b/expand.c
@@ -97,6 +97,11 @@ void cast_value(struct expression *expr, struct symbol=
 *newtype, struct expressi
 	if (is_float_type(newtype) || is_float_type(oldtype))
 		goto Float;
=20
+	if (!is_bool_type(newtype) && new_size > 64 && old_size >=3D 64 &&
+	    new_size > old_size && (oldtype->ctype.modifiers & MOD_UNSIGNED) &&
+	    (old->value & (1ULL << 63)))
+		return;
+
 	// For pointers and integers, we can just move the value around
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D old->taint;
@@ -144,16 +149,60 @@ Int:
=20
 Float:
 	if (!is_float_type(newtype)) {
-		value =3D (long long)old->fvalue;
+		long double fval =3D old->fvalue;
+
+		if (is_bool_type(newtype)) {
+			expr->type =3D EXPR_VALUE;
+			expr->taint =3D 0;
+			expr->ctype =3D newtype;
+			expr->value =3D (fval !=3D 0);
+			return;
+		}
+		if (new_size <=3D 0 || new_size > 64 || !__builtin_isfinite(fval))
+			return;
+		if (newtype->ctype.modifiers & MOD_UNSIGNED) {
+			unsigned long long uval;
+			if (!(fval > -1.0L && fval < 0x1p64L))
+				return;
+			uval =3D (fval <=3D 0.0L) ? 0ULL : (unsigned long long)fval;
+			if (new_size < 64 && uval >=3D (1ULL << new_size))
+				return;
+			value =3D (long long)uval;
+		} else {
+			unsigned long long lim =3D 1ULL << (new_size - 1);
+			unsigned long long umag;
+			if (fval >=3D 0.0L) {
+				if (!(fval < 0x1p63L))
+					return;
+				umag =3D (unsigned long long)fval;
+				if (umag >=3D lim)
+					return;
+				value =3D (long long)umag;
+			} else {
+				long double mag =3D -fval;
+				if (!(mag < 0x1p64L))
+					return;
+				umag =3D (unsigned long long)mag;
+				if (umag > lim)
+					return;
+				value =3D (long long)(0ULL - umag);
+			}
+		}
 		expr->type =3D EXPR_VALUE;
 		expr->taint =3D 0;
 		expr->ctype =3D newtype;
 		goto Int;
 	}
=20
-	if (!is_float_type(oldtype))
-		expr->fvalue =3D (long double)get_longlong(old);
-	else
+	if (!is_float_type(oldtype)) {
+		if ((oldtype->ctype.modifiers & MOD_UNSIGNED) &&
+		    old_size > 64 && (old->value & (1ULL << 63)))
+			return;
+		if (oldtype->ctype.modifiers & MOD_UNSIGNED)
+			expr->fvalue =3D (long double)(unsigned long long)get_longlong(old);
+		else
+			expr->fvalue =3D (long double)get_longlong(old);
+	} else
 		expr->fvalue =3D old->fvalue;
=20
 	if (newtype->rank <=3D 0) {
@@ -200,6 +249,8 @@ static int simplify_int_binop(struct expression *expr=
, struct symbol *ctype)
 	}
 	if (left->type !=3D EXPR_VALUE)
 		return 0;
+	if (!ctype || ctype->bit_size <=3D 0 || ctype->bit_size > 64)
+		return 0;
 	l =3D left->value; r =3D right->value;
 	is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
 	mask =3D sign_bit(ctype->bit_size);
@@ -305,6 +356,8 @@ static int simplify_cmp_binop(struct expression *expr=
, struct symbol *ctype)
=20
 	if (left->type !=3D EXPR_VALUE || right->type !=3D EXPR_VALUE)
 		return 0;
+	if (!ctype || ctype->bit_size <=3D 0 || ctype->bit_size > 64)
+		return 0;
 	l =3D left->value; r =3D right->value;
 	mask =3D sign_bit(ctype->bit_size);
 	sl =3D l; sr =3D r;
@@ -665,8 +718,16 @@ static struct expression *constant_symbol_value(stru=
ct symbol *sym, int offset)
 {
 	struct expression *value;
=20
+	if (offset < 0)
+		return NULL;
+	if (sym->ctype.modifiers & MOD_VOLATILE)
+		return NULL;
 	if (sym->ctype.modifiers & MOD_ACCESS)
 		return NULL;
+	if ((sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
+	    !(sym->ctype.modifiers & MOD_CONST) &&
+	    !sym->string && sym->ident)
+		return NULL;
 	value =3D sym->initializer;
 	if (!value)
 		return NULL;
@@ -707,6 +768,8 @@ static int expand_dereference(struct expression *expr=
)
 	 */
 	if (expr->ctype->ctype.modifiers & MOD_NODEREF)
 		warning(unop->pos, "dereference of noderef expression");
+	if (expr->ctype->ctype.modifiers & MOD_VOLATILE)
+		return SIDE_EFFECTS;
=20
 	/*
 	 * Is it "symbol" or "symbol + offset"?
@@ -732,7 +795,7 @@ static int expand_dereference(struct expression *expr=
)
 			if (value->type =3D=3D EXPR_VALUE) {
 				if (!is_integral_type(ctype))
 					return UNSAFE;
-				if (is_bitfield_type(value->ctype))
+				if (is_bitfield_type(ctype) || is_bitfield_type(value->ctype))
 					return UNSAFE;
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D value->value;
@@ -866,7 +929,8 @@ static int expand_cast(struct expression *expr)
 	/* Simplify normal integer casts.. */
 	if (target->type =3D=3D EXPR_VALUE || target->type =3D=3D EXPR_FVALUE) =
{
 		cast_value(expr, expr->ctype, target);
-		return 0;
+		if (expr->type =3D=3D EXPR_VALUE || expr->type =3D=3D EXPR_FVALUE)
+			return 0;
 	}
 	return cost + 1;
 }
diff --git a/validation/expand-const-and-float.c b/validation/expand-cons=
t-and-float.c
new file mode 100644
index 000000000000..4f0403134cdc
--- /dev/null
+++ b/validation/expand-const-and-float.c
@@ -0,0 +1,73 @@
+static const volatile int cv =3D 42;
+
+int read_cv(void)
+{
+	return cv;
+}
+
+void vol_deref(const volatile int *p)
+{
+	*p;
+}
+
+static const int arr[2] =3D { 10, 20 };
+
+int read_neg_off(void)
+{
+	return *(&arr[0] - 1);
+}
+
+unsigned int float_neg_half(void)
+{
+	return (unsigned int)-0.5;
+}
+
+_Bool float_half_to_bool(void)
+{
+	return (_Bool)0.5;
+}
+
+int float_oob_pos(void)
+{
+	return (int)1e30;
+}
+
+unsigned int float_neg_one(void)
+{
+	return (unsigned int)-1.0;
+}
+
+unsigned long long float_oob_ull(void)
+{
+	return (unsigned long long)1e40;
+}
+
+int float_nan(void)
+{
+	return (int)__builtin_nan("");
+}
+
+int float_inf(void)
+{
+	return (int)__builtin_inf();
+}
+
+int nonconst_float_cast(int x)
+{
+	return (int)(x + 0.0);
+}
+
+/*
+ * check-name: expand-const-and-float
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: load\\.32.*\\[cv\\]
+ * check-output-contains: load\\.32.*%arg1
+ * check-output-contains: ret\\.32.*\\$0
+ * check-output-contains: ret\\.1.*\\$1
+ *
+ * check-error-start
+expand-const-and-float.c:17:26: warning: invalid access below 'arr' (-4 =
8)
+ * check-error-end
+ */
