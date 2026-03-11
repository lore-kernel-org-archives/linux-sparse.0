Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1053C3C12
	for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223362; cv=none; b=Fh6x3vT23ZNtG0Savhl3Ioe4DmkYMKHCblwF/aggqI8HHfASLb9jrnudW4WfltdBzeqNESeSUcoVW7iG/1+26n5hBRmMSrE02o+lXX68ByJMwopxnOd0WBQVq94giboCYjkdPLHxDePEiTyPr07x4ppNCvyo+8LFUJckxA8ibnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223362; c=relaxed/simple;
	bh=diJU7pO3Dpm+KuOEFS69pzt45/BUKlRcPFxqbStdPfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXLhN1y1ewDSJotXcVpvaqXlmiNxiJA/pxUZDxgDXF1McSGh6veRCkgwmjTShNEc8qQsaooPZbCAZQQb5/wEWYuw2Xr8I7yDuj5IUKOl/h7sJNMQda5O90eAjif8nBzaGrcr5rLwAf4k+ADFxz8N530dQRrBGbamcy1zXzM9vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=mcyUNqZ0; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="mcyUNqZ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=f5vO4mAKnsemx7NWsipMd9mTEIwUnwvoJtFYADWCHhw=; b=mcyUNqZ0L11OEK
	U1sgOHlHI6MP8L9wtNPU2uPtDcoqbsG55Uw7ajwTed5DkI1kYfm7Mm5vEZbH3Q719JecELMK7hVPJ
	ENw8/aRoLg7K6Ztd52n469HN2f7irQM5PsKFO23F632QCEGALXXIirL2MBmiARLQbhjnHZBT2HmB5
	ODbl435Q1HYyvxMRaM4eaPC9BkzvN22NVWJUTYW1pscDAstbznInaQZLz2GuAtxj/54eOp8XT8dYP
	00ddjT2h0J9wC+oOhKdGJF8XPHfqlU4CIZ4tz91hR2ZwVj5Uk0cAooCNCTAJvlDB6G2p0tpL6kCSi
	5jCRVVzC8OvPoJ65UkZQ==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1w0GOh-00Ezf8-7r; Wed, 11 Mar 2026 10:02:35 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1w0GOg-00000001c5E-3crO;
	Wed, 11 Mar 2026 10:02:34 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	pjw@kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] RISC-V: Ignore Zicfiss and Zicfilp for now
Date: Wed, 11 Mar 2026 10:02:33 +0000
Message-Id: <20260311100233.384711-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

These two are part of the CFI[1] and do not seem to need any
sort of special handling as yet. Just add these to list of
known extensions to stop annoying warnings from current
Linux kernel builds.

[1] (https://docs.riscv.org/reference/isa/priv/priv-cfi.html
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 target-riscv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index cd6104b2..5b13202c 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -48,6 +48,8 @@ static void parse_march_riscv(const char *arg)
 		{ "_zacas",	RISCV_ATOMIC_CAS },
 		{ "_zabha",	RISCV_ATOMIC_BH },
 		{ "_zicsr",	RISCV_ZICSR },
+		{ "_zicfilp",	0 },
+		{ "_zicfiss'",	0 },
 		{ "_zifencei",	RISCV_ZIFENCEI },
 		{ "_zicbom",	RISCV_ZICBOM },
 		{ "_zihintpause",	RISCV_ZIHINTPAUSE },
-- 
2.37.2.352.g3c44437643

