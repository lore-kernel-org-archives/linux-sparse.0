From: "Marko Kreen" <markokr@gmail.com>
Subject: confusing shift warning
Date: Fri, 25 Apr 2008 10:53:08 +0300
Message-ID: <e51f66da0804250053x2ec991dbu9a5a54fdcbea2a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:12250 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554AbYDYHxL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Apr 2008 03:53:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3039427mue.1
        for <linux-sparse@vger.kernel.org>; Fri, 25 Apr 2008 00:53:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Platform: x64_64 linux, uint64_t -> unsigned long
Sparse: today's git (6dcc36a)

Code:
--------------------------------------------
#include <stdint.h>

static void fn1(uint32_t val) { }

static void fn2(uint64_t val)
{
        fn1(val >> 32); // warning
}

static void fn3(unsigned int val) { }

static void fn4(unsigned long long val)
{
        fn3(val >> 32); // no warning
}
------------------------------

$ cgcc -c test.c
test.c:7:10: warning: shift too big (32) for type unsigned long

-------------------------------

The confusion raises from the fact that "unsigned long" _does_
support 32-bit shift, and anyway I'm using "uint64_t", which
I expect sparse to understand.

Guess - somewhere is hardwired that "long" == "32-bit"?

For reference:
$ cgcc -v -c test.c
sparse -v -c test.c -Dx86_64=1 -D__x86_64=1 -D__x86_64__=1
-D__CHAR_BIT__=8 -D__SCHAR_MAX__=127 -D__SHRT_MAX__=32767
-D__INT_MAX__=2147483647 -D__LONG_MAX__=9223372036854775807L
-D__LONG_LONG_MAX__=9223372036854775807LL -D__FLT_RADIX__=2
-D__FINITE_MATH_ONLY__=0 -D__DECIMAL_DIG__=33 -D__FLT_MANT_DIG__=24
-D__FLT_DIG__=6 -D__FLT_MIN_EXP__='(-125)' -D__FLT_MAX_EXP__=128
-D__FLT_MIN_10_EXP__='(-37)' -D__FLT_MAX_10_EXP__=38
-D__FLT_HAS_INFINITY__=1 -D__FLT_HAS_QUIET_NAN__=1
-D__FLT_DENORM_MIN__=1.40129846e-45F -D__FLT_EPSILON__=1.19209290e-7F
-D__FLT_MAX__=3.40282347e+38F -D__FLT_MIN__=1.17549435e-38F
-D__DBL_MANT_DIG__=53 -D__DBL_DIG__=15 -D__DBL_MIN_EXP__='(-1021)'
-D__DBL_MAX_EXP__=1024 -D__DBL_MIN_10_EXP__='(-307)'
-D__DBL_MAX_10_EXP__=308 -D__DBL_HAS_INFINITY__=1
-D__DBL_HAS_QUIET_NAN__=1 -D__DBL_DENORM_MIN__=4.9406564584124654e-324
-D__DBL_EPSILON__=2.2204460492503131e-16
-D__DBL_MAX__=1.7976931348623157e+308
-D__DBL_MIN__=2.2250738585072014e-308 -D__LDBL_MANT_DIG__=113
-D__LDBL_DIG__=33 -D__LDBL_MIN_EXP__='(-16381)'
-D__LDBL_MAX_EXP__=16384 -D__LDBL_MIN_10_EXP__='(-4931)'
-D__LDBL_MAX_10_EXP__=4932 -D__LDBL_HAS_INFINITY__=1
-D__LDBL_HAS_QUIET_NAN__=1
-D__LDBL_DENORM_MIN__=6.47517511943802511092443895822764655e-4966L
-D__LDBL_EPSILON__=1.92592994438723585305597794258492732e-34L
-D__LDBL_MAX__=1.18973149535723176508575932662800702e+4932L
-D__LDBL_MIN__=3.36210314311209350626267781732175260e-4932L
-U__SIZE_TYPE__ -D__SIZE_TYPE__=long\ unsigned\ int -Dunix=1
-D__unix=1 -D__unix__=1 -D__linux__=1 -D__linux=1 -Dlinux=linux
test.c:7:10: warning: shift too big (32) for type unsigned long


-- 
marko
