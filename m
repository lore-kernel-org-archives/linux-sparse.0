From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Thu, 10 Jul 2008 18:51:00 +0100
Message-ID: <20080710175100.GF28946@ZenIV.linux.org.uk>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp> <20080709.005953.26097194.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36862 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614AbYGJRvD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Jul 2008 13:51:03 -0400
Content-Disposition: inline
In-Reply-To: <20080709.005953.26097194.anemo@mba.ocn.ne.jp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-sparse@vger.kernel.org, linux-mips@linux-mips.org

On Wed, Jul 09, 2008 at 12:59:53AM +0900, Atsushi Nemoto wrote:
explicit (and __STDC__ is redundant): -D__linux__ -Dlinux -D__STDC__
-Dunix -D__unix__ -Wbitwise

Not used anywhere in the tree:
-D__DBL_MIN_EXP__='(-1021)' -D__HQ_FBIT__='15' -D__SFRACT_IBIT__='0'
-D__FLT_MIN__='1.17549435e-38F' -D__UFRACT_MAX__='0XFFFFP-16UR'
-D__DEC64_DEN__='0.000000000000001E-383DD' -D__DQ_FBIT__='63'
-D__ULFRACT_FBIT__='32' -D__SACCUM_EPSILON__='0x1P-7HK'
-D__CHAR_BIT__='8' -D__USQ_IBIT__='0' -D__ACCUM_FBIT__='15'

Maybe, let me check...  Nope, not used.
> -DR3000='1'

Not used anywhere:
> -D__USFRACT_FBIT__='8'
> -D__ULLFRACT_MAX__='0XFFFFFFFFFFFFFFFFP-64ULLR'
> -D__WCHAR_MAX__='2147483647' -D__LACCUM_IBIT__='32'
> -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4='1'
> -D__DBL_DENORM_MIN__='4.9406564584124654e-324'
> -D__FLT_EVAL_METHOD__='0'

Explicitly passed: -D__unix__='1'

Not used:
> -D__LLACCUM_MAX__='0X7FFFFFFFFFFFFFFFP-31LLK' -D__FRACT_FBIT__='15'

Used:
-D_MIPS_ISA='_MIPS_ISA_MIPS32'

Not used:
> -D__UACCUM_FBIT__='16'
> -D__LANGUAGE_C='1' -D__DBL_MIN_10_EXP__='(-307)'
> -D__FINITE_MATH_ONLY__='0' -D_MIPS_TUNE='"mips32r2"'
> -D__LFRACT_IBIT__='0' -D__LFRACT_MAX__='0X7FFFFFFFP-31LR'
> -D__DEC64_MAX_EXP__='384' -D_ABIO32='1' -D__SA_FBIT__='15'
> -D__SHRT_MAX__='32767' -D__LDBL_MAX__='1.7976931348623157e+308L'
> -D__FRACT_MAX__='0X7FFFP-15R' -D__UFRACT_FBIT__='16'
> -D__UFRACT_MIN__='0.0UR' -D__LANGUAGE_C__='1'

Not used, might be worth defining in sparse:
-D__UINTMAX_TYPE__='long
> long unsigned int'

Not used:
 -D__LLFRACT_EPSILON__='0x1P-63LLR'

Explicitly passed:
 -D__linux='1'

Not used:
> -D__DEC32_EPSILON__='1E-6DF'

Passed by sparse:
-D__OPTIMIZE__='1'

Explicitly passed: -D__unix='1'

Not used:
> -D__ULFRACT_MAX__='0XFFFFFFFFP-32ULR' -D__TA_IBIT__='64'
> -D__LDBL_MAX_EXP__='1024'

Used: -D__MIPSEL__='1'

Explicitly passed: -D__linux__='1'

[...]

And AFAICS, the ratio gets even worse further into the list...
