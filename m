Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095344;
	b=Q2cjyYL/BZtGXFNipO3GSC8VxcjL1AiAuJZQYo/u/jylcY+H8ssdsg+5hNqS7JEryX7Z
	 FUm7HzkXjZhl8te5U/PMU+5htAXFTDUp7g/78/vYwjraQXNvORWiyfGs7QulJDoMXcZp1
	 OAuMsd9L8+RxZc6RkmiIbsVn6qmhzXSspUNUk3fg6R+HYQB7MIE+GdzRDHljo5oWPGCzw
	 11J7fgjCWbYz+LBikNF5W7bEPyKTnw2kJafwbAWqyk9rOsJV3w+usC1f50/t4ggEdDJBG
	 86DU2BNQhfZiffga6SIrVaIPk/A3krNI1+FwQ6S+Zz6JSVXjznqrLn3mhAPs80yj42Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095344;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8YlZ90uAKR6aXs1DTGP4PKrRtdPIJ2caVM2+niiG2is=;
	b=Rw3jQwB1EELgdFk2G1rVbnRa1wwOmOmAV0rGz0fhB7XNa/vPKDJlkyUg1lGkNRJwul1m
	 ir/7JIG+MVX7mOap9otzCnUlwV+NxZtDNOBQSvNzMBlt2n7SgU6K2CtUEWsOcFiTQpDqS
	 KwcWrwi9rinvwxSmDghcXfnhd3osc9gkSL+pEAc7LjY5rtOuorm5fNazy4/1ZFlEFKqpi
	 GqL0CnScZMjfm6Fcg3/mF3leNaz/cBb7u1HoB2luCO/bXDkiYytMsBlRszuYd7YyHSyLE
	 KQ6XPW6WiFfurVAf/Zjkte9F31sCjXqch4nmoWxb19MpoYcewHcXK42WAg6iNnYbKUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CC01RG9y;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C51606A31A;
	Tue, 27 Oct 2026 10:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C51606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CC01RG9y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8YlZ90uAKR6aXs1DTGP4PKrRtdPIJ2caVM2+niiG2is=; b=CC01RG9yCK1JUck1nuLgczlS3P
	ryLsu1zlOTJtr8NEfdW2Qo8pchXHOz4UsESUenllIoa0gbAsKZW/5WulZWrfM6uM3ttLpaxGI1kTM
	PEvsEC2Vqmte58VHit57QQyi7nuBRPPNOxFJj4XqX1fsI31af7iGTNtZJYQm8f2Y2DUv27HJoHgbp
	BMVHTdOnyV5fslU6ICouaKU4PRBuje2dsnS3kTL3phA3LgTyucDLLC1+nWpgZqaTM3VhPgRO/ty49
	d4M45efYTP096PvzUTotc8iOlKr2yp+VniyEdl4VHmI9h1UzLP5MTXU82WaihTDyfMZFtPGr+1AdU
	+48KcZmw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLe0W-0000000EhbJ-3Yzd;
	Tue, 27 Oct 2026 10:02:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31058300DB9; Tue, 27 Oct 2026 11:02:15 +0100 (CET)
Date: Tue, 27 Oct 2026 11:02:15 +0100
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
Subject: Re: [PATCH] x86/kcfi: Don't emit KCFI_REFERENCE() in modules
Message-ID: <20261027100215.GA2668804@noisy.programming.kicks-ass.net>
References: <20261024-kcfi-reference-modules-v1-1-43c2a4a9e657@proton.me>
 <20261026103743.GD2668200@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261026103743.GD2668200@noisy.programming.kicks-ass.net>

On Mon, Oct 26, 2026 at 11:37:43AM +0100, Peter Zijlstra wrote:
> On Sat, Oct 24, 2026 at 06:46:33PM -0700, Cytops via B4 Relay wrote:
> > From: Cytops <cyridge@proton.me>
> > 
> > KCFI_REFERENCE() takes the address of a symbol so that the compiler
> > emits its __kcfi_typeid_ symbol, which the SYM_TYPED_FUNC_START()
> > assembly implementing it needs. It is used from arch/x86 headers for
> > __clear_pages_unrolled(), copy_page(), __memset() and __memmove(), and
> > all of that assembly is built into vmlinux.
> > 
> > Modules include the same headers, so with CONFIG_CFI=y every module
> > also gets an __ADDRESSABLE() reference to each of these symbols in
> > .discard.addressable. This serves no purpose there, and since
> > __clear_pages_unrolled() is EXPORT_SYMBOL_GPL, modpost now rejects any
> > GPL-incompatible module that includes <linux/mm.h>:
> > 
> >   ERROR: modpost: GPL-incompatible module repro.ko uses GPL-only
> >   symbol '__clear_pages_unrolled'
> > 
> > even though the module never uses the symbol. This makes OpenZFS
> > impossible to build against CFI kernels; its configure checks fail
> > in the same way and are misreported as CONFIG_DEBUG_LOCK_ALLOC.
> > 
> > Only emit the reference when building vmlinux.
> > 
> > Tested on x86_64 with clang 23.1.3, CONFIG_CFI=y and
> > CONFIG_LTO_CLANG_FULL=y (the configuration from the Fixes: commit):
> > vmlinux links without warnings and still contains
> > __kcfi_typeid___clear_pages_unrolled, __kcfi_typeid_copy_page,
> > __kcfi_typeid___memset and __kcfi_typeid___memmove. It boots in QEMU
> > with no CFI failures. A minimal module with MODULE_LICENSE("Proprietary")
> > including <linux/mm.h> fails modpost before this change and builds and
> > loads after it. OpenZFS builds against a CFI kernel with this change,
> > and its pool, encryption, checksum and send/recv operations run with
> > CONFIG_CFI_PERMISSIVE=y without CFI failures.
> > 
> > Fixes: 9b041a4b66b3 ("x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols")
> > Link: https://github.com/openzfs/zfs/issues/18092
> > Assisted-by: LLM
> > Signed-off-by: Cytops <cyridge@proton.me>
> 
> Yeah, I suppose this will do. Thanks.

Borislav reminded me that we need a real identity for SoB.
