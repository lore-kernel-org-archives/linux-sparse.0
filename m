Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20D32C94A
	for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260056; cv=none; b=k1TK0/f8huSgBceMfu7pT3aVuSjSUwiNxwPWdAHPIbztxzFjUuYrg3VAdoNdEks1TwNfJLYFdlSO8qFs76ZU+ttRMe606QlqxTkIrANh1Co5RZstm6wcPcj5fP4W3ebAVOE867nB+sK9aSjZUiESoymTfHaVEr+9T1M7V33QrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260056; c=relaxed/simple;
	bh=0acjMcoJUiaFnPoCYWrbzE85T1PrmLPVLxdvEZJvJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HzMzzwL0NZRR9/tzjla6B6NDVZDKxpolyKcBpOk4KJ7hAxmWcxTFBd3EFSMz272ZLWzfGdH8H2Crx3eOXRgZ0Fwj3ob4hfwpDvkIW643nZSUoM31bISOWLV9tJIUWj9MrGdqrDAENBlk8EoaD/92p2Hbc2mw1Lu6knnWYJgljwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7rDtBLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7rDtBLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Fq4oTUVrsQYX9Hdd5tH5N4xhhl2H/rgDamOoCUZtfg4=;
	b=Q7rDtBLSVFJiDdpMULVM/EMU2mehvMA9vEETwBrihJyQjfrp5ia3rMyjtXaiYs4OcbMOUW
	rideofTamCIz3kxGcYNU7PBuy0T0974lD860Wev3jCuXGfVLoEJOQcP4gFNRdVsuod9KPk
	piGpSQr27jbN3KYBW+zmcHP7DaULtTA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-TYyAqMRiOB6rOEQHwV_pgw-1; Fri,
 12 Jun 2026 06:27:30 -0400
X-MC-Unique: TYyAqMRiOB6rOEQHwV_pgw-1
X-Mimecast-MFC-AGG-ID: TYyAqMRiOB6rOEQHwV_pgw_1781260049
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4C131805C0A;
	Fri, 12 Jun 2026 10:27:28 +0000 (UTC)
Received: from fedora (unknown [10.44.48.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E3AB81800583;
	Fri, 12 Jun 2026 10:27:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 12 Jun 2026 12:27:28 +0200 (CEST)
Date: Fri, 12 Jun 2026 12:27:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>, linux-sparse@vger.kernel.org
Subject: [PATCH] sparse: predefine __ILP32__ and _ILP32 in 32-bit mode
Message-ID: <aivfDcM9QctmHBJx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VGvkVjvllHG657dDXvv6CRFdeNq7SLfOkOqXsy0dV9o_1781260049
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Unlike gcc, sparse doesn't define __ILP32__ in 32-bit mode:

	$ gcc -dM -E -m32 - </dev/null | grep LP32
	#define __ILP32__ 1
	#define _ILP32 1
	$ ./sparse -dM -E -m32 - </dev/null | grep LP32
	$

Because of this, arch/x86/include/uapi/asm/bitsperlong.h

	#if defined(__x86_64__) && !defined(__ILP32__)
	# define __BITS_PER_LONG 64
	#else
	# define __BITS_PER_LONG 32
	#endif

wrongly defines __BITS_PER_LONG == 64 when sparse inspects the files
in arch/x86/boot/. sparse treats -m16 like -m32 and this is fine for
sparse/semind purposes, but without __ILP32__ the bitsperlong checks
fail. For example, the following command

	$ make C=2 CHECK="semind add --"

complains:

	./include/asm-generic/bitsperlong.h:23:2: error: Inconsistent word size. Check asm/bitsperlong.h
	./include/asm-generic/bitsperlong.h:27:33: error: static assertion failed: "Inconsistent word size. Check asm/bitsperlong.h"

Change predefined_macros() to define __ILP32__ and _ILP32 for both
ARCH_X32 and ARCH_LP32.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 predefine.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/predefine.c b/predefine.c
index 5b0f0caf..28601aba 100644
--- a/predefine.c
+++ b/predefine.c
@@ -209,9 +209,8 @@ void predefined_macros(void)
 	predefine("__pragma__", 0, NULL);
 
 	switch (arch_m64) {
-	case ARCH_LP32:
-		break;
 	case ARCH_X32:
+	case ARCH_LP32:
 		predefine("__ILP32__", 1, "1");
 		predefine("_ILP32", 1, "1");
 		break;
-- 
2.52.0


