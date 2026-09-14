Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF22481658;
	Mon, 14 Sep 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397906; cv=none; b=Kg6j+L0YKjVOXIMclNbO7HmFKkLrNyScDmRfm/ch4aybBvvWXshkLh0ZmerhvdW7JFu0a8y7jvYwoxULyJewY6MgWfdZh8e4s/DGEtpKrJnevb9qnm6KdVAHe7XUA/LR3ZY6efkY+HlUnKKWGlw/akob0SZ7S668GsDlb2ar1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397906; c=relaxed/simple;
	bh=EEOOdautznK/sgOL60c6W/9rPBbMT6ssLfGdFQaRCRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V98y52N9M6wlsJ5VjMGnRSE1X+M3J/BJIgTWrSd0VnsthaTQ8nwWSmnziIg/9xFaMEodCxE5fCoSry/hodLqwmyBeROLpgrwuvu8SG6tujGGA/HRMv9vGD/B5IQTBfnjuoGtuts3YevxsnHUEPXWyLtiuynmyb+IHuidCcXOKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVHK92B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVHK92B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817331F00898;
	Mon, 14 Sep 2026 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397904;
	bh=bqizXDotRGiGRWOoi8HdEKlXyDQcvyMD0zojHkcJHNM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XVHK92B+JTQDHPg8PhhU7GB3ACSwdWXw+Jrgwn88HgEzmH/vCtGJmlHkyhaIGA3Qa
	 tLEV/M/OE9eSNwBcXKVQHFtUaonmh6a1abLHNe23gAFcVX4wmh2QagevUo/tKgTX7G
	 eWvD7cIX9KOR6xdioQHY1v6tShic4vNEuP+7BuGNKt+8gLxkOPa0Ir5F0j6f7vVw1c
	 PKqyb4yGiB/Ko5BDGa+VwIC3GIizTFCZsLRUKc/2wC0TnPL69JcWJQ78iedLW89mHx
	 2mjOBf+yJlqEwH4ajKPyfgsDuC6we2Qe70ag9DYP8FyP3VDEt5Y4j9HyHhZ5Ujlc/r
	 ZuXxSvKzCJdfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 91F75CE10F1; Mon, 14 Sep 2026 07:58:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 07:58:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Li <sparse@chrisli.org>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <david.laight.linux@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/uaccess: Drop the address space qualifier
 from put_user()
Message-ID: <a8390eb2-9cea-45cd-add0-b30c8d8e942d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
 <20260914-unqual-v2-2-60a1407a0cd4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-unqual-v2-2-60a1407a0cd4@chromium.org>

On Mon, Sep 14, 2026 at 01:53:32PM +0000, Ricardo Ribalda wrote:
> __typeof__() preserves every qualifier, the address space included.
> 
> When we do __typeof(*__user *int), we are declaring a __user integer,
> which is pretty much meaningless. A value in a register or in the stack
> does not live in the user address space.
> 
> This annotation did not trigger any error until a recent version of
> smatch[1] started caring. And as a result of that now we have tens of
> warnings like:
> 
>   drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
>   drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
>   drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *
> 
> Instead of __typeof__() use TYPEOF_UNQUAL(). It maps to
> __typeof_unqual__() in recent compilers, so the address space annotation
> is gone.
> 
> [1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/r/20260825-unqual-v1-2-7024fb81b4f9@chromium.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Queued for testing and review, thank you both!

							Thanx, Paul

> ---
>  arch/x86/include/asm/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 3a0dd3c2b233..4e576c0b9131 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -172,7 +172,7 @@ extern void __put_user_nocheck_8(void);
>  	int __ret_pu;							\
>  	void __user *__ptr_pu;						\
>  	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
> -	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
> +	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
>  	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
>  	__chk_user_ptr(__ptr);						\
>  	__ptr_pu = __ptr;						\
> @@ -231,7 +231,7 @@ extern void __put_user_nocheck_8(void);
>  
>  #define __put_user_size(x, ptr, size, label)				\
>  do {									\
> -	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
> +	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
>  	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
>  	__chk_user_ptr(__ptr);						\
>  	switch (size) {							\
> 
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 
