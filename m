Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FB23535E
	for <linux-sparse@vger.kernel.org>; Sun,  4 Jan 2026 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540131; cv=none; b=WWtNNv0awNq7eIDDnFNWLmua4qysfKTIRkcyRNBTYh3g1P2xFAEZY07bKyHMMmq6fA22iJatUz8kdRLZ+FIl8mBGdnZpvweWLjb1d9XO7YbpWIAypdaNQES5bYxDfcmInWUtUdobnz9w0DQIAXwFqEY5LMuUdm7/wtODXosnFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540131; c=relaxed/simple;
	bh=ccrZZGNq0BaLa9qz5FRfDEt49M+YTrJGSeTSVF+bN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:Content-Disposition; b=KK2b8UieIoTH1uh67YHX1h+gQoul9PVsj/vZq/OYEdE528e7k6Iu7fdL5NB2/iLNKbgqkLYuXK1ST9OpwdlAc3S1A36QE8Heus7AUOoSX2LEPrCvLBsvfz8W2RpI+6RGqbSz9P1AyCMf+4J7ad0J/hKeHx0449Utnm/a4/0qR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpa6KMOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpa6KMOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767540128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=duGzPfjg4447ruiwYGm5S+k9LJXRn0LgN+VZ5meW3XY=;
	b=cpa6KMOre57TIwYA+D4/3vs3Kx8vnA+eAxNojsgvZ9b0/AqZfoH+qg4hdhxLf0pvnUwhhu
	WeanCGXuUoKYy9GOzoBe+uHWtwX73XMNDIXnwQTSnXPcSoYSl9KKTBUugMw/fFKDu0wnP6
	rxdUuO9akVlmZUFHiZ6IUZJERG7UQfk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-0FN0FvxQNt27c84eOwuAOA-1; Sun,
 04 Jan 2026 10:22:05 -0500
X-MC-Unique: 0FN0FvxQNt27c84eOwuAOA-1
X-Mimecast-MFC-AGG-ID: 0FN0FvxQNt27c84eOwuAOA_1767540124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76EC919560A5;
	Sun,  4 Jan 2026 15:22:04 +0000 (UTC)
Received: from fedora (unknown [10.45.224.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9D8BE18004D8;
	Sun,  4 Jan 2026 15:22:02 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Jan 2026 16:22:04 +0100 (CET)
Date: Sun, 4 Jan 2026 16:22:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 2/4] sparse/dissect: report the usage of enumerators
Message-ID: <aVqFmM1ILcca3e6l@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aVqFaL88QonZYs63@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZAi5l_vukDJfQbV0y3KbO1WL39HZHgYp0EJk0fqItVA_1767540124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Test-case:

	$ cat ENUM_2.c
	enum X { A, B };
	typeof(A) x = B;

	$ ./test-dissect ENUM_2.c

	   2:11                   def   v x                                int
	   2:11                   -w-   v x                                int

With this patch:

	$ ./test-dissect ENUM_2.c

	   1:6                    def   E X                                unsigned int
	   1:10                   def   e X.A                              unsigned int enum X
	   1:13                   def   e X.B                              unsigned int enum X
	   2:8                    ---   e X.A                              unsigned int enum X
	   2:11                   def   v x                                int
	   2:11                   -w-   v x                                int
	   2:15  x                -r-   e X.B                              unsigned int enum X

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c    | 6 +++++-
 expression.c | 3 +++
 expression.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index abca1805..d36986dd 100644
--- a/dissect.c
+++ b/dissect.c
@@ -345,9 +345,13 @@ again:
 		warning(expr->pos, "bad expr->type: %d", expr->type);
 
 	case EXPR_TYPE:		// [struct T]; Why ???
-	case EXPR_VALUE:
 	case EXPR_FVALUE:
 
+	break; case EXPR_VALUE:
+		if (expr->flags & CEF_ENUM)
+			report_member(mode, &expr->pos,
+				base_type(expr->enum_node), expr->enum_node);
+
 	break; case EXPR_LABEL:
 		ret = &label_ctype;
 
diff --git a/expression.c b/expression.c
index b23107da..573358e3 100644
--- a/expression.c
+++ b/expression.c
@@ -479,6 +479,9 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			/* we want the right position reported, thus the copy */
 			expr->pos = token->pos;
 			expr->flags = CEF_SET_ENUM;
+			// enum { X = bad } results in EXPR_SYMBOL
+			if (expr->type == EXPR_VALUE)
+				expr->enum_node = sym;
 			token = next;
 			break;
 		}
diff --git a/expression.h b/expression.h
index ce8a29ce..b7abff15 100644
--- a/expression.h
+++ b/expression.h
@@ -167,6 +167,7 @@ struct expression {
 		// EXPR_VALUE
 		struct {
 			unsigned long long value;
+			struct symbol *enum_node;
 			unsigned taint;
 		};
 
-- 
2.52.0

