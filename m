Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793190833;
	b=etH0gc8OZM9e0RYGmEOp3V6hrjNZk4BtJxua7fexReKnAhktaSA/GRueHdkdQWmyDaGJ
	 7TzJ2AVXKY+OpLgT2e5+telIi3qyi4mgzIqh5rtDo2vhH+nXnFtL/ZFdgGxHPoABvfhUT
	 9LMn0JfjjwiEoOF2IkvHqiYVEqIvaX3DOeziJNrf87IbeL0uWy7zA5W0z/3EMdLFeAahO
	 kZnaEqmNlbinQXFT0/eo/ajh8arAn6PhK1ifgjabSfk1Lat7PminrJsZrT0s94bpAnOiO
	 yfMEF7SsYLLR+hmlmJHgcleTEbobmPsR7Z7SbyIHdOvhlncqwC8NgU3C3Njmb80UM+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793190833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WMoRfpkzjo+kxzqaZnu+n0oPg+0cBm0W+fYTzt9xvJM=;
	b=K4SU+Tg4bN2R9CcKgqKzVVrkSmXp4Tp+hAcPiYweFDdFSTA+2zzq3FjQOA0vW5OLQE8c
	 stC4tVy9+J22ADgwJJh1Gwhl0aDyURVppYO9vufn3gHtoBixsmaoBL55lKXUGWKlKHKK2
	 m1BhCt7uDfIIbaollvcwMJKkIgkAS6XX6UzAA+fvJUQV2RlZ+aLqWlUPcMioVCMYgmZTL
	 bZaJ9yIPLgJ3ah4XnOQGs76MPU+KBB1ziQptcHKR4BQ3n1nMzTd0jBG9S/GNLSXIGstCo
	 RfUpPCvSGpvec/DrP9osxHJWkoIDozo2mu7CW1Jyq44ZHHrnOBFvxgMGOl7kuIDauEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jq0iAutx;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC2606A31A;
	Wed, 28 Oct 2026 12:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56CC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jq0iAutx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WMoRfpkzjo+kxzqaZnu+n0oPg+0cBm0W+fYTzt9xvJM=; b=jq0iAutxytuvAawK7WINQARGoT
	X2MepMdn+xPfgVJs/KFJbzRJWgZm1zasPGW5gu2Pcce0E0H24Q2vcJOMCWulX9GkERDvvStwroz7X
	Jh3Q8KCz5l5nyskkh2Y9FDhP9JlfQK/44TL5EUZ7YrJK1w4hjYy8gw+gAJbVFkvqK4+OOdnEfKtFy
	l11xc+AyKyFA/rF3oRy7Jj8E6KpBpq804dtDkLj9CaVaNx7HrQJzPdVj55bG8K08LoyMd0daHqNy8
	3o5ure+t/IIQz3iXuDvFC0hjqoS63wj2jrLgUEtjMxEoBik224g5ERoh/hDrQr1fo7nYMDsjjJ4zq
	9qGAKtKA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2qj-00000003RA4-186T;
	Wed, 28 Oct 2026 12:33:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D115930120E; Wed, 28 Oct 2026 13:33:48 +0100 (CET)
Date: Wed, 28 Oct 2026 13:33:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: cyridge@proton.me
Cc: x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chris Li <sparse@chrisli.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2] x86/kcfi: Don't emit KCFI_REFERENCE() in modules
Message-ID: <20261028123348.GQ2668564@noisy.programming.kicks-ass.net>
References: <20261027-kcfi-reference-modules-v2-1-3a3247f15806@proton.me>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-kcfi-reference-modules-v2-1-3a3247f15806@proton.me>

On Tue, Oct 27, 2026 at 03:29:21PM -0700, Ridge Lomont via B4 Relay wrote:
> From: Ridge Lomont <cyridge@proton.me>
> 
> KCFI_REFERENCE() takes the address of a symbol so that the compiler
> emits its __kcfi_typeid_ symbol, which the SYM_TYPED_FUNC_START()
> assembly implementing it needs. It is used from arch/x86 headers for
> __clear_pages_unrolled(), copy_page(), __memset() and __memmove(), and
> all of that assembly is built into vmlinux.
> 
> Modules include the same headers, so with CONFIG_CFI=y every module
> also gets an __ADDRESSABLE() reference to each of these symbols in
> .discard.addressable. This serves no purpose there, and since
> __clear_pages_unrolled() is EXPORT_SYMBOL_GPL, modpost now rejects any
> GPL-incompatible module that includes <linux/mm.h>:
> 
>   ERROR: modpost: GPL-incompatible module repro.ko uses GPL-only
>   symbol '__clear_pages_unrolled'
> 
> even though the module never uses the symbol. This makes OpenZFS
> impossible to build against CFI kernels; its configure checks fail
> in the same way and are misreported as CONFIG_DEBUG_LOCK_ALLOC.
> 
> scripts/module.lds.S does not help here: modpost checks <module>.o
> before the final link, and even after it the discarded section only
> loses its relocations, the undefined symbols stay in .symtab, where
> the module loader resolves them with the same license check.
> 
> Only emit the reference when building vmlinux.
> 
> Tested on x86_64 with clang 23.1.3 and CONFIG_CFI=y, with both
> CONFIG_LTO_CLANG_FULL=y (the configuration from the Fixes: commit) and
> CONFIG_LTO_CLANG_THIN=y: vmlinux links without warnings and still contains
> __kcfi_typeid___clear_pages_unrolled, __kcfi_typeid_copy_page,
> __kcfi_typeid___memset and __kcfi_typeid___memmove. It boots in QEMU
> with no CFI failures. A minimal module with MODULE_LICENSE("Proprietary")
> including <linux/mm.h> fails modpost before this change and builds and
> loads after it. OpenZFS builds against a CFI kernel with this change,
> and its pool, encryption, checksum and send/recv operations run
> without CFI failures, in QEMU and on a desktop with CFI enforcing.
> 
> Fixes: 9b041a4b66b3 ("x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols")
> Link: https://github.com/openzfs/zfs/issues/18092
> Assisted-by: LLM
> Signed-off-by: Ridge Lomont <cyridge@proton.me>
> Acked-by: Nathan Chancellor <nathan@kernel.org>

Thanks!
