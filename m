Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B230EF76
	for <linux-sparse@vger.kernel.org>; Fri,  2 Jan 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355768; cv=none; b=AJo7VUzSfoF3OX18AViVc0DFdI03TYo+qSEuATzw1voAlwc5C14nU8rPXqc8Wu9Pyx77e975h/qOozX2xdFFgsgx2j5i94R3fmpo14sykPyXn0GpFvJkLLmuYUVFsj6Rp525EKSGw2uXCoi2monqfR2j+OGHkrYE/T7UJcVbJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355768; c=relaxed/simple;
	bh=s2EyDQjTgg2RCdccckdJ5JFFrG10s/9+Du5ubd+1N4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNZ9NXt9VVThiAchIk3/07QAl51VqDXOGaNgDtlTkyawheJmtqKc1aQrg35IeOaOKC0rWQv3ULjYA+gZRs9hBS4PI3msxDQd+1APpMXiFNBOVjMLdS2FSbLdH4LZcHPorgITyi1MExwm66NsVVTUCRtL9o0jLEAb67lkXx/sm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=6a3a/+6d; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="6a3a/+6d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=zjo3PiQezr0MQPpRQGd3WNZe5cObPVmGZc16I/iCTxM=; b=6a3a/+6dJV28MUgj
	URCBnzM1u5/k+99yZ0Tlzo76y0REbr26aQSuw9SqGKcvcQH4gzJ2mQEHdOcmElqpfR/t9iAt28i+H
	kLUvFrWcIZQuqz7rZqzn/pAv5MK8nfFOnh88Rl0wiwtBayQXTLcDzY0nYxKnWPi3dKvQnx34O2W6M
	mfT5o+HTdmWGv+PbEjzY5OmM5bAOD74p774HwxqbARqe89OvrRssdFptYZbqHFqkuP/jT8/UF1kNZ
	uNpROgAV360MlP585IMXiM2S+RseQVQXCoxoJFxON80LYNIgqKly+1iDxxB5MpxFK22DUfwqAe6xY
	EBpLsaDnSl4gkE+vJQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vbdaM-00HP3W-TF; Fri, 02 Jan 2026 11:44:50 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vbdaM-00000002FXn-2JHX;
	Fri, 02 Jan 2026 11:44:50 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/2] RISC-V: restart extension search on match
Date: Fri,  2 Jan 2026 11:44:49 +0000
Message-Id: <20260102114449.535597-3-ben.dooks@codethink.co.uk>
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

If we are passed multiple extensions in -march, don't assume these will
be in any sort of order. If we do match, then restart the loop by setting
the search back to 0, and retrying.

This sorts out issues with the current kernel build where there are now
lots of extensions for the rv64i and even adding zacas doesn't silence the
warnings generated.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 target-riscv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target-riscv.c b/target-riscv.c
index 80c25285..ddf50e61 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -56,7 +56,7 @@ static void parse_march_riscv(const char *arg)
 
 	// Each -march=.. options entirely overrides previous ones
 	riscv_flags = 0;
-
+	
 	for (i = 0; i < ARRAY_SIZE(basic_sets); i++) {
 		const char *pat = basic_sets[i].pattern;
 		size_t len = strlen(pat);
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

