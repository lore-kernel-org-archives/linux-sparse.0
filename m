Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D4301010
	for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2026 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892220; cv=none; b=t09jvSTTtnahDV7s3vbCPZSo3kVjlI/lSgWE/fEmIMP0RKZ0xG/MZicDmpo6tzabrv/eweedpOf7sgWdgj3M7oCN/Ibr1UtTjU1mGnJGXlRUnyVdqKtIHyrMQcNvkNj7n/br2XGKKneD2BQr3lKV8xPfNto8Bv1+lOZDiMcdNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892220; c=relaxed/simple;
	bh=8wBuxkDRdGCNd2KhKwVX5L6SRpI94fJ7sSuELmyYTlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7E+lkCMAwQWvjwoOTT4xcPwqzOL4m+7poKCvxuVFWSAFniVrgxThANWcq8bnMK2nujQBFbYWCdBLNzBqg6uJHoI87u28OK9gg4wELugnNq6E+xW8hA8xbeNnWTUcsY7vSVWBztQKKIIUjA9GvrQl6Q7mUaTUIoSpxLHd/wS2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=B95DDKZJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="B95DDKZJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zjOPngRkJr+V43/swTjEkqd51rEzYrMykENlYZFjV2M=; b=B95DDKZJlPhxM67nQg3gxYLhyM
	hJ8OgIs8dAEQd+Q8AVQFQz94R5z2QkvVqGlpBupfLRdIqcREa2WkTRyZwwMqJzRV/RBMoMpjN3TeH
	QSRoJISFBXpy4JfXa7oWO6aLJzSJnek3Nary83/8KVtYOXYGUxv3DEy9cv9MTn7ZEQuB+6a8Iz7//
	ftnGZr/6iezyG+eRBlvSJIp33oF+0yw28Q7SvPmcYjpMaDFDOHgnlMk+pXsgsCNyLXDsqlvkS/WUj
	S8UXOo3QfF7Ym3C6esQyz8f4qubglTSLwFPALAYMh87hsGgzqPSEazKEPJx0Zf+QhlGEiWBjK19re
	joNwSO6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w34Ro-0000000BKMV-2Xof;
	Thu, 19 Mar 2026 03:53:25 +0000
Date: Thu, 19 Mar 2026 03:53:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Zhang <zxh@xh-zhang.com>, linux-sparse@vger.kernel.org,
	dan.carpenter@linaro.org, chriscli@google.com,
	ben.dooks@codethink.co.uk, rf@opensource.cirrus.com
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260319035324.GG3836593@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
 <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghBU1bB6E889nv5fg+40b4_n5WnA0h3bVh32EKw0zE2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 16, 2026 at 09:42:01AM -0700, Linus Torvalds wrote:
> I have tested that branch on a few trivial cases, and it looks good to me.
> 
> I did write a long rant about how I hate cpp tricks and wish we had a
> few simple extensions (__VA_COUNT__ would be the most simple one,
> because COUNT_ARGS() is disgusting), but it is what it is, and this
> makes things better. So I decided to just delete my rant.

Speaking of rants: gcc code generation in general and around bitfields.  
Example: in collect_arg() we have
		next->pos.stream = pos->stream;
		next->pos.line = pos->line;
		next->pos.pos = pos->pos;
		next->pos.newline = 0;
in a loop, pos is declared const struct position *.  Generates the
following horror:
        movzwl  2(%r12), %edx
        movl    (%r12), %ecx
        leaq    8(%rax), %rbp
        shrw    $6, %dx
        andl    $1048512, %ecx
        movzwl  %dx, %edx
        salq    $22, %rdx
        orq     %rcx, %rdx
        movl    4(%r12), %ecx
        andl    $2147483647, %ecx
        salq    $32, %rcx
        orq     %rcx, %rdx
        movq    (%rax), %rcx
        andq    %r14, %rcx
        orq     %rcx, %rdx
        movq    %rdx, (%rax)
r12 is 'pos', rax - 'next', r14 comes from
        movabsq $-9223372036852678593, %r14
in the beginning of the function (0x800000000020003f).  Note that
*everything* prior to the last 4 insns is equivalent to
	rbp = &(struct token *)rax->next
	rdx = *(u64 *)r12 & 0x7fffffffffc0xfffc0
written in a really convoluted way.
OK, so it doesn't figure out it could bloody well calculate that rdx
value once and store in some register (the same r12, for that matter).
Let's make it simple for the damn thing - pass struct position instead
of struct position *; what we get is
	movq    %r12, %rdx
	leaq    8(%rax), %rbp
	movabsq $9223372032559808512, %rcx
	andl    $1048512, %edx
	andq    %r12, %rcx
	orq     %r14, %rdx
	orq     %rcx, %rdx
	movabsq $-9223372036852678593, %rcx
	andq    (%rax), %rcx
	orq     %rcx, %rdx
	movq    %rdx, (%rax)
What the hell?  No, really - it's
	rdx = r12;
	rbp = &(struct token *)rax->next;
	rcx = 0x7fffffff00000000;
	rdx &= 0xfffc0;
	rcx &= r12;
	rdx |= rcx;
followed by
	rcx = 0x800000000020003f & *(u64 *)rax;
	rdx |= rcx;
	*(u64 *)rax = rdx;
Leaving aside the utility of repeating the same calculation on each
iteration of the loop, figuring out that 
	(0x7fffffff00000000 & r12) | (0xfffc0 & r12)
is equal to
	0x7fffffffffc0fffc0 & r12
ought to be within the abilities of the damn compiler - and it *is*
loading a 64bit constant into rcx as it is.  What's more, it's not
a preference to using 64bit constants with lower 32 bits clear -
another movabsq in the same chunk is not of that form.

Perhaps it's an explicit store of 0 to ->newline that does it?
Clearing pos.newline in the beginning and have 
		next->pos.newline = pos.newline;
instead of zeroing in the loop does not change anything (other than
worse register allocation).  Moving zeroing of pos.newline into the
caller finally gets that calculation out of loop... and messes with
the register allocation in the caller, which is inlined into expand(),
along with substitute(), do_argument() and quite a few other things.

Granted, collect_arg() is not particularly hot, but... ouch.
I really, really don't like the handling of bitfields ;-/
