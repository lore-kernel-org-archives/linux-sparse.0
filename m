Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256426;
	b=QEnfu8uSk6PjThYa+CjprAxPHOTjOFvUfn14oIfHohlv0aF8dasb2gROJ7xtUhLwr96u
	 7EPA0fnb4xDfaPi8JNGZUCxohUeGUrW+H04++uU/iD0uzw129GgxsgM3tGt68DU5ZHZ/K
	 yfDUzoJlImj4g0Ut4AUxJ2/xj9giXCZkBiG0ATEQ/OiVuqcLgjAdRKCBiKpgprXbWN7aE
	 u1LeDVNVU2CoixB4c/IK4RIgv/5/rG8DaDuxXQWJsHp0NvULWQqmuPHqhKuSyzUrHFzDJ
	 AqqdPIR5yYvEz4p3awEfD3rS4sn1fSIvafAFQ1/pMkr3ksDiGOctUiHJ3O8DK2nH51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=QJRhYRY8d2FNym1c/rfLJVqwhH+F6Rs5lBW0HxAfea8=;
	b=0WjI3yGf5BAGJD4MouJfISVXrV++dtbhvISHXaM3r/A+ah9gUHSl8dDXdlmrQdKREfuN
	 iK5gRauuEHrxyMI9L1spEyh9KM4BQ+l/7msz1aeG9nfSB5jPMPsg0zicA9v7UXnOPmcwE
	 Drk6ZqL3dW167ShclNyvQf0myDAXVitBx9BI3KeG5lA3SJ2MzW8pYWsuF/swE5TytUFX/
	 CfUKPF9w6mcKbhl8137OLhzZg4+qqbdLq5uRR70EVu4bNAD4gbIuJ1EWTirk+LUzbnDLY
	 01Y+YOanvpsZaNL2bkLXnyqFzkxCPbA4PxyaG+qkZr87KvCuCWtMaApJC0QybzHugsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uwvBD5CC;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F5606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533F5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uwvBD5CC
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM92MgQz1XMYJd;
	Mon,  9 Nov 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=QJRhY
	RY8d2FNym1c/rfLJVqwhH+F6Rs5lBW0HxAfea8=; b=uwvBD5CCq/sCnb2DZMife
	8WrovgZJDr1zVMUQfgDoh5HLs5egWdmVVgEf7GZpeAo6Y3QGjvIsN0cZbwMS0ANa
	jmfMCxYgzzKK4jxatW9wW4YcQZDcmvg9WgeJOX12MHuathvkSmFKuKRAUIh4wkl6
	58/m5bzfSsHRbkSjJW/JgfqnaCsEvJaSDvACVn7f+KFpATSwfpBrghgRbiRVNZ3q
	QMnEjz0tXpVOx23xzUmrOKddD7oiQ3EKlgM9Zs4Q/hsa1WPBuGDjeMUVAKuNMiQI
	pY2K0ZbBikuplbIxbVY/h6Oo8qhZTHhSLB8XbiJiIKkJg+LLuUQS/TrM52lB7Ol0
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wPBa5aqSeLLK; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM11YqVz1XMYJS;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 40/73] preprocessor: Add support for #elifdef and #elifndef
Date: Mon,  9 Nov 2026 12:32:26 -0800
Message-ID: <20261109203259.362845-41-bvanassche@acm.org>
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

Support the #elifdef and #elifndef preprocessing directives introduced in
C23 (WG14 N2645) as shorthand for #elif defined(...) and #elif
!defined(...), and emit a pedantic warning when used in language modes
prior to C23.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c                               | 71 +++++++++++++++++++--
 validation/preprocessor/c23-elifdef-error.c | 35 ++++++++++
 validation/preprocessor/c23-elifdef.c       | 44 +++++++++++++
 3 files changed, 145 insertions(+), 5 deletions(-)
 create mode 100644 validation/preprocessor/c23-elifdef-error.c
 create mode 100644 validation/preprocessor/c23-elifdef.c

diff --git a/pre-process.c b/pre-process.c
index ca019d704a10..aa59dca1ae97 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1713,39 +1713,98 @@ static int handle_if(struct stream *stream, struc=
t token **line, struct token *t
 	return preprocessor_if(stream, token, value);
 }
=20
-static int handle_elif(struct stream * stream, struct token **line, stru=
ct token *token)
+static int do_handle_elif(struct stream *stream, struct token *token,
+			  int (*eval)(struct token *),
+			  bool (*check)(struct token *))
 {
 	struct token *top_if =3D stream->top_if;
 	end_group(stream);
=20
 	if (!top_if) {
 		nesting_error(stream);
-		sparse_error(token->pos, "unmatched #elif within stream");
+		sparse_error(token->pos, "unmatched #%s within stream",
+			     show_token(token));
 		return 1;
 	}
=20
 	if (token_type(top_if) =3D=3D TOKEN_ELSE) {
 		nesting_error(stream);
-		sparse_error(token->pos, "#elif after #else");
+		sparse_error(token->pos, "#%s after #else", show_token(token));
 		if (!false_nesting)
 			false_nesting =3D 1;
 		return 1;
 	}
=20
 	dirty_stream(stream);
-	if (token_type(top_if) !=3D TOKEN_IF)
+	if (token_type(top_if) !=3D TOKEN_IF) {
+		if (false_nesting <=3D 1 && check)
+			check(token);
 		return 1;
+	}
 	if (false_nesting) {
 		false_nesting =3D 0;
-		if (!expression_value(&token->next))
+		if (!eval(token))
 			false_nesting =3D 1;
 	} else {
+		if (check)
+			check(token);
 		false_nesting =3D 1;
 		token_type(top_if) =3D TOKEN_SKIP_GROUPS;
 	}
 	return 1;
 }
=20
+static int eval_elif(struct token *token)
+{
+	return expression_value(&token->next);
+}
+
+static bool check_elifdef(struct token *token)
+{
+	struct token *next =3D token->next;
+
+	if (standard < STANDARD_C23 && Wpedantic)
+		warning(token->pos, "ISO C does not support #%s before C23",
+			show_token(token));
+	if (token_type(next) !=3D TOKEN_IDENT) {
+		sparse_error(token->pos, "expected preprocessor identifier");
+		return false;
+	}
+	if (!eof_token(next->next))
+		warning(next->next->pos,
+			"extra tokens at end of #%s directive",
+			show_token(token));
+	return true;
+}
+
+static int eval_elifdef(struct token *token)
+{
+	return check_elifdef(token) && token_defined(token->next);
+}
+
+static int eval_elifndef(struct token *token)
+{
+	return check_elifdef(token) && !token_defined(token->next);
+}
+
+static int handle_elif(struct stream *stream, struct token **line,
+		       struct token *token)
+{
+	return do_handle_elif(stream, token, eval_elif, NULL);
+}
+
+static int handle_elifdef(struct stream *stream, struct token **line,
+			  struct token *token)
+{
+	return do_handle_elif(stream, token, eval_elifdef, check_elifdef);
+}
+
+static int handle_elifndef(struct stream *stream, struct token **line,
+			   struct token *token)
+{
+	return do_handle_elif(stream, token, eval_elifndef, check_elifdef);
+}
+
 static int handle_else(struct stream *stream, struct token **line, struc=
t token *token)
 {
 	struct token *top_if =3D stream->top_if;
@@ -2163,6 +2222,8 @@ static void init_preprocessor(void)
 		{ "endif",	handle_endif },
 		{ "if",		handle_if },
 		{ "elif",	handle_elif },
+		{ "elifdef",	handle_elifdef },
+		{ "elifndef",	handle_elifndef },
 	};
 	static struct {
 		const char *name;
diff --git a/validation/preprocessor/c23-elifdef-error.c b/validation/pre=
processor/c23-elifdef-error.c
new file mode 100644
index 000000000000..606a780aa6d2
--- /dev/null
+++ b/validation/preprocessor/c23-elifdef-error.c
@@ -0,0 +1,35 @@
+#define FOO 1
+
+#if 1
+int taken =3D 1;
+#elifdef FOO
+int skipped1 =3D 1;
+#elifndef BAR
+int skipped2 =3D 1;
+#elifdef 123
+int skipped3 =3D 1;
+#endif
+
+#if 0
+#if 1
+#elifdef FOO
+#elifdef 123
+#endif
+#endif
+
+/*
+ * check-name: c23-elifdef-error
+ * check-command: sparse -std=3Dc17 -Wpedantic -E $file
+ *
+ * check-output-start
+
+int taken =3D 1;
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/c23-elifdef-error.c:5:2: warning: ISO C does not support #e=
lifdef before C23
+preprocessor/c23-elifdef-error.c:7:2: warning: ISO C does not support #e=
lifndef before C23
+preprocessor/c23-elifdef-error.c:9:2: warning: ISO C does not support #e=
lifdef before C23
+preprocessor/c23-elifdef-error.c:9:2: error: expected preprocessor ident=
ifier
+ * check-error-end
+ */
diff --git a/validation/preprocessor/c23-elifdef.c b/validation/preproces=
sor/c23-elifdef.c
new file mode 100644
index 000000000000..5772fb5eb432
--- /dev/null
+++ b/validation/preprocessor/c23-elifdef.c
@@ -0,0 +1,44 @@
+#define FOO 1
+
+#if 0
+int a =3D 0;
+#elifdef FOO
+int a =3D 1;
+#else
+int a =3D 2;
+#endif
+
+#if 0
+int b =3D 0;
+#elifdef BAR
+int b =3D 1;
+#elifndef BAR
+int b =3D 2;
+#else
+int b =3D 3;
+#endif
+
+#if 1
+int c =3D 1;
+#elifdef FOO
+int c =3D 2;
+#endif
+
+#if 1
+int d =3D 1;
+#elifndef BAR
+int d =3D 2;
+#endif
+
+/*
+ * check-name: c23-elifdef
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+int a =3D 1;
+int b =3D 2;
+int c =3D 1;
+int d =3D 1;
+ * check-output-end
+ */
