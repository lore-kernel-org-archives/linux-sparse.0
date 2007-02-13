From: Christopher Li <sparse@chrisli.org>
Subject: Re: Another sparse warning...
Date: Mon, 12 Feb 2007 18:00:54 -0800
Message-ID: <20070213020054.GB2922@chrisli.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk> <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:65337 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965473AbXBMCaO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 21:30:14 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

On Mon, Feb 12, 2007 at 07:50:24AM -0800, Linus Torvalds wrote:
> 
> Now, you can either try to make sparsedo global analysis (which some 
> people apparently really _are_ trying to do), or you can tell sparse that 
> it holds a certain lock on entry, and is _supposed_ to release it. You can 
> do that by annotating the function with __acquires/__releases():
> 
> 	int myfunction(..)
> 		__releases(kernel_lock)
> 		__acquires(kernel_lock)

Aha. That is the purpose of ctype member "context_list *context".
I was puzzling about it when I am reading the context checking code.

Without knowing the input/output context stuff, this syntax is
really cryptic.

# define __acquire(x)	__context__(x,1)
# define __acquires(x)	__attribute__((context(x,0,1)))
# define __releases(x)	__attribute__((context(x,1,0)))

>  - it shows the *programmer* that the function is doing somethign 
>    "strange" (not really strange, but still: it's basically a fairly 
>    readable way that it's doing locking in a weird way).

Should the function declare in the header file has that as well?
When call one of those functions, it can know that function will change
context.  That might be a way to solve the problem that some of the
spinlock function is not a inline function at all.

Chris
