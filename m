Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2C3E5590
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671423; cv=none; b=qV6UJXFuY1C4+TuDhD3y+ISQofc2fUV4ZaLiXVFexwShYijjKdHJXXzZ1yBk9WVebou4KnWLTiMZguIIP/3WLX0bwZHbtIMQskAT1/BtifHcnyYwfah0lz2EWibYMMQjpzd0Jy/efNxGaMt6pcqAaVNWgxjSZ7Wa1mp9MqKR8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671423; c=relaxed/simple;
	bh=fgT90wYqfCLBW9xZNvcmnueXzhPfZ1iRZmh9RxXJiC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=mvBg618awAlrbZYSKjFjrCkJOTMSLY5mLQD/16SniearFMZ7WEtwi2zGAcdheZ5ic2rXpGCIhXprbl1N0rux7eI7uvVGNAyrPdzytpHjGdNhZc0VtbgWczDrlJfHQdpBWo1dAqxkBK31G90zz7MOJYXFEddoRz0SBOPhmqG15NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaJWggzB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaJWggzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=SXDGOvP5VpRI5oh2bvp2YTBv0c7lCybD3ELNFJcW7sM=;
	b=OaJWggzBgpgVMOA4LQeF7lgKej3d0oI1o9chVTPfrLejMQnpOc6y3SnVe1Gkzv50gBGOwj
	dXTsEHArUQHDPBS31wfwEg6ecdYkGmtAdv1OTrmCpcbpyx7xfcXlBfOI6e8tfVH4O+B2N5
	YS5gEaRrQU21oRNhXXYDhceOxE6elLI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Zu4N4HtBPmCRx-zr-jPz6w-1; Fri,
 05 Jun 2026 10:56:57 -0400
X-MC-Unique: Zu4N4HtBPmCRx-zr-jPz6w-1
X-Mimecast-MFC-AGG-ID: Zu4N4HtBPmCRx-zr-jPz6w_1780671416
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59DF18002FF;
	Fri,  5 Jun 2026 14:56:56 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 17F54195608E;
	Fri,  5 Jun 2026 14:56:54 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jun 2026 16:56:56 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:56:53 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 4/4] sparse/dissect: fix missing usage reports for unnamed
 members of named types
Message-ID: <aiLjtfbosMDLSux5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aiLjjDwKRB1UjNcs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: paX2vv8coo0GaJEBZXNXz_OM7-_3GcogdXhfwc2-9Iw_1780671416
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With the recent change, dissect.c correctly reports the definitions of the
promoted members, but it still doesn't report the usages of the underlying
members.

This means, for example, that

	$ semind search -m r ns_tree.ns_id

finds nothing without this change.

Minimal (same) test-case:

	union U { int i; };

	struct S { union U; } v = { .i = 0 };

Before the patch:

	$ test-dissect TEST.c
	3:8                    def   s S
	1:7                    def   s U
	1:15                   def   m U.i                              int
	3:19                   def   m S.i                              int
	3:23                   def   v v                                struct S
	3:23                   -w-   v v                                struct S
	3:30  v                -w-   m S.i                              int

The usage of U.i is not reported.

After the patch:

	$ test-dissect TEST.c
	3:8                    def   s S
	1:7                    def   s U
	1:15                   def   m U.i                              int
	3:19                   def   m S.i                              int
	3:23                   def   v v                                struct S
	3:23                   -w-   v v                                struct S
	3:30  v                -w-   m U.i                              int
	3:30  v                -w-   m S.i                              int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 3da9e3a2..2358297b 100644
--- a/dissect.c
+++ b/dissect.c
@@ -286,8 +286,19 @@ static struct symbol *base_type(struct symbol *sym)
 struct lookup_args {
 	struct ident *name;
 	int *p_addr;
+	struct position pos;
+	struct symbol *stack[8];
+	unsigned int depth;
 };
 
+static inline void lookup_push(struct lookup_args *la, struct symbol *type)
+{
+	if (la->depth == ARRAY_SIZE(la->stack))
+		warning(la->pos, "lookup stack overflow");
+	else
+		la->stack[la->depth++] = type;
+}
+
 static struct symbol *lookup_member(struct symbol *type, struct lookup_args *la)
 {
 	struct symbol *node;
@@ -299,9 +310,13 @@ static struct symbol *lookup_member(struct symbol *type, struct lookup_args *la)
 				return node;
 		}
 		else if (node->ident == NULL) {
-			node = lookup_member(node->ctype.base_type, la);
-			if (node)
+			struct symbol *base = node->ctype.base_type;
+			node = lookup_member(base, la);
+			if (node) {
+				if (type->ident != base->ident)
+					lookup_push(la, base);
 				goto found;
+			}
 		}
 		else if (node->ident == la->name) {
 found:			if (la->p_addr)
@@ -321,6 +336,8 @@ static struct symbol *find_report_member(usage_t mode, struct position *pos,
 	struct lookup_args la = {
 		.name	= name,
 		.p_addr	= p_addr,
+		.pos	= *pos,
+		.depth	= 0,
 	};
 	struct symbol *mem = lookup_member(type, &la);
 
@@ -338,6 +355,9 @@ static struct symbol *find_report_member(usage_t mode, struct position *pos,
 		mem->ident = name;
 	}
 
+	while (la.depth)
+		report_member(mode, pos, la.stack[--la.depth], mem);
+
 	return report_member(mode, pos, type, mem);
 }
 
-- 
2.52.0

