Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D1386C9
	for <linux-sparse@vger.kernel.org>; Sun, 21 Dec 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766327298; cv=none; b=e/pzP+EUiopHHA0Kevdt5EpNF7+kndO8xvXiu5+NLQq9H8mvv3vqD/ofbTlf/pY83BXqeIYzEETi1E1uPLHPYMsEwMlqmeW9+lIR768ZGbkD5ZC4BIK4Nat4wm/Klf90LLpbznhhK+W6XfQ3gwvCid8UPXRMxUvTKD/jt90YNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766327298; c=relaxed/simple;
	bh=rL65uBtwdd7jJshynB84paE+Yrl55oBOiWW9YgXrh0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nmEBTqrdAVK3sSaYBY8BsAAZcBgwwFJ/yY4ZEUIOHsNHVHlvJe3StnAYFgkgoio8MK2PJ1CYRPGeJu1l2HIOLs0DuXmE1SkwwDDl5g+YIqLHK5dOSLVG2YAKBe7gmj/u77aWUck5795J1cINhiNHAiHBgffa4+JJ4FdaEm5bNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Jy5izH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Jy5izH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766327290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eEqAVcKDowKnloawicw3Hx/21CRj/FzWqwTmrvxjVN8=;
	b=S1Jy5izHAiMMZ+0vmP8ZXQ7D8yYKCvMFpCMN8MhNN73AzElXKwllB3ndREirs16qokC8kv
	Ctp4z3dmoqBS21imgQ6DsJhuuuYXAUbuhoTFbVtixAzMUxl+MKMyFR7AA44aEONn88q8N1
	PQ+g0DZ+fmzGmzXozYr/NLdGbTf4k2M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-L97Ld0k-NKShe-hoKDBeCA-1; Sun,
 21 Dec 2025 09:28:05 -0500
X-MC-Unique: L97Ld0k-NKShe-hoKDBeCA-1
X-Mimecast-MFC-AGG-ID: L97Ld0k-NKShe-hoKDBeCA_1766327284
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BB84180028B;
	Sun, 21 Dec 2025 14:28:04 +0000 (UTC)
Received: from fedora (unknown [10.44.32.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 72D261953984;
	Sun, 21 Dec 2025 14:28:02 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 21 Dec 2025 15:28:07 +0100 (CET)
Date: Sun, 21 Dec 2025 15:28:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/parse: update decl->pos when direct_declarator() sees
 TOKEN_IDENT
Message-ID: <aUgD9MIbq4V3JKA1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jvQMkwG0tbzykogWfDDhEOPkD43CIpOaTr7MAdmvm2k_1766327284
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Test-case:

	$ cat -n DECL_POS.c
	     1	void
	     2	 *       ptr,
	     3	 *   (*  fptr  ) (int),
	     4	 *       ary[2];
	     5
	     6	struct T {
	     7	 void
	     8	  *      mptr1[],
	     9	  *      mptr2[];
	    10	 int     dummy;
	    11	};
	    12
	    13	static void func(struct T *t)
	    14	{
	    15		__builtin_offsetof(typeof(*t), dummy);
	    16	}

Note that all variables/members are defined at column 10.

However, before this patch

	$ ./sparse DECL_POS.c
	DECL_POS.c:2:2: warning: symbol 'ptr' was not declared. Should it be static?
	DECL_POS.c:3:2: warning: symbol 'fptr' was not declared. Should it be static?
	DECL_POS.c:4:2: warning: symbol 'ary' was not declared. Should it be static?
	DECL_POS.c:8:3: error: flexible array member 'mptr1' is not last
	DECL_POS.c:9:3: error: flexible array member 'mptr2' is not last

every reported position is wrong.

This is because the users of declarator() do alloc_symbol(token->pos),
but the current token is not necessarily the ident found later in the
declarator() paths.

With this patch:

	$ ./sparse DECL_POS.c
	DECL_POS.c:2:10: warning: symbol 'ptr' was not declared. Should it be static?
	DECL_POS.c:3:10: warning: symbol 'fptr' was not declared. Should it be static?
	DECL_POS.c:4:10: warning: symbol 'ary' was not declared. Should it be static?
	DECL_POS.c:8:10: error: flexible array member 'mptr1' is not last
	DECL_POS.c:9:10: error: flexible array member 'mptr2' is not last

See also the fixes in validation/{function-redecl,reserved}.c, some
of the old positions in the check-error-start/end blocks were wrong.

TODO: there are more users of users of declarator() which should
probably be updated the same way.

NOTE: unlike external_declaration(), declaration_list() doesn't check
ident != NULL, so ./sparse doesn't complain about "struct { int; };",
this should probably be fixed.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 parse.c                      |   5 ++
 symbol.h                     |   1 +
 validation/function-redecl.c |  16 ++--
 validation/reserved.c        | 144 +++++++++++++++++------------------
 4 files changed, 86 insertions(+), 80 deletions(-)

diff --git a/parse.c b/parse.c
index 9389079e..1166ab7b 100644
--- a/parse.c
+++ b/parse.c
@@ -1821,6 +1821,8 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 
 	if (ctx->ident && token_type(token) == TOKEN_IDENT) {
 		*ctx->ident = token->ident;
+		if (ctx->d_pos)
+			*ctx->d_pos = token->pos;
 		token = token->next;
 	} else if (match_op(token, '(') &&
 	    is_nested(token, &next, ctx->prefer_abstract)) {
@@ -1945,6 +1947,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
 		ctx.cleanup = NULL;
 		ctx.ident = &decl->ident;
+		ctx.d_pos = &decl->pos;
 
 		token = declarator(token, &ctx);
 		if (match_op(token, ':'))
@@ -2963,6 +2966,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	saved = ctx.ctype;
+	ctx.d_pos = &decl->pos;
 	token = declarator(token, &ctx);
 	token = handle_asm_name(token, &ctx);
 	token = handle_attributes(token, &ctx);
@@ -3089,6 +3093,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		ctx.ctype = saved;
 		ctx.cleanup = NULL;
+		ctx.d_pos = &decl->pos;
 		token = handle_attributes(token, &ctx);
 		token = declarator(token, &ctx);
 		token = handle_asm_name(token, &ctx);
diff --git a/symbol.h b/symbol.h
index 3552d439..52f0977a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -107,6 +107,7 @@ struct ctype {
 struct decl_state {
 	struct ctype ctype;
 	struct ident **ident;
+	struct position *d_pos;
 	struct symbol_op *mode;
 	struct expression *cleanup;
 	unsigned long f_modifiers;		// function attributes
diff --git a/validation/function-redecl.c b/validation/function-redecl.c
index d0d844a5..272d4ac9 100644
--- a/validation/function-redecl.c
+++ b/validation/function-redecl.c
@@ -56,14 +56,14 @@ function-redecl.c:9:11: error: symbol 'ret_const' redeclared with different type
 function-redecl.c:9:11:    int extern const [addressable] [signed] [toplevel] ret_const( ... )
 function-redecl.c:8:5: note: previously declared as:
 function-redecl.c:8:5:    int extern [addressable] [signed] [toplevel] ret_const( ... )
-function-redecl.c:13:13: error: symbol 'ret_as' redeclared with different type (different address spaces):
-function-redecl.c:13:13:    void <asn:1> *extern [addressable] [toplevel] ret_as( ... )
-function-redecl.c:12:6: note: previously declared as:
-function-redecl.c:12:6:    void *extern [addressable] [toplevel] ret_as( ... )
-function-redecl.c:17:12: error: symbol 'ret_mod' redeclared with different type (different modifiers):
-function-redecl.c:17:12:    void const *extern [addressable] [toplevel] ret_mod( ... )
-function-redecl.c:16:6: note: previously declared as:
-function-redecl.c:16:6:    void *extern [addressable] [toplevel] ret_mod( ... )
+function-redecl.c:13:14: error: symbol 'ret_as' redeclared with different type (different address spaces):
+function-redecl.c:13:14:    void <asn:1> *extern [addressable] [toplevel] ret_as( ... )
+function-redecl.c:12:7: note: previously declared as:
+function-redecl.c:12:7:    void *extern [addressable] [toplevel] ret_as( ... )
+function-redecl.c:17:13: error: symbol 'ret_mod' redeclared with different type (different modifiers):
+function-redecl.c:17:13:    void const *extern [addressable] [toplevel] ret_mod( ... )
+function-redecl.c:16:7: note: previously declared as:
+function-redecl.c:16:7:    void *extern [addressable] [toplevel] ret_mod( ... )
 function-redecl.c:21:6: error: symbol 'arg_type' redeclared with different type (incompatible argument 1 (different base types)):
 function-redecl.c:21:6:    void extern [addressable] [toplevel] arg_type( ... )
 function-redecl.c:20:6: note: previously declared as:
diff --git a/validation/reserved.c b/validation/reserved.c
index 6a2163e9..73995c6b 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -82,77 +82,77 @@ static int (__builtin_va_list);
 /*
  * check-name: const et.al. are reserved identifiers
  * check-error-start
-reserved.c:1:12: error: Trying to use reserved word 'auto' as identifier
-reserved.c:2:12: error: Trying to use reserved word 'break' as identifier
-reserved.c:3:12: error: Trying to use reserved word 'case' as identifier
-reserved.c:4:12: error: Trying to use reserved word 'char' as identifier
-reserved.c:5:12: error: Trying to use reserved word 'const' as identifier
-reserved.c:6:12: error: Trying to use reserved word '__const' as identifier
-reserved.c:7:12: error: Trying to use reserved word '__const__' as identifier
-reserved.c:8:12: error: Trying to use reserved word 'continue' as identifier
-reserved.c:9:12: error: Trying to use reserved word 'default' as identifier
-reserved.c:10:12: error: Trying to use reserved word 'do' as identifier
-reserved.c:11:12: error: Trying to use reserved word 'double' as identifier
-reserved.c:12:12: error: Trying to use reserved word 'else' as identifier
-reserved.c:13:12: error: Trying to use reserved word 'enum' as identifier
-reserved.c:14:12: error: Trying to use reserved word 'extern' as identifier
-reserved.c:15:12: error: Trying to use reserved word 'float' as identifier
-reserved.c:16:12: error: Trying to use reserved word 'for' as identifier
-reserved.c:17:12: error: Trying to use reserved word 'goto' as identifier
-reserved.c:18:12: error: Trying to use reserved word 'if' as identifier
-reserved.c:19:12: error: Trying to use reserved word 'inline' as identifier
-reserved.c:20:12: error: Trying to use reserved word '__inline' as identifier
-reserved.c:21:12: error: Trying to use reserved word '__inline__' as identifier
-reserved.c:22:12: error: Trying to use reserved word 'int' as identifier
-reserved.c:23:12: error: Trying to use reserved word 'long' as identifier
-reserved.c:24:12: error: Trying to use reserved word 'register' as identifier
-reserved.c:25:12: error: Trying to use reserved word 'restrict' as identifier
-reserved.c:26:12: error: Trying to use reserved word '__restrict' as identifier
-reserved.c:27:12: error: Trying to use reserved word '__restrict__' as identifier
-reserved.c:28:12: error: Trying to use reserved word 'return' as identifier
-reserved.c:29:12: error: Trying to use reserved word 'short' as identifier
-reserved.c:30:12: error: Trying to use reserved word 'signed' as identifier
-reserved.c:31:12: error: Trying to use reserved word 'sizeof' as identifier
-reserved.c:32:12: error: Trying to use reserved word 'static' as identifier
-reserved.c:33:12: error: Trying to use reserved word 'struct' as identifier
-reserved.c:34:12: error: Trying to use reserved word 'switch' as identifier
-reserved.c:35:12: error: Trying to use reserved word 'typedef' as identifier
-reserved.c:36:12: error: Trying to use reserved word 'union' as identifier
-reserved.c:37:12: error: Trying to use reserved word 'unsigned' as identifier
-reserved.c:38:12: error: Trying to use reserved word 'void' as identifier
-reserved.c:39:12: error: Trying to use reserved word 'volatile' as identifier
-reserved.c:40:12: error: Trying to use reserved word 'volatile' as identifier
-reserved.c:41:12: error: Trying to use reserved word '__volatile' as identifier
-reserved.c:42:12: error: Trying to use reserved word '__volatile__' as identifier
-reserved.c:43:12: error: Trying to use reserved word 'while' as identifier
-reserved.c:45:12: error: Trying to use reserved word '_Alignas' as identifier
-reserved.c:46:12: error: Trying to use reserved word '_Alignof' as identifier
-reserved.c:47:12: error: Trying to use reserved word '_Atomic' as identifier
-reserved.c:48:12: error: Trying to use reserved word '_Bool' as identifier
-reserved.c:49:12: error: Trying to use reserved word '_Complex' as identifier
-reserved.c:50:12: error: Trying to use reserved word '_Generic' as identifier
-reserved.c:51:12: error: Trying to use reserved word '_Imaginary' as identifier
-reserved.c:52:12: error: Trying to use reserved word '_Noreturn' as identifier
-reserved.c:53:12: error: Trying to use reserved word '_Static_assert' as identifier
-reserved.c:54:12: error: Trying to use reserved word '_Thread_local' as identifier
-reserved.c:57:12: error: Trying to use reserved word '__context__' as identifier
-reserved.c:58:12: error: Trying to use reserved word '__range__' as identifier
-reserved.c:59:12: error: Trying to use reserved word '__sizeof_ptr__' as identifier
-reserved.c:62:12: error: Trying to use reserved word '__alignof' as identifier
-reserved.c:63:12: error: Trying to use reserved word '__alignof__' as identifier
-reserved.c:65:12: error: Trying to use reserved word '__asm' as identifier
-reserved.c:66:12: error: Trying to use reserved word '__asm__' as identifier
-reserved.c:67:12: error: Trying to use reserved word '__label__' as identifier
-reserved.c:68:12: error: Trying to use reserved word '__thread' as identifier
-reserved.c:69:12: error: Trying to use reserved word 'typeof' as identifier
-reserved.c:70:12: error: Trying to use reserved word '__typeof' as identifier
-reserved.c:71:12: error: Trying to use reserved word '__typeof__' as identifier
-reserved.c:73:12: error: Trying to use reserved word '__int128' as identifier
-reserved.c:74:12: error: Trying to use reserved word '__int128_t' as identifier
-reserved.c:75:12: error: Trying to use reserved word '__uint128_t' as identifier
-reserved.c:77:12: error: Trying to use reserved word '__builtin_ms_va_list' as identifier
-reserved.c:78:12: error: Trying to use reserved word '__builtin_offsetof' as identifier
-reserved.c:79:12: error: Trying to use reserved word '__builtin_types_compatible_p' as identifier
-reserved.c:80:12: error: Trying to use reserved word '__builtin_va_list' as identifier
+reserved.c:1:13: error: Trying to use reserved word 'auto' as identifier
+reserved.c:2:13: error: Trying to use reserved word 'break' as identifier
+reserved.c:3:13: error: Trying to use reserved word 'case' as identifier
+reserved.c:4:13: error: Trying to use reserved word 'char' as identifier
+reserved.c:5:13: error: Trying to use reserved word 'const' as identifier
+reserved.c:6:13: error: Trying to use reserved word '__const' as identifier
+reserved.c:7:13: error: Trying to use reserved word '__const__' as identifier
+reserved.c:8:13: error: Trying to use reserved word 'continue' as identifier
+reserved.c:9:13: error: Trying to use reserved word 'default' as identifier
+reserved.c:10:13: error: Trying to use reserved word 'do' as identifier
+reserved.c:11:13: error: Trying to use reserved word 'double' as identifier
+reserved.c:12:13: error: Trying to use reserved word 'else' as identifier
+reserved.c:13:13: error: Trying to use reserved word 'enum' as identifier
+reserved.c:14:13: error: Trying to use reserved word 'extern' as identifier
+reserved.c:15:13: error: Trying to use reserved word 'float' as identifier
+reserved.c:16:13: error: Trying to use reserved word 'for' as identifier
+reserved.c:17:13: error: Trying to use reserved word 'goto' as identifier
+reserved.c:18:13: error: Trying to use reserved word 'if' as identifier
+reserved.c:19:13: error: Trying to use reserved word 'inline' as identifier
+reserved.c:20:13: error: Trying to use reserved word '__inline' as identifier
+reserved.c:21:13: error: Trying to use reserved word '__inline__' as identifier
+reserved.c:22:13: error: Trying to use reserved word 'int' as identifier
+reserved.c:23:13: error: Trying to use reserved word 'long' as identifier
+reserved.c:24:13: error: Trying to use reserved word 'register' as identifier
+reserved.c:25:13: error: Trying to use reserved word 'restrict' as identifier
+reserved.c:26:13: error: Trying to use reserved word '__restrict' as identifier
+reserved.c:27:13: error: Trying to use reserved word '__restrict__' as identifier
+reserved.c:28:13: error: Trying to use reserved word 'return' as identifier
+reserved.c:29:13: error: Trying to use reserved word 'short' as identifier
+reserved.c:30:13: error: Trying to use reserved word 'signed' as identifier
+reserved.c:31:13: error: Trying to use reserved word 'sizeof' as identifier
+reserved.c:32:13: error: Trying to use reserved word 'static' as identifier
+reserved.c:33:13: error: Trying to use reserved word 'struct' as identifier
+reserved.c:34:13: error: Trying to use reserved word 'switch' as identifier
+reserved.c:35:13: error: Trying to use reserved word 'typedef' as identifier
+reserved.c:36:13: error: Trying to use reserved word 'union' as identifier
+reserved.c:37:13: error: Trying to use reserved word 'unsigned' as identifier
+reserved.c:38:13: error: Trying to use reserved word 'void' as identifier
+reserved.c:39:13: error: Trying to use reserved word 'volatile' as identifier
+reserved.c:40:13: error: Trying to use reserved word 'volatile' as identifier
+reserved.c:41:13: error: Trying to use reserved word '__volatile' as identifier
+reserved.c:42:13: error: Trying to use reserved word '__volatile__' as identifier
+reserved.c:43:13: error: Trying to use reserved word 'while' as identifier
+reserved.c:45:13: error: Trying to use reserved word '_Alignas' as identifier
+reserved.c:46:13: error: Trying to use reserved word '_Alignof' as identifier
+reserved.c:47:13: error: Trying to use reserved word '_Atomic' as identifier
+reserved.c:48:13: error: Trying to use reserved word '_Bool' as identifier
+reserved.c:49:13: error: Trying to use reserved word '_Complex' as identifier
+reserved.c:50:13: error: Trying to use reserved word '_Generic' as identifier
+reserved.c:51:13: error: Trying to use reserved word '_Imaginary' as identifier
+reserved.c:52:13: error: Trying to use reserved word '_Noreturn' as identifier
+reserved.c:53:13: error: Trying to use reserved word '_Static_assert' as identifier
+reserved.c:54:13: error: Trying to use reserved word '_Thread_local' as identifier
+reserved.c:57:13: error: Trying to use reserved word '__context__' as identifier
+reserved.c:58:13: error: Trying to use reserved word '__range__' as identifier
+reserved.c:59:13: error: Trying to use reserved word '__sizeof_ptr__' as identifier
+reserved.c:62:13: error: Trying to use reserved word '__alignof' as identifier
+reserved.c:63:13: error: Trying to use reserved word '__alignof__' as identifier
+reserved.c:65:13: error: Trying to use reserved word '__asm' as identifier
+reserved.c:66:13: error: Trying to use reserved word '__asm__' as identifier
+reserved.c:67:13: error: Trying to use reserved word '__label__' as identifier
+reserved.c:68:13: error: Trying to use reserved word '__thread' as identifier
+reserved.c:69:13: error: Trying to use reserved word 'typeof' as identifier
+reserved.c:70:13: error: Trying to use reserved word '__typeof' as identifier
+reserved.c:71:13: error: Trying to use reserved word '__typeof__' as identifier
+reserved.c:73:13: error: Trying to use reserved word '__int128' as identifier
+reserved.c:74:13: error: Trying to use reserved word '__int128_t' as identifier
+reserved.c:75:13: error: Trying to use reserved word '__uint128_t' as identifier
+reserved.c:77:13: error: Trying to use reserved word '__builtin_ms_va_list' as identifier
+reserved.c:78:13: error: Trying to use reserved word '__builtin_offsetof' as identifier
+reserved.c:79:13: error: Trying to use reserved word '__builtin_types_compatible_p' as identifier
+reserved.c:80:13: error: Trying to use reserved word '__builtin_va_list' as identifier
  * check-error-end
  */
-- 
2.52.0


