From: Tony Camuso <tcamuso@redhat.com>
Subject: sparse error on __int128
Date: Tue, 11 Aug 2015 07:32:31 -0400
Message-ID: <55C9DD4F.9050805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933911AbbHKLcd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2015 07:32:33 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>

I think I've raised this question before, but I don't think I
got a response that indicated whether this is a sparse bug or
if there was a source or compile issue.

Here is the error:
sparse /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i
/work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: impossible combination of type specifiers: unsigned __int128
/work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: Expected ) at end of cast operator
/work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i:5505:26: error: got __int128

Here is the offending line in context:

  5503 static inline __attribute__((no_instrument_function)) u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
  5504 {
  5505  return (u64)(((unsigned __int128)a * mul) >> shift);
  5506 }

Here is the compile command:

$ gcc -E -Wp,-MD,/work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/.fw_common.i.d  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/5.1.1/include -I/work/rh7/arch/x86/include -Iarch/x86/include/generated  -Iinclude -I/work/rh7/arch/x86/include/uapi -Iarch/x86/include/generated/uapi -I/work/rh7/include/uapi -Iinclude/generated/uapi -include /work/rh7/include/linux/kconfig.h -D__KERNEL__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -m64 -mno-sse -mpreferred-stack-boundary=3 -mtune=generic -mno-red-zone -mcmodel=kernel -funit-at-a-time -maccumulate-outgoing-args -Wframe-larger-than=2048 -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=
 1 -DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -pipe -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -Wframe-larger-than=2048!
  -fstack-p
rotector-strong -Wno-unused-but-set-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -pg -mfentry -DCC_USING_FENTRY -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DCC_HAVE_ASM_GOTO -D__CHECK_ENDIAN__  -DMODULE  -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(fw_common)"  -D"KBUILD_MODNAME=KBUILD_STR(rtl8723_common)" -o /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.i /work/rh7/drivers/net/wireless/rtlwifi/rtl8723com/fw_common.c
