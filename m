From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Wed, 09 Jul 2008 00:59:53 +0900 (JST)
Message-ID: <20080709.005953.26097194.anemo@mba.ocn.ne.jp>
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:56631 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbYGHP6M (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 Jul 2008 11:58:12 -0400
In-Reply-To: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-mips@linux-mips.org

On Wed, 09 Jul 2008 00:28:05 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
> sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> pre_buffer overflow.

Here is an example of sparse commandline:

sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise
-D__DBL_MIN_EXP__='(-1021)' -D__HQ_FBIT__='15' -D__SFRACT_IBIT__='0'
-D__FLT_MIN__='1.17549435e-38F' -D__UFRACT_MAX__='0XFFFFP-16UR'
-D__DEC64_DEN__='0.000000000000001E-383DD' -D__DQ_FBIT__='63'
-D__ULFRACT_FBIT__='32' -D__SACCUM_EPSILON__='0x1P-7HK'
-D__CHAR_BIT__='8' -D__USQ_IBIT__='0' -D__ACCUM_FBIT__='15'
-DR3000='1' -D__USFRACT_FBIT__='8'
-D__ULLFRACT_MAX__='0XFFFFFFFFFFFFFFFFP-64ULLR'
-D__WCHAR_MAX__='2147483647' -D__LACCUM_IBIT__='32'
-D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4='1'
-D__DBL_DENORM_MIN__='4.9406564584124654e-324'
-D__FLT_EVAL_METHOD__='0' -D__unix__='1'
-D__LLACCUM_MAX__='0X7FFFFFFFFFFFFFFFP-31LLK' -D__FRACT_FBIT__='15'
-D_MIPS_ISA='_MIPS_ISA_MIPS32' -D__UACCUM_FBIT__='16'
-D__LANGUAGE_C='1' -D__DBL_MIN_10_EXP__='(-307)'
-D__FINITE_MATH_ONLY__='0' -D_MIPS_TUNE='"mips32r2"'
-D__LFRACT_IBIT__='0' -D__LFRACT_MAX__='0X7FFFFFFFP-31LR'
-D__DEC64_MAX_EXP__='384' -D_ABIO32='1' -D__SA_FBIT__='15'
-D__SHRT_MAX__='32767' -D__LDBL_MAX__='1.7976931348623157e+308L'
-D__FRACT_MAX__='0X7FFFP-15R' -D__UFRACT_FBIT__='16'
-D__UFRACT_MIN__='0.0UR' -D__LANGUAGE_C__='1' -D__UINTMAX_TYPE__='long
long unsigned int' -D__LLFRACT_EPSILON__='0x1P-63LLR' -D__linux='1'
-D__DEC32_EPSILON__='1E-6DF' -D__OPTIMIZE__='1' -D__unix='1'
-D__ULFRACT_MAX__='0XFFFFFFFFP-32ULR' -D__TA_IBIT__='64'
-D__LDBL_MAX_EXP__='1024' -D__MIPSEL__='1' -D__linux__='1'
-D__ULLFRACT_MIN__='0.0ULLR' -D__SCHAR_MAX__='127' -D__DBL_DIG__='15'
-D__LLACCUM_MIN__='(-0X1P31LLK-0X1P31LLK)' -D__SQ_FBIT__='31'
-D__SIZEOF_POINTER__='4' -D__USACCUM_IBIT__='8'
-D__USER_LABEL_PREFIX__='' -D__STDC_HOSTED__='0'
-D__LDBL_HAS_INFINITY__='1' -D__LFRACT_MIN__='(-0.5LR-0.5LR)'
-D__mips_fpr='32' -D__HA_IBIT__='8' -D__TQ_IBIT__='0'
-D__FLT_EPSILON__='1.19209290e-7F' -D__mips__='1'
-D__USFRACT_IBIT__='0' -D__LDBL_MIN__='2.2250738585072014e-308L'
-D__FRACT_MIN__='(-0.5R-0.5R)' -D__DEC32_MAX__='9.999999E96DF'
-D__DA_IBIT__='32' -DMIPSEL='1' -D__UQQ_FBIT__='8'
-D__SIZEOF_LONG__='4' -D__UACCUM_MAX__='0XFFFFFFFFP-16UK'
-D__DECIMAL_DIG__='17' -D__LFRACT_EPSILON__='0x1P-31LR'
-D__ULFRACT_MIN__='0.0ULR' -D__gnu_linux__='1'
-D__LDBL_HAS_QUIET_NAN__='1' -D__ULACCUM_IBIT__='32'
-D__UACCUM_EPSILON__='0x1P-16UK'
-D__ULLACCUM_MAX__='0XFFFFFFFFFFFFFFFFP-32ULLK' -D__HQ_IBIT__='0'
-D__FLT_HAS_DENORM__='1' -D__SIZEOF_LONG_DOUBLE__='8' -D_R3000='1'
-D__DQ_IBIT__='0' -D__DBL_MAX__='1.7976931348623157e+308'
-D__ULFRACT_IBIT__='0' -D__DBL_HAS_INFINITY__='1'
-D__ACCUM_IBIT__='16' -D__DEC32_MIN_EXP__='(-95)'
-D__LACCUM_MAX__='0X7FFFFFFFFFFFFFFFP-31LK' -D__LDBL_HAS_DENORM__='1'
-D__DEC128_MAX__='9.999999999999999999999999999999999E6144DL'
-D__DEC32_MIN__='1E-95DF' -D__ACCUM_MAX__='0X7FFFFFFFP-15K'
-D__DBL_MAX_EXP__='1024' -D__USACCUM_EPSILON__='0x1P-8UHK'
-D__R3000__='1' -D__DEC128_EPSILON__='1E-33DL'
-D__SFRACT_MAX__='0X7FP-7HR' -D__FRACT_IBIT__='0'
-D__UACCUM_MIN__='0.0UK' -Dmips='1' -D__UACCUM_IBIT__='16'
-D__LONG_LONG_MAX__='9223372036854775807LL' -D__SIZEOF_SIZE_T__='4'
-D__ULACCUM_MAX__='0XFFFFFFFFFFFFFFFFP-32ULK' -D__SIZEOF_WINT_T__='4'
-D__SA_IBIT__='16' -D__ULLACCUM_MIN__='0.0ULLK'
-D__GXX_ABI_VERSION='1002' -D__UTA_FBIT__='64'
-D__FLT_MIN_EXP__='(-125)' -D__USFRACT_MAX__='0XFFP-8UHR'
-D__UFRACT_IBIT__='0' -D_MIPSEL='1'
-D__DBL_MIN__='2.2250738585072014e-308' -D_MIPS_ARCH='"mips32r2"'
-D__LACCUM_MIN__='(-0X1P31LK-0X1P31LK)' -D__ULLACCUM_FBIT__='32'
-D__ULLFRACT_EPSILON__='0x1P-64ULLR' -D__DEC128_MIN__='1E-6143DL'
-D__REGISTER_PREFIX__='' -D__DBL_HAS_DENORM__='1'
-D__ACCUM_MIN__='(-0X1P15K-0X1P15K)' -D__SQ_IBIT__='0'
-D__UHA_FBIT__='8' -D__SFRACT_MIN__='(-0.5HR-0.5HR)' -D__R3000='1'
-D__UTQ_FBIT__='128' -D__FLT_MANT_DIG__='24' -D__VERSION__='"4.3.1"'
-D__ULLFRACT_FBIT__='64' -D__FRACT_EPSILON__='0x1P-15R'
-D__ULACCUM_MIN__='0.0ULK' -D__UDA_FBIT__='32'
-D__LLACCUM_EPSILON__='0x1P-31LLK' -D_MIPS_TUNE_MIPS32R2='1'
-D__USFRACT_MIN__='0.0UHR' -D__UQQ_IBIT__='0'
-D__DEC64_EPSILON__='1E-15DD' -D__DEC128_MIN_EXP__='(-6143)'
-D__UHQ_FBIT__='16' -D__LLACCUM_FBIT__='31' -Dunix='1'
-D__SIZE_TYPE__='unsigned int' -D__UDQ_FBIT__='64'
-D__DEC32_DEN__='0.000001E-95DF' -D__ELF__='1' -D__mips_isa_rev='2'
-D__ULFRACT_EPSILON__='0x1P-32ULR' -D__LLFRACT_FBIT__='63'
-D__FLT_RADIX__='2' -D__LDBL_EPSILON__='2.2204460492503131e-16L'
-D__SACCUM_MAX__='0X7FFFP-7HK' -D__SIZEOF_PTRDIFF_T__='4'
-D__LACCUM_EPSILON__='0x1P-31LK' -D_MIPS_SZPTR='32'
-D__USACCUM_MAX__='0XFFFFP-8UHK' -D__SFRACT_EPSILON__='0x1P-7HR'
-D__FLT_HAS_QUIET_NAN__='1' -D__FLT_MAX_10_EXP__='38'
-D__LONG_MAX__='2147483647L' -D__FLT_HAS_INFINITY__='1'
-D__USA_FBIT__='16' -D__DEC64_MAX__='9.999999999999999E384DD'
-D__DEC64_MANT_DIG__='16' -D__SACCUM_FBIT__='7' -D_mips='1'
-D__SIZEOF_INT__='4' -D__DEC32_MAX_EXP__='96' -D__QQ_FBIT__='7'
-Dlinux='1'
-D__DEC128_DEN__='0.000000000000000000000000000000001E-6143DL'
-D__UTA_IBIT__='64' -D_MIPS_SZINT='32' -D__LDBL_MANT_DIG__='53'
-D__SFRACT_FBIT__='7' -D__SACCUM_MIN__='(-0X1P7HK-0X1P7HK)'
-D__DBL_HAS_QUIET_NAN__='1' -D__MIPSEL='1' -D__WCHAR_TYPE__='int'
-D__SIZEOF_FLOAT__='4' -D__USQ_FBIT__='32'
-D__DEC64_MIN_EXP__='(-383)' -D__ULLACCUM_IBIT__='32'
-D__FLT_DIG__='6' -D__INT_MAX__='2147483647' -D__LACCUM_FBIT__='31'
-D__USACCUM_MIN__='0.0UHK' -D__UHA_IBIT__='8' -D__FLT_MAX_EXP__='128'
-D__UTQ_IBIT__='0' -D_MIPS_SIM='_ABIO32' -D__DBL_MANT_DIG__='53'
-D__DEC64_MIN__='1E-383DD' -D__WINT_TYPE__='unsigned int'
-D__SIZEOF_SHORT__='2' -D__ULLFRACT_IBIT__='0'
-D__LDBL_MIN_EXP__='(-1021)' -D_MIPS_FPSET='16' -D__UDA_IBIT__='32'
-D__LFRACT_FBIT__='31' -D__LDBL_MAX_10_EXP__='308'
-D__DBL_EPSILON__='2.2204460492503131e-16' -D__SIZEOF_WCHAR_T__='4'
-D__LLFRACT_MAX__='0X7FFFFFFFFFFFFFFFP-63LLR' -D__TQ_FBIT__='127'
-D__ULLACCUM_EPSILON__='0x1P-32ULLK' -D__UHQ_IBIT__='0'
-D__LLACCUM_IBIT__='32' -D__DEC_EVAL_METHOD__='2' -D__TA_FBIT__='63'
-D_MIPS_ARCH_MIPS32R2='1' -D__mips_soft_float='1' -D__UDQ_IBIT__='0'
-D__ACCUM_EPSILON__='0x1P-15K'
-D__INTMAX_MAX__='9223372036854775807LL'
-D__FLT_DENORM_MIN__='1.40129846e-45F' -D__LLFRACT_IBIT__='0'
-DVMLINUX_LOAD_ADDRESS='0xffffffff80100000'
-D__FLT_MAX__='3.40282347e+38F' -DLANGUAGE_C='1'
-D__USACCUM_FBIT__='8' -D__SIZEOF_DOUBLE__='8'
-D__FLT_MIN_10_EXP__='(-37)' -D__UFRACT_EPSILON__='0x1P-16UR'
-D__INTMAX_TYPE__='long long int' -D_LANGUAGE_C='1'
-D__DEC128_MAX_EXP__='6144' -D__DEC32_MANT_DIG__='7' -D__HA_FBIT__='7'
-D__DBL_MAX_10_EXP__='308'
-D__LDBL_DENORM_MIN__='4.9406564584124654e-324L' -D__STDC__='1'
-D__PTRDIFF_TYPE__='int' -D__LLFRACT_MIN__='(-0.5LLR-0.5LLR)'
-D__mips='32' -D__DA_FBIT__='31' -D_MIPS_SZLONG='32'
-D__USA_IBIT__='16' -D__DEC128_MANT_DIG__='34'
-D__LDBL_MIN_10_EXP__='(-307)' -D__SIZEOF_LONG_LONG__='8'
-D__ULACCUM_EPSILON__='0x1P-32ULK' -D__SACCUM_IBIT__='8'
-D__LDBL_DIG__='15' -D__GNUC_GNU_INLINE__='1'
-D__USFRACT_EPSILON__='0x1P-8UHR' -D__ULACCUM_FBIT__='32'
-D__QQ_IBIT__='0' -nostdinc -isystem
/usr/lib/gcc/mipsel-linux/4.3.1/include -Wp,-MD,init/.main.o.d
-nostdinc -isystem /usr/lib/gcc/mipsel-linux/4.3.1/include
-D__KERNEL__ -Iinclude -Iinclude2 -I/home/git/linux-mips/include
-include include/linux/autoconf.h -I/home/git/linux-mips/init -Iinit
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -Werror-implicit-function-declaration -O2
-fno-stack-protector -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe
-msoft-float -ffreestanding -march=mips32r2 -Wa,-mips32r2 -Wa,--trap
-I/home/git/linux-mips/include/asm-mips/mach-mips
-Iinclude/asm-mips/mach-mips
-I/home/git/linux-mips/include/asm-mips/mach-generic
-Iinclude/asm-mips/mach-generic
-D"VMLINUX_LOAD_ADDRESS=0xffffffff80100000" -fomit-frame-pointer
-Wdeclaration-after-statement -Wno-pointer-sign -D"KBUILD_STR(s)=#s"
-D"KBUILD_BASENAME=KBUILD_STR(main)"
-D"KBUILD_MODNAME=KBUILD_STR(main)" /home/git/linux-mips/init/main.c ;


Many of them are not required for kernel build.  So another workaround
might be filtering some patterns out on kernel side.  Something like
this:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ad36c94..4ffa809 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -641,6 +641,9 @@ LDFLAGS			+= -m $(ld-emul)
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -xc /dev/null | \
 	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
+	egrep -vw '__(FLT|DBL|LDBL)_[A-Z_0-9]+__' | \
+	egrep -vw '__[A-Z]*(ACCUM|FRACT)_[A-Z_0-9]+__' | \
+	egrep -vw '__DEC[0-9]+_[A-Z_0-9]+__' | \
 	sed -e 's/^\#define /-D/' -e "s/ /='/" -e "s/$$/'/")
 ifdef CONFIG_64BIT
 CHECKFLAGS		+= -m64
