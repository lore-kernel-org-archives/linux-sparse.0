Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051011;
	b=Jk9hNDmvsLy9x5nX3gjq8re7+URojXl6sdGMHZXs1Unmv2ttn6CEDhOn4jlHSHKmlMES
	 XR4jqrrTYpISZ45qqrQtt4p0r06RchDpQi7OnKUQh+WfmFx0yPFdY6ONvtzjlvEwFKnYz
	 VXj/mumKnxx0yRzmg5QoaN6nqAg+3UO5C7+z+ejJH8qPt/ydItDZ/QFgY+NXozMevyvP8
	 bgupUIn2VpMVQub0NOSWBEux86pcRj/vTKLkHnGnyp6qDrxQOQEzkg27BL8Em27hdbQsZ
	 dC44d1U/ywKaznKODCznBsmQVIxoDsZnXVNIiGwzsfmm1JO20gfVKVV/Yh6KyrSO+9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051011;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p0Gwxhn4I9JT9i+lPi13CuP4LyQgb4hEAwqeif8PpK8=;
	b=b5sjRLchx0xB5Cx1k+UQTPEWYIhWfY57Xy6XHjezTyOoQpWAHIkkzDIWLaaSllV0hRvn
	 aUbfuuTK+8cC1VCu3iMjIA9VSP5rAUHYmYHmpM8MyqqaVeBvk/JGD8nwR6RQa2uZMUdFu
	 RswkCNOoKkNYjr1BxeWGleAyxA5fCVDzpoumYIFOloBZCwQz7uSGlFDeLXYuM1m1y1899
	 CFiflowu/IOXjZLg+xMURb7RCKK9i7MCu7bEmGDtt907HOSs0Ivss78R2FF0f2DgaD8BT
	 F70GMhyComMTXec6TySe5Jxe3gpIZ41WYdPwzXn7Zs9vfgr5E/9BOdMCd3zxL56ysfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pmnaskgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA8606A31A;
	Mon, 26 Oct 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pmnaskgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9D61F01825;
	Mon, 26 Oct 2026 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793051011;
	bh=p0Gwxhn4I9JT9i+lPi13CuP4LyQgb4hEAwqeif8PpK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PmnaskgcKW0uMuIbn2UJK2c0KwDkbkzwLH9tJxySj1eIXCGtCcTem5+a2+q4VUxXH
	 lbViimISHT23QaA8y88synZC7V8svNFOqHI2qvbOdHNFlW33fRELq6KedQfD24w7qG
	 ob+QdnZaT1EQ/vcS47ahzfcoIv/FJNoFQwL5DgVe8IfjstHhqsDoIHRgGJr4G22RlE
	 BVJlvKZJyAU3iPNz+A5GdrpjSAErs4VBcAhNrr5cNCz4cIxkKC4RROotrDG6IUEz0R
	 kpj1GzUqLVMlOdrPuD/N2ulqmUex/SvYlxWFbtM4PCzdpd4rwINu8Yjr3UqnQ/IEKz
	 JqQgXohXYeoSA==
Date: Mon, 26 Oct 2026 14:43:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: cyridge@proton.me
Cc: x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chris Li <sparse@chrisli.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH] x86/kcfi: Don't emit KCFI_REFERENCE() in modules
Message-ID: <20261026214325.GA1330439@ax162>
References: <20261024-kcfi-reference-modules-v1-1-43c2a4a9e657@proton.me>
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
In-Reply-To: <20261024-kcfi-reference-modules-v1-1-43c2a4a9e657@proton.me>

On Sat, Oct 24, 2026 at 06:46:33PM -0700, Cytops via B4 Relay wrote:
> From: Cytops <cyridge@proton.me>
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

Shouldn't .discard.addressable be discarded from the module during
linking according to scripts/module.lds.S? Is there some other
interaction going on here with LTO?

> impossible to build against CFI kernels; its configure checks fail
> in the same way and are misreported as CONFIG_DEBUG_LOCK_ALLOC.
> 
> Only emit the reference when building vmlinux.
> 
> Tested on x86_64 with clang 23.1.3, CONFIG_CFI=y and
> CONFIG_LTO_CLANG_FULL=y (the configuration from the Fixes: commit):
> vmlinux links without warnings and still contains
> __kcfi_typeid___clear_pages_unrolled, __kcfi_typeid_copy_page,
> __kcfi_typeid___memset and __kcfi_typeid___memmove. It boots in QEMU
> with no CFI failures. A minimal module with MODULE_LICENSE("Proprietary")
> including <linux/mm.h> fails modpost before this change and builds and
> loads after it. OpenZFS builds against a CFI kernel with this change,
> and its pool, encryption, checksum and send/recv operations run with
> CONFIG_CFI_PERMISSIVE=y without CFI failures.
> 
> Fixes: 9b041a4b66b3 ("x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols")

I suppose this is just because this is the first commit that added
KCFI_REFERENCE to a GPL-only symbol? Unlucky me :)

> Link: https://github.com/openzfs/zfs/issues/18092
> Assisted-by: LLM
> Signed-off-by: Cytops <cyridge@proton.me>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Notes for reviewers:
> 
> - The fix was found and written with an AI coding assistant (Claude
>   Opus 5.5, Claude Code). It started from "CONFIG_CFI breaks
>   OpenZFS"; the assistant traced that to the modpost failure,
>   wrote this change, and ran the tests described in the changelog.
>   I have reviewed it and take responsibility for it.
> - An alternative would be wrapping the KCFI_REFERENCE() lines in
>   arch/x86/include/asm/page_64.h in #ifndef MODULE, as suggested in
>   the OpenZFS report; doing it in the macro covers all users.
> - Only x86_64 was tested; it is the only architecture using
>   KCFI_REFERENCE(). Tested with CONFIG_LTO_CLANG_FULL=y on this tree
>   and with LTO disabled on v7.3; not tested with
>   CONFIG_LTO_CLANG_THIN=y. In-tree modules were built but not loaded.
> - checkpatch reports "Non-standard signature: Assisted-by:", which
>   conflicts with Documentation/process/coding-assistants.rst.
> ---
>  include/linux/compiler.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 0ea7150db..ea161a72d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -258,10 +258,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  
>  #endif /* __KERNEL__ */
>  
> -#if defined(CONFIG_CFI) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
> +#if defined(CONFIG_CFI) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO) && \
> +	!defined(MODULE)
>  /*
>   * Force a reference to the external symbol so the compiler generates
> - * __kcfi_typid.
> + * __kcfi_typid. Only vmlinux needs it, as that is where the assembly
> + * using the typeid lives; in a module it would only add a reference to
> + * the symbol, which fails modpost if the symbol is GPL-only.
>   */
>  #define KCFI_REFERENCE(sym) __ADDRESSABLE(sym)
>  #else
> 
> ---
> base-commit: 6fba331225f5040e93d0947d1027e9712238291f
> change-id: 20261024-kcfi-reference-modules-04c32004af41
> 
> Best regards,
> --  
> Cytops <cyridge@proton.me>
> 
> 

-- 
Cheers,
Nathan
