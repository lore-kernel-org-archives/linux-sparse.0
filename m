Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB7153800;
	Fri, 15 Nov 2024 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703710; cv=none; b=pXVG+rVM/YvM61adG+tBf9KnF0687mPtbPEWkufuTVnzKHEWyS67Xnl8WnTTIIyJ26I36OhLHjZJ7HXzq+Gx1yjhOsCjBojJjKx+QlfGpC91ifFdnQGPIqbdnBIjS7Kr6ZmokIUeb9d3HycrpiwVNzWvvExtK1sE+Y3fN0iaOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703710; c=relaxed/simple;
	bh=qfzvl/GY/RKrYmzxqMtJHuR/sB55o8od60nWBjLqjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzBgM0cNFeZKkghKUG+t7Oxgv0xZ4G9Y2Bdj7s7mWYfi//o5rN6F6zuB3CzGidsMaNVNiKTKdHWhDe7vx1R8FealRdkeZFCLrczqAkDdzxAFOoEXLlWH0tYUfTElZidHo6hWMjJGgFjCuZIiIoagPAhQZy/55w+QR0U5vQyxqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzg7cmjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzg7cmjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2146DC4CECF;
	Fri, 15 Nov 2024 20:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703710;
	bh=qfzvl/GY/RKrYmzxqMtJHuR/sB55o8od60nWBjLqjxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzg7cmjTGyC1uLwc3ZgvSzGMcQ+7lwP1/taovqdAMRKfnn2nr5VQregW6qHNtiYYu
	 8ZCXVKAiqbvTyvyqIQFFmjDD4ZUSD+h5N/utJa7cqlkGbpfqBV7Vn5hcNGWzD4P2ZM
	 DOW1/R5Soz1MUJik8brLkDK2/otG45ez+TreZQCDH/YPYlORZyzNnKIKwhvL8UvaDT
	 GlPIXEzL72ikLPVnvIArQ4bZDzpVpJBmh6LnO0spOFXO2zkvP6PuI11j6Cs9FEm2Gm
	 1bR9aTsEC4aKmYxx0M53Xw+0ruQweLj7HA91ECaKiTt7o0xGQUuz4PzIUkwuov+GV0
	 1633flqFIXqew==
Date: Fri, 15 Nov 2024 12:48:27 -0800
From: Kees Cook <kees@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Fix undefined BUILD_BUG_ON_ZERO()
Message-ID: <202411151247.280F316C83@keescook>
References: <CAHk-=wiPZmd1hrsUoP+9vPg2=E0Jj6Li77_BZcV9GocbJg8fag@mail.gmail.com>
 <20241115204602.249590-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115204602.249590-1-philipp.reisner@linbit.com>

On Fri, Nov 15, 2024 at 09:46:02PM +0100, Philipp Reisner wrote:
> <linux/compiler.h> defines __must_be_array() and __must_be_cstr() and
> both expand to BUILD_BUG_ON_ZERO(), but <linux/build_bug.h> defines
> BUILD_BUG_ON_ZERO(). Including <linux/build_bug.h> in
> <linux/compiler.h> would create a cyclic dependency as
> <linux/build_bug.h> already includes <linux/compiler.h>.
> 
> Fix that by defining __BUILD_BUG_ON_ZERO_MSG() in <linux/compiler.h>
> and using that for __must_be_array() and __must_be_cstr().
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>

Thanks for finding a simple way to make this work sanely. :)

Acked-by: Kees Cook <kees@kernel.org>

Linus, do you want a PR for this, or will you apply it directly?

Thanks!

-Kees

> ---
>  include/linux/compiler.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 4d4e23b6e3e7..469a64dd6495 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -239,11 +239,18 @@ static inline void *offset_to_ptr(const int *off)
>  
>  #endif /* __ASSEMBLY__ */
>  
> +#ifdef __CHECKER__
> +#define __BUILD_BUG_ON_ZERO_MSG(e, msg) (0)
> +#else /* __CHECKER__ */
> +#define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
> +#endif /* __CHECKER__ */
> +
>  /* &a[0] degrades to a pointer: a different type from an array */
> -#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +#define __must_be_array(a)	__BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
>  
>  /* Require C Strings (i.e. NUL-terminated) lack the "nonstring" attribute. */
> -#define __must_be_cstr(p)	BUILD_BUG_ON_ZERO(__annotated(p, nonstring))
> +#define __must_be_cstr(p) \
> +	__BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
>  
>  /*
>   * This returns a constant expression while determining if an argument is
> -- 
> 2.47.0
> 

-- 
Kees Cook
