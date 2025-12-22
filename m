Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0710E3
	for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421568; cv=none; b=Zez/V8xFOoT6wWJqJ11P1+VbRmqIKe4m2XWyAtrjK65B54DI61w3hOE6lSvfXZtjWNjeixxScCKIBcHsRSwzoYgzN90ia0WKp3JPT/TVMsd3DMcmGVurTJOOAW2KfMIb98cGphu3LrsvhcWTvpP6Osh/dJSD5xU6FRCCSoOy5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421568; c=relaxed/simple;
	bh=qPaVm2Swz9eBeBXPyH25jUunj/jz+lj2/2qYdMSSYrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUWbtETdidDsNBCxztKbkCTOyqeR3JucfX8eW9HCc0M7k4KL5ccTBH9xg1GTNmGRAs6GuuWmQEOEG+ymCYyW0+MvDHabj0pLB49ZUAR7Jzx3TzbWAa9BkqD/kR3hB2Bfly19l5urDeEKnP+gMgNHrWs0MxYfz6CyI27SGjqInJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=gjzwjIrq; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="gjzwjIrq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=u4kKN2IkzM8iPJ318JG08IEsjDSP/Sj6qLoNlHEWi5o=; b=gjzwjIrqj3io/k
	8TCyXuwipWpRYuYiZJtAh4AtAb7pcYlRetO3M986Uq2r8EOf7SS+fNDX29Tqkym3U5ZPHZaPlOFoW
	w1svRDWQ6atHW0ggtCA4E8rjv6v1vFoX3F0DaxYu0/+jJwAudwKNYzC2p9/H5lBUtjaBpYMveE7OW
	zaH4tw8W0NpQnKg4D4jY2EYBCqzzo9GUUF3RF/deq+NEr4I97QdDVUV+5hwKog2hsROnoxtYuOReH
	EGEFrK5CrGs0ox0zTvRo7c9eAji+vd3KFQJ+QG8dXeZHifQsXELS0u2qK9plIcNQtxLWHabs67ZNj
	KURvfpZb1pVc0FbLjY9Q==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vXiKp-004DSo-EB; Mon, 22 Dec 2025 16:00:35 +0000
Received: from ben by rainbowdash with local (Exim 4.99)
	(envelope-from <ben@rainbowdash>)
	id 1vXiKp-00000000P2U-0gk4;
	Mon, 22 Dec 2025 16:00:35 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	sparse@chrisli.org
Cc: luc.vanoostenryck@gmail.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 0/4] add variadic format checking
Date: Mon, 22 Dec 2025 16:00:30 +0000
Message-Id: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Second version of this, I think mostly sorting the issues
identified in review.

This series (which was initially sent back in 2020) adds the
ability to deal with __attribute__((format) and checking the
arguments to formatted variadic functions.

I have been considering adding a -Wformat-linux to this as
the kernel now has a number of extra formatting options and
checking the type of these would be useful. An even nicer
extension would be some way of informing the compiler/sparse
of these at compile time (but would need to get agreement on
how to do this with the compilers too)

Ben Dooks (4):
  parse: initial parsing of __attribute__((format))
  add -Wformat
  evaluate: check variadic argument types against formatting info
  tests: add varargs printf format tests

 Makefile                               |   1 +
 builtin.c                              |   4 +-
 evaluate.c                             |  14 +-
 evaluate.h                             |  10 +-
 options.c                              |   2 +
 options.h                              |   1 +
 parse.c                                |  83 ++++-
 sparse.1                               |   8 +
 symbol.h                               |  10 +-
 validation/varargs-format-addrspace1.c |  36 ++
 validation/varargs-format-bad.c        |  18 +
 validation/varargs-format-checking.c   |  21 ++
 validation/varargs-format-position.c   |  32 ++
 validation/varargs-format-prefix.c     |  19 +
 validation/varargs-format-tests.c      |  55 +++
 validation/varargs-type-formattest.c   | 117 +++++++
 verify-format.c                        | 460 +++++++++++++++++++++++++
 verify-format.h                        |   6 +
 18 files changed, 887 insertions(+), 10 deletions(-)
 create mode 100644 validation/varargs-format-addrspace1.c
 create mode 100644 validation/varargs-format-bad.c
 create mode 100644 validation/varargs-format-checking.c
 create mode 100644 validation/varargs-format-position.c
 create mode 100644 validation/varargs-format-prefix.c
 create mode 100644 validation/varargs-format-tests.c
 create mode 100644 validation/varargs-type-formattest.c
 create mode 100644 verify-format.c
 create mode 100644 verify-format.h

-- 
2.37.2.352.g3c44437643

