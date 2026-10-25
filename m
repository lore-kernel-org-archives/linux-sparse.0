Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792892796;
	b=2MD9pcTQWQIspseY4oBCpDbrD12ED+OFVfk5XnBJzvmcWCz7PU85twlM5TbWmtQZRFu1
	 74hRD1R6ggXic5oLJBTOPos+rOVPS4U2E0by2dbgBD3tVI6/iuQfq2XmB+vYvx70MPZZ2
	 PqhhGSljz7C06N6YoQRDESJ0KqnvSvpbgSDxd/cXKY45jCa/SgD8GZpZbZDDvor/XCqqg
	 Ysekl2ppq0TDhF3mJ8Ju5OTrsBbPpLIUFpobCYlfDY2Fsum5phdUV/8cBqiYTHanipqXp
	 dIKV36TJFG1OmbE0bpPYA+VpeWH7r7j+BR2oLpSDJ8EPRwVCYgtAPxf3z7v2znKWAlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892796;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QcG7EDrZJCeBr6j9nSXrB32MYK9BIbSMPV1LPwAiErE=;
	b=zIUBWsJaAviHPva3uH+OTmRHY09s1tQq8LlmCBEAdkwAQdBRlUUdOf6fBTIYzI/vW+im
	 NrwurLNJ6Nhou7ls+GB6585hwRn+UTOJFwd5HshDoxlsGTJfuubQDapKwN9ShV7BM0v8t
	 BD2AOJtGjmZ4Q9aYNQkXylI2JqPVAKuDeh2uxS1mEzeTjXklh+cyN8nw3C5+R88YQL6g7
	 wTQ8fUHomqBZfX/ruddFIGj3Y4QIrIqSxMkxINRBC9EQcxPk9zzxYwx/dEfZugdEoL67J
	 AumOGQYedoVpC3OWg37GwcZhZwkEAN9CnvT0rTGKTYAskX899t/3wVueJ8HaR3/UMnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f03Pq/C0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EB606A31A;
	Sun, 25 Oct 2026 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f03Pq/C0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792892795;
	b=MDlGhA+KoMF9CEdp2p6E/bj0OyDR1vTmV7dgz5IycglrK7D11kY9GgtqMnJSZBojy1kP
	 z7fsjlieVDxyAHIUY4jGrc3x8wUNUqPKYtGUWScZPJiHSK4FbB6LhHWDbnydx+55ufpG6
	 1L98c8CGzFyupEZRW/MryPNJx6bSzwWGnEOcZMV/cNP6DgAltlg6cO22V4tyVhbtGG251
	 nmzE0buEG0TrIFEIfXx2a03vsmVNEhLMIs0HxpLtlILfay1mMowGmgA4nwtigXpY78yQG
	 Vspv9wMGzgxjIGDRcHvw/f6XiTG7IL17sEWIXiCU0LOalk9ZULpWa+BuJyq5P/Adpmw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792892795;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QcG7EDrZJCeBr6j9nSXrB32MYK9BIbSMPV1LPwAiErE=;
	b=rUQpDVY4z6A2DTJTUnem49tPUaq2z6RJAYtmptb/KHJDMtVsn2uNts7WFSGe/S5fFBOT
	 aTiwxRMVroLGHuL/OjQ93VKQXUFf5pAuPq7IE4lupWAucwBMfmMX9n6cc1v9PHbm2M4JA
	 wE7YMt2gWXAlAw6vdUXCOt6Nuw75M6YUwzzfsCZK1piveN/FWX1NrAdA9EuJp3+1tgKmI
	 VbZ2NokVulZ8x82IpmDbWt/gncFJCxVKQJRId6BK37HXDcuOXjM8E5f4pHm369Kps2sUL
	 jP04v/FF6FhmZ5ygsCR3r5akTkGRIQXvqXxTBQAliW9gDUZPbs7Kz9o2LQ4FHUnToDw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 51B441F01825;
	Sun, 25 Oct 2026 01:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792892795;
	bh=QcG7EDrZJCeBr6j9nSXrB32MYK9BIbSMPV1LPwAiErE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=f03Pq/C0oInPgoEfKlRRS/XTqWbJmTCbo8KJRLxhMkMf/QQ0GzeqJDnqKKhYKbKPC
	 G193+FP1o5sO86o6Mwg9cVnDgG14HuzSOEw/0XRk7TcsDgXkGUqYF3xGGtMQyGkSKo
	 maC2RLK2jq4a0bV22euov6boFfl1AmZ9cj1TOAK1daMQDd5b1T7VFpLU4IEk+E1BAW
	 chPpYUtKiBtLbej4hnTJbHntdalitZZzuqvlvvDOdDa8yV3sH8UP059wHzZaamy19R
	 +sUk9FSbYCJdECCve4Ree174Gzgl/vpR1iTrylmrvh03sINvl5ukBZddlqm7lc6FFG
	 ZcBnDNIrRFE+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C4EF844924;
	Sun, 25 Oct 2026 01:46:34 +0000 (UTC)
From: Cytops via B4 Relay <devnull+cyridge.proton.me@kernel.org>
Date: Sat, 24 Oct 2026 18:46:33 -0700
Subject: [PATCH] x86/kcfi: Don't emit KCFI_REFERENCE() in modules
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261024-kcfi-reference-modules-v1-1-43c2a4a9e657@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAyE4atUXmPJCRELroJYFHcC5pGiuEVIV
 e9OgOUnzfwLOarBad8tVPEyt7E0hE1HeunLGWxDM0WJuyAx8U2zcUVGRVHwYxzmO5wl6TaKpD6
 nQO38bBN7/8KH498+n67Q6Vujdf0A+zirNnoAAAA=
X-Change-ID: 20261024-kcfi-reference-modules-04c32004af41
To: x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Chris Li <sparse@chrisli.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-sparse@vger.kernel.org, Cytops <cyridge@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792892794; l=3893;
 i=cyridge@proton.me; s=20261025; h=from:subject:message-id;
 bh=Fe94LxVGlnE7TJPGMDWrW2p2gjEVsTcy+l0YVlT+XbQ=;
 b=3ms2BQ7UUfPIgKWFHNG+ZqtmWMnXu2DPdyGZKqyMErCmt0kQPJuLnEUKY5NtqR9dver0GC+24
 NBd3966TkZ0DVDNh+Pey0aXFAh127ip+BSYSSfVGwmtE+nJBiqYDd2p
X-Developer-Key: i=cyridge@proton.me; a=ed25519;
 pk=vUzN9FERlHN1g72uX883qK0g48rf4ZgAQ82J2Aieyyo=
X-Endpoint-Received: by B4 Relay for cyridge@proton.me/20261025 with
 auth_id=1315
X-Original-From: Cytops <cyridge@proton.me>
Reply-To: cyridge@proton.me
Content-Transfer-Encoding: 7bit

From: Cytops <cyridge@proton.me>

KCFI_REFERENCE() takes the address of a symbol so that the compiler
emits its __kcfi_typeid_ symbol, which the SYM_TYPED_FUNC_START()
assembly implementing it needs. It is used from arch/x86 headers for
__clear_pages_unrolled(), copy_page(), __memset() and __memmove(), and
all of that assembly is built into vmlinux.

Modules include the same headers, so with CONFIG_CFI=y every module
also gets an __ADDRESSABLE() reference to each of these symbols in
.discard.addressable. This serves no purpose there, and since
__clear_pages_unrolled() is EXPORT_SYMBOL_GPL, modpost now rejects any
GPL-incompatible module that includes <linux/mm.h>:

  ERROR: modpost: GPL-incompatible module repro.ko uses GPL-only
  symbol '__clear_pages_unrolled'

even though the module never uses the symbol. This makes OpenZFS
impossible to build against CFI kernels; its configure checks fail
in the same way and are misreported as CONFIG_DEBUG_LOCK_ALLOC.

Only emit the reference when building vmlinux.

Tested on x86_64 with clang 23.1.3, CONFIG_CFI=y and
CONFIG_LTO_CLANG_FULL=y (the configuration from the Fixes: commit):
vmlinux links without warnings and still contains
__kcfi_typeid___clear_pages_unrolled, __kcfi_typeid_copy_page,
__kcfi_typeid___memset and __kcfi_typeid___memmove. It boots in QEMU
with no CFI failures. A minimal module with MODULE_LICENSE("Proprietary")
including <linux/mm.h> fails modpost before this change and builds and
loads after it. OpenZFS builds against a CFI kernel with this change,
and its pool, encryption, checksum and send/recv operations run with
CONFIG_CFI_PERMISSIVE=y without CFI failures.

Fixes: 9b041a4b66b3 ("x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols")
Link: https://github.com/openzfs/zfs/issues/18092
Assisted-by: LLM
Signed-off-by: Cytops <cyridge@proton.me>
---
Notes for reviewers:

- The fix was found and written with an AI coding assistant (Claude
  Opus 5.5, Claude Code). It started from "CONFIG_CFI breaks
  OpenZFS"; the assistant traced that to the modpost failure,
  wrote this change, and ran the tests described in the changelog.
  I have reviewed it and take responsibility for it.
- An alternative would be wrapping the KCFI_REFERENCE() lines in
  arch/x86/include/asm/page_64.h in #ifndef MODULE, as suggested in
  the OpenZFS report; doing it in the macro covers all users.
- Only x86_64 was tested; it is the only architecture using
  KCFI_REFERENCE(). Tested with CONFIG_LTO_CLANG_FULL=y on this tree
  and with LTO disabled on v7.3; not tested with
  CONFIG_LTO_CLANG_THIN=y. In-tree modules were built but not loaded.
- checkpatch reports "Non-standard signature: Assisted-by:", which
  conflicts with Documentation/process/coding-assistants.rst.
---
 include/linux/compiler.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0ea7150db..ea161a72d 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -258,10 +258,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #endif /* __KERNEL__ */
 
-#if defined(CONFIG_CFI) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_CFI) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO) && \
+	!defined(MODULE)
 /*
  * Force a reference to the external symbol so the compiler generates
- * __kcfi_typid.
+ * __kcfi_typid. Only vmlinux needs it, as that is where the assembly
+ * using the typeid lives; in a module it would only add a reference to
+ * the symbol, which fails modpost if the symbol is GPL-only.
  */
 #define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
 #else

---
base-commit: 6fba331225f5040e93d0947d1027e9712238291f
change-id: 20261024-kcfi-reference-modules-04c32004af41

Best regards,
--  
Cytops <cyridge@proton.me>


