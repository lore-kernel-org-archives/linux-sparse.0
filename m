Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C271218316
	for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438549; cv=none; b=avqE6ItG8a7so+WCRPg1sz/CZGGw3TlRxHynaTiJin5C33RhEQ/XZM/Z/fAZPmUa9db8ou4zmEibPxcZ9ZGfeMdGIrxyCZz3h33rw43ted/ivRHWDvX9ljTkaxGL7a+pE53mnh6B1va2sBJ7JH/OdintVVYSPT0CycW/bo8xZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438549; c=relaxed/simple;
	bh=17mtmBY8ZwUCeRi/t4IdmbeGrefNGpC3DWHRJW4wuu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYNN+qi4ko4anSFvGt21+vsBS4pQDjzPHA5X0XtmejF9oUdNOD0yBAilkYbMvWupPzLkjrdbhZxREdFlk6AxMXA5OWVWQxhmw99OVViEJr/9JA6ZnGofEcBuVes2UIsrOwz7iJPpwEp2jZUMFbYnJvFlZ6FwOTB4nFp6cz9tKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ghl1rS2I; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ghl1rS2I"
Received: from localhost.localdomain ([106.146.16.70])
	by smtp.orange.fr with ESMTPA
	id AwFntjwiq18HRAwG3t29pO; Tue, 12 Nov 2024 20:09:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731438545;
	bh=P1AYhd2AajanOBGPm1PpNJJsdw+dSp6kxGNZyhNotu4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ghl1rS2I4TfK8LdPDV4uADyga+Sw7s6CC8y7qXWUBuXCAjCX5eIMQAn1pWT66DxSe
	 QN3bidA+V8ryVF6RtnDm+kLl5Z3o6DOeZSk7QQaopKYtbaa+ssl2y2SwIANK8RaePC
	 VsKSZcJMMvt+b+GCvYibwlHxNSmXK9co6K37Ob9plKaoLWALQcNL1//MbK6mxxbzpS
	 NAc8U8vCjNZYDspouWdz1rfFGPV+mUz0CTr6407O+D7IOVRXEdg+d0Am0dqiuZCyBi
	 ZxFltZWm9mY+XalXCX56dBraFBxDoeewSMQ0r4kmg2igSb+QZRvARBZ+C+ple8+UWF
	 CMQQwKC3UMNeg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Nov 2024 20:09:05 +0100
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
Subject: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
Date: Wed, 13 Nov 2024 04:08:39 +0900
Message-ID: <20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=17mtmBY8ZwUCeRi/t4IdmbeGrefNGpC3DWHRJW4wuu4=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnGy3dEtyo9z0/7PSPAKvVr8gfLeYlBmb531jw89kJG8 nyQLP/PjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABM5uJyRYb7S5Jc/ao1lpAyd jt0Tz220dn0kv6Lb5ZQA5x7PU5HNFgz/q5RVHf5LlD1bZSb9ZHPzs03ss8zbPp09mfReoiHK/LY UNwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

__builtin_constant_p() is known for not always being able to produce
constant expression [1] which lead to the introduction of
__is_constexpr() [2]. Because of its dependency on
__builtin_constant_p(), statically_true() suffers from the same
issues.

For example:

  void foo(int a)
  {
  	 /* fail on GCC */
  	BUILD_BUG_ON_ZERO(statically_true(a));

  	 /* fail both clang and GCC */
  	static char arr[statically_true(a) ? 1 : 2];
  }

For the same reasons why __is_constexpr() was created to cover
__builtin_constant_p() edge cases, __is_constexpr() can be used to
resolve statically_true() limitations.

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
resolves all these failed test.

Declare a new _statically_true() macro which, by making use of the
__builtin_choose_expr() and __is_constexpr(x) combo, always produces a
constant expression.

It should be noted that statically_true() still produces better
folding:

  statically_true(!(var * 8 % 8))

always evaluates to true even if var is unknown, whereas

  _statically_true(!(var * 8 % 8))

fails to fold the expression and return false.

For this reason, usage of _statically_true() be should the exception.
Reflect in the documentation that _statically_true() is less powerful
and that statically_true() is the overall preferred solution.

[1] __builtin_constant_p cannot resolve to const when optimizing
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

[2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Bonuses:

  - above examples, and a bit more:

      https://godbolt.org/z/zzqM1ajPj

  - a proof that statically_true() does better constant folding than _statically_true()

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
+ * at least one of the subcomponent is not constant. For the general
+ * case, statically_true() is better.
+ */
+#define _statically_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.45.2

