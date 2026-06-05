Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8753E2AD0
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671384; cv=none; b=pgGZtID20wSSgoNMLpe4FsLgOVGsUpPLOUyIG2fYAYCr/CgTjP4ozbe53p3IOBR4K90R3YFNFatEUpxDwTcDbAwVFeOR3IXp2cq+9PwpOjbcfVl3wijmyrsJHlqK7urinAQ4Js2lStijtxnVGDCP5bZLEpt1dnz8HI43HsCAVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671384; c=relaxed/simple;
	bh=CqR0VYJw2RgiHYQAaIf3YxcTJuYMrSHRKPWFXgSbxDw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=asm5BvMcjMuVH1vxvBZv/sNoUZLA2ieo+n8VtE5YT/MsR7bz35oOI5sIE3shLMupqROh+2w2KkEc2GOSxDgtM6/BaBcarvSDkEXAuxsRrwhuMPhYwRHOZWNmGeKTWDA4dZa/Kw0VsfutbRjFe21wECe9eFy6iTwKL09FNMfmU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFpwrj2U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFpwrj2U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780671382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CqR0VYJw2RgiHYQAaIf3YxcTJuYMrSHRKPWFXgSbxDw=;
	b=NFpwrj2UqTDS6RK8/6B0ffYGWw8on/M2n/EwPut0kXgdofayJJi8vKE2w8d/wbsKWaKt+4
	/rOm8Ex1eJiBOb2tOjwWBIbkhN7LN86yZFmDLHvxVe+a5z8ro7vGBLL8WXb7bi7rTs/5eA
	Xwr9iwRV4R5jjLjAe6SGv8mOTOtP9Jc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-drgLTZyrMHa0o1-ZkwaxJg-1; Fri,
 05 Jun 2026 10:56:17 -0400
X-MC-Unique: drgLTZyrMHa0o1-ZkwaxJg-1
X-Mimecast-MFC-AGG-ID: drgLTZyrMHa0o1-ZkwaxJg_1780671376
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48A0B195608B;
	Fri,  5 Jun 2026 14:56:16 +0000 (UTC)
Received: from fedora (unknown [10.44.48.10])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 74455765;
	Fri,  5 Jun 2026 14:56:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Jun 2026 16:56:15 +0200 (CEST)
Date: Fri, 5 Jun 2026 16:56:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 0/4] sparse/dissect: fix missing usage reports for unnamed
 members of named types
Message-ID: <aiLjjDwKRB1UjNcs@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bi1ulp5gpQYkZDAONfSHfdY9R5cCUkf4fdRYux3IqDI_1780671376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

With the recent change, dissect.c correctly reports the definitions of the
promoted members, but it still doesn't report the usages of the underlying
members.

The only functional change is 4/4.

Oleg.
---

 dissect.c | 70 +++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 20 deletions(-)

