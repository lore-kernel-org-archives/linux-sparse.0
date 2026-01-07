Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDD2FD1B1
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821421; cv=none; b=C3FjwXF60h9nmx2U37NlsMfip7w2irllq9riZfHZUTT07Xz+PiQZwqI3DalkNz0n2PTWN7N8Pl4lzcJB5LpAp5nkDSF58o2fRQ3CztXR+mOTTQNj7ktv1SVxYhx1n9oZivzp7bphoVli6HocopOi3DAGqFp7r6Szoxaog7GYumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821421; c=relaxed/simple;
	bh=6q0W7uIYVt/wv3gxwgxxNenQVrmhJzNbCAwRQ6EzjFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n3pXqAy/7SxV4YA9nigCIrMNE/dxf8Nn/KanKhdzzQ+0/Nj8Pmhb1yW4YNPP8E6zSJ+ChFqoSu2vr6wIEobfmE4lKoEckZUOSxOQYGaM+4nRUhdhM6nyFEDVkRquLAXWxbiD58GUpCK8nom8oXcMy+b+FSCOhiy3vG32c8+thbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=EEU6ELsm; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="EEU6ELsm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=AU55MMGLjJuViy9eFBoGM5tbTqX5GlGQmkeC3JCUz2w=; b=EEU6ELsmyS4sJc
	UQBcbOFQayCjvbLyJcr6myDeiU3CLMZP96OP4RAycMM+XCeFsrlRBymhWtJmgaeTABkY6PF3AbEDJ
	CEnl8fnydSkMkoLHw0LDJdQvnZFjVr72zoyn5eW807aZrIEJVrCNru3dw/jzADxx77fZGQIpKP5+/
	JPiMTPMzIGtVzHrMUremDGezQPeQ8FgHqL/S7xr5NoJvPzacqgozyG9PbWxrmePJFje+s7UsLnDQr
	t+tlq46Xqv6TA214PVlpK6YbvavELHPwGd1wX4L/YGp6OFjBhsYjNdCZSzWGCsalgFQSXcLfDz1UR
	DnbVMNpG4hiULYnFGFtQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdb6c-009tXE-5P; Wed, 07 Jan 2026 21:30:14 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdb6b-00000000rDs-1Rhf;
	Wed, 07 Jan 2026 21:30:13 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCHv2 1/2] RISC-V: Stop warning about Zabha and Zacas
Date: Wed,  7 Jan 2026 21:30:10 +0000
Message-Id: <20260107213011.204578-1-ben.dooks@codethink.co.uk>
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

