Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432618;
	b=K+9XPoVlDV35mEhHnb62r4StJM4GlX6z+kMYQh13dd6dJRxhsgO7uCDM3BZX0IoYJRbL
	 nX0ShGZ5aVgyQFrYFOTonOggZs9QthLI8Xh9VfhfeBDOmk/o3NgrmmgSVgnANecJ9g0wN
	 FWEjvbcDPkxZs48mQE4kmx3JpR6UAd1owvd+Ev0F6YKSM3C0+AAzvPPHL2ufj1Gu8G1r6
	 IXpVVVSU4vuxuUe0D8IHNmbkwUqgBdbsXo9AgU8LyNDQm1LvxIKh/n6TzItf2qVCxZc6M
	 fnX34OhH+y+Y8SUj+zemy4x2Le7M7UTJ3jb4Ws66hz3Y7a93o0jf5g6DmBi5nGj/nVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=n1fMMsiTBt3tSZsaFi1jfXoK71mX1UFs06jxynojM7k=;
	b=IlQwbKGJJmS9FTobp5vRIn/sX9Nnz+AFBFV9n4BkAogielOTEsS1cqV4uepHw+DOhJVe
	 3hTAkqQcdfFxA4aL75VCQ7LK3MXdbOuYgsiF3iXK3Et8JrJ4QDsBfLrhizDeGktwnEMzS
	 iZ9DjNOqSs9DJWjuv9l8bAf8QaghGRbeYooz1aetMko/usomdzzjKiEUw9RhzCAsFKxQ3
	 BdOsNYHe/gDEz+xXdApF/w7QZlcD7pxKMWJcfeQKra+xsQnMBzOuiury+LgnDHpl+dnxi
	 1TpaZvpV54V2R9SCpF+k55ELe/YGvFXkOXJZSZSPqPi19baRDxASdz50nYCdOFQ/LrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=t3tYVv6u;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FBF606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90FBF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=t3tYVv6u
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jss2zqpz1XM30r;
	Mon, 19 Oct 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432607; x=1795024608; bh=n1fMM
	siTBt3tSZsaFi1jfXoK71mX1UFs06jxynojM7k=; b=t3tYVv6uEl6rGPwWVWdCY
	WX34Y7HsnJbZiR8wP/1n4C90rtm0/de/EG882DWm6rgiX69PVcFqZ04wOMfFdV6B
	aBOfg2gZ+IwQCVA39KtXw2IihiLH6bKup14cG9R/dG+36+W8i52uFSOUM3CDfWIj
	gdiJNscgV52wox5yOGK4XeqmixxFtvcplCfwOX8PSRNGGPl+FQNH+jWi1igZAXPo
	pXSP8SCXGfAjcvLWOM0gD2hdvfJPqA5UgyjWxwfcEW0TmAD9DWnHN0Tvc7GBddWM
	Jd0bJIo63Fk9UkY/O619a9T3v56ZjyzbQP/CFVT2SHgYFGs/+9pIjzqC43vdBzIb
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1EAyfqjz9CjK; Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsq0T0Zz1XM6Hv;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 20/20] ci: Add a GitHub Actions workflow and CI scripts
Date: Mon, 19 Oct 2026 10:56:33 -0700
Message-ID: <20261019175633.415493-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
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

Add a GitHub Actions workflow and supporting scripts to build and test
sparse automatically. Catch regressions in sparse and use
AddressSanitizer and UndefinedBehaviorSanitizer to detect memory errors
and undefined behavior.

- .github/workflows/build.yml: Build and test sparse on ubuntu-latest in
  regular and asan mode. Run on push and pull request events and allow
  manual runs via workflow_dispatch.
- ci/install.sh: Install the packages required to build and test sparse.
- ci/build.sh: Build sparse with parallel make. If MODE=3Dasan, pass ASan
  and UBSan compiler and linker flags. Fail for unknown modes.
- ci/test.sh: Run the sparse test suite via 'make check'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .github/workflows/build.yml | 36 ++++++++++++++++++++++++++++++++++++
 ci/build.sh                 | 22 ++++++++++++++++++++++
 ci/install.sh               | 24 ++++++++++++++++++++++++
 ci/test.sh                  |  3 +++
 4 files changed, 85 insertions(+)
 create mode 100644 .github/workflows/build.yml
 create mode 100755 ci/build.sh
 create mode 100755 ci/install.sh
 create mode 100755 ci/test.sh

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
new file mode 100644
index 000000000000..62d9512fdf9e
--- /dev/null
+++ b/.github/workflows/build.yml
@@ -0,0 +1,36 @@
+# See also https://docs.github.com/en/actions/learn-github-actions/workf=
low-syntax-for-github-actions
+
+name: Build
+
+on:
+  push:
+  pull_request:
+  workflow_dispatch:
+
+jobs:
+  build:
+    runs-on: ${{ matrix.os }}
+
+    strategy:
+      fail-fast: false
+      matrix:
+        include:
+          - os: ubuntu-latest
+            mode: regular
+          - os: ubuntu-latest
+            mode: asan
+
+    env:
+      MODE: ${{ matrix.mode }}
+
+    steps:
+    - uses: actions/checkout@main
+
+    - name: install
+      run: sudo bash -c "MODE=3D$MODE ci/install.sh"
+
+    - name: build
+      run: ci/build.sh
+
+    - name: test
+      run: ci/test.sh
diff --git a/ci/build.sh b/ci/build.sh
new file mode 100755
index 000000000000..a155671dbb8b
--- /dev/null
+++ b/ci/build.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+set -eu
+
+scriptdir=3D"$(dirname "$0")"
+
+echo "compiler path: $(type -p "${CC:-gcc}")"
+nproc=3D$(nproc)
+case "$MODE" in
+    asan)
+	ASAN_FLAGS=3D"-fsanitize=3Daddress,pointer-compare,pointer-subtract,und=
efined"
+	CFLAGS=3D"-O1 -g ${ASAN_FLAGS} -fno-omit-frame-pointer"
+	LDFLAGS=3D"${ASAN_FLAGS}"
+	make -s -j"${nproc}" CFLAGS=3D"${CFLAGS}" LDFLAGS=3D"${LDFLAGS}"
+	;;
+    regular)
+	make -s -j"${nproc}"
+	;;
+    *)
+	exit 1
+	;;
+esac
diff --git a/ci/install.sh b/ci/install.sh
new file mode 100755
index 000000000000..7024c3812fab
--- /dev/null
+++ b/ci/install.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+set -eu
+
+packages=3D(
+    bc
+    bison
+    build-essential
+    dwarves
+    flex
+    libelf-dev
+    libgtk-3-dev
+    libsqlite3-dev
+    libssl-dev
+    llvm-dev
+    make
+    pahole
+    perl
+    pkg-config
+)
+apt-get update
+for p in "${packages[@]}"; do
+    apt-get install -qq -o=3DDpkg::Use-Pty=3D0 -y "$p"
+done
diff --git a/ci/test.sh b/ci/test.sh
new file mode 100755
index 000000000000..a057cba051d0
--- /dev/null
+++ b/ci/test.sh
@@ -0,0 +1,3 @@
+#!/bin/bash
+
+make check
