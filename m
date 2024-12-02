Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939421DB54C;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160904; cv=none; b=hA2CwraA2X5n/ze2yL2DuYTZwp8dv/sFoM5M5JKtPXt77mpvEXgkMoLITp7KF25EZpieThN/2LEnuBFDbxCyUq1SuSCfr8udld8TQr4MQYO6TwCoGA6B56FMQFkj3i0/MH+eHt2CjpvzO2mjdtv1gVVwIfo6zM9DFiuStuDJ9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160904; c=relaxed/simple;
	bh=d4JkfBIFjtnH3QVmKyHAXV1Y+cJkoB706DolhEJtz9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbR8ADWgZ5G8JzGDSiaDV20po2HFfL9V8OUEGM5xmPChhwZuiBTuDN+qTAVDd4RhyE7dDqdfphg3MndmST1NYv8JU6IeBkVeo2tk1VdJk+K8725UFZTOVzXDblr6EkrSTkPIRfVjV2GLVMpnQ8iERS2/MjujD2BsJjd9/a3UOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKBHMJsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKBHMJsH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CE44C4CEE0;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733160904;
	bh=d4JkfBIFjtnH3QVmKyHAXV1Y+cJkoB706DolhEJtz9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IKBHMJsHqq1hMtszvFOcfe9UEP/UCGLNKk9ANnIcCBKQJxvDxJt38mPS8tAgR5c6t
	 j5RlM4BNUTDfxDfI3Avtg0nX8yBTmlggQ5jrzzTBlPG91LszQP7ro4DvKTHMsIFx03
	 Ax8eQJYEbtpeAxORywU3rX4HP+TuVI/B+I0aVoNVWIPai14lbzwm47hWur1xDIshjw
	 +pk1MzpiSmz0v305U/OGH5TFpUNcCVbn7jPy70aIyrijNwRQAXx8tmMsWl5bYKeSLc
	 HHa0DpnGMURhpv8L6OAhVUs2I0ho4wfjaUlxpY9IPbtnDv+aCGGSr+wGWsqEqAq43Y
	 kFSTBtw2Xu9wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDCD7833E;
	Mon,  2 Dec 2024 17:35:04 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Tue, 03 Dec 2024 02:33:25 +0900
Subject: [PATCH 03/10] compiler.h: add is_const_true() and is_const_false()
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-is_constexpr-refactor-v1-3-4e4cbaecc216@wanadoo.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=vXXScdJ5PminDGoxDgA6Iag0c2X2hzS5qLrxjoqdg1k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOm+74+abz5c0vD2uK1kR42Xpca9XMcb2cKG/u3MBSvKH
 /Ku00juKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMBG/KIY/HLZ2z5iFOme/c1oW
 fOXLsXk2BbHp55dO/BLheFbvzrrtzYwMF/986Qm84Gxx5Kl200c5i3rbi3snbcsKbZlrqLn/5is
 dBgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

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

Define a new is_const_true() and is_const_false() pair of macros
which, by making use of __is_const_zero(), always produces a constant
expression.

Note that is_const_false() can not be directly defined as an alias to
__is_const_zero(). Otherwise, it could yield some false positives on
huge numbers because of a lost of precision when doing the (long) cast
in __is_const_zero(). Example:

  is_const_false((u128)ULONG_MAX << BITS_PER_LONG)

Furthermore, using the ! operator like this:

  #define is_const_true(x) __is_const_zero(!(x))
  #define is_const_false(x) __is_const_zero(!!(x))

would yield a -Wint-in-bool-context compiler warning if the argument
is not a boolean. Use the == and != operators instead.

It should be noted that statically_true/false() are the only ones
capable of folding tautologic expressions in which at least one on the
operands is not a constant expression. For example:

  statically_true(true || var)
  statically_true(var == var)
  statically_false(var * 0)
  statically_false(var * 8 % 4)

always evaluate to true, whereas all of these would be false under
is_const_true/false() if var is not a constant expression [3].

For this reason, usage of const_true/false() should be the exception.
Reflect in the documentation that const_true() is less powerful and
that statically_true() is the overall preferred solution.

[1] __builtin_constant_p cannot resolve to const when optimizing
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

[2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04

[3] https://godbolt.org/z/E4r7EaxW9

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/compiler.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 30ce06df4153cfdc0fad9bc7bffab9097f8b0450..165aa5b9bc484376087a130a1ac1f3edb50c983d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,6 +357,29 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define is_const(x) __is_const_zero(0 * (x))
 
+/*
+ * Similar to statically_true() but produces a constant expression
+ *
+ * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
+ * which require their input to be a constant expression and for which
+ * statically_true() would otherwise fail.
+ *
+ * This is a trade-off: is_const_true() requires all its operands to
+ * be compile time constants. Else, it would always returns false even
+ * on the most trivial cases like:
+ *
+ *   true || non_const_expr
+ *
+ * On the opposite, statically_true() is able to fold more complex
+ * tautologies and will return true on expressions such as:
+ *
+ *   !(non_const_expr * 8 % 4)
+ *
+ * For the general case, statically_true() is better.
+ */
+#define is_const_true(x) __is_const_zero((x) == 0)
+#define is_const_false(x) __is_const_zero((x) != 0)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.

-- 
2.45.2


