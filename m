Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B172D5936
	for <linux-sparse@vger.kernel.org>; Sun, 28 Dec 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766926526; cv=none; b=P0EIFjK7EnrIjsuODH3fiTVS3LmSTmT2qKjewjVqzXzZ0tV5S44DJj/qyjIjLmEZGvLe3HQ3Oq2HEMNamIyTZ3KI5ieQY901V3ODtCMqcMQMiTx13lyQ5oRsykYr17z+HsL2F2478tqboQziDF1z+94MjJ6b5bx2I8040ExRBkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766926526; c=relaxed/simple;
	bh=9db6qbyA6vVS0edhUxGKCzcajUECRgqKCiBHlPSJVl4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=orAjBC93Y0qY8jgmNoMewdtCdUVJuAvnEjcPw9k7WzcEgwEt4ayV9M/wpeoccRRz5oJt6QR9tSdVsPyO226g3KyXGJvssj3cqfbDWJjrI+/uZBL6f6XMF2BiFdCoPhCyuzMsnxGvooTAjSR2HEv3RHbLVQNqAdsiChhzAwFoGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQScCX6C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQScCX6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766926523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MCDI7oyrFNaFiHHQRZYfEyf9bydZv7J2bJPi2JTdCj0=;
	b=eQScCX6CQ0/hBU2GHddG9k9pfW3us5ZSaX5AXPllkp+tvE/sqH3plEV2wUda0xLqPPntNx
	nEXy40dOfll8EDz/f/p2PlCXf0XgtNiO2j3adn8JLDK9qMb8eVUpe7GhCaO1NozEVy9G4S
	HatMpSe4IFT2x1f0sVCibfUuRHuL3K8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-39o73qAJMk2Md3gf4CR7uQ-1; Sun,
 28 Dec 2025 07:55:20 -0500
X-MC-Unique: 39o73qAJMk2Md3gf4CR7uQ-1
X-Mimecast-MFC-AGG-ID: 39o73qAJMk2Md3gf4CR7uQ_1766926519
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9ACF19560B2;
	Sun, 28 Dec 2025 12:55:18 +0000 (UTC)
Received: from fedora (unknown [10.44.32.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0AC0F30001A8;
	Sun, 28 Dec 2025 12:55:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Dec 2025 13:55:18 +0100 (CET)
Date: Sun, 28 Dec 2025 13:55:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/dissect: change do_file() to use __sparse()
Message-ID: <aVEos-vrx34olo6s@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tUMyuexf-e7e44PLJJqrthN2JHipErV4r1fexPtgGGM_1766926519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

rather than do sparse_keep_tokens/clear_token_alloc by hand.

dissect/semind doesn't need/use tokens, we can safely do
drop_all_allocations(token_allocator) after parsing.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/dissect.c b/dissect.c
index 62f927c5..55e76846 100644
--- a/dissect.c
+++ b/dissect.c
@@ -681,14 +681,10 @@ static inline bool valid_namespace(enum namespace ns)
 	return (ns == NS_TYPEDEF || ns == NS_MACRO || ns == NS_UNDEF || ns == NS_STRUCT || ns == NS_SYMBOL);
 }
 
-static void do_file(char *file)
+static void do_file(struct symbol_list *res)
 {
-	struct symbol_list *res = sparse_keep_tokens(file);
-
-	if (!dissect_show_all_symbols) {
-		do_sym_list(res);
-		goto end;
-	}
+	if (!dissect_show_all_symbols)
+		return do_sym_list(res);
 
 	DO_LIST(file_scope->symbols, sym,
 		if (input_streams[sym->pos.stream].fd != -1 && valid_namespace(sym->namespace)) {
@@ -719,10 +715,6 @@ static void do_file(char *file)
 			do_symbol(sym);
 		}
 	);
-
-end:
-	/* Drop the tokens for this file after parsing */
-	clear_token_alloc();
 }
 
 void dissect(struct reporter *rep, struct string_list *filelist)
@@ -730,5 +722,5 @@ void dissect(struct reporter *rep, struct string_list *filelist)
 	dissect_mode = 1;
 	reporter = rep;
 
-	DO_LIST(filelist, file, do_file(file));
+	DO_LIST(filelist, file, do_file(__sparse(file)));
 }
-- 
2.52.0


