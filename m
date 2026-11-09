Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256422;
	b=DLHiQIO44XTHT5fdemKZOz3Gdig0T6YAGO6/biouJXMqg/wHfH46hinkYeDH3oMttJxe
	 rcVo6CQwCOxVbjDwX4Lwzc59embAZyS3UqAM6XUmRvZloxFlmDVKX8FV3hOMwQwAI4YWn
	 j2iUqaBL9TzAlNgjhZenFgybfWr4n846gf7bz/79wYbtlZFXHSgDQG78xxjrhVuzJ8RgK
	 SkHFbFD462XU7AsMBSWP60y0wJVUPfO9MdZTqJfE+aCADsNAQJILz4mku+TPpOweW25zi
	 VWLbn0pxkfWh+Weh9IcFvW6bJw2C0ZTJ0sTYK6LeTwpcyuna4dbHOi3TscES1m7e3Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=plElgky+sIvbjKRpLH0SAhHqW4RG5C88ofr5QuCSNMk=;
	b=k6lK7vSOtPKXPzk6k6owBDyPG8nCn75/1JTy2DqcWca9qak7M1sXrbKrEmkWYgrfmwKD
	 brQxxA92ldqKc/RYp9oh5L54EYMIDpED2oOSQ65G43IhUKRBAP19GJBsWtCs8hj+eudlS
	 8xSHnFuJTvXjcLJi9Vk3tQ/jIcu9tz6TYtOGsSrnLrSEfEvpP7g6jRL1o6U4ghl/6rVvy
	 wWFqcZ8g4htaf5Err3jAXKYkH32JzX07+nLa9KC5/X3hYIqqDrY8FGlwwMGjNZHyQM6z1
	 VJBCn4lPATV5+ZCul6cyaetxiY50YYYDxxYXCaV6615CPhSGR9tYRSzvkoLEzzU4jXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=BWOJLpOK;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEA606A331
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1CEA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=BWOJLpOK
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM61Ryjz1XMfrb;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=plElg
	ky+sIvbjKRpLH0SAhHqW4RG5C88ofr5QuCSNMk=; b=BWOJLpOKgEg0YMahU37F8
	KHGq7yJMrvSer5/SnyPEt6b0MO3XiS1DLCNxebks9/dNlcCIzDI44r/rZX546WSJ
	zTypzN8FUmOwDXWZRz5+HRR04t2tAqyIcnHI/XnlyC6+xYRr9fzDm5tYX56Wb5Lr
	085sDGGc5Z4f1z4uermfYFFrOlXbo80UKUGR+07H2RsAD+U9CDOADqLBAyws+jWs
	ltuY/18aA9lMFM23L6CNaNVZf2zKyWv1r9zSfqVmLTdBre4YEI28f6Z/rBJeRPL5
	UpvWWQR3H+SnDXzYCdaSo6W9djxMzqYeqDBh7sqNLdbgmwF6bCwnENfsHSvs/tE6
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BjFxgLcprAam; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLz33v2z1XMYJV;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 32/73] expand: Simplify signed constants early
Date: Mon,  9 Nov 2026 12:32:18 -0800
Message-ID: <20261109203259.362845-33-bvanassche@acm.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Make constant simplification for trivial unary preops on integer
constants ('-5', '+5', '~0') available at type evaluation time via
early_simplify_preop().

Fold unary preop expressions such as '-5' and '~0' before bitwise type
evaluation so that all-bits-set constants such as -1 or ~0 are
recognized as special cases.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Combine the two commits from Linus Torvalds ("simplify
  signed constants early" and "Fix early constant simplification"),
  rewrite the commit message in the imperative mood, include simplify.h i=
n
  expand.c to fix make selfcheck, and guard bit_size in
  early_simplify_preop() ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c | 14 +++++++++++++-
 expand.c   | 31 +++++++++++++++++++++++++------
 simplify.h |  1 +
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 0e4e64d33192..23f87c8dff5b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -35,6 +35,7 @@
 #include <limits.h>
=20
 #include "evaluate.h"
+#include "simplify.h"
 #include "lib.h"
 #include "allocate.h"
 #include "bits.h"
@@ -1944,10 +1945,21 @@ Normal:
 	} else {
 		return bad_expr_type(expr);
 	}
-	if (expr->op =3D=3D '+')
+	if (expr->op =3D=3D '+') {
 		*expr =3D *expr->unop;
+		expr->flags =3D flags;
+		expr->ctype =3D ctype;
+		return ctype;
+	}
 	expr->flags =3D flags;
 	expr->ctype =3D ctype;
+
+	/*
+	 * We simplify sign ops of constants early, turning
+	 * a constant with a sign into just a plain constant
+	 * rather than a preop.
+	 */
+	early_simplify_preop(expr);
 	return ctype;
 Restr:
 	if (restricted_unop(expr->op, &ctype))
diff --git a/expand.c b/expand.c
index 208ce65a2442..267aaf00e9ce 100644
--- a/expand.c
+++ b/expand.c
@@ -44,6 +44,7 @@
 #include "expression.h"
 #include "evaluate.h"
 #include "expand.h"
+#include "simplify.h"
=20
=20
 static int expand_expression(struct expression *);
@@ -817,13 +818,24 @@ static int expand_dereference(struct expression *ex=
pr)
 	return UNSAFE;
 }
=20
-static int simplify_preop(struct expression *expr)
+/*
+ * We want to do certain trivial constant simplifications
+ * early at the type evaluation stage, because those can
+ * depend on specific constants (ie ~0 is ok for restricted
+ * types).
+ *
+ * Return >0 for successful simplification, 0 for none,
+ * and <0 for "not simplified due to overflow".
+ */
+int early_simplify_preop(struct expression *expr)
 {
 	struct expression *op =3D expr->unop;
 	unsigned long long v, mask;
=20
 	if (op->type !=3D EXPR_VALUE)
 		return 0;
+	if (!expr->ctype || expr->ctype->bit_size <=3D 0 || expr->ctype->bit_si=
ze > 64)
+		return 0;
=20
 	mask =3D sign_bit(expr->ctype->bit_size);
 	v =3D op->value;
@@ -831,7 +843,7 @@ static int simplify_preop(struct expression *expr)
 	case '+': break;
 	case '-':
 		if (v =3D=3D mask && !(expr->ctype->ctype.modifiers & MOD_UNSIGNED))
-			goto Overflow;
+			return -1;
 		v =3D -v;
 		break;
 	case '!': v =3D !v; break;
@@ -843,11 +855,18 @@ static int simplify_preop(struct expression *expr)
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D op->taint;
 	return 1;
+}
=20
-Overflow:
-	if (!conservative)
-		warning(expr->pos, "constant integer operation overflow");
-	return 0;
+static int simplify_preop(struct expression *expr)
+{
+	int simplified =3D early_simplify_preop(expr);
+
+	if (simplified < 0) {
+		if (!conservative)
+			warning(expr->pos, "constant integer operation overflow");
+		simplified =3D 0;
+	}
+	return simplified;
 }
=20
 static int simplify_float_preop(struct expression *expr)
diff --git a/simplify.h b/simplify.h
index ed3dd9716a3e..15c887376445 100644
--- a/simplify.h
+++ b/simplify.h
@@ -4,6 +4,7 @@
 #include "linearize.h"
=20
 int simplify_instruction(struct instruction *insn);
+int early_simplify_preop(struct expression *expr);
=20
 int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo);
=20
