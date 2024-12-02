Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F11DB548;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160904; cv=none; b=hOuU2ZDsn9e1oO79/kIPotAVAaFEXKiR9gZzUuDZteCb5qwtW+hbVhTNNXxH+pZvLE5lvFQ+x1Z9La7a4sbhAE45HoJ4StmaQGgkemcbzzRDDafcVMNXci3xLIIlEKht4t+ukuAqTXmz5eKxUVCzpOcGNiGg7kJYVlGk1aik8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160904; c=relaxed/simple;
	bh=xwTNFn3pAcjVSWQWx0fHAn53Pqy1YgPTXPD7CvZlCBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svXudUNAAoW5Mo6kZ3XttlnvfhzsfEBz/1iQ5ZnTfWzbnuP+gjPfhaJeG8wrtY/IGxpDeQSiiwEn0QxgjJIyZkTDe9x+NgnaC0c34TG8EpcIPs+AMPv5TmYi8Vyj+ULYaGCqdLWiew/mZF7OJ6UTQEEA/TheBj3G2/EMmLQ36rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ungmd37L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ungmd37L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 451ECC4CEE2;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160904;
	bh=xwTNFn3pAcjVSWQWx0fHAn53Pqy1YgPTXPD7CvZlCBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ungmd37L4dkWQvhcuFclEv+4CcvM6Wg2DepR4tJAgCJBakZJ4OmYWS9Csu9MKZr41
	 XOv24ODLjWwD+67sbFUifpRNCmPEQhS8JwS9csGxIlgYR/YLsHOkJVI+rsTOnZRPEy
	 yH2cFtTBr9uKzmixHN0oJOTceYmKMqTwlwwO5KPm5TZsGgwOtl4ORdHEwBnZoivBBH
	 bSGeNjS+e1SaQ5F6GGhF5sehAhHeG+tGesILeTagGwibgp+e6zEqRMEwmeSetfdcXn
	 lSorEV45P7zurGKv9mS3+xrhz3uFMSJ+2PzbCz77WDhjVgbfudPNRgeib2oB/A/4F2
	 ITeXGxWMkkBeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CFD7833C;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Tue, 03 Dec 2024 02:33:26 +0900
Subject: [PATCH 04/10] linux/bits.h: simplify GENMASK_INPUT_CHECK() by
 using is_const_true()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-is_constexpr-refactor-v1-4-4e4cbaecc216@wanadoo.fr>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
In-Reply-To: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 David Laight <David.Laight@aculab.com>, 
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Rikard Falkeborn <rikard.falkeborn@gmail.com>, 
 Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=7pxUmK/6W4pXlFZB1NGxttLkuRalLbmF/D69OP2jG1o=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOm+749GXp33N/vXlsdiTw9lODzSEugV7vlifP1CSKJpp
 EL7cw+XjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABNR2Mnw35utNVRP1Thc1XO/
 kFrZj4LtpwX/s53aHOaffebyus1pTgz/82/rzvn0wGB67rdoO1XPe0Viq2NqdiXV19t3Vhuemj6
 RGwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

In GENMASK_INPUT_CHECK(),

  __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)

is equivalent to:

  is_const_true((l) > (h))

Apply is_const_true() to simplify GENMASK_INPUT_CHECK().

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
index 60044b6088172b3f26aa3f17cdaede9786863dae..ef0119e6179e1ca95345a3d4d3327ba19633028e 100644
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
+#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(is_const_true((l) > (h)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,

-- 
2.45.2


