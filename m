Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66914330641
	for <linux-sparse@vger.kernel.org>; Tue, 16 Dec 2025 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892428; cv=none; b=UoKzV+Dz7d/5Alz8oJQZyfEPANqDrqa3AYY9g5FIesHWJI+78c91QN2yT1qxIypdXw84fPDChcBP2ycX81M48GKTDjqchRH7S8qr4Y1WSfhCkWmQ51j09WmPHKywb+7faT28toV9xwNt8J6b2kQ7mK8N95+rkBm7G9Xcwu7iRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892428; c=relaxed/simple;
	bh=s3HoHaiAEsej/mbROFxi1ULQFfXZoQGVkq+4e1KbwXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VQI24LmfJnjyxiE/WnrbVgI6BR4KvG6t2mSOrqZfF4Z02UuQpmNqAxv0Nt6/Rn/+O9iN2YKiM2yHVsPPAG2EVSqTlsCQu1xrBeVOGdiY9+OlE84LWOmmxtTQxXM1RJ4o9pIci/SctD8R1u5bn4/urn/ayUijYositrFc0CFeNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeN+7MF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeN+7MF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765892424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0vCTcSZW1I++bc8woGVrvJpU2dcNopQ4Gfgjtws361E=;
	b=SeN+7MF51nAxSFUHEd4Fgzi0tqrCs0STwz+FTmYh8swSDvxxavTzy1wHc3ZAntidc6KG7O
	+ddcE5bNQ2KkuvKLtL8XZji7FiCUpmBf2jV+hx989DRI4W+psVkUUYI5Y7H4t+jB1PaC4G
	VsIihGqbGzZ+krS/AtgWLUw65uwpOVY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-zqu8aQFnN4WICJQG5oBWqg-1; Tue,
 16 Dec 2025 08:40:20 -0500
X-MC-Unique: zqu8aQFnN4WICJQG5oBWqg-1
X-Mimecast-MFC-AGG-ID: zqu8aQFnN4WICJQG5oBWqg_1765892419
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AD3F1955F11;
	Tue, 16 Dec 2025 13:40:19 +0000 (UTC)
Received: from fedora (unknown [10.45.225.177])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A99371800660;
	Tue, 16 Dec 2025 13:40:17 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 16 Dec 2025 14:40:19 +0100 (CET)
Date: Tue, 16 Dec 2025 14:40:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse: add the new m_pos member into struct
 expression{EXPR_DEREF}
Message-ID: <aUFhP-rIwC-iNJ5s@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZGfCv1Y9IhRjEm6F0gs-vQLCzmfyEyL8bg0iFW4G9ZM_1765892419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Test-case:

	$ cat -n MEMPOS.c
	     1	struct T {
	     2	 int mem;
	     3	} X;
	     4
	     5	void func(struct T *x)
	     6	{
	     7	 x -> mem = 1;
	     8	 X .  mem = 2;
	     9	}

	$ ./test-dissect MEMPOS.c | grep -F T.mem
	   2:6                    def   m T.mem                            int
	   7:4   func             -w-   m T.mem                            int
	   8:4   func             -w-   m T.mem                            int

Note that the reported position of .mem usage is wrong. This is because
do_expression(EXPR_DEREF) uses &expr->pos which is position of TOKEN_SPECIAL,
not the position of the next token (mem).

This also breaks "semind search -l" (search by location)

	$ ./semind add MEMPOS.c
	$ ./semind search -l MEMPOS.c:7:7

reports nothing.

With this patch:

	$ ./test-dissect MEMPOS.c | grep -F T.mem
	   2:6                    def   m T.mem                            int
	   7:7   func             -w-   m T.mem                            int
	   8:7   func             -w-   m T.mem                            int

	$ ./semind add MEMPOS.c
	$ ./semind search -l MEMPOS.c:7:7
	(def) MEMPOS.c	2	6		 int mem;
	(-w-) MEMPOS.c	7	7	func	 x -> mem = 1;
	(-w-) MEMPOS.c	8	7	func	 X .  mem = 2;

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c    | 2 +-
 expression.c | 1 +
 expression.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 9419c593..a6003afa 100644
--- a/dissect.c
+++ b/dissect.c
@@ -454,7 +454,7 @@ again:
 			p_mode = U_R_VAL;
 		p_type = do_expression(p_mode, expr->deref);
 
-		ret = report_member(mode, &expr->pos, p_type,
+		ret = report_member(mode, &expr->m_pos, p_type,
 			lookup_member(p_type, expr->member, NULL));
 	}
 
diff --git a/expression.c b/expression.c
index 727e7056..b23107da 100644
--- a/expression.c
+++ b/expression.c
@@ -605,6 +605,7 @@ static struct token *postfix_expression(struct token *token, struct expression *
 				break;
 			}
 			deref->member = token->ident;
+			deref->m_pos = token->pos;
 			token = token->next;
 			expr = deref;
 			continue;
diff --git a/expression.h b/expression.h
index 8bf40d32..ce8a29ce 100644
--- a/expression.h
+++ b/expression.h
@@ -202,6 +202,7 @@ struct expression {
 		struct /* deref_arg */ {
 			struct expression *deref;
 			struct ident *member;
+			struct position m_pos;
 		};
 		// EXPR_SLICE
 		struct /* slice */ {
-- 
2.52.0


