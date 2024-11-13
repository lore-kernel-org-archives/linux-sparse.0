Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5051200B84
	for <linux-sparse@vger.kernel.org>; Wed, 13 Nov 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519025; cv=none; b=r5HmTm+TdyXgkyGjoNupyXA08K/vsssftv4e3G8sWV6vNM+ba5Ye1mfjF+mT8vKUQS8Ksi6fA4NMlPU3HbVUuOjsPpzvPxZl+FiJub02XL526tHPZbEwze5nUqXqVux/nbCQXENSlP2zvWLIdn14hsfJRn9NFIsn5Jc1tanijHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519025; c=relaxed/simple;
	bh=nrZjwb8ESlnn4C2ZxVImi8EXVuHo0CSJaid/noqaCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhwHPjNUHGCptKVlQBVKFaLbwnZ7g+NsW6yOrCKQu6GVCR0M8whcE+oRKjFjT2AWMKNoWWMq5Z/VNHzgV486cDpZfoq2GJf6FGusqVNMBf60Nc5/wwAvOTXwWp7hTaVllu8oEXw93fL+f/iTA+di259S0kK/JzUjylmpFHz0ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RQSJskoS; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RQSJskoS"
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHBhtnfvcYmvZBHC6tExJW; Wed, 13 Nov 2024 18:30:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731519021;
	bh=9CRME5J/urcdMtjEP4gMVqmlBR0mekaJXIiTy7MX7B0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RQSJskoSQVPj0LUmZl+s12mThNzx+iapYWBMfymoxB7Z4RdgcS8Dt0aTq3Qe25CCT
	 tQk+WfmefdONvNoNE2omqYhsPEYya+NTAJRxNotHwgE5TstAt/p9BfS0XmHfgkNoUx
	 tPPH7NIDfMqLjwVcANmLuZiakAsr/lMGAAUvHwWULfx50MiHbzBuvD/gPo9MmuDNdA
	 PG73KnIXvgHSg2GhwVdccfNWvrmgNn+mbQf7Gcv2TqT5h3BzNlUsh9mArfQqk2GaUM
	 nDG9rjxLXO8VF/aVuRZ3Hrj+tq/B3WO1fGB6Mz2B3FTUZOMBZaDdtkJY7ENG05QLic
	 c239oZ3Y1ewPg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:30:21 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Date: Thu, 14 Nov 2024 02:18:33 +0900
Message-ID: <20241113172939.747686-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=nrZjwb8ESlnn4C2ZxVImi8EXVuHo0CSJaid/noqaCNU=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkmjziOxwTc5XsyS8nm3YE1ug8kN4k2c973mCqx62yws Sjv+XMPO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzk1k1Ghv8/p4SU5367sGzf vs/tDq0TWpsCAwOyCiVMFUJ+rFWeE8XIsH5vaU3MQ+3ZJ2dfed7XYt0xPYH72MaVfeIT7zW7h9/ x5AIA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

In GENMASK_INPUT_CHECK(),

  __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)

is the exact expansion of:

  const_true((l) > (h))

Apply const_true() to simplify GENMASK_INPUT_CHECK().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This change passes the unit tests from CONFIG_BITS_TEST, including the
extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].

[1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
Link: https://git.kernel.org/torvalds/c/6d511020e13d
---
 include/linux/bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 60044b608817..61a75d3f294b 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -20,9 +20,8 @@
  */
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
-#define GENMASK_INPUT_CHECK(h, l) \
-	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+#include <linux/compiler.h>
+#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.45.2

