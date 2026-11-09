Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256420;
	b=nKr6ia+S5+et6Yi+6LEErr5kSEjt0GRg1mcdknnWJMits7PMb5DnoRXDaNglk5Qkc19q
	 h1y5Ye4g0oXeR00zI9jh89krsckNac8uUxD/AU+PbRKHWbk736hPPNkINRZm6ii8XpasK
	 vI30iCURPMfysOnxJ72Q08mEngG2x8p6njVa0l723l46JFqoXyVlYJZO+8kzXz3DPewFu
	 4E4DJIWHKP9fyZTG7rn/+KtoAsgF59l2TPslZH2exSYV+THk/0Z0f7tNFUdGwOdRJ4fC3
	 JkFmDvP1WZHpneLxNKuPwUXaA4El5/LCoF+0Ln8ayHNim3PtAxm3qx8xHe0Ka+4jSpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=IQlpu4B7Tfb/jarJpHhvYkojyeCKAgNO7rf9gVNcy28=;
	b=Lz9vezdCyGW8S8hq0twubQyaRuyO1xk3cGCI0+yOyhlwYpzvg5Db3cmkTvrxC4rEPgin
	 0zj2Zfq0ZI6BvTBQTezOuO3vuVtzPCLTBXPlL8LEwUada2Zdt+PHe1+fgWDd6hX7+ikDm
	 bzrInoKojio6javbPWKGgbezC+7Ur39+YEwylAzMofDnCIv6SoopDs8ugbCCEVsQX1Z3B
	 Y417lgly2StSd47vR1Lqw3WIZqmt+KHaCmoZ/necTa/4cXtM8tCIKv70Rj2/7cO/XkWW6
	 HCYqEf0TkLxQHZonSggBP15e3o1yhgMWvXvCO2k3/yS2dwAS/L8vm9mWef+DG6etgfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1glqHpzx;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA93606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA93606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1glqHpzx
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM44RBTz1XLwXN;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=IQlpu
	4B7Tfb/jarJpHhvYkojyeCKAgNO7rf9gVNcy28=; b=1glqHpzxDIBnvIV+/V7ec
	WvQA4+4ix2Utp+TL8vsR0arToiTGjaTgeLMHHzX4A225XTnVdvaLfr8/QFoXAGip
	lhIxr1lofCNK6ytSToZeKPpMU4iZMsjXBIOwcsZX89O4gCv5acDQNa0ZsuZQxRpa
	UHsQkptACC4ok/miWwAvnd0xx4Y9OlVt0E/ny//pu6jRjFCs88Ag3A3110Hr/i0A
	iN0Z0MzncUB8stFzA6PKkxkKY+NujoJWXdLOsKEup7aA/jdgPAz1jl3NNMqmfLW4
	jVSo9CzgM3aF06Qmrbx8bXXg+Ziv9O27fRB5JT+/NJrVxpde4cGNx5Y6TfjFfd/x
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eRFgGXzMLtyb; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLy40Dkz1XM5kD;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 28/73] inline: Duplicate generic expressions instead of evaluating them
Date: Mon,  9 Nov 2026 12:32:14 -0800
Message-ID: <20261109203259.362845-29-bvanassche@acm.org>
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

Duplicate the EXPR_GENERIC expression, its control expression, its
default expression, and each type-expression map entry during function
inlining instead of evaluating the generic selection prematurely.

Prevent copy_symbol() from traversing already-evaluated expressions
where compound literals (such as &(size_t){ 0 }) produce anonymous local
symbols without replacement symbols and trigger false 'unreplaced symbol
<noident>' warnings.

Allow evaluate_statement() to evaluate the selected branch of the copied
generic expression when the expanded inlined function body is evaluated,
and add validation/inline-generic.c.

Fixes: eb6779f6f621 ("generic: fix missing inlining of generic expression=
")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 inline.c                    | 18 ++++++++++++++----
 validation/inline-generic.c | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/inline.c b/inline.c
index 1948bea52ffb..d94fba807d19 100644
--- a/inline.c
+++ b/inline.c
@@ -345,13 +345,23 @@ static struct expression * copy_expression(struct e=
xpression *expr)
 		}
 		break;
 	}
-	case EXPR_GENERIC:
+	case EXPR_GENERIC: {
+		struct type_expression *map, **p;
 		expr =3D dup_expression(expr);
 		expr->control =3D copy_expression(expr->control);
-		if (!evaluate_expression(expr))
-			return NULL;
-		expr =3D copy_expression(expr);
+		expr->def =3D copy_expression(expr->def);
+		p =3D &expr->map;
+		for (map =3D expr->map; map; map =3D map->next) {
+			struct type_expression *new_map =3D __alloc_type_expression(0);
+			*new_map =3D *map;
+			new_map->type =3D copy_type(map->type);
+			new_map->expr =3D copy_expression(map->expr);
+			*p =3D new_map;
+			p =3D &new_map->next;
+		}
+		*p =3D NULL;
 		break;
+	}
=20
 	default:
 		warning(expr->pos, "trying to copy expression type %d", expr->type);
diff --git a/validation/inline-generic.c b/validation/inline-generic.c
index 1f05c07904b5..3bf97eb69c53 100644
--- a/validation/inline-generic.c
+++ b/validation/inline-generic.c
@@ -5,6 +5,31 @@ inline unsigned f(void) { return e(_Generic(b, int: c())=
); }
 static int g(void) { return f(); }
 static int h(void) { return f(); }
=20
+inline void *cl(void)
+{
+	return _Generic((void *)0,
+			void *: &(int){ 0 },
+			default: (void *)0);
+}
+
+static void test_cl(void)
+{
+	cl();
+}
+
+static inline int inl_gen_vla(int n, void *p)
+{
+	return _Generic((int (*)[n])p,
+			int (*)[n]: (int)sizeof(int [n]),
+			default: 0);
+}
+
+static int test_gen_vla(int x, int y, void *p)
+{
+	return inl_gen_vla(x, p) + inl_gen_vla(y, p);
+}
+
 /*
  * check-name: inline-generic
+ * check-command: sparse -Wno-vla $file
  */
