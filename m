Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091623346A6
	for <linux-sparse@vger.kernel.org>; Sun, 11 Jan 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152505; cv=none; b=pbRUQZtg/p3MYTOFaTxYXLtxU0wL7DfzG0eRWR7jOWOK/wDMg0i1Pl4wFf+7LPm7xdeGguFZEi7Jr/IbrXxJmO4hfpxYp2DP8sppnWYkI36JUi2XN3D/KquGchaiewVRzX8cGBWvVOfi2rRuZYNLPEXBgBlUxRe6pQMGMnPrOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152505; c=relaxed/simple;
	bh=1uED+6AcehgfXDMXQgN1MZH2FL6GsmyPkFVKvgtKtAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GSaLjdqhkzryGufvi1/BfYBBwxKlsJbuBxHfo7dFRdtd9piHjeaaQsC9ZaxdvKrrl8tHv46pddJdrl+PfyqeJk+tJ4CDV3vCWI05k9oL8/rBu6BY7r7fKjk+eMaArmsKEmrgFt6HgcRMOo7nyIU/tclCwwayOsNtp2GUJqTK0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APyzkjfA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APyzkjfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768152503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fB7OsjxwQlwpAHqnS7Sf6B43duggKU8u4DlmZs3QdSQ=;
	b=APyzkjfAX6rk3UHNzhCuEgwtRhF2rIo2LEQAGnycgK0W4tOQW0+pQzzpBzxKkxUWlpcJqR
	F/AXQ8tmQuGmJsU8EPLq/OlI5XMqQ37SJ+OZDz/7UVZ96mLchlZXJkRRrDxl8f57woUTAK
	IbGhsPMs8WYxrrDaKzU/drF5M+Q5ma8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-G746Y7IsOtW6HzNOKyfb6A-1; Sun,
 11 Jan 2026 12:28:19 -0500
X-MC-Unique: G746Y7IsOtW6HzNOKyfb6A-1
X-Mimecast-MFC-AGG-ID: G746Y7IsOtW6HzNOKyfb6A_1768152498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A34B6180047F;
	Sun, 11 Jan 2026 17:28:18 +0000 (UTC)
Received: from fedora (unknown [10.44.33.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CB8B01955F66;
	Sun, 11 Jan 2026 17:28:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 11 Jan 2026 18:28:18 +0100 (CET)
Date: Sun, 11 Jan 2026 18:28:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse/semind: change r_member() to use r_symbol() when
 mem->kind == 'e'
Message-ID: <aWPdrkv4DTnGRHPf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i3FqDNnFHbwd1y-kQNoAo2xI_p1BHnymAjICjCn0RGs_1768152498
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

dissect() tries to provide as much info as possible, but from the
semind's perspective it doesn't make sense to store the enumerators
as members; this just complicates the searching.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 semind.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/semind.c b/semind.c
index e9708444..92b8f243 100644
--- a/semind.c
+++ b/semind.c
@@ -746,6 +746,9 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
 	struct ident *ctx = &null;
 	struct index_record rec;
 
+	if (mem && mem->kind == 'e')
+		return r_symbol(mode, pos, mem);
+
 	update_stream();
 
 	if (semind_streams[pos->stream].id == -1)
-- 
2.52.0


