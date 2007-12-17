From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Signed divides vs shifts (Re: [Security] /dev/urandom uses uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 18:23:12 +0000
Message-ID: <20071217182312.GD8181@ftp.linux.org.uk>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au> <alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org> <20071217185557.0b501e23.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35424 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbXLQSYD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 17 Dec 2007 13:24:03 -0500
Content-Disposition: inline
In-Reply-To: <20071217185557.0b501e23.dada1@cosmosbay.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@BitWagon.com>, Andrew Morton <akpm@linux-foundation.org>, security@kernel.org, tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mpm@selenic.com, linux-sparse@vger.kernel.org

On Mon, Dec 17, 2007 at 06:55:57PM +0100, Eric Dumazet wrote:

> long *mid(long *a, long *b)
> {
> 	return ((a - b) / 2 + a);
> }

... is not actually a middle (you'd want b-a, not a-b there), but anyway

> It gave :
> mid:
>         movq    %rdi, %rdx
>         subq    %rsi, %rdx
>         sarq    $3, %rdx
>         movq    %rdx, %rax
>         shrq    $63, %rax
>         addq    %rdx, %rax
>         sarq    %rax
>         leaq    (%rdi,%rax,8), %rax
>         ret
> 
> while 
> 
> long *mid(long *a, long *b)
> {
> 	return ((a - b) / 2u + a);
> }

... undefined behaviour if a < b

> and while :
> 
> long *mid(long *a, long *b)
> {
> 	return (((unsigned long)(a - b)) / 2 + a);
> }

undefined behaviour, again.
