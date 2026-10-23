Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738232;
	b=Gm8pX2QnMtSqkTy+Z7oo9cEm74/iTiGfY1SIxqCS4Ysxuiu3wOhxIDWSSI1tJ/rTDIA4
	 4f2hyAhEEBz69u8a31IWyjwoRHvGmZ8TUPGtxYJlRyBWo0fAMbUiDOHztPLKdmtAvRy3V
	 jASX9n4ZbpgLVWDkLxuNMIKB3WVFlANUqGlrd1mHWJ0PtxWdNxE2MKeYReh1Eh1uemhjA
	 xjdKEl1lazMT0dmRhxIppbXiXquP7sh72+aSq2/apUIXo+9J+Ew1HxKAi2cN1aSWjwqlg
	 8vE0PbvZvfoCxW51e797AlN1FAgZy/Cb7Wxhy3FYgSaSKtvBeKBMbBrMYjani8UPbuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738232;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=ZcmG/UCEVfdbqO5wIMJXD5ZNV1GWne6PASuXh9pLInc=;
	b=lfhNFvcAK9UbQHTzJQK0mOuawJ4Cp7ufNcoIHnRXw86NqjueXayBpAep76V+BDuyKzoR
	 qGqLxI4PuTFpq8KhMh3pZSjzdv4vNg85W2sA8tsxIFv1ruKXuEwl9+Jo9a0RXJdFwaFZa
	 iccBDmraKsppmHLEPXB1TxXQ1R1o3a3ivY7/oCODo2/UJ+meDjtMeaMKc2j5wowKwfFF7
	 ro6Qdjw6QKnYoqjVjqreJDZ91lQZyfkvBxm6qa9/iWZhfPuSdXuviwSaYThuWw24GHtPQ
	 4SLyaIEBPbfjSCJ34CxP5fFDVOC6HE6kk2UJB0fseGEhSiloW0qotLAx8mbqKEztk/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KSk2fNSB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8D606A329
	for <linux-sparse@vger.kernel.org>; Fri, 23 Oct 2026 06:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C8D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KSk2fNSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcmG/UCEVfdbqO5wIMJXD5ZNV1GWne6PASuXh9pLInc=;
	b=KSk2fNSBy0OH1xwsyDrVy16wZotD2rkwhD/tsGOitdm3fOHvIRvaPQukdDz9wv5z+Kr/pQ
	ca4aJfpaJjUKTS3fPVbir+HpTWz+dDj1n4nngStGdSC5m4ICdRByhtKg2amICwIv3+xI3X
	7UzvqHFOGNgesDtywqqQ2KYOuZNwRHw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-v9zop0riM5q8kBQyX7ObYQ-1; Fri,
 23 Oct 2026 02:50:26 -0400
X-MC-Unique: v9zop0riM5q8kBQyX7ObYQ-1
X-Mimecast-MFC-AGG-ID: v9zop0riM5q8kBQyX7ObYQ_1792738224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34DC41955F18;
	Fri, 23 Oct 2026 06:50:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D92611956095;
	Fri, 23 Oct 2026 06:50:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Chris Li <sparse@chrisli.org>
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-sparse@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 12/13] include: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 23 Oct 2026 08:48:49 +0200
Message-ID: <20261023064908.66707-13-thuth@redhat.com>
In-Reply-To: <20261023064908.66707-1-thuth@redhat.com>
References: <20261023064908.66707-1-thuth@redhat.com>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: J8iVailmm0ZWG5gvz8lY03D8-hWV_6lu4EaKrsw_QZg_1792738224
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/linux/amba/serial.h             |  4 ++--
 include/linux/annotate.h                | 18 +++++++++---------
 include/linux/cfi_types.h               |  6 +++---
 include/linux/compiler.h                |  4 ++--
 include/linux/compiler_types.h          |  8 ++++----
 include/linux/edd.h                     |  4 ++--
 include/linux/err.h                     |  2 +-
 include/linux/export.h                  |  2 +-
 include/linux/init.h                    |  6 +++---
 include/linux/ioport.h                  |  4 ++--
 include/linux/linkage.h                 |  6 +++---
 include/linux/mem_encrypt.h             |  4 ++--
 include/linux/pe.h                      |  4 ++--
 include/linux/platform_data/emif_plat.h |  4 ++--
 include/linux/ti-emif-sram.h            |  2 +-
 include/linux/types.h                   |  4 ++--
 tools/include/asm-generic/barrier.h     |  4 ++--
 tools/include/asm/alternative.h         |  2 +-
 tools/include/linux/cfi_types.h         |  6 +++---
 tools/include/linux/compiler.h          |  4 ++--
 20 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 9120de05ead08..b9129c0d6304f 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -10,7 +10,7 @@
 #ifndef ASM_ARM_HARDWARE_SERIAL_AMBA_H
 #define ASM_ARM_HARDWARE_SERIAL_AMBA_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #endif
@@ -215,7 +215,7 @@
 #define UART01x_RSR_ANY		(UART01x_RSR_OE | UART01x_RSR_BE | UART01x_RSR_PE | UART01x_RSR_FE)
 #define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD | UART01x_FR_DSR | UART01x_FR_CTS)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct amba_device; /* in uncompress this is included but amba/bus.h is not */
 struct amba_pl010_data {
 	void (*set_mctrl)(struct amba_device *dev, void __iomem *base, unsigned int mctrl);
diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 2f1599c9e5732..de8fdcb04f44d 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -11,7 +11,7 @@
 	.long label - ., type;						\
 	.popsection
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ASM_ANNOTATE_LABEL(label, type)					\
 	__stringify(__ASM_ANNOTATE(.discard.annotate_insn, label, type))
@@ -24,7 +24,7 @@
 	"912: "								\
 	__stringify(__ASM_ANNOTATE(.discard.annotate_data, 912b, type))
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 .macro ANNOTATE type
 .Lhere_\@:
@@ -36,22 +36,22 @@
 	__ASM_ANNOTATE(.discard.annotate_data, .Lhere_\@, \type)
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* !CONFIG_OBJTOOL */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define ASM_ANNOTATE_LABEL(label, type) ""
 #define ASM_ANNOTATE(type)
 #define ASM_ANNOTATE_DATA(type)
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 .macro ANNOTATE type
 .endm
 .macro ANNOTATE_DATA type
 .endm
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* !CONFIG_OBJTOOL */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
@@ -111,7 +111,7 @@
  */
 #define ANNOTATE_DATA_SPECIAL		ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
 #define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 /*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=ANNOTYPE_INSTR_BEGIN */
@@ -122,6 +122,6 @@
 #define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
 #define ANNOTATE_NOCFI_SYM		ANNOTATE type=ANNOTYPE_NOCFI
 #define ANNOTATE_DATA_SPECIAL		ANNOTATE_DATA type=ANNOTYPE_DATA_SPECIAL
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _LINUX_ANNOTATE_H */
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index a86af9bc8bdc4..b17614c493e4c 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_CFI_TYPES_H
 #define _LINUX_CFI_TYPES_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <linux/linkage.h>
 
 #ifdef CONFIG_CFI
@@ -41,7 +41,7 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_CFI
 #define DEFINE_CFI_TYPE(name, func)						\
@@ -64,5 +64,5 @@
 	);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_CFI_TYPES_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 70cb31d605384..bb602ab527c88 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef __KERNEL__
 
@@ -277,7 +277,7 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Force the compiler to emit 'sym' as a symbol, so that we can reference
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f1390079..7c2432987105b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -15,7 +15,7 @@
 #define ___PASTE(a, b) a##b
 #define __PASTE(a, b) ___PASTE(a, b)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * C23 introduces "auto" as a standard way to define type-inferred
@@ -454,7 +454,7 @@ struct ftrace_likely_data {
 
 #endif /* __KERNEL__ */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The below symbols may be defined for one or more, but not ALL, of the above
@@ -598,7 +598,7 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Use __typeof_unqual__() when available.
  */
@@ -637,7 +637,7 @@ struct ftrace_likely_data {
 
 #include <asm/percpu_types.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * __signed_scalar_typeof(x) - Declare a signed scalar type, leaving
diff --git a/include/linux/edd.h b/include/linux/edd.h
index 1c16fbcb81c06..32517f283f044 100644
--- a/include/linux/edd.h
+++ b/include/linux/edd.h
@@ -23,7 +23,7 @@
 
 #include <uapi/linux/edd.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern struct edd edd;
-#endif				/*!__ASSEMBLY__ */
+#endif				/*!__ASSEMBLER__ */
 #endif				/* _LINUX_EDD_H */
diff --git a/include/linux/err.h b/include/linux/err.h
index d3e38d5b3a985..033faa80be885 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -17,7 +17,7 @@
  */
 #define MAX_ERRNO	4095
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /**
  * IS_ERR_VALUE - Detect an error pointer.
diff --git a/include/linux/export.h b/include/linux/export.h
index a686fd0ba4065..432e980140f2b 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -51,7 +51,7 @@
 
 #define __EXPORT_SYMBOL(sym, license, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
-#elif defined(__ASSEMBLY__)
+#elif defined(__ASSEMBLER__)
 
 #define __EXPORT_SYMBOL(sym, license, ns) \
 	___EXPORT_SYMBOL(sym, license, ns)
diff --git a/include/linux/init.h b/include/linux/init.h
index 6326c61e2332d..cf43f1765eb2e 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -102,7 +102,7 @@
 #define __REFDATA        .section       ".ref.data", "aw"
 #define __REFCONST       .section       ".ref.rodata", "a"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Used for initialization calls..
  */
@@ -180,7 +180,7 @@ extern struct module __this_module;
   
 #ifndef MODULE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * initcalls are now grouped by functionality into separate
@@ -375,7 +375,7 @@ extern const struct obs_kernel_param __setup_start[], __setup_end[];
 /* Relies on boot_command_line being set */
 void __init parse_early_param(void);
 void __init parse_early_options(char *cmdline);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* MODULE */
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f7930b3dfd0a5..4728386ce65ca 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/args.h>
 #include <linux/bits.h>
 #include <linux/compiler.h>
@@ -461,5 +461,5 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 
 extern struct address_space *iomem_get_mapping(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 53fe1f48fd28d..303e74cf4ead6 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -66,7 +66,7 @@
  * end up needing stack temporaries for).
  */
 /* Assembly files may be compiled with -traditional .. */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef asmlinkage_protect
 # define asmlinkage_protect(n, ret, args...)	do { } while (0)
 #endif
@@ -77,7 +77,7 @@
 #define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* SYM_T_FUNC -- type used by assembler to mark functions */
 #ifndef SYM_T_FUNC
@@ -355,6 +355,6 @@
 	SYM_DATA_END(name)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _LINUX_LINKAGE_H */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 07584c5e36fb4..463090c4f9517 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -10,7 +10,7 @@
 #ifndef __MEM_ENCRYPT_H__
 #define __MEM_ENCRYPT_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_ARCH_HAS_MEM_ENCRYPT
 
@@ -54,6 +54,6 @@
 #define dma_addr_canonical(x)		(x)
 #endif
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
diff --git a/include/linux/pe.h b/include/linux/pe.h
index cd2b7275385f3..ab45bba90ce82 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -240,7 +240,7 @@
 #define IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	20 /* Extended DLL characteristics bits */
 #define IMAGE_DEBUG_TYPE_PERFMAP		21 /* Location of associated Ready To Run PerfMap file */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mz_hdr {
 	uint16_t magic;		/* MZ_MAGIC */
@@ -546,6 +546,6 @@ struct win_certificate {
 	uint16_t cert_type;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __LINUX_PE_H */
diff --git a/include/linux/platform_data/emif_plat.h b/include/linux/platform_data/emif_plat.h
index b93feef5d586f..ad7f706c124e3 100644
--- a/include/linux/platform_data/emif_plat.h
+++ b/include/linux/platform_data/emif_plat.h
@@ -39,7 +39,7 @@
 #define EMIF_CUSTOM_CONFIG_TEMP_ALERT_POLL_INTERVAL	0x00000002
 #define EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART		0x00000004
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct ddr_device_info - All information about the DDR device except AC
  *		timing parameters
@@ -121,6 +121,6 @@ struct emif_platform_data {
 	u32 ip_rev;
 	u32 phy_type;
 };
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __LINUX_EMIF_H */
diff --git a/include/linux/ti-emif-sram.h b/include/linux/ti-emif-sram.h
index 441b2988e66a5..b256a9b4ef053 100644
--- a/include/linux/ti-emif-sram.h
+++ b/include/linux/ti-emif-sram.h
@@ -10,7 +10,7 @@
 
 #include <linux/kbuild.h>
 #include <linux/types.h>
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct emif_regs_amx3 {
 	u32 emif_sdcfg_val;
diff --git a/include/linux/types.h b/include/linux/types.h
index 53e0adca4b9fb..c4aa8cc4b1cd6 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -4,7 +4,7 @@
 
 #include <uapi/linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
@@ -288,5 +288,5 @@ struct rcuwait {
 	struct task_struct __rcu *task;
 };
 
-#endif /*  __ASSEMBLY__ */
+#endif /*  __ASSEMBLER__ */
 #endif /* _LINUX_TYPES_H */
diff --git a/tools/include/asm-generic/barrier.h b/tools/include/asm-generic/barrier.h
index 6ef36e920ea8a..b61c3bde0447e 100644
--- a/tools/include/asm-generic/barrier.h
+++ b/tools/include/asm-generic/barrier.h
@@ -13,7 +13,7 @@
 #ifndef __TOOLS_LINUX_ASM_GENERIC_BARRIER_H
 #define __TOOLS_LINUX_ASM_GENERIC_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 
@@ -36,5 +36,5 @@
 #define wmb()	mb()
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __TOOLS_LINUX_ASM_GENERIC_BARRIER_H */
diff --git a/tools/include/asm/alternative.h b/tools/include/asm/alternative.h
index 8e548ac8f740c..85db65074a714 100644
--- a/tools/include/asm/alternative.h
+++ b/tools/include/asm/alternative.h
@@ -3,7 +3,7 @@
 #define _TOOLS_ASM_ALTERNATIVE_ASM_H
 
 #if defined(__s390x__)
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 .macro ALTERNATIVE oldinstr, newinstr, feature
 	\oldinstr
 .endm
diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
index a86af9bc8bdc4..b17614c493e4c 100644
--- a/tools/include/linux/cfi_types.h
+++ b/tools/include/linux/cfi_types.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_CFI_TYPES_H
 #define _LINUX_CFI_TYPES_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <linux/linkage.h>
 
 #ifdef CONFIG_CFI
@@ -41,7 +41,7 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_CFI
 #define DEFINE_CFI_TYPE(name, func)						\
@@ -64,5 +64,5 @@
 	);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_CFI_TYPES_H */
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index f2f54b0381680..0e08ad7e9a386 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -2,7 +2,7 @@
 #ifndef _TOOLS_LINUX_COMPILER_H_
 #define _TOOLS_LINUX_COMPILER_H_
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_types.h>
 
@@ -256,6 +256,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #endif
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _TOOLS_LINUX_COMPILER_H */
-- 
2.56.0

