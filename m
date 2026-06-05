Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AB199FB0
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671416; cv=none; b=LOX12H4MuzwcjdeC7C7ZrQGxSDrbdDoUyY0luW1uaKPddS9eYgmElrUgumVmw1tXsDxl3AV9MsL3+4S5tCQju3R2q6s/w8yqhSbanchWz6/uVzsRPuo6FjcaknBo9IbBos9da9pRUm/4v2b4NeMOjSBXZ+egka7gHExJHtODrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671416; c=relaxed/simple;
	bh=0euJVLr+IEKGtpRxyJc37n/464ztXIjkhcCA6icfXFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=ZBxSwCzYHlogPcxt1+F9YNm6Rq5E+dq2jxXHPGLjCLafredkA/dUP4RlnRt+i6jTkQJYMbKFveV7Q8QSHC+5xrrzvSyP9ScDs9nH/O62EwHFGozgnwIj8X+FKRXbn2Exo9LSrUaZV8bF3RH6wFCVDvgeVfDRQJ4BDWjOFkZsxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLHOOUEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLHOOUEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=fr0jrnnz0de94TpXwgjx/H7V2Pg60+QCDronq1kASJQ=;
	b=bLHOOUEyy/OuksbX4gsx1eiVVSSTa2pj+A1M0Lfpx7yhSqCEJYYoyuJbeALmoL1aA8SP+O
	U6O9Gi6ElxIGBbjs3PKx16JMi0p7PNUdH2I6JIyVp6cKH0AXX73jRrm0vFxU07EGnLfTjU
	2/mLo42qavtM90oeH8D9CpVKtMuWsZs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-uekG7jOZMeeeO8GS64AL9w-1; Fri,
 05 Jun 2026 10:56:50 -0400
X-MC-Unique: uekG7jOZMeeeO8GS64AL9w-1
X-Mimecast-MFC-AGG-ID: uekG7jOZMeeeO8GS64AL9w_1780671409
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A676719560A7;
	Fri,  5 Jun 2026 14:56:49 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CD61F195608E;
	Fri,  5 Jun 2026 14:56:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jun 2026 16:56:49 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:56:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 2/4] sparse/dissect: fold lookup_member() into
 find_report_member()
Message-ID: <aiLjrseuO-EnSUep@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aiLjjDwKRB1UjNcs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DDJI73xCN23W0dtLIQ44tmWox9Xp59PRuDdWONT5rw0_1780671409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After the previous change lookup_member() has a single caller. Fold it
into find_report_member() and rename __lookup_member().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/dissect.c b/dissect.c
index 6b5cb0ef..c790807e 100644
--- a/dissect.c
+++ b/dissect.c
@@ -283,7 +283,7 @@ static struct symbol *base_type(struct symbol *sym)
 		?: &bad_ctype;
 }
 
-static struct symbol *__lookup_member(struct symbol *type, struct ident *name, int *p_addr)
+static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *p_addr)
 {
 	struct symbol *node;
 	int addr = 0;
@@ -294,7 +294,7 @@ static struct symbol *__lookup_member(struct symbol *type, struct ident *name, i
 				return node;
 		}
 		else if (node->ident == NULL) {
-			node = __lookup_member(node->ctype.base_type, name, NULL);
+			node = lookup_member(node->ctype.base_type, name, NULL);
 			if (node)
 				goto found;
 		}
@@ -310,9 +310,11 @@ found:
 	return NULL;
 }
 
-static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *addr)
+static struct symbol *find_report_member(usage_t mode, struct position *pos,
+					 struct symbol *type, struct ident *name,
+					 int *p_addr)
 {
-	struct symbol *mem = __lookup_member(type, name, addr);
+	struct symbol *mem = lookup_member(type, name, p_addr);
 
 	if (!mem) {
 		static struct symbol bad_member = {
@@ -328,14 +330,7 @@ static struct symbol *lookup_member(struct symbol *type, struct ident *name, int
 		mem->ident = name;
 	}
 
-	return mem;
-}
-
-static struct symbol *find_report_member(usage_t mode, struct position *pos,
-					 struct symbol *type, struct ident *name,
-					 int *p_addr)
-{
-	return report_member(mode, pos, type, lookup_member(type, name, p_addr));
+	return report_member(mode, pos, type, mem);
 }
 
 static struct expression *peek_preop(struct expression *expr, int op)
-- 
2.52.0

