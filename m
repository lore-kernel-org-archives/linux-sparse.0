Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256423;
	b=Zdcu5UJ8Ynh8AtZ6wHefY2lsJQgognxDgXEHX/uNnamrUkvx/CC8QL5x/HcuGan0lWYb
	 xcEFFhlBslXvA7R4TavwvhDpCa0yHIztnc+usS1rRUCb73kWz7wKrIMWeZViUMGeHuN9k
	 YPI6kGMgfWff8pHKfqmI1cF7ujszMrQVfmusXKj/wgF21dnp88leeo1pULCwyVZ00v3p7
	 FD8wBrqmgn+oZSw0c7KWeeiORX/UDrED20SA7NgRJSn1cC3VJCGc2OiJ7xuX0NZKQ3oeR
	 9ngYRfoV5VwkuJcosL4sJ21seEd5OciNhexDOGp57zw683kZMI93FML5dPjPRxH4XLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YSgPcwPPMcSZmEoTDkTyqTI4picvMndjbwy3COe/JfA=;
	b=5MIqjyWSdwKGjWVy8anL3NEDveHPNswBUP3FWubMbpFkqnHRUC7gEUjAfApnvewDRR3A
	 6fSPZlFzBdXaWk5uH1D0oxlLly+0JaEFI3Uryd0coC+S2B7Twbuyz236Cvj5Y+ABJBiJb
	 3jU+y9Ny3iIflFpJGXM6MebTAIP9MTA9WVaiIB/Lzbi07CkL/SaihL4adTFms3LcmUrjg
	 lWcq6m5iVk2irG53EcSz4cQw7XxmOSX7U1ZoXuwEgmGeghakQDbHcMZfjTL314uKZ6lVB
	 7VBvsfkcZbzVjpTAt3V/Z8DleiehyMNAtzIydFJNIBReK2tBWiX0v8bfvOZjyG7meHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yZP74UcW;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD69606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD69606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=yZP74UcW
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM63Sjdz1XMG4K;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=YSgPc
	wPPMcSZmEoTDkTyqTI4picvMndjbwy3COe/JfA=; b=yZP74UcWWZMYJOKr3oXyL
	OqfC1uiDA8JnZkNVujoYN6Q/gm2bY3aX+qXJrJ8/v21GODvr4Jiy07koPRTpCm5y
	Y0OQoo3X7livPkPFeHLOJhEhAWGUyfREPZsgyWUHqtv0V0K929JBsyFbvTUfxrwd
	49OKcNB3/fJdrOVhPxMlU++P6nyJJwtxbQWQ4UCrrHAswXp5/BezWJsGDGpudLOV
	Aqp1Wfam1VXPxh4yKiMt8/Bd+Pra9MBe/lrgiLWiwzjJMVToRZY4+jd3Jyo8Tann
	25vELB8T+3w297e7PdxKw2HqDpOCvSQln5rpTw2fAtMOny3KF4TfHzwBGkKzQd5m
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id paJEZb0rScPm; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLz68vMz1XMYJW;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 34/73] bitwise: Allow restricted ordered compares with unrestricted values
Date: Mon,  9 Nov 2026 12:32:20 -0800
Message-ID: <20261109203259.362845-35-bvanassche@acm.org>
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

Update restricted_binop() to check unrestricted values (0 and ~0) for
ordered comparisons just like equality comparisons, and warn when '<' or
'>' is used against 0 or ~0 because restricted types are unsigned and
those comparisons are always true or false.

Allow idiomatic bounds checks such as 'flags <=3D 0' or 'flags >=3D ~0' o=
n
bitwise types while catching tautological comparisons.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, require unsigned
  types in can_order() without warning on '<' or '>', pass the target
  type to restricted_value(), and extend
  validation/bitwise-all-bits-and-casts.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                              | 25 ++++++++++++++++++++++---
 validation/bitwise-all-bits-and-casts.c | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f4d59d2679d6..23f9e0fcdc4a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -465,7 +465,19 @@ static int restricted_value(struct expression *v, st=
ruct symbol *type)
 	return 0;
 }
=20
-static int restricted_binop(int op, struct symbol *type)
+/*
+ * Bitwise types can do ordered comparisons with
+ * the unrestricted values, but not in general
+ */
+static bool can_order(struct symbol *type, struct expression *left, stru=
ct expression *right)
+{
+	if (!is_unsigned_restricted_or_int(type))
+		return false;
+	return !restricted_value(left, type) ||
+		!restricted_value(right, type);
+}
+
+static int restricted_binop(int op, struct symbol *type, struct expressi=
on *left, struct expression *right)
 {
 	switch (op) {
 		case '&':
@@ -478,6 +490,13 @@ static int restricted_binop(int op, struct symbol *t=
ype)
 		case '^':
 		case '?':
 			return 2;	/* keep fouled */
+		case '<':
+		case '>':
+		case SPECIAL_LTE:
+		case SPECIAL_GTE:
+			if (can_order(type, left, right))
+				return 3;
+			return 0;
 		case SPECIAL_EQUAL:
 		case SPECIAL_NOTEQUAL:
 			return 3;	/* warn if fouled */
@@ -530,7 +549,7 @@ static struct symbol *restricted_binop_type(int op,
 		ctype =3D rtype;
=20
 	if (ctype) {
-		switch (restricted_binop(op, ctype)) {
+		switch (restricted_binop(op, ctype, left, right)) {
 		case 1:
 			if ((lclass ^ rclass) & TYPE_FOULED)
 				ctype =3D unfoul(ctype);
@@ -1364,7 +1383,7 @@ static int evaluate_assign_op(struct expression *ex=
pr)
 			return 0;
 		}
 		if (tclass & TYPE_RESTRICT) {
-			if (!restricted_binop(op, t)) {
+			if (!restricted_binop(op, t, expr->left, expr->right)) {
 				warning(expr->pos, "bad assignment (%s) to %s",
 					show_special(op), show_typename(t));
 				expr->right =3D cast_to(expr->right, target);
diff --git a/validation/bitwise-all-bits-and-casts.c b/validation/bitwise=
-all-bits-and-casts.c
index c69041f80318..08f2b4c43285 100644
--- a/validation/bitwise-all-bits-and-casts.c
+++ b/validation/bitwise-all-bits-and-casts.c
@@ -30,6 +30,24 @@ static be16 test_narrow_all_bits(void)
 	return a | b;
 }
=20
+static int test_ordered_compare(be32 x, be16 y)
+{
+	int res =3D 0;
+	if (x > 0)
+		res++;
+	if (x <=3D 0)
+		res++;
+	if (0 < x)
+		res++;
+	if (0 >=3D x)
+		res++;
+	if (x < ~0)
+		res++;
+	if (y <=3D 0xffff)
+		res++;
+	return res;
+}
+
 /*
  * check-name: bitwise-all-bits-and-casts
  * check-command: sparse -Wbitwise $file
