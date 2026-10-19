Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432611;
	b=fMxdzq5ri06dvImM92P9zq6qwWHJ9G2w+VTumhzBSQkrkxHTGCvMCXbF6ZDmqNeR3oIM
	 9js5oYSLepICTFNDJTTGn/qs5RWB69GRo/uK5seUxQyp72WzzoW73FchtkxQnnQWuRPPf
	 2RTPmiACuRicZ1t+T4iyP4pH/UjjHqQiG98632iyHowl5nhuTvqnjOv2SRePCZKpX67JO
	 9ywqqOBkXiPyYzNiBrZTdR4NsI4r/KciUsodhz+LuVHJqKE17qhJmEEPqd4Yk5vPm378i
	 qeCtfubi1IEIbKCvzbnoqn/uxMF1FBw14w5H14FBzUHm11xfauXo08p8HVcwtaKwq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KMAK/rNUOVr2zqy0EVlOgOMipbYPebuodUM+eloBnWs=;
	b=rTOnWUuXyoLhrNMv/w0KzzXiKwbQiZCQ0ZbeNFCuULn5H4fLp14FYFumYMyzMm6Cr+Ds
	 9j0JeBxshDzASqLfknTup1/sshfcZVjBA8torYFJiN8wUfLMHaFT40IyGwEHQycqj9PQz
	 yeuN2S0qVMEwtPkgREZKoLtFMLXKmwPNR5rbWBj0bH8HKlMEfwO+QA4ix6yIiaS/1xFWp
	 53M9t5QigsPBjbMQ4BHCnRG88vOASQdItzForpGXRj9G0A+kZoR/ZDAl8OjGYsO7O5/LG
	 YrQwHDwQdQKoPGdSFO1yuBkkEt4O5KuD/vDJAIRFcrDitlXwxi4k3aoImB6eUQAy++A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=WnCX5s4B;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9945606A31D
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9945606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=WnCX5s4B
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsm2s2Pz1XM6J4;
	Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1792432601; x=1795024602; bh=KMAK/rNUOVr2zqy0EVlOgOMipbYPebuodUM
	+eloBnWs=; b=WnCX5s4BnvihShRgVOEfkium2QZjbWpe9IvXbRNq3dwx7Coz++e
	5DhkZFNhH6qZJlBx6GGlHSUcrOx+LTMPwHpof/Cj/RGDI5n5rGQ7w046BE0qfJ3K
	yk5ONNICpBKLJSwazZMu98HSgoZcAPpM5ZvtgF/zd6xs0zsD3s265y+5eauQi3hR
	ytnJTePRa99fj8XQWy/U/sEmQ8m2mpILyE/oVnBiUfb3mNiNKoJac893BCusez85
	eqJeoAnJrSG46VFjgQxP/NNlWuUecct7NCAOioWZcaKYecpLiOMb8eTCr+GU8RFD
	LVr48OEUbVGFDGDBJiL2sxiJMhBkzEQiCuQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S0PCJAyJDJa2; Mon, 19 Oct 2026 17:56:41 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsj5kGDz1XM4Tl;
	Mon, 19 Oct 2026 17:56:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/20] Sanitizer fixes, LLVM updates, and CI workflow
Date: Mon, 19 Oct 2026 10:56:13 -0700
Message-ID: <20261019175633.415493-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
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

Hi,

Please help with reviewing these sparse patches.

This patch series updates the Sparse maintainer and mirror documentation,
fixes undefined behavior and memory leaks reported by sanitizers, updates
the LLVM backend for recent LLVM releases, adds support for empty attribu=
te
argument lists, and introduces a GitHub Actions CI workflow:

- Patch 1 updates the maintainer history in Documentation/index.rst from
  the git changelog and points the GitHub mirror link to
  https://github.com/bvanassche/sparse.
- Patches 2-14 fix memory leaks, out-of-bounds array reads, null member
  accesses, inactive union member reads, zero-length VLAs, signed integer
  overflows, and out-of-range bit shifts across ptrlist, bitmask helpers,
  storage management, builtin declarations, c2xml, parsing, preprocessing=
,
  target size conversions, evaluation, linearization, constant folding, a=
nd
  IR simplification so Sparse runs cleanly under ASan, LSan, and UBSan.
- Patches 15-17 and 19 update sparsec and sparse-llvm for modern LLVM
  versions and LeakSanitizer cleanliness. sparsec emits object files
  directly via 'llc -filetype=3Dobj' instead of piping assembly to 'as', =
and
  sparse-llvm avoids deprecated LLVMConstGEP2() calls on LLVM 15+, uses a=
n
  explicit LLVMContextRef instead of the deprecated global context, and
  disposes allocated arrays, IR builders, and LLVM modules on exit.
- Patch 18 teaches the parser to accept empty attribute argument lists su=
ch
  as __attribute__((nonnull())), matching GCC and Clang and avoiding pars=
e
  errors on Linux kernel headers.
- Patch 20 adds a GitHub Actions workflow and CI scripts that build Spars=
e
  and run 'make check' in both regular mode and ASan + UBSan mode to catc=
h
  regressions, memory errors, and undefined behavior automatically.

If nobody objects I plan to push these changes to the kernel.org sparse g=
it
repository by the end of this week.

Thanks,

Bart.

Bart Van Assche (19):
  doc: Update maintainer and mirror information
  ptrlist: Guard against null list in ptrlist operations
  bits: Guard against out-of-bounds bit shifts in bitmask helpers
  storage: Free hash table entries when freeing storage
  builtin: Bound argument array iteration in declare_builtin()
  c2xml: Use an unsigned shift in examine_modifiers()
  parse: Avoid incrementing rank on invalid long real specifiers
  pre-process: Avoid zero-length VLAs for parameterless macros
  pre-process: Avoid reading token->string on non-string tokens
  target: Avoid signed overflow in bit and byte conversion helpers
  evaluate: Use bitmask helpers in evaluate_ptr_add()
  linearize: Use bits_mask() in linearize_bitfield_insert()
  expand: Avoid undefined shifts and signed overflow in constant folding
  simplify: Avoid undefined shifts and signed overflow in simplification
  sparsec: Emit object files directly with llc -filetype=3Dobj
  llvm: Stop calling LLVMConstGEP2() for string literals
  llvm: Free leaked allocations and LLVM objects
  llvm: Use explicit LLVMContextRef instead of global context
  ci: Add a GitHub Actions workflow and CI scripts

Dmitry Ilvokhin (1):
  parse: Accept an empty attribute argument list

 .github/workflows/build.yml          | 36 +++++++++++
 Documentation/index.rst              | 11 ++--
 bitmap.h                             |  2 +-
 bits.h                               | 12 ++--
 builtin.c                            |  2 +-
 builtin.h                            |  1 -
 c2xml.c                              |  2 +-
 ci/build.sh                          | 22 +++++++
 ci/install.sh                        | 24 +++++++
 ci/test.sh                           |  3 +
 evaluate.c                           |  6 +-
 expand.c                             | 52 ++++++---------
 linearize.c                          |  2 +-
 parse.c                              | 34 ++++++----
 pre-process.c                        | 10 +--
 ptrlist.c                            | 47 ++++++++++----
 ptrlist.h                            | 14 ++--
 simplify.c                           | 53 ++++++++-------
 sparse-llvm.c                        | 96 ++++++++++++++++++----------
 sparsec                              |  2 +-
 storage.c                            | 10 ++-
 target.h                             |  6 +-
 validation/attribute-nonnull-empty.c | 12 ++++
 23 files changed, 310 insertions(+), 149 deletions(-)
 create mode 100644 .github/workflows/build.yml
 create mode 100755 ci/build.sh
 create mode 100755 ci/install.sh
 create mode 100755 ci/test.sh
 create mode 100644 validation/attribute-nonnull-empty.c

