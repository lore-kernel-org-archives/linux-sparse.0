Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50E3346A6
	for <linux-sparse@vger.kernel.org>; Sun, 11 Jan 2026 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152530; cv=none; b=SRw/BIshma2CmIzABSSWEWbTdB3VTIzWvVxqaweGxxS20ZDFnLyw5qGJ+kJExIuUejrGt3xI+Xuy3UINFShPXGY8aiFfgYUo9rvZdLryK7Me/5XcjVcHuoC+tgdYQhyINb1HU8KI5s0qsKWauLgVYubIOsaT1qyuXGj8H4O+kAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152530; c=relaxed/simple;
	bh=gDbu7wi6X9UvZUfMezlRqfZFl0pGVDpZv/5pjT4cgBA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oAGYFx6uwmWHaGSoP/7CBU08CBLbScNYnwgqLWtfXB4GOZcXb/zcwh8CWdA9HuYHQ1V/XWTSLckfMMpJ47Kqt1dn8+pHBLgES8TLRujo3EmdUMchEx6X5qRF6scBHHulySq7TE9xrRCGSPB9sMAX5nASRd/LfUUZ70DEEIUlpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWaL9XOD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWaL9XOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768152527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uBEtjeSDtWNHkelxbH8EVEocmUdMR/PKKgi+mpZzQ/o=;
	b=HWaL9XODTveQgKKQEUnSeu6nbeBXNW2CMyBP+ZRRXZ/G17e69NHeFXzE53jrPuprx/JDTI
	hGQ76FmfYnGTPPUhP6JsYfuCYKDLd1AHSYpQ4iopSjdgmStgrvqCFxJLzn2Whvr6tskvGN
	c6+GFxnqJMxEcUFAP88B0oBBWimmIvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-DdMpUpLUNGm9QMFVHrInwA-1; Sun,
 11 Jan 2026 12:28:34 -0500
X-MC-Unique: DdMpUpLUNGm9QMFVHrInwA-1
X-Mimecast-MFC-AGG-ID: DdMpUpLUNGm9QMFVHrInwA_1768152510
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07F971956096;
	Sun, 11 Jan 2026 17:28:30 +0000 (UTC)
Received: from fedora (unknown [10.44.33.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3262218004D8;
	Sun, 11 Jan 2026 17:28:27 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 11 Jan 2026 18:28:29 +0100 (CET)
Date: Sun, 11 Jan 2026 18:28:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/dissect: change do_symbol(sym) to use sym->definition
Message-ID: <aWPduv1ewBCFVn5w@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JWci1n1NcAxP2foFZnClGbmCxYgPyUHl_SbSLDaQbZU_1768152510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Test-case:

	$ cat TEST.c
	static inline void i_func(void) { FUNC(); }
	static inline void i_func(void);
	void func(void) { i_func(); }

	$ ./test-dissect TEST.c

	   3:6                    def   f func                             void ( ... )
	   2:20                   def   f i_func                           void ( ... )
	   3:19  func             --r   f i_func                           void ( ... )

dissect reports the wrong position for the definition of i_func()
and doesn't inspect its body.

This is because the 2nd external_declaration() binds another SYM_NODE
to the same ident and lookup_symbol() called during parsing returns
the most recent one, which is then used by do_symbol().

With this patch:

	$ ./test-dissect TEST.c

	   3:6                    def   f func                             void ( ... )
	   1:20                   def   f i_func                           void ( ... )
	   1:35  i_func           --r   f FUNC                             bad type
	   3:19  func             --r   f i_func                           void ( ... )

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index a0fda09c..f20522f0 100644
--- a/dissect.c
+++ b/dissect.c
@@ -630,12 +630,17 @@ static inline bool is_typedef(struct symbol *sym)
 	return (sym->namespace == NS_TYPEDEF);
 }
 
-static struct symbol *do_symbol(struct symbol *sym)
+static struct symbol *do_symbol(struct symbol *__sym)
 {
+	struct symbol *sym = __sym->definition ?: __sym;
 	struct symbol *type = base_type(sym);
 	struct symbol *dctx = dissect_ctx;
 	struct statement *stmt;
 
+	if (sym->inspected)
+		return type;
+	sym->inspected = 1;
+
 	reporter->r_symdef(sym);
 
 	switch (type->type) {
-- 
2.52.0


