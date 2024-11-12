Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB91FCC55;
	Tue, 12 Nov 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420315; cv=none; b=EiVisdFXJPwYjEZJOZVjdt4OHb8xifGz3rA4qUvr9sDUrIULu9suIu+CbGGMke7fLnlyJx0yL/TDoYnhyhWrSCgNvC3A/JSGHP7b70mLJNJfWzahKi5wy4cC5yEg9V6or2E4iCRxK52fUrTFUIJUEZvvXkMboU94uL6Y+v+3lLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420315; c=relaxed/simple;
	bh=SrJFRuhlzoZ8GAgh2rIJFuamp5YX3FbowBkwkQ/Ewdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/bigGDoVNVNrUXeGjS/3XW9KIpGSmET3fagzyzyVMbUaYzKyKhp6wYvT+/uKogsJgTvXhfHYshDBjwMbYROElizApnbvKGyxkMgY7Sq0xFZEWZOM5e6071TQvRm2xBZMaddIQeIXQJetk4Xaqcf2lVLeRBAQhaZVyXpMipgAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb47387ceso58682055ad.1;
        Tue, 12 Nov 2024 06:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420313; x=1732025113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLgkTjb8Qax6qcLVJZ4OagY9T3nwD0WZDNygw1a2Krs=;
        b=XuxqLi8zSVn2mvN9ETYpig1fxvxYu/xa50WQaiZgMk4KpYW+Z/OXYpHYuyvIFP2WKH
         uvd+MSamKr9JaMAXzNWrlctOxDpXO5/CkrGKrf8kzIYik371oY1U1xCqpONOUZFUdtox
         uAC6YzhGRkXYosKFL6fd8xG+Y3JoTVUGWpwVeIaxXo/4aIcEUz091b8+VjvZFmazpoj9
         Ov8HRg6Zeb3hvezSuup9kpUD3UhjrN7Ih8q7omyXIJx2pjATmP7Wj96hZFOJ68QJyr8N
         oZZQsim9u4TpxUbFKOvDrDfsAmAm6f3f5NTz3ZFkTzeaDbNfGpiQVQmZAZJvsMqFxpJm
         3SfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9DzG18godwmIU3LxXEpUFChcn+CBoNB8dV9UL9vUIiy3j9ewpBnrHciVCUtPM8sFoczHFIX5iThEYhKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5izl7vEJ/yki71Bwy1ZwDEqyPUlwhfbSs71sgjlhtHHousI5c
	6LSlFPj4cbd/uHqnp9pWXWu2/LDExPB65o4OejIwqD8xrkLxR4PA
X-Google-Smtp-Source: AGHT+IHAyO2QTUUO0HaKBXoybzM/XHVUDbmdQqcbH3AkbpQT70i1dhQgvuaRFWMkaVeJcpDf3iHTeQ==
X-Received: by 2002:a17:902:e752:b0:20c:8907:908 with SMTP id d9443c01a7336-2118359c216mr209080545ad.44.1731420312602;
        Tue, 12 Nov 2024 06:05:12 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644a23sm10480007a12.53.2024.11.12.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:05:12 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 2/2] linux/bits.h: simplify GENMASK_INPUT_CHECK()
Date: Tue, 12 Nov 2024 22:59:24 +0900
Message-ID: <20241112140454.518823-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
References: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=SrJFRuhlzoZ8GAgh2rIJFuamp5YX3FbowBkwkQ/Ewdc=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGCd13Oq9q39+g/TFD9ZLI4uA77k9nnX63eeHV91fvm Z35tfiKXUcpC4MYF4OsmCLLsnJOboWOQu+wQ38tYeawMoEMYeDiFICJGFky/DNYN931SmLzZYO8 7ftfyi801y0NXpJU/euYTJgLV/yki9MZ/vDO3ztR2/dlyOeiZYcbd3+Oq/p06Gn11mPKR7WmLmT ZKcMAAA==
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

