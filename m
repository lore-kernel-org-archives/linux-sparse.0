Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA289218946
	for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438552; cv=none; b=ite2w9OZdnnJAtsmkShmpw6e2c5IueRmGGWlnQXKPbFKf4woSvpc9S/pbNFhxAKbX0MlKVOliN//+g2DgpAntnLJXA0X/zywiOoZ4glJqLK5jV1mXa/JVc7zQxth1l9dutm/oA/D87c/+pyti9y68pzAs1jUyA9Trkj5Xn4xwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438552; c=relaxed/simple;
	bh=1ytyDmqmYGEfJHwfaXioLVwFYj+zkAhZNDBlxyKs8Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RppY/AVfRcC95wSFQtH7OIAy6cve8dyE6dmJ6KpbR4YQQUdoMu84kAMIvvCQ4btLD4tAagdj3+LVCI7k4e602Qzk4iWNFOQRCdsEjEVZuKh5V2sOid36UE6b3BSgkEOT3m+HCLE3jkv8/Icbbr1aqMz0swTQAbMiyAWIPcQXzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=TinuTRjl; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="TinuTRjl"
Received: from localhost.localdomain ([106.146.16.70])
	by smtp.orange.fr with ESMTPA
	id AwFntjwiq18HRAwG9t29qp; Tue, 12 Nov 2024 20:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731438550;
	bh=0NHpSD6qsurxbYxMcXGV0ZZS/bVySspTWKfjYRHZuDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TinuTRjlMaUiCOOU+hZbqTOjC9r46Zs0iNGlHeQ0iPhUMzkaFmzJECSReUcoWBQ7D
	 rN7WKUqk9KTJJqysH5xzLVW6Gdv2LTnvUmX2fIyLdMb0kTcwYGUAbVz3bSex7WD1gY
	 +Faf8J7j74+2J/sTMRcB/PGML2dNuziF/UhVNWrA2LvKMjgTRAqZskRNuDu0/HOOon
	 0zfewxJhvvZZuch9zCk9y1ddSGohbAtkrr8Sm/UN7487fqE80v+kz/x9EStv9SGnjj
	 kJeeCeDMK0utEKEzRJaqi7maWuZY3FJKAfBg1XJtBDtURACOrbiwXEmX0ari39WyDZ
	 W62l8GarnqDoQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 20:09:10 +0100
X-ME-IP: 106.146.16.70
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v3 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Date: Wed, 13 Nov 2024 04:08:40 +0900
Message-ID: <20241112190840.601378-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=1ytyDmqmYGEfJHwfaXioLVwFYj+zkAhZNDBlxyKs8Dw=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGy3cca1jFf27D1c3L7ldtbf9yo3qefAXz1RWHUmL/l 975mjTVqqOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBElP4z/DO62VISH1IZ9dnq +a0kxlkX3JZ+dlvieEyuJ5+J7ZBO9X6G/2V561Q/vVj16sYC1Tyxig7pwBTLll26euuXRRW+VNr 5gwkA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

In GENMASK_INPUT_CHECK(),

  __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)

is the exact expansion of:

  _statically_true((l) > (h))

Apply _statically_true() to simplify GENMASK_INPUT_CHECK().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This change passes the unit tests from CONFIG_BITS_TEST, including the
extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].

[1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
Link: https://git.kernel.org/torvalds/c/6d511020e13d

** Changelog **

v2 -> v3:

   - split the single patch into a series of two patches.

   - add greater explanation of why _statically_true() is needed in
     addition of the existing statically_true(). Explain the pros and
     cons of both.

   - use __builtin_choose_expr() in _statically_true(). The
     _statically_true() of the v2 works perfectly fine when used in
     conjunction with BUILD_BUG_ON_ZERO() but fails if used in arrays
     or in static_assert()

   - update the patch description accordingly

Link: https://lore.kernel.org/all/20241111164743.339117-2-mailhol.vincent@wanadoo.fr/

v1 -> v2:

   - introduce _statically_true(), taking inspiration from
     statically_true() as introduced in commit 22f546873149 ("minmax:
     improve macro expansion and type checking").

Link: https://lore.kernel.org/all/20240609073513.256179-1-mailhol.vincent@wanadoo.fr/
---
 include/linux/bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 60044b608817..01713e1eda56 100644
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
+#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(_statically_true((l) > (h)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.45.2

