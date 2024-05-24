Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F22D611
	for <linux-sparse@vger.kernel.org>; Fri, 24 May 2024 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716518855; cv=none; b=U3y9WwnHhlwjZhhMcLGSJD5J+7V+FyMY7sdp1uE+RLrWbRaXgWgbez+1X0M17rc1AG4QwNno+khh3I0Zb8ksionWVXIJoOV22mkPqNoEQpGNVo/+x8F/elixx1zpMrY0MoLW/9YnL9ZXFro8UvC0afTcTDI4Ii1rLweEcQ8BUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716518855; c=relaxed/simple;
	bh=S03xS6WpExb0fY9BC3j6FXlQgiuHSBLYXsNQV0n/nCw=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=m9qabP9T7Nt9//I02XqmhcUbGmwP6RG8lbH0yB9PcGs3XrMDAdAuivRLtj1ZgDSdmBW6WnbMBisa1G1sKnAuYlQF5Pony7AA7kPkdNNxn+gxBryVKTcD56o9LsrVFbbt/qIuEim+1GyVQAlUGcyge+ZXq7PuxG+DJntmIx9Bmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.40.29])
	by gateway (Coremail) with SMTP id _____8Axz+u+_09m4zsDAA--.9087S3;
	Fri, 24 May 2024 10:47:28 +0800 (CST)
Received: from [10.40.40.29] (unknown [10.40.40.29])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMW7_09mpn0HAA--.9785S3;
	Fri, 24 May 2024 10:47:25 +0800 (CST)
To: linux-sparse@vger.kernel.org
From: wuruilong <wuruilong@loongson.cn>
Subject: [ Patch 001 ] feature: add support for loongarch
Message-ID: <c35dc58e-444f-0809-67cc-113d6b4b29be@loongson.cn>
Date: Fri, 24 May 2024 10:47:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4E9B240543FACD2D229BA345"
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxBMW7_09mpn0HAA--.9785S3
X-CM-SenderInfo: 5zxu3xporqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wASzI0EjI02j7AqF2xKxwAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU

This is a multi-part message in MIME format.
--------------4E9B240543FACD2D229BA345
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Maintainer:
   sparse compiles incorrectly on loongarch, the attached patch compiles 
successfully after local testing.

wuruilong


--------------4E9B240543FACD2D229BA345
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Add-support-for-loongarch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-support-for-loongarch.patch"

From 474acf81ee8162f50c20f41a566510d84a1f828c Mon Sep 17 00:00:00 2001
From: wuruilong <wuruilong@loongson.cn>
Date: Fri, 24 May 2024 02:23:46 +0000
Subject: [PATCH] Add support for loongarch

Signed-off-by: wuruilong <wuruilong@loongson.cn>
---
 Makefile             |  1 +
 machine.h            |  3 +++
 target-loongarch64.c | 21 +++++++++++++++++++
 target.c             | 48 +++++++++++++++++++++++---------------------
 target.h             |  1 +
 5 files changed, 51 insertions(+), 23 deletions(-)
 create mode 100644 target-loongarch64.c

diff --git a/Makefile b/Makefile
index e172758b..315617f4 100644
--- a/Makefile
+++ b/Makefile
@@ -73,6 +73,7 @@ LIB_OBJS += target-arm64.o
 LIB_OBJS += target-bfin.o
 LIB_OBJS += target-default.o
 LIB_OBJS += target-h8300.o
+LIB_OBJS += target-loongarch64.o
 LIB_OBJS += target-m68k.o
 LIB_OBJS += target-microblaze.o
 LIB_OBJS += target-mips.o
diff --git a/machine.h b/machine.h
index d05b5045..8be3aeed 100644
--- a/machine.h
+++ b/machine.h
@@ -42,6 +42,7 @@ enum machine {
 	MACH_OPENRISC,
 	MACH_SH,
 	MACH_XTENSA,
+	MACH_LOONGARCH64,
 	MACH_UNKNOWN
 };
 
@@ -55,6 +56,8 @@ enum machine {
 #define	MACH_NATIVE	MACH_X86_64
 #elif defined(__i386__) || defined(__i386)
 #define	MACH_NATIVE	MACH_I386
+#elif defined(__loongarch__)
+#define MACH_NATIVE     MACH_LOONGARCH64
 #elif defined(__mips64__) || (defined(__mips) && __mips == 64)
 #define	MACH_NATIVE	MACH_MIPS64
 #elif defined(__mips__) || defined(__mips)
diff --git a/target-loongarch64.c b/target-loongarch64.c
new file mode 100644
index 00000000..34b4d3d9
--- /dev/null
+++ b/target-loongarch64.c
@@ -0,0 +1,21 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+
+
+
+static void predefine_loongarch64(const struct target *self)
+{
+	predefine("__loongarch__", 1, "64");
+}
+
+const struct target target_loongarch64 = {
+	.mach = MACH_LOONGARCH64,
+	.bitness = ARCH_LP64,
+
+	.big_endian = 0,
+	.unsigned_char = 1,
+	.has_int128 = 1,
+
+	.predefine = predefine_loongarch64,
+};
diff --git a/target.c b/target.c
index 8ae22d74..0e075d59 100644
--- a/target.c
+++ b/target.c
@@ -94,6 +94,7 @@ static const struct target *targets[] = {
 	[MACH_PPC64] =		&target_ppc64,
 	[MACH_RISCV32] =	&target_riscv32,
 	[MACH_RISCV64] =	&target_riscv64,
+	[MACH_LOONGARCH64] =    &target_loongarch64,
 	[MACH_S390] =		&target_s390,
 	[MACH_S390X] =		&target_s390x,
 	[MACH_SH] =		&target_sh,
@@ -112,29 +113,30 @@ enum machine target_parse(const char *name)
 		enum machine mach;
 		char bits;
 	} archs[] = {
-		{ "alpha",	MACH_ALPHA,	64, },
-		{ "aarch64",	MACH_ARM64,	64, },
-		{ "arm64",	MACH_ARM64,	64, },
-		{ "arm",	MACH_ARM,	32, },
-		{ "bfin",	MACH_BFIN,	32, },
-		{ "h8300",	MACH_H8300,	32, },
-		{ "i386",	MACH_I386,	32, },
-		{ "m68k",	MACH_M68K,	32, },
-		{ "microblaze",	MACH_MICROBLAZE,32, },
-		{ "mips",	MACH_MIPS32,	0,  },
-		{ "nds32",	MACH_NDS32,	32, },
-		{ "nios2",	MACH_NIOS2,	32, },
-		{ "openrisc",	MACH_OPENRISC,	32, },
-		{ "powerpc",	MACH_PPC32,	0,  },
-		{ "ppc",	MACH_PPC32,	0,  },
-		{ "riscv",	MACH_RISCV32,	0,  },
-		{ "s390x",	MACH_S390X,	64, },
-		{ "s390",	MACH_S390,	32, },
-		{ "sparc",	MACH_SPARC32,	0,  },
-		{ "x86_64",	MACH_X86_64,	64, },
-		{ "x86-64",	MACH_X86_64,	64, },
-		{ "sh",		MACH_SH,	32, },
-		{ "xtensa",	MACH_XTENSA,	32, },
+		{ "alpha",	MACH_ALPHA,	 64, },
+		{ "aarch64",	MACH_ARM64,	 64, },
+		{ "arm64",	MACH_ARM64,	 64, },
+		{ "arm",	MACH_ARM,	 32, },
+		{ "bfin",	MACH_BFIN,	 32, },
+		{ "h8300",	MACH_H8300,	 32, },
+		{ "i386",	MACH_I386,	 32, },
+		{ "loongarch64",MACH_LOONGARCH64,64, },
+		{ "m68k",	MACH_M68K,	 32, },
+		{ "microblaze",	MACH_MICROBLAZE, 32, },
+		{ "mips",	MACH_MIPS32,	 0,  },
+		{ "nds32",	MACH_NDS32,	 32, },
+		{ "nios2",	MACH_NIOS2,	 32, },
+		{ "openrisc",	MACH_OPENRISC,	 32, },
+		{ "powerpc",	MACH_PPC32,	 0,  },
+		{ "ppc",	MACH_PPC32,	 0,  },
+		{ "riscv",	MACH_RISCV32,	 0,  },
+		{ "s390x",	MACH_S390X,	 64, },
+		{ "s390",	MACH_S390,	 32, },
+		{ "sparc",	MACH_SPARC32,	 0,  },
+		{ "x86_64",	MACH_X86_64,	 64, },
+		{ "x86-64",	MACH_X86_64,	 64, },
+		{ "sh",		MACH_SH,	 32, },
+		{ "xtensa",	MACH_XTENSA,	 32, },
 		{ NULL },
 	};
 	const struct arch *p;
diff --git a/target.h b/target.h
index 92b8af91..b24574ae 100644
--- a/target.h
+++ b/target.h
@@ -120,6 +120,7 @@ extern const struct target target_ppc32;
 extern const struct target target_ppc64;
 extern const struct target target_riscv32;
 extern const struct target target_riscv64;
+extern const struct target target_loongarch64;
 extern const struct target target_s390;
 extern const struct target target_s390x;
 extern const struct target target_sh;
-- 
2.43.0


--------------4E9B240543FACD2D229BA345--

