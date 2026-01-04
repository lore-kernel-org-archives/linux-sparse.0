Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396A3C38
	for <linux-sparse@vger.kernel.org>; Sun,  4 Jan 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767540085; cv=none; b=fsZ5w51dFS8VvYWii36SFqqO2wKWm9KCcVg2m8fL3QfG3FbSOLxD7ogXEcHrs4TBTHP5132/hak6vUeqjwR2BOpXL5QwUM5wiL8Q7E+sEDRcrWLFiKEEGZSBiumnIUU2IV+sQ1t542M/NA3iUyM/cjfMG66ACVTWRH+tb2Se46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767540085; c=relaxed/simple;
	bh=41XzK9TZ1cICTJWasCK77JPQNPAlBwgNtX5rVXmB0ck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZH/A/8bTigrqH7cMxvCXZNj0eky/JnN97y7k1QnqEQ5nOoPS6DEOfkjqBeunWu7akn48WUfRhvtRqCs1zWQWFIloCg9JEhBHUK0HNYkp0jpzWwlMBWNfiW/G07mEKRDodohmEC2bTgmdJuX/x/vB3+Qk6eg2jHMjmEhjmgtnPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T831KeHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T831KeHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767540082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cvdCMr1ajnYWvjvJ7MO8mDOR6hOfBQVfSUPb9cyVlJM=;
	b=T831KeHB6tlo0LPxQhWahzrlzA01OXi2eU+Ll0ZZBdPq+s6PnN+qH2CFGJJPnY/ygse2Xb
	M24hg7JDnMvbVKtXhOxqNHf9LKiEo/uG3yITkwOb5p3MgNg+vjZ+BrBAn1CzzlCMbG/2ja
	lOWycpt5bVhkY7osS+xCsDr1p6b2HF4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-dRbiIvKUN3Ou9VGDicGIwg-1; Sun,
 04 Jan 2026 10:21:17 -0500
X-MC-Unique: dRbiIvKUN3Ou9VGDicGIwg-1
X-Mimecast-MFC-AGG-ID: dRbiIvKUN3Ou9VGDicGIwg_1767540076
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89221195608D;
	Sun,  4 Jan 2026 15:21:16 +0000 (UTC)
Received: from fedora (unknown [10.45.224.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 975F819560AB;
	Sun,  4 Jan 2026 15:21:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  4 Jan 2026 16:21:16 +0100 (CET)
Date: Sun, 4 Jan 2026 16:21:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH 0/4] sparse/dissect: handle SYM_ENUM
Message-ID: <aVqFaL88QonZYs63@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nI2dM-PYsZ8K5gBeWNy39MGc2mDce8fS8ThD-QR58aE_1767540076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Chris, Luc, will you ever take or at least review the spam I send? ;)

semind.c:r_member() was not updated yet, this needs to be discussed
with Alexey first.

Oleg.
---

 dissect.c      | 20 ++++++++++---------
 expression.c   |  3 +++
 expression.h   |  1 +
 test-dissect.c | 61 ++++++++++++++++++++++++++++++++--------------------------
 4 files changed, 49 insertions(+), 36 deletions(-)

