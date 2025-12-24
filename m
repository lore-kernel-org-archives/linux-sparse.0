Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB825201004
	for <linux-sparse@vger.kernel.org>; Wed, 24 Dec 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766576318; cv=none; b=f/iw3PTGP2z/TR/5v6I8Ks8fj+6xpUQBh+U8e2V5u7bUJhebbV6zItzi526fuUv2EJpPl0Il5P+dNii7YPbzQBmIOvSv8sUTeOVTQ35eaX+J5LdEa5fOeRn0BguSpgNg7juT6rhpizmNu6X0w4mDgmENMV4NAs+AGg7P3PsrODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766576318; c=relaxed/simple;
	bh=mNpO19fO9MF+AsIy9tYRBeLyyNhRdxjEi10GhTix83I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Po6kwd4/GSU7bYrgd6g3Ic1cXm7Zxey0aR5NPNUHbyDJlpXLt+NylcHy5bCfZYaBHrTBSU9OLgY5VKmhrjMRgMhOH+C3f6pR4UUAaVE5wNYoJJ3iFaLGS9SvO4qeSlH+uw7zYSVkBbQCQnYnFvQ77S91+Fja0PxXyGZ7FHiqIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZY7c6RR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZY7c6RR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766576315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=34EJpF30wqqTk3LFAHKokO6CodFlyTtIxX/FNKJwdNM=;
	b=VZY7c6RRU9wjMycatEiYHmav/iZufxP+XtPJAe3YslqR7tfd+qUFTLkbTGPnpG8mYhksaB
	EENdxBbbNdNve/1Tx+ve8vyeu7kZrOdXqvi6liaQRIT/So/lQBRsPtCoFl1IOBC+pfDT2Z
	fodt64fNX0lgmSTbnImtKlKz9p2/9Rk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-QbnNCyuaO0SfbxCWanyjWg-1; Wed,
 24 Dec 2025 06:38:32 -0500
X-MC-Unique: QbnNCyuaO0SfbxCWanyjWg-1
X-Mimecast-MFC-AGG-ID: QbnNCyuaO0SfbxCWanyjWg_1766576311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A7D195608E;
	Wed, 24 Dec 2025 11:38:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.73])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B76FA19560A7;
	Wed, 24 Dec 2025 11:38:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Dec 2025 12:38:31 +0100 (CET)
Date: Wed, 24 Dec 2025 12:38:23 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/dissect: introduce do_inline(struct symbol *sym)
Message-ID: <aUvQr9q1ePtvSwCs@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tBZdVCpZ6yoRxWKJWHUlHiDNDy-J9zaGML9ms1gN5_Y_1766576311
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

parse_function_body() doesn't do add_symbol(decl) if MOD_INLINE, this
means that dissect/semind can't see the definitions of inline functions
in translation_unit_used_list.

Test-case:

	$ cat -n INLINE.c
	     1	static inline void i_func(void)
	     2	{
	     3		unknown();
	     4	}
	     5
	     6	void func(void)
	     7	{
	     8		i_func();
	     9		i_func();
	    10	}

Before this patch:

	$ ./test-dissect INLINE.c

	   6:6                    def   f func                             void ( ... )
	   8:9   func             --r   f i_func                           void ( ... )
	   9:9   func             --r   f i_func                           void ( ... )

With this patch:

	$ ./test-dissect INLINE.c

	   6:6                    def   f func                             void ( ... )
	   1:20                   def   f i_func                           void ( ... )
	   3:9   i_func           --r   f unknown                          bad type
	   8:9   func             --r   f i_func                           void ( ... )
	   9:9   func             --r   f i_func                           void ( ... )

This change is not really needed if dissect_show_all_symbols == 1, in
this case do_file() uses file_scope/global_scope. do_inline() doesn't
bother to check dissect_show_all_symbols, it relies on sym->visited.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 5fed8e22..62f927c5 100644
--- a/dissect.c
+++ b/dissect.c
@@ -59,6 +59,7 @@ static void do_sym_list(struct symbol_list *list);
 
 static struct symbol
 	*base_type(struct symbol *sym),
+	*do_symbol(struct symbol *sym),
 	*do_initializer(struct symbol *type, struct expression *expr),
 	*do_expression(usage_t mode, struct expression *expr),
 	*do_statement(usage_t mode, struct statement *stmt);
@@ -331,6 +332,16 @@ static struct expression *peek_preop(struct expression *expr, int op)
 	return NULL;
 }
 
+static inline void do_inline(struct symbol *sym)
+{
+	if (sym && !sym->visited && (sym->ctype.modifiers & MOD_INLINE)) {
+		struct symbol *dctx = dissect_ctx;
+		dissect_ctx = NULL;
+		do_symbol(sym);
+		dissect_ctx = dctx;
+	}
+}
+
 static struct symbol *do_expression(usage_t mode, struct expression *expr)
 {
 	struct symbol *ret = &int_ctype;
@@ -377,8 +388,10 @@ again:
 		ret = do_expression(mode, expr->cond_false);
 
 	break; case EXPR_CALL:
-		if (expr->fn->type == EXPR_SYMBOL)
+		if (expr->fn->type == EXPR_SYMBOL) {
 			expr->fn->op = 'f'; /* for expr_symbol() */
+			do_inline(expr->fn->symbol);
+		}
 		ret = do_expression(U_R_PTR, expr->fn);
 		if (is_ptr(ret))
 			ret = ret->ctype.base_type;
@@ -621,7 +634,7 @@ static inline bool is_typedef(struct symbol *sym)
 	return (sym->namespace == NS_TYPEDEF);
 }
 
-static inline struct symbol *do_symbol(struct symbol *sym)
+static struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
 	struct symbol *dctx = dissect_ctx;
-- 
2.52.0


