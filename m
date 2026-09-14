Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F30486BB6;
	Mon, 14 Sep 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398784; cv=none; b=Rj4k7aNKEOXSOMhuTr5qB1ZL3a7HynRPyANKYfq970wyjgWCdc19lu9I+bIgOns4ooyODT4fhhAbxY8XpX2Gdd9YV2zZpsKxaKbMIWB5UnFWZEBcveq8u01JM7YSbOM9er8AA4MFQvTR7paG/bF6EUghv6ev9oPSic1FwhIwJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398784; c=relaxed/simple;
	bh=EYOJjkjalKpTkgKhS8cNH2Fo/jGJRY60Y/75QfPqqg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff8Jp0aStd6bK7hkEqbJnxABFk+L/nX5hpsxtS5nd3YOpixuXoHH/5ilatoGCGDqIGlcn01SkLgkoJUrSnRngJpTup3P9rqnV5rAIxrQz+FMm9ISADCquUA2mEcEphzo2yCVSc9sZ/qb5F33NPSnWhe+hxCkVwN9DG/K6E/oLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVYDBCRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVYDBCRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5D1F000FF;
	Mon, 14 Sep 2026 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398782;
	bh=1u1kW8se/45dRzDbJTvl7JVnLGclNI511eFVSjq5A1I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XVYDBCRdkqysO6jyOtijmD3JfEWavJE6huYXYHYLzvZnRkLZ/dTv7vIo13UrzVHvh
	 RUAkWV6ZVp16sgsaJlihCSnKo2KLcw64KVRLfQVibt4XNwvjitqDnJFmHcJlQ1dlDK
	 xjJT/r8sAdlF9mvT2LWTFtxKmEaZYc0J03qsUasExgsErjJ53guitZX89ZSmMRUwXY
	 fjlT7sAGFgb1PF/KcMhJhs5Djs6eWk7ki4hDw8gjfs8mYX74GfFzlLg+6ylkczPWqp
	 PuCxL0sBmBnphwhKk3rbBUW3b/766yzJa/UpOnfE7ZFrzNTJXBEJJf8sgcST94F191
	 Ya05matRz6KQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 081ECCE10F1; Mon, 14 Sep 2026 08:13:01 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:13:01 -0700
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
Message-ID: <4f446901-ceeb-4444-a4ea-f9c94effacea@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
 <20260914-unqual-v2-2-60a1407a0cd4@chromium.org>
 <a8390eb2-9cea-45cd-add0-b30c8d8e942d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8390eb2-9cea-45cd-add0-b30c8d8e942d@paulmck-laptop>

On Mon, Sep 14, 2026 at 07:58:23AM -0700, Paul E. McKenney wrote:
> On Mon, Sep 14, 2026 at 01:53:32PM +0000, Ricardo Ribalda wrote:
> > __typeof__() preserves every qualifier, the address space included.
> > 
> > When we do __typeof(*__user *int), we are declaring a __user integer,
> > which is pretty much meaningless. A value in a register or in the stack
> > does not live in the user address space.
> > 
> > This annotation did not trigger any error until a recent version of
> > smatch[1] started caring. And as a result of that now we have tens of
> > warnings like:
> > 
> >   drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
> >   drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
> >   drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *
> > 
> > Instead of __typeof__() use TYPEOF_UNQUAL(). It maps to
> > __typeof_unqual__() in recent compilers, so the address space annotation
> > is gone.
> > 
> > [1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/r/20260825-unqual-v1-2-7024fb81b4f9@chromium.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> Queued for testing and review, thank you both!

GAH!!!  I actually queued the rcu_ref one and replied to the wrong
email, apologies for my confusion.  Or was it a hallucination?
You be the judge!  ;-)

0a45e252da65 ("rcu: Drop the address space qualifier from the dereference macros")

							Thanx, Paul

> > ---
> >  arch/x86/include/asm/uaccess.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index 3a0dd3c2b233..4e576c0b9131 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -172,7 +172,7 @@ extern void __put_user_nocheck_8(void);
> >  	int __ret_pu;							\
> >  	void __user *__ptr_pu;						\
> >  	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
> > -	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
> > +	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
> >  	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
> >  	__chk_user_ptr(__ptr);						\
> >  	__ptr_pu = __ptr;						\
> > @@ -231,7 +231,7 @@ extern void __put_user_nocheck_8(void);
> >  
> >  #define __put_user_size(x, ptr, size, label)				\
> >  do {									\
> > -	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
> > +	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
> >  	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
> >  	__chk_user_ptr(__ptr);						\
> >  	switch (size) {							\
> > 
> > -- 
> > 2.55.0.1007.g17ff1f9808-goog
> > 
> 
