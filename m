From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] sparse: Fix including glibc headers on x86-64
Date: Fri, 23 Mar 2012 20:01:49 +1100
Message-ID: <1332493309.2882.6.camel@pasglop>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi>
	 <CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37577 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910Ab2CWJEI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2012 05:04:08 -0400
In-Reply-To: <CANeU7Q=h1egUD1cSpNwmAnemXPTa0k0OrKQOY6Rhow_5hb1hYA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: penberg@cs.helsinki.fi, linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Frederic Crozat <fcrozat@suse.com>

On Fri, 2012-03-23 at 01:59 -0700, Christopher Li wrote:
> 
> I just realized that this patch has the unwanted side effect that,
> even if you try to define 32 bit compile in 64 bit Linux, the
> __x86_64__ will
> still be there. The weak define only avoid the conflict of defining
> the __x86_64__
> the second time. It does not solve the case where __x86_64__ shouldn't
> be there.
> 
> The better way seems to be parsing -m32 and -m64 then set the
> __x86_64__ accordingly. 

That reminds me we should also have a way to pass the arch triplet and
have a good way to find a "default". On debian sid you need it to get
all your standard includes for userspace, and we should really pass it
to llvm in sparse-llvm.

Cheers,
Ben.


