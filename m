Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C026D4F7
	for <linux-sparse@vger.kernel.org>; Sat, 13 Jun 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362436; cv=none; b=S0sPdX+3PEzkbXvqMGGrZjpLhQbmEoOeX/4Wlo+OLvGSjrVhYjLciC1/pBlCmLcumprnZUTzUIjXU/0CLZHJlPj+tBzm1qaLT7dEHF+d2NxTIvgqNeedCkx6eugXPogoNMvnmSCGVjDjNRky/H9gTofZEMhUy9XZOTPc0p+E3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362436; c=relaxed/simple;
	bh=yH/PHyWa8mS73SxMtevbmxL6nATaQKLrfDkkPP5vaQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ma1985KUrvVZ4jNgL9VlLBN1E/Uqbz6OgffAaiwXgq40rS/lLNm69Dj4Q1NkfU6/Bnmb5NoZfQSz3Skle2Ieoe9/rs9doZtPBsrLvJpyxwpsUH1hbGADrmhJ5qUDsdiN36bYoNNs3JQIY9iWp4F5s7tfixvxSDf7meTxwNXxbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHjoDRGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHjoDRGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781362434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ohu5KKiOqpxpvJJ5iKLtWh/Sveu9NRoDYxVfZDnw3IM=;
	b=NHjoDRGih5zIlyxN0NDKymgRA3BNxxN+AWnD50NvmgMyjaNFbxXLq73hI5OxHlFEREXcrW
	qXnMnwVaAi/DTcWSqfLNq753BkpUYha5UbNSJQ1/iRqXXuu5C0GfwO9xiflG3BudrmLdUw
	CKbGxXFwty6YMBcFkgju41QXTffE1oM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-qtzNgPrzNJylrGlZhswELQ-1; Sat,
 13 Jun 2026 10:53:52 -0400
X-MC-Unique: qtzNgPrzNJylrGlZhswELQ-1
X-Mimecast-MFC-AGG-ID: qtzNgPrzNJylrGlZhswELQ_1781362431
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A2701800347;
	Sat, 13 Jun 2026 14:53:51 +0000 (UTC)
Received: from fedora (unknown [10.44.32.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B349F180049F;
	Sat, 13 Jun 2026 14:53:49 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 13 Jun 2026 16:53:51 +0200 (CEST)
Date: Sat, 13 Jun 2026 16:53:47 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse: increase MAX_STRING to 4096*3
Message-ID: <ai1u-0eA0bCn-VkM@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x8waSCz6UmkPqw5aCUJTfd_gulkG_mK-a62Lhh3mNh4_1781362431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sure, 12288 is just another "random" value, but with this change the
following command

	$ make C=2 CHECK="semind add --"

no longer emits the errors like

	./include/trace/events/vmscan.h:122:17: error: too long token expansion

It is not clear why (before this change) MAX_STRING is odd. I guess this
comes from the initial commit 7601387b02d9 ("C99 says strings should be up
to 4095 bytes."), but I don't think this is relevant at least after another
commit fbc8230fa8c4 ("Larger buffer size for token concatenation") which
increased MAX_STRING to 4096*2-1. And struct string / __alloc_string() do
not depend on the hardcoded constants anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 token.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/token.h b/token.h
index 9000e0cb..720ad0c3 100644
--- a/token.h
+++ b/token.h
@@ -197,7 +197,7 @@ struct token {
 	};
 };
 
-#define MAX_STRING 8191
+#define MAX_STRING (4096*3)
 
 static inline struct token *containing_token(struct token **p)
 {
-- 
2.52.0


