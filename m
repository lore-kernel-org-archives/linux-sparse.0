Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAF200CBE
	for <linux-sparse@vger.kernel.org>; Wed, 13 Nov 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519027; cv=none; b=iuYCPKRynhDmsokviuatfPQ6NGItBxLKZ+ayL3fmnUkpUyXPuiByQllULPpn/nmSmPd9Dyy0s0cCmqQAzPOGxR7Io1tzCjaW0BpAse/hLAF4UzFWzJGwGycoYYcAeQzwKv6QJfoYiLSCP6iecKNqYnnMXOGcYlC5GuVgCTvkh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519027; c=relaxed/simple;
	bh=dRzCa1uDVyS26Wtq5rMMcIZMJgLz9zwTHznyKMLaxEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHDzjVNJkBSpzeaOSsOHmJqiNARtcRIiirhdnXBaj+2B8bK+yRb/WsHTqAFMB16vsSx+ZMFLZNrbUAEzymRh4WCmhd0E3bsHtWh56ERZl6LyIhcLS4o2GRbhHyfQjCDV46cO7ykNU/0p9JqJ5rjqPib2h0c7ucDOO38GYikryqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ih6by5Rg; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ih6by5Rg"
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHBhtnfvcYmvZBHC3tEx9V; Wed, 13 Nov 2024 18:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731519018;
	bh=O/zWUDrlJrt9OWtHAoVstJ185WaYNX2xPZnV1yv2Sm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ih6by5RgWAHBuiu9HMFHhqDQtNUiyRrUcZx1UQD06jNN39f3Y88bTE9sZ2IOQehak
	 vmcywdVEOlzci6A+vvPDqb5BpurflRppsfOk7dJCW6Nfx0PoFITcE42CzwsjfMbsYE
	 69iW/R+a331opn7AcLv/soa6eyBE6m28mTiVIr806bu1+s131YSmB79ASeIa7lslaB
	 Py3eVkQzUMiAeezOs61IZm+5YSaMIt5QkxjfOrP7xJSBJdLRaK4TXpPoDUVcuF/4TN
	 7P/YvT3h6vuvIOTXFPMcNVV5YNyqF25IQ5+1tOCdndAKvwHV7CpvDCrbGwvXk885tw
	 qXoRkLJSbO4qw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:30:18 +0100
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
Subject: [PATCH v4 1/2] compiler.h: add const_true()
Date: Thu, 14 Nov 2024 02:18:32 +0900
Message-ID: <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=dRzCa1uDVyS26Wtq5rMMcIZMJgLz9zwTHznyKMLaxEA=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkmjziuMfQ4sd0zWfq1KNNQ+te/oCPcD9TNfROtLsdtP L0jdoJ6RykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkkiTIyHItbG71G6q7VVpe1 AtHXt00wnlOk89BhSeut7fwfL8m/YmVk2Giw/e1mSe6c/2ums2Qz7YiJe5+mt0/78JyHdY8vTdU Q4QYA
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

For the same reasons why __is_constexpr() was created to cover
__builtin_constant_p() edge cases, __is_constexpr() can be used to
resolve statically_true() limitations.

Note that, somehow, GCC is not always able to fold this:

  __is_constexpr(x) && (x)

It is OK in BUILD_BUG_ON_ZERO() but not in array declarations nor in
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
resolves all these failed tests.

Define a new const_true() macro which, by making use of the
__builtin_choose_expr() and __is_constexpr(x) combo, always produces a
constant expression.

It should be noted that statically_true() is the only one able to fold
tautologic expressions in which at least one on the operands is not a
constant expression. For example:

  statically_true(true || var)
  statically_true(var == var)
  statically_true(var * 0 + 1)
  statically_true(!(var * 8 % 4))

always evaluates to true, whereas all of these would be false under
const_true() if var is not a constant expression [3].

For this reason, usage of const_true() be should the exception.
Reflect in the documentation that const_true() is less powerful and
that statically_true() is the overall preferred solution.

[1] __builtin_constant_p cannot resolve to const when optimizing
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

[2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04

[3] https://godbolt.org/z/c61PMxqbK

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Above examples, and a bit more:

      https://godbolt.org/z/11xnxfx3P
---
 include/linux/compiler.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4d4e23b6e3e7..f9d660b63765 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -308,6 +308,28 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define statically_true(x) (__builtin_constant_p(x) && (x))
 
+/*
+ * Similar to statically_true() but produces a constant expression
+ *
+ * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
+ * which require their input to be a constant expression and for which
+ * statically_true() would otherwise fail.
+ *
+ * This is a trade-off: const_true() requires all its operands to be
+ * compile time constants. Else, it would always returns false even on
+ * the most trivial cases like:
+ *
+ *   true || non_const_var
+ *
+ * On the opposite, statically_true() is able to fold more complex
+ * tautologies and will return true on expressions such as:
+ *
+ *   !(non_const_var * 8 % 4)
+ *
+ * For the general case, statically_true() is better.
+ */
+#define const_true(x) __builtin_choose_expr(__is_constexpr(x), x, false)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
-- 
2.45.2

