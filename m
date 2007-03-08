From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG: sparse redeclaration warning when assigning to a declared
 variable!
Date: Thu, 8 Mar 2007 10:06:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703081003400.10832@woody.linux-foundation.org>
References: <200703081853.15693.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56563 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbXCHSGc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 13:06:32 -0500
In-Reply-To: <200703081853.15693.blaisorblade@yahoo.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Sparse ML <linux-sparse@vger.kernel.org>



On Thu, 8 Mar 2007, Blaisorblade wrote:
>
> Code giving one of these warnings (kernel tree 2.6.20.1), other warnings are 
> like this. I.e.:
> ret = something()
> is seen as redeclaration.

No. Sparse is actually correct, but you didn't notice that there is 
*another* "ret" there.

See how TestClearPageWriteback() is declared in <linux/page-flags.h>. THAT 
is the "ret" that shadows an earlier one..

(And no, a macro should not use a common name like that - imagine if you 
call it with an argument that really is "struct page *ret", and thing what 
happens to the TestClearPageWritepage expansion..)

So sparse in this case does seem to be pointing out a potentially 
dangerous situation, where a macro declares a local variable with the same 
name as a user of that macro.

			Linus
