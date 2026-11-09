Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256430;
	b=vJ3G1WPJnEtsf04/ttkM7Gfi+MHoEYU5wjdbBmEw/EEl6eZ0aWSvDlMjd+vJIlxfFvD1
	 I0uYXh/l9wBtUfaCpFfQ3Jl6GNdStizWTsFIpAGzZzHnQaRrUwmEvr7fuTBgjeZ+/Vgyw
	 7xqz1fASsBTQDF5WqZmPFD+uTQsC6TCz2rnXdTYd5sXaK9M/BqHutxCDaH7GhcjuqksKK
	 OXEWMIcvy1nlcXuBg5go8MvCAWB25o4Vh4ttn374nL0+84Ev66CSgqOy/wS6+ii2JxRcD
	 d9nEOf11PXAVAkV3GajEAr3zOPavLv+i9GkMyLwJHwWSFUc1mWPAp01nWbNwcVG408g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Ini2qkSITqJ8t/n3b52NZm/KmkXlqpcg9Gk5vE7IL1w=;
	b=svsrCTGI0stKP37X4jFDN5AnzIvBtwEXgjZ0QrEaKPegq6v96IQI182IarpEN3tEtQfG
	 XQYL+oPyNt/szIAV/kkTE6uTP6Eg/1qF4sBsfDYv/Q8NcCBs3VP8qCsaI49PUfShAJqi6
	 htXKfSU0CdytPkr3ys3OOtLjcAVRd5WC1vSmpSeNC49KfR3QKWof7DXmXY2fPlMs4nX8A
	 cBNJJHFTL81JAtkmhorsPn/ik6qQMzwYvZed/lY4UGb8qqGLgbjurrjMrweHSp2bGAiN0
	 52iJVjkyc0xXRbr51nEhGsrr1FXwkz0FKhtRfrQNmAXZ05l0O7pi5rhA0+/nt7FMivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CMcdEKnR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E80606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CMcdEKnR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMC5sjSz1XMG49;
	Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256420; x=1796848421; bh=Ini2q
	kSITqJ8t/n3b52NZm/KmkXlqpcg9Gk5vE7IL1w=; b=CMcdEKnRL+KIRIuMBHPbH
	o3loc+28WlsSok4D9MjJVk2incmydml3BpEggUnXFuf0GAK20CZ8MLfOk0li72Dq
	AHGs97k2R/uvMV28y8DAuC9qT5IMhDcDXaU0dfkar/b43fYqgYRlEGL/QduNiFWk
	7Vq0WO4xlJFrBd+HCR2OMgl3EQZxcHCjYzm1oOSl3GUnZHjG7Eg5ToRSGarkCMDL
	oM5Nf8M5H7zVY36dWJ91FwlhjfcuIT0ZvdWHDCGN9A8QT0fs9Lunjh4IDZsJY3yU
	bP7Z2i+eEgaD437DvCVjdWPnkDpVTxwvYeEbAMdaoJ/KFkfQEpv91PmRecCdEiKK
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o8zAQQY-BsrU; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM83l6nz1XMfrm;
	Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 73/73] ci: Add Linux kernel GitHub Actions workflow and build script
Date: Mon,  9 Nov 2026 12:32:59 -0800
Message-ID: <20261109203259.362845-74-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a GitHub Actions workflow and helper script to build the Linux
kernel with sparse under AddressSanitizer and UndefinedBehaviorSanitizer
so regressions not covered by the validation suite are caught on a large
real-world C codebase:
- .github/workflows/build-linux-kernel-with-sparse.yml: Run on push,
  pull_request, daily schedule, and workflow_dispatch with read-only
  repository contents permissions.
- ci/build-linux-kernel-with-sparse.sh: Clean and build sparse in asan
  mode, clone ../linux-kernel or upstream torvalds/linux.git, neutralize
  non-core __CHECKER__ guards, and run a defconfig C=3D1 kernel check wit=
h
  detect_invalid_pointer_pairs=3D2 and halt_on_error=3D1.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .../build-linux-kernel-with-sparse.yml        | 28 +++++++++++++++++++
 ci/build-linux-kernel-with-sparse.sh          | 23 +++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 .github/workflows/build-linux-kernel-with-sparse.yml
 create mode 100755 ci/build-linux-kernel-with-sparse.sh

diff --git a/.github/workflows/build-linux-kernel-with-sparse.yml b/.gith=
ub/workflows/build-linux-kernel-with-sparse.yml
new file mode 100644
index 000000000000..a7566c4d8082
--- /dev/null
+++ b/.github/workflows/build-linux-kernel-with-sparse.yml
@@ -0,0 +1,28 @@
+# See also https://docs.github.com/en/actions/learn-github-actions/workf=
low-syntax-for-github-actions
+
+name: Build Linux kernel with sparse
+
+on:
+  push:
+  pull_request:
+  schedule:
+    - cron: '0 0 * * *'
+  workflow_dispatch:
+
+permissions:
+  contents: read
+
+jobs:
+  build:
+    runs-on: ubuntu-latest
+
+    steps:
+    - uses: actions/checkout@main
+
+    - name: install
+      run: sudo ci/install.sh
+
+    - name: build Linux kernel with sparse
+      run: |
+        sudo rm -rf /usr/share/dotnet /usr/local/lib/android /opt/ghc
+        ci/build-linux-kernel-with-sparse.sh
diff --git a/ci/build-linux-kernel-with-sparse.sh b/ci/build-linux-kernel=
-with-sparse.sh
new file mode 100755
index 000000000000..7e3505634d95
--- /dev/null
+++ b/ci/build-linux-kernel-with-sparse.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+set -euo pipefail
+
+make clean
+export MODE=3Dasan
+ci/build.sh
+
+rm -rf linux-kernel
+if [ -e ../linux-kernel ]; then
+    git clone ../linux-kernel linux-kernel
+else
+    git clone --depth=3D3 https://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git linux-kernel
+fi
+cd linux-kernel
+# Make most __CHECKER__ checks ineffective.
+{ git grep -lw __CHECKER__ || [ $? -eq 1 ]; } |
+    { grep -vE '^arch/|^include/linux/compiler|^include/uapi/linux/types=
.h|^include/linux/bug.h' || [ $? -eq 1 ]; } |
+    xargs -r -d '\n' sed -i 's/__CHECKER__/___CHECKER___/g'
+make defconfig
+export ASAN_OPTIONS=3Ddetect_invalid_pointer_pairs=3D2
+export UBSAN_OPTIONS=3Dhalt_on_error=3D1
+make -sj"$(nproc)" C=3D1 CHECK=3D"${PWD}/../sparse"
