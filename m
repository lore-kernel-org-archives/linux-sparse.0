Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E39154BF5
	for <linux-sparse@vger.kernel.org>; Fri,  2 Jan 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356807; cv=none; b=Idfk/3AdEB9SdtWZfwAVsWf0C4x+wu5jDkSTSIwV4zZI0/yc2NJR2R/yg1K/knrqISWWvyy10ubsgom3PNz1JSl0bhtgGqTd0i+dx8F8iwiC6fnR9ZPgZ4tgjvLPgPSBpmi3bRQwzxs/+ABfkYkAoBtx9i8iwVItKAhRaZF8HIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356807; c=relaxed/simple;
	bh=Axn9yvQTDr8iE9WkmAi1sT44ZFvCnT20G9DfRVZHlas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVbMMyhHVkhXZajAsa8D89VHupe4nuYg7AquFEs9V/C5neWJpZRKpVDSYVN93JJqZsUpY8v8gPvh2E5LQOZ7/TOv3aGIUfrWAjmpT+pZXJECBSzTWo1PbIemXQhzcFNmc3gdJ+v4yhowEVgR7LwAQv3yJy8nqHZI7RRux6qMp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=u0Ei5SmU; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="u0Ei5SmU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=A/oPUVC995fZtlQ5hcnZuZKofYdrDDgjMGWMWw8cFJY=; b=u0Ei5SmUqAqK4Tf9
	dvI85aEJOYIxF7Uj2VHl0UNQlzTvkKvLj6sXckDAeqdK7sZtDCMxhEJIVTw0xMECADYTSU5Vbz+OT
	NSkDw51UjzLyBfhl1VJM2s9nBVfssZXt+dcd/ViziB+KNdYP9mGAiQAyzTo735N80sKpeBm7TIhuQ
	wpajM9L5u197SEhE3G4IFrz3Rtb8TxyG8fN4W/gbKw02VupIrT8rj7rnanOJ9QJx+KbaCUbb5U6fa
	FRFMkDbjN62PPPWDqBxc1P8O5BQu6u7FDsF64EZNGCJmATcx12ouQh8XcOid2PHBtDvkGybu+lfC5
	y8bQP8XPFAWzLY6/ng==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vbdaM-003fEa-PP; Fri, 02 Jan 2026 11:44:50 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vbdaM-00000002FXj-1ynz;
	Fri, 02 Jan 2026 11:44:50 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] RISC-V: Stop warning about Zabha and Zacas
Date: Fri,  2 Jan 2026 11:44:48 +0000
Message-Id: <20260102114449.535597-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260102114449.535597-1-ben.dooks@codethink.co.uk>
References: <20260102114449.535597-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The zabha (atomic byte and halfword) and zacas (atomic compare/swap)
are now being used by the kernel, so parse these and stop the warnings
when running make C=1 on current kernels.

WARNING: invalid argument to '-march': '_zacas_zabha'

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 target-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index d30be04b..80c25285 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -22,6 +22,8 @@
 #define RISCV_ZICBOM	(1 << 12)
 #define RISCV_ZIHINTPAUSE	(1 << 13)
 #define RISCV_VECTOR	(1 << 14)
+#define RISCV_ATOMIC_CAS (1 << 15)
+#define RISCV_ATOMIC_BH	 (1 << 16)
 
 static unsigned int riscv_flags;
 
@@ -43,6 +45,8 @@ static void parse_march_riscv(const char *arg)
 		{ "d",		RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
 		{ "c",		RISCV_COMP },
 		{ "v",		RISCV_VECTOR|RISCV_FPU|RISCV_ZICSR },
+		{ "_zacas",	RISCV_ATOMIC_CAS },
+		{ "_zabha",	RISCV_ATOMIC_BH },
 		{ "_zicsr",	RISCV_ZICSR },
 		{ "_zifencei",	RISCV_ZIFENCEI },
 		{ "_zicbom",	RISCV_ZICBOM },
-- 
2.37.2.352.g3c44437643

