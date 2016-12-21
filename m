From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: cgcc and -Dx86_64
Date: Wed, 21 Dec 2016 11:07:44 -0500
Message-ID: <13736b0d-b29a-0118-6846-f08bb3bb76f4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbcLUQHp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Dec 2016 11:07:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 811A9D77FE
        for <linux-sparse@vger.kernel.org>; Wed, 21 Dec 2016 16:07:45 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello linux-sparse,

I was trying to run sparse against the upstream kpatch project and ran
into problems with an include file that defined an "x86_64" variable:

% git clone https://github.com/dynup/kpatch
% cd kpatch/kpatch-build

% ~/sparse/cgcc -v -MMD -MP -I../kmod/patch -Iinsn -Wall -g -Werror -c
-o create-diff-object.o create-diff-object.c

sparse -v --debug -MMD -MP -I../kmod/patch -Iinsn -Wall -g -Werror -c -o
create-diff-object.o create-diff-object.c -Dx86_64=1 -D__x86_64=1
-D__x86_64__=1 -D__LP64__=1 -D__CHAR_BIT__=8 -D__SCHAR_MAX__=127
-D__SHRT_MAX__=32767 -D__INT_MAX__=2147483647
-D__LONG_MAX__=9223372036854775807L
-D__LONG_LONG_MAX__=9223372036854775807LL
-D__LONG_LONG_LONG_MAX__=170141183460469231731687303715884105727LLL
-D__FLT_RADIX__=2 -D__FINITE_MATH_ONLY__=0 -D__DECIMAL_DIG__=33
-D__FLT_MANT_DIG__=24 -D__FLT_DIG__=6 -D__FLT_MIN_EXP__='(-125)'
-D__FLT_MAX_EXP__=128 -D__FLT_MIN_10_EXP__='(-37)'
-D__FLT_MAX_10_EXP__=38 -D__FLT_HAS_INFINITY__=1
-D__FLT_HAS_QUIET_NAN__=1 -D__FLT_DENORM_MIN__=1.40129846e-45F
-D__FLT_EPSILON__=1.19209290e-7F -D__FLT_MAX__=3.40282347e+38F
-D__FLT_MIN__=1.17549435e-38F -D__DBL_MANT_DIG__=53 -D__DBL_DIG__=15
-D__DBL_MIN_EXP__='(-1021)' -D__DBL_MAX_EXP__=1024
-D__DBL_MIN_10_EXP__='(-307)' -D__DBL_MAX_10_EXP__=308
-D__DBL_HAS_INFINITY__=1 -D__DBL_HAS_QUIET_NAN__=1
-D__DBL_DENORM_MIN__=4.9406564584124654e-324
-D__DBL_EPSILON__=2.2204460492503131e-16
-D__DBL_MAX__=1.7976931348623157e+308
-D__DBL_MIN__=2.2250738585072014e-308 -D__LDBL_MANT_DIG__=113
-D__LDBL_DIG__=33 -D__LDBL_MIN_EXP__='(-16381)' -D__LDBL_MAX_EXP__=16384
-D__LDBL_MIN_10_EXP__='(-4931)' -D__LDBL_MAX_10_EXP__=4932
-D__LDBL_HAS_INFINITY__=1 -D__LDBL_HAS_QUIET_NAN__=1
-D__LDBL_DENORM_MIN__=6.47517511943802511092443895822764655e-4966L
-D__LDBL_EPSILON__=1.92592994438723585305597794258492732e-34L
-D__LDBL_MAX__=1.18973149535723176508575932662800702e+4932L
-D__LDBL_MIN__=3.36210314311209350626267781732175260e-4932L
-U__SIZE_TYPE__ -D__SIZE_TYPE__=long\ unsigned\ int
-D__SIZEOF_POINTER__=8 -Dunix=1 -D__unix=1 -D__unix__=1 -D__linux__=1
-D__linux=1 -Dlinux=linux -gcc-base-dir /usr/lib/gcc/x86_64-linux-gnu/5/
-multiarch-dir x86_64-linux-gnu

insn/asm/insn.h:65:23: error: expected ; at end of declaration
insn/asm/insn.h:65:23: error: Expected } at end of
struct-union-enum-specifier
insn/asm/insn.h:65:23: error: got 1
insn/asm/insn.h:69:1: error: Expected ; at the end of type declaration
insn/asm/insn.h:69:1: error: got }
insn/asm/insn.h:99:65: error: Expected ) in function declarator
insn/asm/insn.h:99:65: error: got 1
create-diff-object.c:914:53: error: no member 'next_byte' in struct insn


I can avoid this by renaming the structure member to something like
"foo_x86_64".  I believe the problem stems from cgcc passing "-Dx86_64"
to gcc... sparse later gets confused as there is now a preprocessor
variable defined with the same name.

We could s/x86_64/something_else/g across the whole project to avoid
this glitch, but was wondering if there was a better way.  IMHO,
"x86_64" is a reasonable name that a developer might want to use... I
can't find any documentation that this is a (gcc) reserved keyword.

Advice appreciated... thanks!

-- Joe
