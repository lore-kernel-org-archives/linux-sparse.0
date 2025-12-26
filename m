Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DC3A1E60
	for <linux-sparse@vger.kernel.org>; Fri, 26 Dec 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766759525; cv=none; b=CQ7e7NQieU8o9Rz26sK8WygvsyvQsYtkNpd9frq/A758PLhAa2yqaAVtnWpzqtxBAmtS8VcmqChEIXJRByuNJ78D3apmFXhBjH3F6xE73GyUMlHx1l9R/N16HhzuVOzGW7h9AHN+8RFQPioVC/mkvswf40OUY7LBKI3TlwC7K8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766759525; c=relaxed/simple;
	bh=/tKKPzd1OL3FL+umGHfeLviD6ucp+0CNBpqjWcPmyl0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ty7zUAykxPCcXAQ5bMpefAOx934DIG4aaieNVDX1aVwPANMGebMDMpILDBWj3vK8XY9cXhlE8atSszx0/vt0TStWqecedGfAouM1JOSU+EbHrA6C3I+P1LBlN67ISvvTCqeeXYHvaO1zbL3KNthDyYvqzzQDPy455YL1yS7gwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UW56cyFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW56cyFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766759523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1QdLUV3cXKLDm5bUtna847OneK77XC4e+aeTqa6z/J4=;
	b=UW56cyFvKwb9v9ROuZbw5alClxwfSSsjR7iVatJd27QXIkFIiZpomk7favkaxBgoqNPgDc
	x/Q+qxXut5Q1LKe6Da2JXdxlDb7y/JgsMrVYEDwLGFU2fSm+hmuNbQpedasbIxFoNQ6xM8
	Bc76Qx7D4IbsUvBkDcIvaerfYcqScBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-TTofv-n-PeKgAyJdli48bw-1; Fri,
 26 Dec 2025 09:32:01 -0500
X-MC-Unique: TTofv-n-PeKgAyJdli48bw-1
X-Mimecast-MFC-AGG-ID: TTofv-n-PeKgAyJdli48bw_1766759520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EDA6195F156;
	Fri, 26 Dec 2025 14:32:00 +0000 (UTC)
Received: from fedora (unknown [10.45.224.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 342681800367;
	Fri, 26 Dec 2025 14:31:57 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Dec 2025 15:31:59 +0100 (CET)
Date: Fri, 26 Dec 2025 15:31:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 1/2] sparse/semind: add the new --param=dissect-show-compiled
 option
Message-ID: <aU6cXFyfwtD9GMYa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XhwwolnL3wuzrJvT3QciT4MXTTCgp-CAyAxa_K-cTf8_1766759520
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

parse_cmdline_add() sets dissect_show_all_symbols = 1 unconditionally
and currently it is not possible to clear this option.

We could simply remove this line; users could use
"semind add --param=dissect-show-all-symbols," but this would break
existing setups.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 options.c | 2 ++
 semind.c  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/options.c b/options.c
index 0f207e80..dbe0349f 100644
--- a/options.c
+++ b/options.c
@@ -976,6 +976,8 @@ static char **handle_param(char *arg, char **next)
 
 	if (!strcmp(value, "dissect-show-all-symbols"))
 		dissect_show_all_symbols = 1;
+	else if (!strcmp(value, "dissect-show-compiled"))
+		dissect_show_all_symbols = 0;
 
 	return next;
 }
diff --git a/semind.c b/semind.c
index ad8003ba..fa084e04 100644
--- a/semind.c
+++ b/semind.c
@@ -322,14 +322,14 @@ done:
 		show_usage();
 	}
 
-	// enforce tabstop
+	// enforce defaults
 	tabstop = 1;
+	dissect_show_all_symbols = 1;
 
 	// step back since sparse_initialize will ignore argv[0].
 	optind--;
 
 	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
-	dissect_show_all_symbols = 1;
 }
 
 static void parse_cmdline_rm(int argc, char **argv)
-- 
2.52.0


