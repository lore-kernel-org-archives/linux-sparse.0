Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256425;
	b=rOEJO5vSb0dzId9aHOY3miFmTC3I7cuhioqt4T+l+Sq5ynAygcoarJpQcQoP6E9NF1aT
	 68C8e820sJ5wpLayybJbqvDq8SJxIfdxVPA8zRhM/Cm28dWhQXX8i9ghPDNi+87GkAbZt
	 7ycuA1ECLEqQQWI7Jda+rWUbA3jrfRjjPlmTrk1ptxbWOEgBBd0R/nw8HCTRPPrmdYrvy
	 nvP2wqyCRpHyUqaD1xdyOIlezefvb+3INPjiKzW/9kw8rlM4M1uIlGkugJudO0iZjAUBf
	 oVcQAwyePAQoMS33u92ubhgtdjzCS476GB0/k4LJ6Pby/YUl2+mPuSrhKydzXOdHJ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1wLUwA3AamVtyVt8fxowkWoQYrt+r9lIcxZUXs1uYhI=;
	b=NkC/VDzM7f4B6rGZL1IzMUJbqSXflRlvON1puXZDfOmuRXm/DtvyqI/6Fz4r34Q3SFwT
	 LBXElah5r/TgeRlJANWZbG7VyWbKAaEexjqhOpRx28RmdCueswYZZmxkpdccU5+ZHTeox
	 k1kbBeTXKz4EUp0H9MetEV0jrlkDpJlsQz+cxF4wrDk3cGenAy/SCTjABIAacT2zdovbA
	 y5kxZjoMDPjOXVXM+s0UFOkq3z4cnk7LcNP+KlUMcSoDXzsZjH6K/9/7Z56QoJId2YiTF
	 y/op2qOqcma8bh6VACEFSxTIofERFgiESSh+fXM/Wh/Z+mweyQ+O7r45pfz9y2s39OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1WuZnaTu;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E10606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E10606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1WuZnaTu
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM72qvKz1XMYJY;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=1wLUw
	A3AamVtyVt8fxowkWoQYrt+r9lIcxZUXs1uYhI=; b=1WuZnaTuX3pY9XQZGPpSJ
	PG32JXLmEwPqXMXfqveCSgqSoIPai53QaAtC7ZTxElbTWEBgIl2nZyjx7beZ+pjL
	JiSDYrBeNlClyuMjh4z7RYNYD8LGvcpBIOE/a433ud92x+XBvz4Qy9Xi799QKRRh
	UquajFhS2pNf4+4GIPbj7BLFscGUpqeqeUcrE+pwzeRtNjLqMQR2WLGoHBt+3Xie
	Jx580na75zzXpLn6aHgn1qvXpYu+4bouFblqq0Plk41NNkYGfiFT9wl/reH9G44t
	zWppFpCcLCe+F0QFLMJPKg61xVnmycEX7Fl2kK/IUxtuOa8/aZXfYX3h6hY9VvZW
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fWcMbl-04MJW; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLy73yYz1XMYJT;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 30/73] cse, canon: Cast pointers to uintptr_t before relational comparison
Date: Mon,  9 Nov 2026 12:32:16 -0800
Message-ID: <20261109203259.362845-31-bvanassche@acm.org>
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

Cast pointer operands to uintptr_t before comparing them with relational
operators (<) in cse.c, simplify.c, and storage.c.

Avoid undefined behavior under ISO C when comparing pointers that do not
point to elements of the same object, and prevent AddressSanitizer
invalid-pointer-pair aborts under detect_invalid_pointer_pairs=3D2.

Fixes: fe8df476cce2 ("Add initial CSE pass")
Fixes: 37a29afc774f ("Start splitting out generic "storage"...")
Fixes: 84f84262a122 ("canon: simplify calculation of canonical order")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 cse.c      | 17 +++++++++--------
 simplify.c |  3 ++-
 storage.c  |  5 +++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/cse.c b/cse.c
index b59581814ab7..b7d0314a0400 100644
--- a/cse.c
+++ b/cse.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <stddef.h>
+#include <stdint.h>
 #include <assert.h>
=20
 #include "parse.h"
@@ -28,9 +29,9 @@ static int phi_compare(pseudo_t phi1, pseudo_t phi2)
 	const struct instruction *def2 =3D phi2->def;
=20
 	if (def1->src1 !=3D def2->src1)
-		return def1->src1 < def2->src1 ? -1 : 1;
+		return (uintptr_t)def1->src1 < (uintptr_t)def2->src1 ? -1 : 1;
 	if (def1->bb !=3D def2->bb)
-		return def1->bb < def2->bb ? -1 : 1;
+		return (uintptr_t)def1->bb < (uintptr_t)def2->bb ? -1 : 1;
 	return 0;
 }
=20
@@ -184,7 +185,7 @@ static int insn_compare(const void *_i1, const void *=
_i2)
=20
 	case OP_SEL:
 		if (i1->src3 !=3D i2->src3)
-			return i1->src3 < i2->src3 ? -1 : 1;
+			return (uintptr_t)i1->src3 < (uintptr_t)i2->src3 ? -1 : 1;
 		/* Fall-through to binops */
=20
 	/* Binary arithmetic */
@@ -208,7 +209,7 @@ static int insn_compare(const void *_i1, const void *=
_i2)
 	case OP_FDIV:
 	case_binops:
 		if (i1->src2 !=3D i2->src2)
-			return i1->src2 < i2->src2 ? -1 : 1;
+			return (uintptr_t)i1->src2 < (uintptr_t)i2->src2 ? -1 : 1;
 		/* Fall through to unops */
=20
 	/* Unary */
@@ -216,17 +217,17 @@ static int insn_compare(const void *_i1, const void=
 *_i2)
 	case OP_FNEG:
 	case OP_SYMADDR:
 		if (i1->src1 !=3D i2->src1)
-			return i1->src1 < i2->src1 ? -1 : 1;
+			return (uintptr_t)i1->src1 < (uintptr_t)i2->src1 ? -1 : 1;
 		break;
=20
 	case OP_LABEL:
 		if (i1->bb_true !=3D i2->bb_true)
-			return i1->bb_true < i2->bb_true ? -1 : 1;
+			return (uintptr_t)i1->bb_true < (uintptr_t)i2->bb_true ? -1 : 1;
 		break;
=20
 	case OP_SETVAL:
 		if (i1->val !=3D i2->val)
-			return i1->val < i2->val ? -1 : 1;
+			return (uintptr_t)i1->val < (uintptr_t)i2->val ? -1 : 1;
 		break;
=20
 	case OP_SETFVAL:
@@ -244,7 +245,7 @@ static int insn_compare(const void *_i1, const void *=
_i2)
 	case OP_PTRCAST:
 	case OP_UTPTR: case OP_PTRTU:
 		if (i1->src !=3D i2->src)
-			return i1->src < i2->src ? -1 : 1;
+			return (uintptr_t)i1->src < (uintptr_t)i2->src ? -1 : 1;
=20
 		// Note: if it can be guaranted that identical ->src
 		// implies identical orig_type->bit_size, then this
diff --git a/simplify.c b/simplify.c
index 2ddaf1c619a8..88f261da297e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -40,6 +40,7 @@
 // * `SHIFT(x, S)` is used for `LSR(x, S)` or `SHL(x, S)`.
=20
 #include <assert.h>
+#include <stdint.h>
=20
 #include "parse.h"
 #include "expression.h"
@@ -1814,7 +1815,7 @@ static int canonical_order(pseudo_t p1, pseudo_t p2=
)
 		return 0;
 	switch (t1) {
 	case PSEUDO_SYM:
-		return p1->sym <=3D p2->sym;
+		return (uintptr_t)p1->sym <=3D (uintptr_t)p2->sym;
 	case PSEUDO_REG:
 	case PSEUDO_ARG:
 		return p1->nr <=3D p2->nr;
diff --git a/storage.c b/storage.c
index 160d424ee1f6..1dafa08dccf0 100644
--- a/storage.c
+++ b/storage.c
@@ -8,6 +8,7 @@
  */
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <assert.h>
=20
 #include "symbol.h"
@@ -33,7 +34,7 @@ static int hash_list_cmp(const void *_a, const void *_b=
)
 	const struct storage_hash *a =3D _a;
 	const struct storage_hash *b =3D _b;
 	if (a->pseudo !=3D b->pseudo)
-		return a->pseudo < b->pseudo ? -1 : 1;
+		return (uintptr_t)a->pseudo < (uintptr_t)b->pseudo ? -1 : 1;
 	return 0;
 }
=20
@@ -118,7 +119,7 @@ static int storage_hash_cmp(const void *_a, const voi=
d *_b)
 	struct storage *bb =3D b->storage;
=20
 	if (a->bb !=3D b->bb)
-		return a->bb < b->bb ? -1 : 1;
+		return (uintptr_t)a->bb < (uintptr_t)b->bb ? -1 : 1;
 	if (a->inout !=3D b->inout)
 		return a->inout < b->inout ? -1 : 1;
 	if (aa->type !=3D bb->type)
