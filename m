Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3391EA65
	for <linux-sparse@vger.kernel.org>; Wed, 31 Dec 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197786; cv=none; b=ooQPikAM/8C5hOTvXZvCylFM09qQwc7Ye2zGmKnFr7u9/5tVgtPsquhaMsk/1FruQAPM5VJu2nouWB0gn/qSYOBgN3x9Uw77F/ySN63KPfsl4yZshtNGVB83BXBbZ3VHwhytfWRXA3PKTGS4VVPpRe0yOWfcQZxd+7asFng1fhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197786; c=relaxed/simple;
	bh=xpWmZUIR8a8b/aFakBhSHYwrrwuYmc68iW+FsgWIVqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hx8XzMzboZ091MRMVnhdId33gF8y3isiZP2R8oWyjzPce84fUgmrCEZevXSho2GNdl+ukJTjmuVN3DHxyZ0np9SG5CCQfhMuIcdq7XsSP4week+5RGxZyUwzCBoBsT1ROf96fvaFNDydM5cmYN22a0ufNib36Rmzl4adA6i/05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USY77O+i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USY77O+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767197783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tc/Ck7b+F7PJLIdv9vtyqQfkVtW66elCplEX5LQE8/g=;
	b=USY77O+icPK9ywIx5eCuEYN9DJ3F7Czvwlj+Z78m3U3hb9YmigWHGPgPC/O9TYyw9g3Va8
	nE8v8NgO3TiK7JE3PDpuRI/cvU0oQkooyuY2FLOnGX+fA/qdhJ5fNQPsaMSlw9h+0anRzM
	kHMiR0IADDAtztBx8Hc3edViAR1oZXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-zvUxhXV3OVu9ZwffEOFYPA-1; Wed,
 31 Dec 2025 11:16:22 -0500
X-MC-Unique: zvUxhXV3OVu9ZwffEOFYPA-1
X-Mimecast-MFC-AGG-ID: zvUxhXV3OVu9ZwffEOFYPA_1767197781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B5651956080;
	Wed, 31 Dec 2025 16:16:21 +0000 (UTC)
Received: from fedora (unknown [10.44.32.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 587D519560A7;
	Wed, 31 Dec 2025 16:16:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Dec 2025 17:16:22 +0100 (CET)
Date: Wed, 31 Dec 2025 17:16:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH v2] sparse/dissect: don't miss inline functions when
 !dissect_show_all_symbols
Message-ID: <aVVMU0Vu-t6SN4g-@redhat.com>
References: <aUvQr9q1ePtvSwCs@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aUvQr9q1ePtvSwCs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EcTVaZ3y6O_cKyuLNknR_t5preteS15gq60Z7hXSovE_1767197781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

parse_function_body() doesn't do add_symbol(decl) if MOD_INLINE, this
means that dissect/semind can't see the definitions of inline functions
in translation_unit_used_list.

This change is not really needed if dissect_show_all_symbols == 1, in
this case do_file() inspects file_scope/global_scope.

Test-case:

	$ cat -n INLINE.c
	     1	static inline void i_func1(void)
	     2	{
	     3		unkown();
	     4	}
	     5	static inline void *i_func2(void)
	     6	{
	     7		return i_func1;
	     8	}
	     9
	    10	void func(void)
	    11	{
	    12		i_func2();
	    13	}

Before this patch:

	$ ./test-dissect INLINE.c

	  10:6                    def   f func                             void ( ... )
	  12:9   func             --r   f i_func2                          void *( ... )

With this patch:

	$ ./test-dissect INLINE.c

	  10:6                    def   f func                             void ( ... )
	   5:21                   def   f i_func2                          void *( ... )
	   1:20                   def   f i_func1                          void ( ... )
	   3:9   i_func1          --r   f unkown                           bad type
	   7:16  i_func2          r--   f i_func1                          void ( ... )
	  12:9   func             --r   f i_func2                          void *( ... )

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index a825bb30..b9d4adc4 100644
--- a/dissect.c
+++ b/dissect.c
@@ -59,6 +59,7 @@ static void do_sym_list(struct symbol_list *list);
 
 static struct symbol
 	*base_type(struct symbol *sym),
+	*do_symbol(struct symbol *sym),
 	*do_initializer(struct symbol *type, struct expression *expr),
 	*do_expression(usage_t mode, struct expression *expr),
 	*do_statement(usage_t mode, struct statement *stmt);
@@ -225,6 +226,12 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 
 		case SYM_FN:
 			node->kind = 'f';
+			if (node->ctype.modifiers & MOD_INLINE) {
+				struct symbol *dctx = dissect_ctx;
+				dissect_ctx = NULL;
+				do_symbol(node);
+				dissect_ctx = dctx;
+			}
 			node = base;
 			break;
 
@@ -621,7 +628,7 @@ static inline bool is_typedef(struct symbol *sym)
 	return (sym->namespace == NS_TYPEDEF);
 }
 
-static inline struct symbol *do_symbol(struct symbol *sym)
+static struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
 	struct symbol *dctx = dissect_ctx;
-- 
2.52.0


