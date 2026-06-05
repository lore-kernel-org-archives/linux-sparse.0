Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B173E51CE
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671419; cv=none; b=ZHmIi3PHVTrk82tmJIIeoxWmh6KHCOMaWYnlIGqrTIrKG2ij+aN6BK8Oc3Ianheydzrr0mftoGWOCGFyBnNmbyNrlwnP3aDPmZzd5k5P7TsrGFAt0PbwnYuaONCGa+4b5gThianWnlmW6O/pvxRR0wLURD+Ed0FE0fV7c4MS61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671419; c=relaxed/simple;
	bh=n9QaaXDGYhSyinCNtsAvS8n1Rtrr4MaFnAI3JA1gej0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=jdlhDmnNG8sClvr+NdSz+VTc4lBM3vnqj+a0PyJf79etGcVZk+e6xOYQWuQlj360aei14z72pOlt696O7+WfthGgnoXgpH0CsJKkqw9y7fHh45uMqjDAiwYl7l3UPDBCgbU7mKpJ2s6/Vkv4JPe5UkE9o7fd1m3NHMJgBUi1lhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXkFPnR6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXkFPnR6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=UzOHE8hxikKaot9uBQ2nr0J1ytkjfalIfFGzM/DA+3g=;
	b=iXkFPnR6LvFvt0eUL/e21z8iQ3YcTK+B0MZH8lJ3xFXwuKRR8GqWW5bp7zsgeQ8OF/S+Wx
	simYyGr4DUR0qEXbs7XrQFsAnJO9UOGhBAdeSuP8atspwJ/RD3UBpnfLxNpTVfvt3A9ntg
	c1iUuYFengkxL6dzVY6zwhjFWwtPBJw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-UYWCFYKIOg20-f9CCdRUtw-1; Fri,
 05 Jun 2026 10:56:54 -0400
X-MC-Unique: UYWCFYKIOg20-f9CCdRUtw-1
X-Mimecast-MFC-AGG-ID: UYWCFYKIOg20-f9CCdRUtw_1780671413
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ED6119560A5;
	Fri,  5 Jun 2026 14:56:53 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 83EF91955BC0;
	Fri,  5 Jun 2026 14:56:51 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jun 2026 16:56:52 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:56:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 3/4] sparse/dissect: introduce struct lookup_args for
 lookup_member()
Message-ID: <aiLjsol2gybBNBwc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aiLjjDwKRB1UjNcs@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UTX08pK-Ua_lm9efd9Szjkeu8UROTAiuduqiLM-Oe8U_1780671413
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

No functional changes, preparation for the next patch.

The new "struct lookup_args" bundles the current name/p_addr arguments
of lookup_member().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/dissect.c b/dissect.c
index c790807e..3da9e3a2 100644
--- a/dissect.c
+++ b/dissect.c
@@ -283,25 +283,29 @@ static struct symbol *base_type(struct symbol *sym)
 		?: &bad_ctype;
 }
 
-static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *p_addr)
+struct lookup_args {
+	struct ident *name;
+	int *p_addr;
+};
+
+static struct symbol *lookup_member(struct symbol *type, struct lookup_args *la)
 {
 	struct symbol *node;
 	int addr = 0;
 
 	FOR_EACH_PTR(type->symbol_list, node)
-		if (!name) {
-			if (addr == *p_addr)
+		if (!la->name) {
+			if (*la->p_addr == addr)
 				return node;
 		}
 		else if (node->ident == NULL) {
-			node = lookup_member(node->ctype.base_type, name, NULL);
+			node = lookup_member(node->ctype.base_type, la);
 			if (node)
 				goto found;
 		}
-		else if (node->ident == name) {
-found:
-			if (p_addr)
-				*p_addr = addr;
+		else if (node->ident == la->name) {
+found:			if (la->p_addr)
+				*la->p_addr = addr;
 			return node;
 		}
 		addr++;
@@ -314,7 +318,11 @@ static struct symbol *find_report_member(usage_t mode, struct position *pos,
 					 struct symbol *type, struct ident *name,
 					 int *p_addr)
 {
-	struct symbol *mem = lookup_member(type, name, p_addr);
+	struct lookup_args la = {
+		.name	= name,
+		.p_addr	= p_addr,
+	};
+	struct symbol *mem = lookup_member(type, &la);
 
 	if (!mem) {
 		static struct symbol bad_member = {
-- 
2.52.0

