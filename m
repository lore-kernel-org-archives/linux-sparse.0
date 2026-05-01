Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A226FDBF
	for <linux-sparse@vger.kernel.org>; Fri,  1 May 2026 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630753; cv=none; b=jaYHkIjxckUDh5+mH3l/oN56SnbpHNaogKJGimU+D51FBC+i5pIpPKULMazJoi1puJ/mP9iDY681wvLfkvJn2jrnNBORxC6dFW6T6m4u4QR8aRHXxJ/Bx3rJ82cm8niNxl6jbBgVIH5+Lig3I/TBETDmgAZ6f62xxhH8shMiswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630753; c=relaxed/simple;
	bh=F8P4NXDJFmj26W/IY6mTp2IAxxgsx3159DFUq7HKVy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOgbGOw15bWF3aYENWE0ItrNXvVXd0d38UMybDACLFJajZPdILY6l9t1Bi8rcERlR0+2lR7Khg27EUqwqT/TvraQqEvG0xP5utJyE0fwUWgbD1sSmBd9zm9ZMQmivyZ02AG5g53o1KJmW79mh3AccNuBAoiTAraoXeVCzz6Wfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=fSke407e; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="fSke407e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=zkb2LCPEDjl3gNAq/UMJ3+Gohk+udUcrm/U2wX2aT8g=; b=fSke407eE+4D7FLF
	mHC2/O2fyFV+7h+VKKFmLQ+jBxEDv51fXct5zE7zo6PEox3TXgdRHmFXTaZ5EPAIfMzlFt9HoILtN
	+nawE4kyZhu3lgFe84JN2IdUQPPH61IEkn3h4izlXQIOnGWQg+0bqF2/ZlPAWY74gu+LUPN8kqjiT
	46XHBK5QcSv4101oa8wlguvwQl5Df1+WqaL0E2qSq8Qjobmpfc643Wzb4EOr/0JTEx84FlI1AcUvn
	b9MahN59eZK27cgierr2fajtkjDUDH8Y2m1zpRDaCLcq733K1xEcxtLfpqjZGvBFbuGkB3damuVoi
	Wrl5FtA3649eldmErA==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wIkMG-0038rI-2d; Fri, 01 May 2026 10:40:28 +0100
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1wIkMF-00000002wKp-31en;
	Fri, 01 May 2026 10:40:27 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH RESEND 2/2] RISC-V: restart extension search on match
Date: Fri,  1 May 2026 10:40:26 +0100
Message-Id: <20260501094026.700865-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260501094026.700865-1-ben.dooks@codethink.co.uk>
References: <20260501094026.700865-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

If we are passed multiple extensions in -march, don't assume these will
be in any sort of order. If we do match, then restart the loop by setting
the search back to 0, and retrying.

This sorts out issues with the current kernel build where there are now
lots of extensions for the rv64i and even adding zacas doesn't silence the
warnings generated.

Tested-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
  - fixed accidental whitespace change.
---
 target-riscv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target-riscv.c b/target-riscv.c
index 80c25285..cd6104b2 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -80,6 +80,7 @@ ext:
 		if (!strncmp(arg, pat, len)) {
 			riscv_flags |= extensions[i].flags;
 			arg += len;
+			i = 0;
 		}
 	}
 	if (arg[0])
-- 
2.37.2.352.g3c44437643

