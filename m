From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: Tue, 1 May 2007 17:24:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705011719520.3808@woody.linux-foundation.org>
References: <4637AC3D.6000008@freedesktop.org>
 <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
 <4637D47D.7040203@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:53875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946156AbXEBAZY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 20:25:24 -0400
In-Reply-To: <4637D47D.7040203@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>



On Tue, 1 May 2007, Josh Triplett wrote:
> 
> Do you know whether the current version of GCC generates poor code for pointer
> subtraction?

You _cannot_ generate good code.

When you subtract two pointers, the C definition means that you first 
subtract the values (cheap), and then you *divide* the result by the size 
of the object the pointer points to (expensive!).

So pointer subtraction is by definition expensive, if the size of the 
object is not some kind of nice power-of-two or similar.

Of course, modern CPU's are getting better at divides.

> Has anyone reported this poor code generation to the GCC bugzilla?  If so, I
> can add a reference to the bug in any (hypothetical) documentation for
> -Wptr-subtraction-blows.

The only thing that was gcc-specific about it is that gcc goes to some 
extreme lengths to turn the constant-sized division into a sequence of 
shifts/multiples/subtracts, and can often turn a division into something 
like ten cheaper operations instead.

But that optimization was also what made gcc take such a long time if the 
constant division is very common (ie a header file with an inline 
function, whether that function is actually _used_ or not apparently 
didn't matter to gcc)

So gcc does pretty well on these divisions, and makes them cheaper (except 
on CPU's where divides are really fast and possibly even cheaper than the 
combination of shifts/subtracts, but afaik, that probably won't be until 
the next-generation Intel Core 2 45nm "Penryn" thing)

			Linus
