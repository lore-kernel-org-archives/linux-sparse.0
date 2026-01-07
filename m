Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B93090E0
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821422; cv=none; b=cZcKc3IEe+556HWLCTWSwCh9kUVp5YrUwECgDJvMEh26A+osuOlE03GK1Dnly4vaU55k3SiS91cfbbnH7ChoPCX1a0YLlr+/CeRNL7n5kcTkqOB5azoN8Ig2anakqIyuSPQzkkKHLVpwRL0r2OuaUqj55NCAawgeivV6JikxXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821422; c=relaxed/simple;
	bh=F8P4NXDJFmj26W/IY6mTp2IAxxgsx3159DFUq7HKVy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FA20NwyLzvzAfHaZxF1YOk/IzZxDx7tDsfYOkNIZZV63Ew5SzRFzpMlKSLW1PuFzBhatYlBsJC93/sgojgv6usDDAm+kWJ3stEJxHm6xgZT+6ixcmnJMo49Zq73/IAsOGAAeZLmnKUfSCTLKoC/KcSGT/Kg5PVLdN1DMYyVEMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=YAU98IEo; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="YAU98IEo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=zkb2LCPEDjl3gNAq/UMJ3+Gohk+udUcrm/U2wX2aT8g=; b=YAU98IEoBuY9P/Wn
	kCVyCMn07xjQ3yUblp4/eVFmcMXEJChPAj4M+FMzifK60dlPXyMSenQntLyQTv0TMkRJDEGHOvDUK
	41tOAxlrxzYR1kfLvD81PFeI5M9AQRRl5YFWa/alNsCNVFF4+/taZV10nuWjZMTHOPPwumOMuCyz/
	T/Ftk0GiJ5pObzFcZRfMeXgwl81CTNX+9KttTOLXL6zPgjVar1Yj7A1hFUoPONHwM+9wtrAfK9S8P
	xP3kvv5BNuEIOPOmuQYZ4MZxtPxDJbWmHXz00le0RJiY8/H8D3bTq+kZLcDyiXXmDe+DhLW1HHq99
	SWfZ3Ldya2T8HH5dYw==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vdb6d-009tXJ-DU; Wed, 07 Jan 2026 21:30:15 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
	(envelope-from <ben@rainbowdash>)
	id 1vdb6d-00000000rDx-0H8u;
	Wed, 07 Jan 2026 21:30:15 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCHv2 2/2] RISC-V: restart extension search on match
Date: Wed,  7 Jan 2026 21:30:11 +0000
Message-Id: <20260107213011.204578-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260107213011.204578-1-ben.dooks@codethink.co.uk>
References: <20260107213011.204578-1-ben.dooks@codethink.co.uk>
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

