Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0B3C38
	for <linux-sparse@vger.kernel.org>; Sun,  4 Jan 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540129; cv=none; b=YeAGNle89kWTzq9jez2Zt2QzSDqw6T/iAk4T+pOXspwLGKSMAT3hRHXLwgZ4hXTW/Jjm9c5b+YQJziLkt5HM4QijoQW30yI5Vi0x6yMCKyaBLUEJeCdM1FLpi6Z2DJSIerY6o+h29qW4F6WkennxoETKN8VeGiEWzbqgvSOK5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540129; c=relaxed/simple;
	bh=EyIZhuPGmIfijicITApr+xwsKSMw78dfJJLw4lDLEas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=XXPMKUtuItYP+FI1s6nXXpCwlD8cuSsdAYw8rKmYHLAUI50lf283UQ41ThrPEpdQnEguCEC6B+dRoE/Z7qpmF/QYC583tEe4Kwi2SGtK/Bfquss5r2BuF9yaP5IIYSKwOVn03ukTrfvhY/gRZvnwMjjlSm9j52LLXWtbschuQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+dRRtdF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+dRRtdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767540124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=LwrkjVeFVclRCcjTs45yvkuXcacBkY58szZNLNul9n4=;
	b=L+dRRtdFD/Sr/kOJkCQPkZ6qzIQro/mk5zTyQVrahVj1AdV079vY12GQ/BUhL4DX4WEvuU
	6E9aXnUyOZWYDPTG6apYBwRRx9+dyYLEJeeVG95hPuQULIYZSRGL9dW3ADzfs0llVxuYh5
	0PCNLr4AAzgfIMYZIY3VHgOgdKj123A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-iR4Ii76gOUK0tP9OITHzGw-1; Sun,
 04 Jan 2026 10:22:01 -0500
X-MC-Unique: iR4Ii76gOUK0tP9OITHzGw-1
X-Mimecast-MFC-AGG-ID: iR4Ii76gOUK0tP9OITHzGw_1767540120
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7879B19560A5;
	Sun,  4 Jan 2026 15:22:00 +0000 (UTC)
Received: from fedora (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A55C230001A2;
	Sun,  4 Jan 2026 15:21:58 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Jan 2026 16:22:00 +0100 (CET)
Date: Sun, 4 Jan 2026 16:21:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 1/4] sparse/dissect: examine SYM_ENUM nodes
Message-ID: <aVqFlC4sni-vU9Pw@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aVqFaL88QonZYs63@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hbHlUlTPdcc1EFWlQ0QChBuuRU7Dcg2nvMswYGrWNLU_1767540120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Test-case:

	$ cat ENUM_1.c
	enum X { A,B } x;

	$ ./test-dissect ENUM_1.c

	   1:16                   def   v x                                unsigned int enum X

With this patch:

	$ ./test-dissect ENUM_1.c

	   1:6                    def   E X                                unsigned int
	   1:10                   def   e X.A                              unsigned int enum X
	   1:12                   def   e X.B                              unsigned int enum X
	   1:16                   def   v x                                unsigned int enum X

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      |  9 +++------
 test-dissect.c | 17 +++++++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/dissect.c b/dissect.c
index b9d4adc4..abca1805 100644
--- a/dissect.c
+++ b/dissect.c
@@ -168,9 +168,6 @@ static struct symbol *report_symbol(usage_t mode, struct expression *expr)
 	struct symbol *sym = expr_symbol(expr);
 	struct symbol *ret = base_type(sym);
 
-	if (0 && ret->type == SYM_ENUM)
-		return report_member(mode, &expr->pos, ret, expr->symbol);
-
 	reporter->r_symbol(fix_mode(ret, mode), &expr->pos, sym);
 
 	return ret;
@@ -195,7 +192,7 @@ static bool deanon(struct symbol *base, struct ident *node, struct symbol *paren
 
 static void report_memdef(struct symbol *sym, struct symbol *mem)
 {
-	mem->kind = 'm';
+	mem->kind = sym && sym->type == SYM_ENUM ? 'e' : 'm';
 	if (sym && mem->ident)
 		reporter->r_memdef(sym, mem);
 }
@@ -235,12 +232,12 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 			node = base;
 			break;
 
-		case SYM_STRUCT: case SYM_UNION: //case SYM_ENUM:
+		case SYM_STRUCT: case SYM_UNION: case SYM_ENUM:
 			if (base->inspected)
 				return;
 			base->inspected = 1;
-			base->kind = 's';
 
+			base->kind = base->type == SYM_ENUM ? 'E' : 's';
 			if (!base->symbol_list)
 				return;
 
diff --git a/test-dissect.c b/test-dissect.c
index 65b205f8..3691218d 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -58,13 +58,16 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 
 	switch (sym->kind) {
 	case 'd':
+	case 't':
 		break;
+	case 'E':
+		if (sym->type == SYM_ENUM)
+			break;
+		goto err;
 	case 's':
 		if (sym->type == SYM_STRUCT || sym->type == SYM_UNION)
 			break;
 		goto err;
-	case 't':
-		break;
 	case 'f':
 		if (sym->type != SYM_BAD && sym->ctype.base_type->type != SYM_FN)
 			goto err;
@@ -84,6 +87,7 @@ err:
 static void r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
 {
 	struct ident *ni, *si, *mi;
+	int mk;
 
 	print_usage(pos, sym, mode);
 
@@ -91,15 +95,16 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
 	si = sym->ident ?: ni;
 	/* mem == NULL means entire struct accessed */
 	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
+	mk = mem ? mem->kind : 'm';
 
-	printf("%c m %.*s.%-*.*s %s\n",
-		symscope(sym), si->len, si->name,
+	printf("%c %c %.*s.%-*.*s %s\n",
+		symscope(sym), mk, si->len, si->name,
 		32-1 - si->len, mi->len, mi->name,
 		show_typename(mem ? mem->ctype.base_type : sym));
 
-	if (sym->ident && sym->kind != 's')
+	if (sym->ident && sym->kind != 's' && sym->kind != 'E')
 		warning(*pos, "r_member bad sym type=%d kind=%d", sym->type, sym->kind);
-	if (mem && mem->kind != 'm')
+	if (mem && mem->kind != 'm' && mem->kind != 'e')
 		warning(*pos, "r_member bad mem->kind = %d", mem->kind);
 }
 
-- 
2.52.0

