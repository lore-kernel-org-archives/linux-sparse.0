Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1B101EE
	for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2024 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705767821; cv=none; b=W50hQauhrVCe3hDEBSWuP3FEsYsk0ymqgAbbDOkU5GZomSlZ4w7k86a9kXYkYxlH1OURzf7aLenWj8wbotYbQHjgn/1viRXSW/wJSXEpc+gzFURxaBhCVkCNCvNm+gSJ+7XsVFWSQW+DnQgRIDAZgb0qotjSpV/34qX7ZrWV1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705767821; c=relaxed/simple;
	bh=un+jSdCsP427qKmxZ7e/eWy3ITVq39p9zcgLDV4UcPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlywmMhrPg8hY9+aMWaU4C7Qyy/Rne4ay21Tujx2fFrYx1iAgpWpMhA/Jr+2NdpOKp7m6n6shvBaf1P16i5APzrKBJldnG5giF8bIO3DgeBb6pv7h2P4hMSexUolSvieOAkAqvaV8lQd1o09+01TAgENbPHAtQbHCZcbBIbzAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY2ykoYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY2ykoYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1525C433C7;
	Sat, 20 Jan 2024 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705767821;
	bh=un+jSdCsP427qKmxZ7e/eWy3ITVq39p9zcgLDV4UcPE=;
	h=From:To:Cc:Subject:Date:From;
	b=FY2ykoYTg/eoPYSI/1LDRAo9ipPHoAezkhmkvpiCAxpXkCgUtIwv1dSu0+9w8sHqz
	 CV1GsCeAxvv/wVKlDb11ObzCSdoISVSC40Xc5NLXcmYOBAJnxkQ6z0f1uGQfEhdOWz
	 QGdVK2YkS+FtYI3mbaPe8N9BMb1QKbvp275smd7NkFLRxn7/QaYSRrKosuMKmhEHbD
	 OP4m/xo5uOXpuzSZVBshhx3Iv7wC7Tw0JsRW0Q9QDePDmnUA9fCzTgh85KGbGdozwd
	 24NGBTY/5sCS3wIE0Y1mZgoZ61V0b/eyHF/Oen6cem/OsUGj3+H19D02kiEkevV5+9
	 XWa1mj0jhk9Xg==
From: lucvoo@kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <lucvoo@kernel.org>
Subject: [PATCH] llvm: allow arm64
Date: Sat, 20 Jan 2024 17:23:12 +0100
Message-ID: <20240120162312.92842-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luc Van Oostenryck <lucvoo@kernel.org>

This patch is somehow incomplete because the layout is not set
but it's not clear what exactly the layout is needed for and at
least it allows to run the testsuite on this architecture.

Signed-off-by: Luc Van Oostenryck <lucvoo@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 84b4527f244e..216abbd1f6c8 100644
--- a/Makefile
+++ b/Makefile
@@ -200,7 +200,7 @@ arch := $(shell uname -m)
 ifeq (${MULTIARCH_TRIPLET},x86_64-linux-gnux32)
 arch := x32
 endif
-ifneq ($(filter ${arch},i386 i486 i586 i686 x86_64 amd64),)
+ifneq ($(filter ${arch},i386 i486 i586 i686 x86_64 amd64 aarch64 arm64),)
 LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
 LLVM_VERSION_MAJOR:=$(firstword $(subst ., ,$(LLVM_VERSION)))
 ifeq ($(shell expr "$(LLVM_VERSION_MAJOR)" '>=' 3),1)
-- 
2.43.0

