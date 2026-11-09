Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256427;
	b=O3mtyXYtcu3CzOlttx5v1tarXfj2lJ2Qf6ZdNLphy6FJpvvPkfQU2ygLqXB42YBaB5CQ
	 AEXz6B4nf813J/oceJv4uXYqNxzErxGRYwmReJGx68Jv7stuPUn+K9Z5CsLYwHFr8xnR9
	 QsL1/0O21HBbIQZcvUHy3DUxsPSHegInpeABmUrF98a9+PPI6zwgDDA76H2o8I/3FkB+7
	 wLl4uuQ81StvX2OGYftb5Wxu7iW+EzwHywD1w40sOZYyyGmLU1uBmvVLBWyIur80LufLJ
	 CxdoJstT6W5az6fZmVZ1zCEOruYlWCgMOdy/zJF32HLuXYdSlst+5qKOOkzjJotFhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=UMwkkcA/2NtkTGHZrt2UgbKTdxOFI4CnBnZf78la1FU=;
	b=BXIFqvyJ6bIcNNJJ8wKmiVa3tBEV6ek2TY58ss7royFpkmfeIurjxZKyWeHlCB6y7XES
	 sPXZ7PmwSYguMBf8SYslo+ABuMRy0Zg2NbKzjECBdtQPvv4lsc/D7qNov3uO7EWfZL9R/
	 clqYV5dwo8W8kYmT9pKt6LtbjsEyMykDaQ6zhVZh89TwJbeNxAU0evnn0+3Hdj09pNpLj
	 MzYs486plHQ2QoLr0bm/AmZdptBI9g+qnpGDzamFJeopZhYk6EZ0A4ZuvGzlOERXhr9DM
	 cpvkH/Ph4HLyu8hLhnlGlvKsrlR0spF/E31p432cVPJtg5eZ5YTZm/GE7d37eFoVt+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DeB3Cu70;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F0606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 199F0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DeB3Cu70
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMB1f5hz1XLyht;
	Mon,  9 Nov 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=UMwkk
	cA/2NtkTGHZrt2UgbKTdxOFI4CnBnZf78la1FU=; b=DeB3Cu704bSFyvrh0T1gL
	rjkXEuMQlRcfowZAvArQgIN/+MWr+BlZ3y6HvIKZa8yQZ7VxlgPi/1+khGdrvlIm
	08l01H4h3fV8ehPPmHZwyjUaXQ3XjiBg6o5ET8Aa1mEBQs20RV/fkfJn+qLd0UiG
	QvmfCnEymKvJE1lvW5WoiI7eN24DRNISsZ0qx396ePzivxt0eUS9PMpomIrm6ezr
	GL7wPLUx4zApmXq9X96LXFtd7l1nVIGn6xMB0IMVf3zpSjCbrAKVQQd37JHrqI+o
	YZmGVCwaQiG1FC7IUk1SHKD4zDp3N64sCoJnhSAGKHjDk1XDMZ/Z0wcrLE2A5k3y
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wXVyVtsMTuPW; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM63nHmz1XMYJR;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 64/73] expand: Ignore top-level non-array address space in compare_types()
Date: Mon,  9 Nov 2026 12:32:50 -0800
Message-ID: <20261109203259.362845-65-bvanassche@acm.org>
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

Clear c1.as and c2.as in compare_types() only when base_type is not
SYM_ARRAY so that __builtin_types_compatible_p() ignores top-level scalar
address spaces while still distinguishing both pointer target address
spaces and array element address spaces.

Add active validation tests in validation/types-compatible-address-space.=
c
instead of placing assertions in check-known-to-fail typeof-addresspace.c=
.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expand.c                                    |  9 +++--
 validation/types-compatible-address-space.c | 39 +++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 validation/types-compatible-address-space.c

diff --git a/expand.c b/expand.c
index 815ff24ac487..57d3aeba0f4e 100644
--- a/expand.c
+++ b/expand.c
@@ -790,8 +790,13 @@ static int expand_comma(struct expression *expr)
=20
 static int compare_types(int op, struct symbol *left, struct symbol *rig=
ht)
 {
-	struct ctype c1 =3D {.base_type =3D left};
-	struct ctype c2 =3D {.base_type =3D right};
+	struct ctype c1 =3D left->type =3D=3D SYM_NODE ? left->ctype : (struct =
ctype){.base_type =3D left};
+	struct ctype c2 =3D right->type =3D=3D SYM_NODE ? right->ctype : (struc=
t ctype){.base_type =3D right};
+
+	if (!c1.base_type || c1.base_type->type !=3D SYM_ARRAY)
+		c1.as =3D NULL;
+	if (!c2.base_type || c2.base_type->type !=3D SYM_ARRAY)
+		c2.as =3D NULL;
 	switch (op) {
 	case SPECIAL_EQUAL:
 		return !type_difference(&c1, &c2, MOD_IGN, MOD_IGN);
diff --git a/validation/types-compatible-address-space.c b/validation/typ=
es-compatible-address-space.c
new file mode 100644
index 000000000000..38953eca77e2
--- /dev/null
+++ b/validation/types-compatible-address-space.c
@@ -0,0 +1,39 @@
+#define __as1 __attribute__((address_space(1)))
+#define __as2 __attribute__((address_space(2)))
+
+typedef int __as1 as1_int_t;
+typedef int __as1 as1_arr_t[4];
+typedef int __as1 as1_mat_t[2][4];
+
+static void test_types_compatible_as(void)
+{
+	int __as1 obj, *ptr;
+
+	/* Top-level address space on scalar / pointer itself is ignored */
+	_Static_assert(__builtin_types_compatible_p(int __as1, int), "scalar as=
1 vs int");
+	_Static_assert(__builtin_types_compatible_p(as1_int_t, int), "typedef s=
calar as1 vs int");
+	_Static_assert(__builtin_types_compatible_p(typeof(obj), int), "typeof(=
obj) vs int");
+	_Static_assert(__builtin_types_compatible_p(typeof(*ptr), int), "typeof=
(*ptr) vs int");
+	_Static_assert(__builtin_types_compatible_p(int * __as1, int *), "ptr o=
wn as1 vs int *");
+
+	/* Pointee address space must match */
+	_Static_assert(!__builtin_types_compatible_p(int __as1 *, int *), "poin=
tee as1 vs default");
+	_Static_assert(!__builtin_types_compatible_p(typeof(ptr), int *), "type=
of(ptr) vs int *");
+	_Static_assert(!__builtin_types_compatible_p(int __as1 *, int __as2 *),=
 "pointee as1 vs as2");
+	_Static_assert(__builtin_types_compatible_p(int __as1 *, int __as1 *), =
"pointee as1 vs as1");
+
+	/* Array element address space must match */
+	_Static_assert(!__builtin_types_compatible_p(int __as1[4], int[4]), "ar=
ray elem as1 vs default");
+	_Static_assert(!__builtin_types_compatible_p(as1_arr_t, int[4]), "typed=
ef array as1 vs int[4]");
+	_Static_assert(!__builtin_types_compatible_p(typeof(as1_arr_t), int[4])=
, "typeof(as1_arr_t) vs int[4]");
+	_Static_assert(!__builtin_types_compatible_p(int __as1[4], int __as2[4]=
), "array elem as1 vs as2");
+	_Static_assert(__builtin_types_compatible_p(int __as1[4], int __as1[4])=
, "array elem as1 vs as1");
+	_Static_assert(!__builtin_types_compatible_p(int __as1[2][4], int[2][4]=
), "2d array elem as1 vs default");
+	_Static_assert(!__builtin_types_compatible_p(as1_mat_t, int[2][4]), "ty=
pedef 2d array as1 vs int[2][4]");
+	_Static_assert(__builtin_types_compatible_p(int __as1[2][4], int __as1[=
2][4]), "2d array elem as1 vs as1");
+}
+
+/*
+ * check-name: types-compatible-address-space
+ * check-command: sparse $file
+ */
