Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F52199FB0
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671412; cv=none; b=vCmS5C3j/66TdFTBHVqebwbnZcJh7us3ifMAuuDY6Q01PXh1gFcFagynyu4L9ahwjjcP5OLBWk5maLjwlH3rxYN18XULY4UxZUYzroiPRCeBTOj+W4lepI9W8OInXVc4sy/e7ukmvjVpGm2sI7jkDjBkkMwZCkChDCYOBX+ACA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671412; c=relaxed/simple;
	bh=CQaXOp8JqxfQ9VvclMEumm3cqBRnn7pFgJ8NG0qBxC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=aC9sa/VObofcQTPQL+GO5tqidce8NIYmOfOzBAbxdE6y2cL9jPTc6BzEf6hU8e5oF9zxwsfAURVxGDE9CzaOFRShZBOpG/yAbFlFq5FSnGQM2M2whP1vo+8Q5mwxrF03nRJXaUT2nY7Gb8aDwha9D/kO5PIzB+nw38OoFGi4tBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtNqfi07; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtNqfi07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zbH0oy+mcP0WrMN0f9PyaVqkMhWykgd72uMl2lhCaOI=;
	b=GtNqfi072EkAbdXZ8LhO/MsbZ0CXw5sBKUdomAozG6jHd5I+qorSjVIEC5YDUFAoN0ZK8D
	KKJeJYqFchF6TCSymA0vLx1zwgTcHxdkwsmRdfDExTa8a0vfmJJjlbW8vzeYXo9f0MchLa
	yISh8maIiX43rfmENd6D8/vbsxT30Sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-mcu6NLFaM4iu2gZbx1btyw-1; Fri,
 05 Jun 2026 10:56:47 -0400
X-MC-Unique: mcu6NLFaM4iu2gZbx1btyw-1
X-Mimecast-MFC-AGG-ID: mcu6NLFaM4iu2gZbx1btyw_1780671405
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C088A180034B;
	Fri,  5 Jun 2026 14:56:45 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EEE4A195608E;
	Fri,  5 Jun 2026 14:56:43 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jun 2026 16:56:45 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:56:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 1/4] sparse/dissect: introduce find_report_member()
Message-ID: <aiLjqif9hlvb3VbP@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aiLjjDwKRB1UjNcs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M6lbNFGO4mJFXBWjKBeiwFQMTIblrcXjzV49IzXJtr8_1780671405
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

No functional changes, preparation for the next patches.

Add the new helper, find_report_member(), which simply does
lookup_member() + report_member(), and update the current users of
the same pattern to use it.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/dissect.c b/dissect.c
index 04ec89ca..6b5cb0ef 100644
--- a/dissect.c
+++ b/dissect.c
@@ -331,6 +331,13 @@ static struct symbol *lookup_member(struct symbol *type, struct ident *name, int
 	return mem;
 }
 
+static struct symbol *find_report_member(usage_t mode, struct position *pos,
+					 struct symbol *type, struct ident *name,
+					 int *p_addr)
+{
+	return report_member(mode, pos, type, lookup_member(type, name, p_addr));
+}
+
 static struct expression *peek_preop(struct expression *expr, int op)
 {
 	do {
@@ -474,8 +481,8 @@ again:
 			p_mode = U_R_VAL;
 		p_type = do_expression(p_mode, expr->deref);
 
-		ret = report_member(mode, &expr->m_pos, p_type,
-			lookup_member(p_type, expr->member, NULL));
+		ret = find_report_member(mode, &expr->m_pos,
+					 p_type, expr->member, NULL);
 	}
 
 	break; case EXPR_OFFSETOF: {
@@ -483,8 +490,8 @@ again:
 
 		do {
 			if (expr->op == '.') {
-				in = report_member(U_VOID, &expr->pos, in,
-					lookup_member(in, expr->ident, NULL));
+				in = find_report_member(U_VOID, &expr->pos,
+							in, expr->ident, NULL);
 			} else {
 				do_expression(U_R_VAL, expr->index);
 				in = in->ctype.base_type;
@@ -609,8 +616,8 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 
 				m_type = type;
 				while (m_expr->type == EXPR_IDENTIFIER) {
-					m_type = report_member(U_W_VAL, &m_expr->pos, m_type,
-							lookup_member(m_type, m_expr->expr_ident, m_atop));
+					m_type = find_report_member(U_W_VAL, &m_expr->pos,
+								    m_type, m_expr->expr_ident, m_atop);
 					m_expr = m_expr->ident_expression;
 					m_atop = NULL;
 
@@ -621,8 +628,8 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 				}
 
 				if (m_atop) {
-					m_type = report_member(U_W_VAL, &m_expr->pos, m_type,
-							lookup_member(m_type, NULL, m_atop));
+					m_type = find_report_member(U_W_VAL, &m_expr->pos,
+								    m_type, NULL, m_atop);
 				}
 
 				if (m_expr->type != EXPR_INITIALIZER)
-- 
2.52.0

