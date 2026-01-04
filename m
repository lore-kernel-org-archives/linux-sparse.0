Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEA3C38
	for <linux-sparse@vger.kernel.org>; Sun,  4 Jan 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540134; cv=none; b=V6JCPAqt5OKsFz1V84ZBRR83CKB9VP3bPC+lvdCwV4GmVun8qI85kLd5UREXCt2ExL24BPkYWZzXnizDLdXfO99Kdd5AwG5iqW9wEC3pk758Vl8xGhFShd0JHJVAg8bbt9AhI2pkeRCepbgp8bNlJEB24VXcHKD4uhkfTazG8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540134; c=relaxed/simple;
	bh=v+6Fbeh58qLRIEn5zPyUTmEquifRWOdcHACcnkfpiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=qnb37EGwzQmGUxNIZV64jxxqx+dU1Y/YlT0p8US8z4Qf2igeL0Vh6yirUnlvznG+BDyGFXmtW0B0e31ooLZ2Q9B3HdNzGjg4kI6RUuLrhkArT3q0wR5FRi7cSKztVhxLRdm7ylz4lyGznSknEZkjHn7FoLFIU73oKJTVVRvRN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CScDRtFB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CScDRtFB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767540130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=JG3TUAmSLsMGGlHnkOh4j7NwRkXoFJBNhg2BUlAzpjw=;
	b=CScDRtFB5+oeuMh3UnI5miMeEA/qxZsKSdMxp5edWZA3p3yNnKw6DltQzGHgxmTqUV+omf
	Zott/eSlLy1+RCkTRjHR/VKIbORcgO8UOKkBz2S4KLVeWi93RFkNowGwMqp4d3SEc2MKIS
	VYBcXKKKlO8IQG1BAEGzdQTZ5Oc34+c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-BSh1OGW7N7aZ6ZOtOxaEYA-1; Sun,
 04 Jan 2026 10:22:09 -0500
X-MC-Unique: BSh1OGW7N7aZ6ZOtOxaEYA-1
X-Mimecast-MFC-AGG-ID: BSh1OGW7N7aZ6ZOtOxaEYA_1767540128
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CAF519560B2;
	Sun,  4 Jan 2026 15:22:08 +0000 (UTC)
Received: from fedora (unknown [10.45.224.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7C3881800352;
	Sun,  4 Jan 2026 15:22:06 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Jan 2026 16:22:07 +0100 (CET)
Date: Sun, 4 Jan 2026 16:22:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 3/4] sparse/dissect: shift symscope() callsites into
 print_usage()
Message-ID: <aVqFnEPFlsFsYPhz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aVqFaL88QonZYs63@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fsSvsKmaCdlyVP5cg8mTkOfhH5wKB9QQsbDvap9i9IY_1767540128
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Simplification and preparation for the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 test-dissect.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/test-dissect.c b/test-dissect.c
index 3691218d..e2b8ec9d 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -16,7 +16,17 @@ static inline const char *show_mode(unsigned mode)
 	return str;
 }
 
-static void print_usage(struct position *pos, struct symbol *sym, unsigned mode)
+static char symscope(struct symbol *sym)
+{
+	if (sym_is_local(sym)) {
+		if (!dissect_ctx)
+			warning(sym->pos, "no context");
+		return '.';
+	}
+	return ' ';
+}
+
+static void print_usage(struct position *pos, struct symbol *sym, unsigned mode, int kind)
 {
 	static unsigned curr_stream = -1;
 	static struct ident null;
@@ -30,30 +40,21 @@ static void print_usage(struct position *pos, struct symbol *sym, unsigned mode)
 	if (dissect_ctx)
 		ctx = dissect_ctx->ident;
 
-	printf("%4d:%-3d %-16.*s %s ",
-		pos->line, pos->pos, ctx->len, ctx->name, show_mode(mode));
-
-}
+	printf("%4d:%-3d %-16.*s %s %c %c ",
+		pos->line, pos->pos, ctx->len, ctx->name,
+		show_mode(mode), symscope(sym), kind);
 
-static char symscope(struct symbol *sym)
-{
-	if (sym_is_local(sym)) {
-		if (!dissect_ctx)
-			warning(sym->pos, "no context");
-		return '.';
-	}
-	return ' ';
 }
 
 static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 {
-	print_usage(pos, sym, mode);
-
 	if (!sym->ident)
 		sym->ident = built_in_ident("__asm__");
 
-	printf("%c %c %-32.*s %s\n",
-		symscope(sym), sym->kind, sym->ident->len, sym->ident->name,
+	print_usage(pos, sym, mode, sym->kind);
+
+	printf("%-32.*s %s\n",
+		sym->ident->len, sym->ident->name,
 		show_typename(sym->ctype.base_type));
 
 	switch (sym->kind) {
@@ -89,16 +90,16 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
 	struct ident *ni, *si, *mi;
 	int mk;
 
-	print_usage(pos, sym, mode);
-
 	ni = built_in_ident("?");
 	si = sym->ident ?: ni;
 	/* mem == NULL means entire struct accessed */
 	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
 	mk = mem ? mem->kind : 'm';
 
-	printf("%c %c %.*s.%-*.*s %s\n",
-		symscope(sym), mk, si->len, si->name,
+	print_usage(pos, sym, mode, mk);
+
+	printf("%.*s.%-*.*s %s\n",
+		si->len, si->name,
 		32-1 - si->len, mi->len, mi->name,
 		show_typename(mem ? mem->ctype.base_type : sym));
 
-- 
2.52.0

