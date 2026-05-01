Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DE13D638
	for <linux-sparse@vger.kernel.org>; Fri,  1 May 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777628438; cv=none; b=miK1pv4Sg3+PTurt4AYuusZQZp4/3FDyPvMKn2BCIzfjzsbuDQdgpJ5prcIcJ1T4ZhpSiDv/sxa1jdNajb22vaQUYvBO9GSnv3AxcMRqa/VYI3aT975fUvePYkzBZnk7M2wktx+VHk3dkBUSeDeD9sFYzWdGc932+HWlUlFtyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777628438; c=relaxed/simple;
	bh=6q0W7uIYVt/wv3gxwgxxNenQVrmhJzNbCAwRQ6EzjFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f989jOiy4KSPczbKltRkqCq0FiDikHpkA+7r5mDyeBhobO2PnBZZCyzhPUsJezMtCD8pF38Nq8KtTtKq12m15qzMEKPxblrDR6o3ASTrFkYNGHxQX/qxIOCY7+jS6nJNPz4riyf4hQ5jPIEgTpvLSljIQfe5cy3zdyxAQPgYDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=cJI/MPp9; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="cJI/MPp9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=AU55MMGLjJuViy9eFBoGM5tbTqX5GlGQmkeC3JCUz2w=; b=cJI/MPp94xcrDG
	/p4y3BXfoeKeMrw9VwqjvRWn00Cvldgi/FoPC9bNB4ov6YFqSVcsGlZ8EkHvS7WITb9BlwtV5q9tM
	E0vka0gMeLTRiSk5gxbJgkjcLtG2ZVgGz2qoNbhXpwYJumZNf2Xy+trkkVd0aa4K6Z6hyHIErF7cQ
	jzGJItECOpcIt9GvcLLfqhbqG5lDVSl5x+kV+f9ZXHv7WX0oHqxTOpwhvKKcV+LDbOvxkAkLomIOK
	O/OJ1BAwo8O/4G8j8SiaMHzc0gekd3I2pqIXhRKTv3lDRiG3BTF6mJTLwy2yg7D3ZtGxyGvU53Rly
	OydyZZoz301R6Vp1ptNA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wIkMF-007ohQ-Sz; Fri, 01 May 2026 10:40:27 +0100
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1wIkMF-00000002wKW-255M;
	Fri, 01 May 2026 10:40:27 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH RESEND 1/2] RISC-V: Stop warning about Zabha and Zacas
Date: Fri,  1 May 2026 10:40:25 +0100
Message-Id: <20260501094026.700865-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
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

Tested-by: Paul Walmsley <pjw@kernel.org>
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

