Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794B1FBF62;
	Tue, 12 Nov 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420312; cv=none; b=SGGhJsfBgXPY48LxQhe2xv7xZxY45IFSqLfNG244jMdTxwpvi02KTct1uOufc3bSEmo9Ye302Y4sLcawnBdkOMc1mrtt86nBc48IJeV/GUQ5b9TGRGn7joM4sagh2INKOcgM98yD4rRQaXohOD9S0heTT//uFyPH6P1RST9YGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420312; c=relaxed/simple;
	bh=E+yhVoHUHrTpPileTWne1ORFEvQ8LJtTJNjzT3bPXXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+aL+dUiHmYZXk2YxP0y4U2YG4IZelBWXft5BJTMgAFaNCp3D0YPKJIDBFsGkunhcoA1Jgs4G4vx0qnKpbflCOIn+btSjD9kRC/kB+Q+fdjnJRTFwDp4eWLdcc+x9lhSLo0rvwE8Ss6HYINyhA8tL3qsO63N/3f8NWeQ23/6s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7242f559a9fso2857012b3a.1;
        Tue, 12 Nov 2024 06:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420310; x=1732025110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0iNeks1Xj+YevyLTEj6OBBzVntidHMn90B9+6RuYRs=;
        b=mhcuZcBvk7zTSJX5fb+av9c0CMZcx78fkq/E/C8r7thedxSC4KiO8ELl0wpP+MB79o
         yXxdztOhpe9qbaDs5TTnwfH+D+/9ZAtYRlhFcqBGy64NfL7AXXuNS2o+gJqa8ZHI7lMo
         rNx2JYun9OGQy6mB9jfnbKZcZTQi2BefWNz4+DIaPQb+LZyUKVRpdy27ry1Sj2tuTws0
         hJlySxZVCIpxlfK9ZywflwbjxiaiCHeGVrvy6qn9ioy+GaJYqfRFz3d3pDMwH2Nu4hsb
         TszaXJePVbD98GTWYvdX6HbvK8sDjIRQzXrwvLMBpmnG5T10T6VMRyZYqawPMFtMLTJr
         2lIA==
X-Forwarded-Encrypted: i=1; AJvYcCUuPjIwA7jItng6uvirQeHBqdW6JEfOLO8cWblcB1kH9WmG8xPKskAHk74KikJ5eQKeyE5g98Ja0ehVgKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPR1Ruz0bxW/Bavq/sGM8zcFewxJl4shxw0t/1QszyrDh0scO
	PqGHwpJQDSaersP8bZUiY/C8UJYhVyn2m5clZdP3lfYvRU/2DTyV
X-Google-Smtp-Source: AGHT+IGkWb6iO4CGt8QCeeIcGW6dDLF/A6x1hKkDJIKvjDH+k5ImbLiEqGHdTyBB0OMeN3Obr58WMQ==
X-Received: by 2002:a05:6a20:8421:b0:1d9:c6e8:60fc with SMTP id adf61e73a8af0-1dc228931b2mr25103396637.6.1731420310186;
        Tue, 12 Nov 2024 06:05:10 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f644a23sm10480007a12.53.2024.11.12.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:05:09 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 1/2] compiler.h: add _static_assert()
Date: Tue, 12 Nov 2024 22:59:23 +0900
Message-ID: <20241112140454.518823-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
References: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=E+yhVoHUHrTpPileTWne1ORFEvQ8LJtTJNjzT3bPXXE=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGCd0X2o8us1M5wBUVUxZ1QNHGZ3vbhBXuStnOBg/jO l5zfbjfUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCIF2owMS92mdHp2hCiwrCx/ wvk6wtn/0DHOvL2/DsXucb7xaeXxUwz/vRwU7s7bspV55ooA/ahO5/J10eIddj8ff16S+vXiLol THAA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

__builtin_constant_p() is known for not always being able to produce
constant expression [1] which led to the introduction of
__is_constexpr() [2]. Because of its dependency on
__builtin_constant_p(), statically_true() suffers from the same
issues.

For example:

  void foo(int a)
  {
  	 /* fail on GCC */
  	BUILD_BUG_ON_ZERO(statically_true(a));

  	 /* fail on both clang and GCC */
  	static char arr[statically_true(a) ? 1 : 2];
  }

For the same reasons why __is_constexpr() was created to remediate
__builtin_constant_p() edge cases, __is_constexpr() can be used to
resolve statically_true()'s limitations.

Note that, somehow, GCC is not always able to fold this:

  __is_constexpr(x) && (x)

It is OK in BUILD_BUG_ON_ZERO() but not in array declarations or in
static_assert():

  void bar(int a)
  {
  	/* success */
  	BUILD_BUG_ON_ZERO(__is_constexpr(a) && (a));

  	/* fail on GCC */
  	static char arr[__is_constexpr(a) && (a) ? 1 : 2];

  	/* fail on GCC */
  	static_assert(__is_constexpr(a) && (a));
  }

Encapsulating the expression in a __builtin_choose_expr() switch
resolves all these failed examples.

Declare a new _statically_true() macro which, by making use of the
__builtin_choose_expr() and __is_constexpr() combo, always produces a
constant expression.

It should be noted that statically_true() still produces better
folding:

  statically_true(!(var * 8 % 8))

always evaluates to true even if var is unknown, whereas

  _statically_true(!(var * 8 % 8))

fails to fold the expression and returns false.

For this reason, usage of _statically_true() should be the exception.
Reflect in the documentation that _statically_true() is less powerful
and that statically_true() is the overall preferred solution.

[1] __builtin_constant_p cannot resolve to const when optimizing
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

[2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Bonuses:

  - above examples (and a bit more) in godbolt:

      https://godbolt.org/z/GYeEK5d7s

  - that proof, in godbolt, that statically_true() is bettera at
    constant folding than _statically_true()

      https://godbolt.org/z/vK6KK4hMG
---
 include/linux/compiler.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..c76db8b50202 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -308,6 +308,20 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define statically_true(x) (__builtin_constant_p(x) && (x))
 
+/*
+ * Similar to statically_true() but produces a constant expression
+ *
+ * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
+ * which require their input to be a constant expression and for which
+ * statically_true() would otherwise fail.
+ *
+ * This is a tradeoff: _statically_true() is less efficient at
+ * constant folding and will fail to optimize any expressions in which
+ * at least one of the subcomponents is not constant. For the general
+ * case, statically_true() is better.
+ */
+#define _statically_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.45.2

