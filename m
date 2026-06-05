Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093564C8FFD
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659070; cv=none; b=tBCVfvjAMQpn8CReU2mz1eGasJL7Ic7ejilh4oue92yU7wQpceN+EzbtxbztydoHqcSyOxBmXgWE8CC1BmbCosiOqDOb7wkwU05csRAIO1nngD6l0COF6MiJBNkg6Ojt0c/hH+FNltM8KMckkfVy5Ihwlyr1rNuMsZXjFX7TALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659070; c=relaxed/simple;
	bh=mHSvhLilcJ8VuFuqcd9tocuM4VOBzDhKMKT4YE+07iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYgaXidGD2+w4eCznCorGYGb7z6U8IC42KD3Rq0sd5r2Wjl4eZTBpixWqJ2nccwe/mybUusPam9a/01WF4u4/t0lknVBLCcuNqbQzoKNDMFQBMPg7VKvzWSZUs+IDXzQDOMVqtwSEuz5ROhGQ6GykoqArMgfLDKHEPzUmNvFgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ShoIPYDv; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ShoIPYDv"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 46FBDD120D;
	Fri, 05 Jun 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1780659067;
	bh=/tUOK+mEotLDa1FWbzPQ301or5GmuZa1h3jo9htUyrA=;
	h=From:To:Cc:Subject:Date;
	b=ShoIPYDvWR8M/XGZG1ElZowrRH23hZXqt36TjcSWeyQnxkv8DMEaJZ7mAvFLAiYm4
	 Llop/KRQYk5P14BVB1hMvRR6GE5xxrf+rzqu3zjKkp9GXBCFbjLIAePS+XxmcftQhE
	 7+4oxbQC8IAm66R1s9B1zh5a6EcdykoeiIRNsevM=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] accept an empty attribute argument list
Date: Fri,  5 Jun 2026 11:30:45 +0000
Message-ID: <20260605113045.483498-1-d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 parse.c                              | 17 +++++++++++++----
 validation/attribute-nonnull-empty.c | 12 ++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 validation/attribute-nonnull-empty.c

diff --git a/parse.c b/parse.c
index 9389079e..3b380156 100644
--- a/parse.c
+++ b/parse.c
@@ -1106,8 +1106,13 @@ static struct token *autotype_specifier(struct token *token, struct symbol *sym,
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	struct expression *expr = NULL;
-	if (match_op(token, '('))
-		token = parens_expression(token, &expr, "in attribute");
+	if (match_op(token, '(')) {
+		/* Accept an empty argument list, e.g. __attribute__((nonnull())) */
+		if (match_op(token->next, ')'))
+			token = token->next->next;
+		else
+			token = parens_expression(token, &expr, "in attribute");
+	}
 	return token;
 }
 
@@ -1362,8 +1367,12 @@ static struct token *recover_unknown_attribute(struct token *token)
 	if (Wunknown_attribute)
 		warning(token->pos, "unknown attribute '%s'", show_ident(token->ident));
 	token = token->next;
-	if (match_op(token, '('))
-		token = parens_expression(token, &expr, "in attribute");
+	if (match_op(token, '(')) {
+		if (match_op(token->next, ')'))
+			token = token->next->next;
+		else
+			token = parens_expression(token, &expr, "in attribute");
+	}
 	return token;
 }
 
diff --git a/validation/attribute-nonnull-empty.c b/validation/attribute-nonnull-empty.c
new file mode 100644
index 00000000..c4021f61
--- /dev/null
+++ b/validation/attribute-nonnull-empty.c
@@ -0,0 +1,12 @@
+/*
+ * An empty attribute argument list, like __attribute__((nonnull())), is
+ * accepted by GCC and Clang (equivalent to the bare __attribute__((nonnull)))
+ * and must be parsed by sparse too.
+ */
+extern void *bare (void *d, const void *s) __attribute__((nonnull));
+extern void *empty(void *d, const void *s) __attribute__((nonnull()));
+extern void *args (void *d, const void *s) __attribute__((nonnull(1, 2)));
+
+/*
+ * check-name: attribute with empty argument list
+ */
-- 
2.53.0-Meta

