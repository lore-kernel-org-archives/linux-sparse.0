Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432618;
	b=5qDXuLIHsihWSkFdmqW3sjBrI8W+7bJJztbCj+wJOfqvJYPVODnUFN2VzCsfv5Pac6Z1
	 cmoV7BDVlmqFsAwGKgLSAAfGfdyskmweLnE32HSVxQo9eO9T24dKtOgktGe2JwRbA9e2z
	 IhRpJTaoLHrjWzXH4CnQn3Yi13RjskYN2/jXVSPIvI1+BaXTbHEWFc8CzU352W7x6SB+Y
	 Pu2J0YYhACQVSTIaD1+rfpmUOlsDgxu4DncW0kKKRYzYrHJofCC3DPcm90UyUl7QlC0iZ
	 +l2YcOAEnkFLNWbRLHVZ5qYPhr7GyXalLN981bwLXCkleGnW5qRFqGQuX/jVYmpJ44A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RwquHYRpL6xzZ6ruGGX/+Zb0GJ1AK7WteJqN720NP2s=;
	b=w438CB5GTu56duIscHz9PHWNPJnx0fcb8SC1+h1BrEmVOJNzTzcyXrOIfvS4SNagM8OO
	 COvxefT5yzg82tNC2jLONDm6vOdzLoiLU3QM7GcrCeR8laON+VI5ubf5XPgDC1VwWSTNJ
	 50ZmEYPkAFJWFkqAcm0DVeRUvSROdbIHiZffIhjXbGhaOPOD5bMJKjt2sS9Swj0GplGeC
	 UVg1UwB6hcTFCcf6fgL87sC75J/XUbx3XDU6oNQy4C4XXy50HziYFua5DNoO9/Ri84lae
	 LCyKnlzZhIVlGdk7Y7InwGpqQGw550Ff4ATQbpQZO8Rse4q5Y9HQpVv+2hYOXHi8gbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IOwfohjy;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125B606A31B
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7125B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=IOwfohjy
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jst2yMmz1XM30w;
	Mon, 19 Oct 2026 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432607; x=1795024608; bh=RwquH
	YRpL6xzZ6ruGGX/+Zb0GJ1AK7WteJqN720NP2s=; b=IOwfohjypZV5Q/OknLobN
	WyhxvrkioAM1nFQGxHiEWDI+FzJRYYx8p97i35kMWmqB7S2Y0jxDoaLmYeioQzQa
	NhCM+9IhUFgAVmsHtw1I+E0RH3m4+4/CICUq6WpZpd1SBQ2uX3LDqLX6Gt4h+etN
	ar+Hyri7yUgGmxUyvqZYbtgjWpyVB8y5VCUr4q/Yi3HjXJVfUW75YMu0ndCtQep1
	shZAYKqTN5KfyWt4CCkpGzTduEI2pSIQ1z4OBa3PmroyMTukkDKvRvz/8YofiwfF
	9jyMJoPktpFsnyfTkWDW0le3JxkOzdk3j3Yctod+BjDGbD0hK7AlT++MQ0Su1rEH
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id V9WbjHO1R2v4; Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsp3Lpqz1XM6JG;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH 18/20] parse: Accept an empty attribute argument list
Date: Mon, 19 Oct 2026 10:56:31 -0700
Message-ID: <20261019175633.415493-19-bvanassche@acm.org>
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

From: Dmitry Ilvokhin <d@ilvokhin.com>

GCC and clang accept an empty argument list for attributes, e.g.
__attribute__((nonnull())), and treat it the same as the bare
__attribute__((nonnull)). sparse instead rejects it with
"an expression is expected before ')'".

ignore_attribute() and recover_unknown_attribute() consume the optional
argument list with parens_expression(), which requires a non-empty
expression, so an empty () is rejected. The bare form is fine because it
takes no parentheses and skips that path.

This turned up in the Linux kernel: the cleanup.h guard macros expand
__nonnull_args() to __attribute__((__nonnull__())).

  https://lore.kernel.org/all/aiJi0WcYE8FZt-jO@stanley.mountain/

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
Tested-by: Dan Carpenter <error27@gmail.com>
[ bvanassche: added "parse" prefix to the patch subject ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                              | 17 +++++++++++++----
 validation/attribute-nonnull-empty.c | 12 ++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 validation/attribute-nonnull-empty.c

diff --git a/parse.c b/parse.c
index 0e3e384550c5..1a889ccb6a90 100644
--- a/parse.c
+++ b/parse.c
@@ -1106,8 +1106,13 @@ static struct token *autotype_specifier(struct tok=
en *token, struct symbol *sym,
 static struct token *ignore_attribute(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
 	struct expression *expr =3D NULL;
-	if (match_op(token, '('))
-		token =3D parens_expression(token, &expr, "in attribute");
+	if (match_op(token, '(')) {
+		/* Accept an empty argument list, e.g. __attribute__((nonnull())) */
+		if (match_op(token->next, ')'))
+			token =3D token->next->next;
+		else
+			token =3D parens_expression(token, &expr, "in attribute");
+	}
 	return token;
 }
=20
@@ -1362,8 +1367,12 @@ static struct token *recover_unknown_attribute(str=
uct token *token)
 	if (Wunknown_attribute)
 		warning(token->pos, "unknown attribute '%s'", show_ident(token->ident)=
);
 	token =3D token->next;
-	if (match_op(token, '('))
-		token =3D parens_expression(token, &expr, "in attribute");
+	if (match_op(token, '(')) {
+		if (match_op(token->next, ')'))
+			token =3D token->next->next;
+		else
+			token =3D parens_expression(token, &expr, "in attribute");
+	}
 	return token;
 }
=20
diff --git a/validation/attribute-nonnull-empty.c b/validation/attribute-=
nonnull-empty.c
new file mode 100644
index 000000000000..c4021f61db0e
--- /dev/null
+++ b/validation/attribute-nonnull-empty.c
@@ -0,0 +1,12 @@
+/*
+ * An empty attribute argument list, like __attribute__((nonnull())), is
+ * accepted by GCC and Clang (equivalent to the bare __attribute__((nonn=
ull)))
+ * and must be parsed by sparse too.
+ */
+extern void *bare (void *d, const void *s) __attribute__((nonnull));
+extern void *empty(void *d, const void *s) __attribute__((nonnull()));
+extern void *args (void *d, const void *s) __attribute__((nonnull(1, 2))=
);
+
+/*
+ * check-name: attribute with empty argument list
+ */
