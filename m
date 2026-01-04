Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213A3C38
	for <linux-sparse@vger.kernel.org>; Sun,  4 Jan 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540139; cv=none; b=kyc6Op6nVK/EScYuPp50b4LsfDD6kbzLWoQV0joDUAOvvB3UoPAlo9Dod4N3e/+EJwTj8rigYTWmSg6FFugj1qfFG8PGmms8oq2cS/ejygXp2fpbtYiiMojagOFXENC+uo7WgtyN3svfeAOufEiUMk+U3h3n+JU5kQWFY3k0qWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540139; c=relaxed/simple;
	bh=Kp+oYk0eTFgsAOhUb+ZgXs7zPDaE+yIWXbHt+cEDvfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=dmqb+cqCjezKUOvy7a4P/nkytdre+gqrrzbo0/t+EdOrRuCOcRl37fTPVH8UfRrXa5w+po/Y8xcWAv+cyyjcWGdfhBvNTkKe44KyRp8w44rtsda7SQ6h2VZkcubgINPJGlDecz0IfVCTdO9FSIfmxb4PWw4HJUTWKxSTgTTC6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6QjogOp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6QjogOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767540136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=duxtonDACSQrZPm7dCdKhkogJ3WuXm6i9M5XHFHKeR0=;
	b=h6QjogOp7eq9tYn9iQ1kvBdaqHq4UIaSZy68wB7sl150dPgaAGNH2mWrySXV7qQVzeeYkz
	5N+EOVUxf4YwEckd5arcQhoR+iQuyDg+0iZmBa70Mt33uZhrZHjPedaJ75Cf2j+iWr+wXn
	+x76YmnrMg/NcRRVzM0n0M4jUK1Kfo0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-vyb3oa2NMN6sq15izfbiBA-1; Sun,
 04 Jan 2026 10:22:13 -0500
X-MC-Unique: vyb3oa2NMN6sq15izfbiBA-1
X-Mimecast-MFC-AGG-ID: vyb3oa2NMN6sq15izfbiBA_1767540132
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E1D1800342;
	Sun,  4 Jan 2026 15:22:12 +0000 (UTC)
Received: from fedora (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7B0C530001A2;
	Sun,  4 Jan 2026 15:22:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Jan 2026 16:22:11 +0100 (CET)
Date: Sun, 4 Jan 2026 16:22:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 4/4] sparse/dissect: sanitize the de-anonymization of
 SYM_ENUMs
Message-ID: <aVqFoD7JKxylHanE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aVqFaL88QonZYs63@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0CfXKm0VWbr58fEcJT9Sc3mT1W6AlOyupoJS27YC4q0_1767540132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

examine_sym_node() tries to de-anonymize enums just like structs,
and sometimes it makes sense:

	$ ~/tmp/sparse/test-dissect - <<<'enum { X } x;'

	   1:6                    def   E :x                               unsigned int
	   1:8                    def   e :x.X                             unsigned int enum :x
	   1:12                   def   v x                                unsigned int enum :x

But it doesn't make sense to de-anonymize enum types using the name
of its enum_member.

Test-case:

	$ cat -n ENUM_3.c
	     1	enum { A, B };
	     2	typeof(B) x = A;

	$ ./test-dissect ENUM_3.c

	   1:6                    def   E :B                               unsigned int
	   1:8                    def   e :B.A                             unsigned int enum :B
	   1:11                   def   e :B.B                             unsigned int enum :B
	   2:8                    ---   e :B.B                             unsigned int enum :B
	   2:11                   def   v x                                int
	   2:11                   -w-   v x                                int
	   2:15  x                -r-   e :B.A                             unsigned int enum :B

With this patch:

	$ ./test-dissect ENUM_3.c

	   1:8                    def   e A                                unsigned int enum <noident>
	   1:11                   def   e B                                unsigned int enum <noident>
	   2:8                    ---   e B                                unsigned int enum <noident>
	   2:11                   def   v x                                int
	   2:11                   -w-   v x                                int
	   2:15  x                -r-   e A                                unsigned int enum <noident>

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      |  5 +++--
 test-dissect.c | 13 +++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/dissect.c b/dissect.c
index d36986dd..a0fda09c 100644
--- a/dissect.c
+++ b/dissect.c
@@ -245,10 +245,11 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 			if (toplevel(base->scope))
 				dissect_ctx = NULL;
 
-			if (base->ident || deanon(base, name, parent))
+			if (base->ident || (!node->enum_member &&
+					    deanon(base, name, parent)))
 				reporter->r_symdef(base);
 
-			if (base->ident)
+			if (base->ident || base->type == SYM_ENUM)
 				parent = base;
 			DO_LIST(base->symbol_list, mem,
 				examine_sym_node(mem, parent);
diff --git a/test-dissect.c b/test-dissect.c
index e2b8ec9d..0a7ee98c 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -88,19 +88,20 @@ err:
 static void r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
 {
 	struct ident *ni, *si, *mi;
-	int mk;
+	int mk, ms = 32;
 
 	ni = built_in_ident("?");
-	si = sym->ident ?: ni;
 	/* mem == NULL means entire struct accessed */
-	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
 	mk = mem ? mem->kind : 'm';
+	mi = mem ? (mem->ident ?: ni) : built_in_ident("*");
+	si = sym->ident ?: (mk == 'e' ? NULL : ni);
 
 	print_usage(pos, sym, mode, mk);
 
-	printf("%.*s.%-*.*s %s\n",
-		si->len, si->name,
-		32-1 - si->len, mi->len, mi->name,
+	if (si)
+		ms -= printf("%.*s.", si->len, si->name);
+
+	printf("%-*.*s %s\n", ms, mi->len, mi->name,
 		show_typename(mem ? mem->ctype.base_type : sym));
 
 	if (sym->ident && sym->kind != 's' && sym->kind != 'E')
-- 
2.52.0

