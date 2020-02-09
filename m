From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH bpf] bpf: Improve bucket_log calculation logic
Date: Sun, 9 Feb 2020 13:19:50 +0100
Message-ID: <20200209121950.gxnfnyr2tpnuqz47@ltop.local>
References: <20200207081810.3918919-1-kafai@fb.com>
 <CAHk-=wieADOQcYkehVN7meevnd3jZrq06NkmyH9GGR==2rEpuQ@mail.gmail.com>
 <CAHk-=wjbhawNieeiEig4LnPVRTRPgY8xag7NuAKuM9NKXCTLeQ@mail.gmail.com>
 <20200207204144.hh4n4o643oqpcwed@ltop.local>
 <CAHk-=whvS9x5NKtOqcUgJeTY7dfdAHcEALJT53cy3P7Hzfgr1g@mail.gmail.com>
 <20200208235459.xmliqf2ksbre53jj@ltop.local>
 <CAHk-=whqDZUo6yARXMgwHSJRerXM4tWgMPV=MC9wR80YCEon1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36263 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBIMTz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Feb 2020 07:19:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so4144531wru.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Feb 2020 04:19:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHk-=whqDZUo6yARXMgwHSJRerXM4tWgMPV=MC9wR80YCEon1A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 08, 2020 at 04:58:51PM -0800, Linus Torvalds wrote:
> 
> Anyway, your fixed patch looks good, and the numbers look lovely. I
> don't see why there would sometimes be extra memory use, but the patch
> feels like the right thing to do regardless.

Yes, I'm quite happy with it so. Thank you for the suggestion.

For the cases with extra memory consumption, I've investigated the
most extreme one and it's quite interesting. The extra memory was
used for basic blocks, instructions and pseudos, so more linearized
code. I reduced it to:

	static inline int get_order(long size)
	{
		return __builtin_constant_p(size) ? 0 : 1;
	}
	
	int foo(void)
	{
		return get_order(0);
	}

Sparse used to not recognized the size as a constant (I don't
understand why but haven't investigated). Strangely, the builtin
without the conditional gave the expected result.

Now, with the patch doing the inlining during expansion, the size
is correctly recognized as a constant, with or without the conditional.
The extra linearized code comes from some complex expression that is
now selected instead of a function call (while reducing, I had the
vague impression that the expression should have expanded further
but I haven't check that yet).

-- Luc
