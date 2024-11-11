Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3414AD3F;
	Mon, 11 Nov 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343676; cv=none; b=bGMm8ge0g3W6UjCgd8ad7GprhGUGNsXhpnAMevmSlkudK2mwlFlJKlzM6oF+9TmKCXPRuEx4316olxCWOR0r8HlFEabA1uPm3VhNxdZOQhgk3t9bQmkoJpVSv9i3O2uEY/7u4OJ+iJMOUtEHUX4+lRJc6y8T/zmuwr12KcSA1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343676; c=relaxed/simple;
	bh=cv7HOX0Be8oHN7NlH//fc5XDhKL3U1WcsBw8HaIGpAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQm3NId4XXmxj4F4PQs2OUD3aL7drNyxPb4OczKjUUx85/NXsMnHlBYg0ajyYsbj6U00Yf3Pkp9NYA0BLuT02fCOeigJ6HtOm8wI9QtL8L8EdAQZqhiC7pdYSF37ARhkQqO6QBRFGa+0ZCZvmfXt13DNOHCPz+5bhvhmmCwT/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e681bc315so3351885b3a.0;
        Mon, 11 Nov 2024 08:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343674; x=1731948474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVmNpVa6d/vTSwVDSMcQM5C6SueKqprysTTJDf+O7Ww=;
        b=MG9iN78W9Gl29k/H2cWMD8jaZMANy7m0FVWb48jKZXKcxcYjHoXiWbIgkVsoVWp30r
         Y0XEXxpUbp9Z4BFYplKXBNld4T5c9fo5J5O4ngw0jY/tbH8ZKCI+JwVmvHhVaF59nG0w
         Anffk5hCLrFOU06BZUH1CDDahRvFonppQcA34pORj6zsXnzkUypVRYlvw1bh5YM/9y6T
         Ar+vP3AJ6dIbYb0Q3kFySRpTJluZB16G5f8UnxQk0txn+EnmyQ3iZdq/Ryfo81mh1Kq3
         Bs+O8WWvXBPw/9BphYhvWZ4JWNoj7tmA7KWnECFk91EqRErBpwBWctTSL4nEfS4ni0BC
         0Z+w==
X-Forwarded-Encrypted: i=1; AJvYcCWK/w2Ibyi9/7SwdJ4t3Rb8A9l/Vh7VrnHbWUvSw0ID4B48z7HnVxKjByy4ZMsJhX2cEWRqbyA6BBk3do4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMbxS+5VPQGu2utj4IRmGNC75NX8ml/O3KlUiCjLnYMSSx7uZ
	OQr5rZwQU2cr020IYDevijVFYM+sLG2ViCgC11WutDrVV9tXanOEo1nP2g==
X-Google-Smtp-Source: AGHT+IGSM7pZgBQnjHeMc2NFU1cL0j9i+gxsihDAEjJ3LFHOucYoiCJyTai75Q2+UnECBNXfPwgS5A==
X-Received: by 2002:a05:6a00:21c4:b0:71e:7f08:492c with SMTP id d2e1a72fcca58-72413f4c526mr20021547b3a.1.1731343673645;
        Mon, 11 Nov 2024 08:47:53 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a5ea27sm9232913b3a.177.2024.11.11.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:47:53 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] linux/bits: simplify GENMASK_INPUT_CHECK()
Date: Tue, 12 Nov 2024 01:43:30 +0900
Message-ID: <20241111164743.339117-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=cv7HOX0Be8oHN7NlH//fc5XDhKL3U1WcsBw8HaIGpAs=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOlGpvot4dKidyLWMF5kWtCXdrI8WdSAKeuFncmbk7+Pc zutZ13fUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCK7fBn+GS3w26X36fefI3Yt uZ9WqmilBX9lKr+48MTt7XIvojI/v2ZkWHf8/rmtiYLyml/9zp64m1g67SzD8RNHnzvNOp/dtkQ okh8A
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Because of the shortcut logic of the && operator, below expression:

  __builtin_choose_expr(condition, boolean_expression, false)

can be simplified as:

  condition && boolean_expression

Applied to GENMASK_INPUT_CHECK(),

  __builtin_choose_expr(__is_constexpr((l) > (h)), (l) > (h), 0)

can be replaced by:

  __is_constexpr((l) > (h)) && (l) > (h)

Finally, above expression is nearly the same as the expansion of
statically_true((l) > (h)), except from the use of __is_constexpr()
instead of __builtin_constant_p().

Introduce _statically_true() which is similar to statically_true()
but with __is_constexpr(). Apply _statically_true() to simplify
GENMASK_INPUT_CHECK().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This change passes the unit tests from CONFIG_BITS_TEST, including the
extra negative tests provided under #ifdef TEST_GENMASK_FAILURES [1].

[1] commit 6d511020e13d ("lib/test_bits.c: add tests of GENMASK")
Link: https://git.kernel.org/torvalds/c/6d511020e13d


** Changelog **

v1 -> v2:

   - introduce _statically_true(), taking inspiration from
     statically_true() as introduced in commit 22f546873149 ("minmax:
     improve macro expansion and type checking")

Link: https://lore.kernel.org/all/20240609073513.256179-1-mailhol.vincent@wanadoo.fr/
---
 include/linux/bits.h     | 5 ++---
 include/linux/compiler.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..fee66166eca2 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -307,6 +307,7 @@ static inline void *offset_to_ptr(const int *off)
  * values to determine that the condition is statically true.
  */
 #define statically_true(x) (__builtin_constant_p(x) && (x))
+#define _statically_true(x) (__is_constexpr(x) && (x))
 
 /*
  * This is needed in functions which generate the stack canary, see
-- 
2.45.2

