From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 00/13] improve constexpr handling
Date: Thu, 23 Jul 2015 00:54:25 +0200
Message-ID: <87y4i7kdlq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36877 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbbGVWy3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 18:54:29 -0400
Received: by wibud3 with SMTP id ud3so193618309wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 15:54:28 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id z9sm24198783wiv.9.2015.07.22.15.54.26
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 15:54:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=linux-constexpr-fixes.diff

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 59915ea..00eb776 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -736,7 +736,7 @@ void init_cpu_online(const struct cpumask *src);
  */
 #define to_cpumask(bitmap)						\
 	((struct cpumask *)(1 ? (bitmap)				\
-			    : (void *)sizeof(__check_is_bitmap(bitmap))))
+			    : (void *)0 + sizeof(__check_is_bitmap(bitmap))))
 
 static inline int __check_is_bitmap(const unsigned long *bitmap)
 {
diff --git a/include/linux/log2.h b/include/linux/log2.h
index fd7ff3d..384d6e5 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -82,80 +82,80 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  *
  * selects the appropriately-sized optimised version depending on sizeof(n)
  */
-#define ilog2(n)				\
-(						\
-	__builtin_constant_p(n) ? (		\
-		(n) < 1 ? ____ilog2_NaN() :	\
-		(n) & (1ULL << 63) ? 63 :	\
-		(n) & (1ULL << 62) ? 62 :	\
-		(n) & (1ULL << 61) ? 61 :	\
-		(n) & (1ULL << 60) ? 60 :	\
-		(n) & (1ULL << 59) ? 59 :	\
-		(n) & (1ULL << 58) ? 58 :	\
-		(n) & (1ULL << 57) ? 57 :	\
-		(n) & (1ULL << 56) ? 56 :	\
-		(n) & (1ULL << 55) ? 55 :	\
-		(n) & (1ULL << 54) ? 54 :	\
-		(n) & (1ULL << 53) ? 53 :	\
-		(n) & (1ULL << 52) ? 52 :	\
-		(n) & (1ULL << 51) ? 51 :	\
-		(n) & (1ULL << 50) ? 50 :	\
-		(n) & (1ULL << 49) ? 49 :	\
-		(n) & (1ULL << 48) ? 48 :	\
-		(n) & (1ULL << 47) ? 47 :	\
-		(n) & (1ULL << 46) ? 46 :	\
-		(n) & (1ULL << 45) ? 45 :	\
-		(n) & (1ULL << 44) ? 44 :	\
-		(n) & (1ULL << 43) ? 43 :	\
-		(n) & (1ULL << 42) ? 42 :	\
-		(n) & (1ULL << 41) ? 41 :	\
-		(n) & (1ULL << 40) ? 40 :	\
-		(n) & (1ULL << 39) ? 39 :	\
-		(n) & (1ULL << 38) ? 38 :	\
-		(n) & (1ULL << 37) ? 37 :	\
-		(n) & (1ULL << 36) ? 36 :	\
-		(n) & (1ULL << 35) ? 35 :	\
-		(n) & (1ULL << 34) ? 34 :	\
-		(n) & (1ULL << 33) ? 33 :	\
-		(n) & (1ULL << 32) ? 32 :	\
-		(n) & (1ULL << 31) ? 31 :	\
-		(n) & (1ULL << 30) ? 30 :	\
-		(n) & (1ULL << 29) ? 29 :	\
-		(n) & (1ULL << 28) ? 28 :	\
-		(n) & (1ULL << 27) ? 27 :	\
-		(n) & (1ULL << 26) ? 26 :	\
-		(n) & (1ULL << 25) ? 25 :	\
-		(n) & (1ULL << 24) ? 24 :	\
-		(n) & (1ULL << 23) ? 23 :	\
-		(n) & (1ULL << 22) ? 22 :	\
-		(n) & (1ULL << 21) ? 21 :	\
-		(n) & (1ULL << 20) ? 20 :	\
-		(n) & (1ULL << 19) ? 19 :	\
-		(n) & (1ULL << 18) ? 18 :	\
-		(n) & (1ULL << 17) ? 17 :	\
-		(n) & (1ULL << 16) ? 16 :	\
-		(n) & (1ULL << 15) ? 15 :	\
-		(n) & (1ULL << 14) ? 14 :	\
-		(n) & (1ULL << 13) ? 13 :	\
-		(n) & (1ULL << 12) ? 12 :	\
-		(n) & (1ULL << 11) ? 11 :	\
-		(n) & (1ULL << 10) ? 10 :	\
-		(n) & (1ULL <<  9) ?  9 :	\
-		(n) & (1ULL <<  8) ?  8 :	\
-		(n) & (1ULL <<  7) ?  7 :	\
-		(n) & (1ULL <<  6) ?  6 :	\
-		(n) & (1ULL <<  5) ?  5 :	\
-		(n) & (1ULL <<  4) ?  4 :	\
-		(n) & (1ULL <<  3) ?  3 :	\
-		(n) & (1ULL <<  2) ?  2 :	\
-		(n) & (1ULL <<  1) ?  1 :	\
-		(n) & (1ULL <<  0) ?  0 :	\
-		____ilog2_NaN()			\
-				   ) :		\
-	(sizeof(n) <= 4) ?			\
-	__ilog2_u32(n) :			\
-	__ilog2_u64(n)				\
- )
+#define ilog2(n)							\
+	__builtin_choose_expr(						\
+		__builtin_constant_p(n),				\
+		(							\
+			(n) & (1ULL << 63) ? 63 :			\
+			(n) & (1ULL << 62) ? 62 :			\
+			(n) & (1ULL << 61) ? 61 :			\
+			(n) & (1ULL << 60) ? 60 :			\
+			(n) & (1ULL << 59) ? 59 :			\
+			(n) & (1ULL << 58) ? 58 :			\
+			(n) & (1ULL << 57) ? 57 :			\
+			(n) & (1ULL << 56) ? 56 :			\
+			(n) & (1ULL << 55) ? 55 :			\
+			(n) & (1ULL << 54) ? 54 :			\
+			(n) & (1ULL << 53) ? 53 :			\
+			(n) & (1ULL << 52) ? 52 :			\
+			(n) & (1ULL << 51) ? 51 :			\
+			(n) & (1ULL << 50) ? 50 :			\
+			(n) & (1ULL << 49) ? 49 :			\
+			(n) & (1ULL << 48) ? 48 :			\
+			(n) & (1ULL << 47) ? 47 :			\
+			(n) & (1ULL << 46) ? 46 :			\
+			(n) & (1ULL << 45) ? 45 :			\
+			(n) & (1ULL << 44) ? 44 :			\
+			(n) & (1ULL << 43) ? 43 :			\
+			(n) & (1ULL << 42) ? 42 :			\
+			(n) & (1ULL << 41) ? 41 :			\
+			(n) & (1ULL << 40) ? 40 :			\
+			(n) & (1ULL << 39) ? 39 :			\
+			(n) & (1ULL << 38) ? 38 :			\
+			(n) & (1ULL << 37) ? 37 :			\
+			(n) & (1ULL << 36) ? 36 :			\
+			(n) & (1ULL << 35) ? 35 :			\
+			(n) & (1ULL << 34) ? 34 :			\
+			(n) & (1ULL << 33) ? 33 :			\
+			(n) & (1ULL << 32) ? 32 :			\
+			(n) & (1ULL << 31) ? 31 :			\
+			(n) & (1ULL << 30) ? 30 :			\
+			(n) & (1ULL << 29) ? 29 :			\
+			(n) & (1ULL << 28) ? 28 :			\
+			(n) & (1ULL << 27) ? 27 :			\
+			(n) & (1ULL << 26) ? 26 :			\
+			(n) & (1ULL << 25) ? 25 :			\
+			(n) & (1ULL << 24) ? 24 :			\
+			(n) & (1ULL << 23) ? 23 :			\
+			(n) & (1ULL << 22) ? 22 :			\
+			(n) & (1ULL << 21) ? 21 :			\
+			(n) & (1ULL << 20) ? 20 :			\
+			(n) & (1ULL << 19) ? 19 :			\
+			(n) & (1ULL << 18) ? 18 :			\
+			(n) & (1ULL << 17) ? 17 :			\
+			(n) & (1ULL << 16) ? 16 :			\
+			(n) & (1ULL << 15) ? 15 :			\
+			(n) & (1ULL << 14) ? 14 :			\
+			(n) & (1ULL << 13) ? 13 :			\
+			(n) & (1ULL << 12) ? 12 :			\
+			(n) & (1ULL << 11) ? 11 :			\
+			(n) & (1ULL << 10) ? 10 :			\
+			(n) & (1ULL <<  9) ?  9 :			\
+			(n) & (1ULL <<  8) ?  8 :			\
+			(n) & (1ULL <<  7) ?  7 :			\
+			(n) & (1ULL <<  6) ?  6 :			\
+			(n) & (1ULL <<  5) ?  5 :			\
+			(n) & (1ULL <<  4) ?  4 :			\
+			(n) & (1ULL <<  3) ?  3 :			\
+			(n) & (1ULL <<  2) ?  2 :			\
+			(n) & (1ULL <<  1) ?  1 :			\
+			(n) == 1 ? 0 :					\
+			__builtin_warning(1, "log2 gives NaN") ? 0 : 0	\
+			),						\
+		(sizeof(n) <= 4) ?					\
+		__ilog2_u32(n) :					\
+		__ilog2_u64(n)						\
+		)
 
 /**
  * roundup_pow_of_two - round the given value up to nearest power of two
@@ -165,14 +165,14 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  * - the result is undefined when n == 0
  * - this can be used to initialise global variables from constant data
  */
-#define roundup_pow_of_two(n)			\
-(						\
-	__builtin_constant_p(n) ? (		\
-		(n == 1) ? 1 :			\
-		(1UL << (ilog2((n) - 1) + 1))	\
-				   ) :		\
-	__roundup_pow_of_two(n)			\
- )
+#define roundup_pow_of_two(n)				\
+	__builtin_choose_expr(				\
+		__builtin_constant_p(n),		\
+		(					\
+			(n == 1) ? 1 :			\
+			(1UL << (ilog2((n) - 1) + 1))	\
+			),				\
+		__roundup_pow_of_two(n))
 
 /**
  * rounddown_pow_of_two - round the given value down to nearest power of two
@@ -182,12 +182,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
  * - the result is undefined when n == 0
  * - this can be used to initialise global variables from constant data
  */
-#define rounddown_pow_of_two(n)			\
-(						\
-	__builtin_constant_p(n) ? (		\
-		(1UL << ilog2(n))) :		\
-	__rounddown_pow_of_two(n)		\
- )
+#define rounddown_pow_of_two(n)		\
+	(1UL << ilog2(n))
 
 /**
  * order_base_2 - calculate the (rounded up) base 2 order of the argument
diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 0e011eb..d44773e 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -102,28 +102,28 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
  * __swab16 - return a byteswapped 16-bit value
  * @x: value to byteswap
  */
-#define __swab16(x)				\
-	(__builtin_constant_p((__u16)(x)) ?	\
-	___constant_swab16(x) :			\
-	__fswab16(x))
+#define __swab16(x)							\
+	__builtin_choose_expr(__builtin_constant_p((__u16)(x)),	\
+			___constant_swab16(x),				\
+			__fswab16(x))
 
 /**
  * __swab32 - return a byteswapped 32-bit value
  * @x: value to byteswap
  */
-#define __swab32(x)				\
-	(__builtin_constant_p((__u32)(x)) ?	\
-	___constant_swab32(x) :			\
-	__fswab32(x))
+#define __swab32(x)							\
+	__builtin_choose_expr(__builtin_constant_p((__u32)(x)),	\
+			___constant_swab32(x),				\
+			__fswab32(x))
 
 /**
  * __swab64 - return a byteswapped 64-bit value
  * @x: value to byteswap
  */
-#define __swab64(x)				\
-	(__builtin_constant_p((__u64)(x)) ?	\
-	___constant_swab64(x) :			\
-	__fswab64(x))
+#define __swab64(x)							\
+	__builtin_choose_expr(__builtin_constant_p((__u64)(x)),	\
+			___constant_swab64(x),				\
+			__fswab64(x))
 
 /**
  * __swahw32 - return a word-swapped 32-bit value

--=-=-=
Content-Type: text/plain

This patch series is split into four parts:
- The first part deals with the refactorization of the current integer
  constant expression handling and introduces some support for
  recognizing arithmetic expressions. [1-5/13]
- The second part introduces support for recognizing address constants.
  [6/13]
- The third part introduces a check for the constness of static storage
  duration objects' initializers. [7/13]
- The last part stems from my tests with the kernel. It contains things
  I missed in the first [9-10/13] and second [8,12/13] parts and
  relaxes some of the constraints on constant expressions [11/13].
  For the last patch [13/13], please see below.

My initial intent was to rework the current integer constant expression
handling in order to allow for the recognition of constant subexpressions
built up by means of __builtin_choose_expr(). Hence the first part.

However, since I had to touch the whole constant expression handling
code anyways, I decided to experimentally extend it to support
arithmetic constant expressions and address constants as well. Hence
the second part.

Since the additional information on expressions obtained through the
first two parts is rather pointless without making any use of it, I
implemented part three, the checking of static storage duration
objects' initializers for constness.
This part is the reason why there is a 'RFC' tag in the subject.
It is up to you to decide whether letting sparse check for C99
conformity is a valuable thing to have or whether being stricter than
GCC is counter-productive/completely idiotic.

Although the patches of the fourth part, the fixup part, fit very well
into the first two categories, their associated testcases, if any,
depend on [7/13]. Thus, I dediced to keep the order as is.

If you decide that you do not want to have the third part, I will
resend a stripped version of the first one only, together with
[9-10/13].


Random notes:

- [1/13] is basically a renaming patch only. It introduces additional
  flags used in later patches. It should not alter any behaviour.

- I am not very confident about [13/13]. It could introduce some
  new issues as well as just fix symptoms, not the problem.
  Please double check when reviewing.

- This series introduces two new testsuite failers, namely
  validation/choose_expr.c and validation/builtin_bswap.c.
  These testcases really violate the constexpr constraints. However,
  for the moment, I left them as is.


Results from running sparse on the kernel:

For testing, I ran sparse without and with this series applied on an
allmodconfig kernel on x86_64.
Beforehand, I fixed commonly used macros, namely log2- and
swab-related ones and to_cpumask() to qualify as constexprs,
if possible. See the attached diff (and blame me for attaching diffs).
Especially log2() needs this fixing anyways since it is used all over
the place where only integer constant expressions are allowed (in array
designators).

sparse now finds 519 occurences of non-const initializers of static
storage duration objects, 474 of which are located in drivers/acpi
and stem from this subsystem's custom offsetof macro implemented by
means of taking pointer differences.

The remaining hits are distributed as follows
14 drivers/net/ethernet/sfc/
13 drivers/isdn/hardware/mISDN/
 8 drivers/usb/core/
 2 drivers/net/wireless/libertas_tf/
 1 drivers/infiniband/hw/qib/
 1 drivers/misc/genwqe/
 1 drivers/net/ethernet/qlogic/qlcnic/
 1 drivers/net/wireless/ath/ath6kl/
 1 drivers/scsi/snic/
 1 drivers/staging/comedi/drivers/
 1 drivers/tty/ipwireless/
 1 net/wireless/

OTOH, 40 errors due to non-integer constant expressions in array
designators formerly spit out by sparse have vanished. This is because
the attached diff on log2() relies on __builtin_warning() getting
recognized as an integer constant, i.e. on [10/13].



Nicolai Stange (13):
  expression: introduce additional expression constness tracking flags
  expression: examine constness of casts at evaluation only
  expression: examine constness of binops and alike at evaluation only
  expression: examine constness of preops at evaluation only
  expression: examine constness of conditionals at evaluation only
  expression, evaluate: add support for recognizing address constants
  evaluate: check static storage duration objects' intializers'
    constness
  expression: recognize references to labels as address constants
  expression: examine constness of __builtin_offsetof at evaluation only
  symbol: flag builtins constant_p, safe_p and warning as constexprs
  evaluate: relax some constant expression rules for pointer expressions
  expression, evaluate: support compound literals as address constants
  symbol: do not inherit storage modifiers from base types at
    examination

 evaluate.c                              | 191 +++++++++++++++++++++++++-------
 expand.c                                |   2 +-
 expression.c                            |  54 +++++----
 expression.h                            | 133 +++++++++++++++++++++-
 symbol.c                                |  12 +-
 validation/constexpr-binop.c            |  33 ++++++
 validation/constexpr-cast.c             |  25 +++++
 validation/constexpr-compound-literal.c |  18 +++
 validation/constexpr-conditional.c      |  34 ++++++
 validation/constexpr-init.c             | 109 ++++++++++++++++++
 validation/constexpr-offsetof.c         |  21 ++++
 validation/constexpr-preop.c            |  29 +++++
 12 files changed, 578 insertions(+), 83 deletions(-)
 create mode 100644 validation/constexpr-binop.c
 create mode 100644 validation/constexpr-cast.c
 create mode 100644 validation/constexpr-compound-literal.c
 create mode 100644 validation/constexpr-conditional.c
 create mode 100644 validation/constexpr-init.c
 create mode 100644 validation/constexpr-offsetof.c
 create mode 100644 validation/constexpr-preop.c

-- 
2.4.5

--=-=-=--
