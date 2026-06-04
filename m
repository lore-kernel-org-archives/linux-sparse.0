Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9AE37E304
	for <linux-sparse@vger.kernel.org>; Thu,  4 Jun 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581181; cv=none; b=g2mnZL76lM8712MayyD0k9DcwQ1jJvn/lsNiOfjUKo/v/P0tS+NypDjXkZVvS2roKFqtESCa/pornEqn/TbAazlOQuZSlP0vIJSmVwaObdVPPCdfxmpi0NN9kG4mmaPNzGerLpqk44W4Oag3HLha+OjVh/G4MJL31oTncGq60ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581181; c=relaxed/simple;
	bh=jneIgYV5WuRzVycvcqDS1blrYbbHs7QesIy9djtumD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DDHgDGpmVin5ZXVJ0vum7tFMq0B62nlq9wUvkX0oRg5jMgIwVPzBQM9rUw/sk9zzvWhtM8mVKESviKy+RV3LJAcPSOLkwvZkYiIIJvDljwQr4eXVj8vKDT2WApAE38XuMtHjM5xfvkPbaHfMu37RYcTYfbrl/4KKtSEBF75v4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXA6CYu7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXA6CYu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780581179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BvNOucMrxn0Hc6LtpskrP4iZJJk+LAXEepYejzaMARs=;
	b=DXA6CYu7YGM8vBhtHLZGmIOiylYTyNjHZ8gGnvG5lJeJdjOPq/XQxYUkPmTVZx5J++XGZ1
	XR4PfzyfO/Gkr8QAFqTK8ltESFnD8bBsDQA5ERL3k/qStRaREI7pmukh17ry0C2dFVCnAQ
	DPKvlycXZa2/TXiwUSet3n8A7Er/iUY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-h6iMdQAjOgG_BAIQ3jRQ_A-1; Thu,
 04 Jun 2026 09:52:56 -0400
X-MC-Unique: h6iMdQAjOgG_BAIQ3jRQ_A-1
X-Mimecast-MFC-AGG-ID: h6iMdQAjOgG_BAIQ3jRQ_A_1780581175
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E42DF1800473;
	Thu,  4 Jun 2026 13:52:54 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 369431955BC0;
	Thu,  4 Jun 2026 13:52:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Jun 2026 15:52:54 +0200 (CEST)
Date: Thu, 4 Jun 2026 15:52:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/dissect: fix missing definitions for unnamed members
 of named types
Message-ID: <aiGDM56DNkolOPPX@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ipMBNlyzXHWsJup2EEtew6JdD7LzB4ij2TGe16iDrBo_1780581175
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that the Linux kernel is built with -fms-extensions, people use
this feature more and more often. However, dissect.c doesn't report
the definitions of members promoted from unnamed fields of named types.

This means, for example, that

	$ semind search -m def ns_common.ns_id

fails without this change.

Minimal test-case:

	union U { int i; };

	struct S { union U; } v = { .i = 0 };

Before the patch:

   3:8                    def   s S
   1:7                    def   s U
   1:15                   def   m U.i                              int
   3:23                   def   v v                                struct S
   3:23                   -w-   v v                                struct S
   3:30  v                -w-   m S.i                              int

After the patch:

   3:8                    def   s S
   1:7                    def   s U
   1:15                   def   m U.i                              int
   3:19                   def   m S.i                              int
   3:23                   def   v v                                struct S
   3:23                   -w-   v v                                struct S
   3:30  v                -w-   m S.i                              int

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 796b6e4d..04ec89ca 100644
--- a/dissect.c
+++ b/dissect.c
@@ -193,8 +193,19 @@ static bool deanon(struct symbol *base, struct ident *node, struct symbol *paren
 static void report_memdef(struct symbol *sym, struct symbol *mem)
 {
 	mem->kind = sym && sym->type == SYM_ENUM ? 'e' : 'm';
-	if (sym && mem->ident)
+	if (!sym)
+		return;
+	else if (mem->ident)
 		reporter->r_memdef(sym, mem);
+	else {
+		struct symbol *base = mem->ctype.base_type;
+		if (base->ident == sym->ident) // deanon()'ed
+			return;
+		// base->inspected is T, we can override ->pos
+		DO_LIST(base->symbol_list, __mem,
+			__mem->pos = mem->pos;
+			report_memdef(sym, __mem));
+	}
 }
 
 static void examine_sym_node(struct symbol *node, struct symbol *parent)
-- 
2.52.0


