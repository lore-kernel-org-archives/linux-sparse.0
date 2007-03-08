From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 8 Mar 2007 11:08:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703081104010.10832@woody.linux-foundation.org>
References: <1173319356.3546.54.camel@johannes.berg> <1173375270.15842.24.camel@dv>
 <1173375791.3248.37.camel@johannes.berg> <200703081908.40997.IvDoorn@gmail.com>
 <Pine.LNX.4.64.0703081023490.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0703081023490.10832-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org



On Thu, 8 Mar 2007, Linus Torvalds wrote:
> 
> To check a value for being a nice range of consecutive bits, you can 
> simply do:
> 
> 	#define is_power_of_two(x) (!((x) & ((x)-1)))
> 	#define low_bit_mask(x) (((x)-1) & ~(x))
> 	#define is_contiguous_mask(x) is_power_of_two(1 + (x) + low_bit_mask(x))

Side note: I didn't check this. So if you actually do this, please 
double-check. The math should all be good, but there's a few caveats:

 - I might have made a mistake

 - 0 is special, and is generally considered to be a power of two (and 
   this is more fundamental than you'd think: it's not just fall-out from 
   the particular expression chosen, it is fundamentally *required* to 
   handle overflow, and you can think of 0 as 2**x, x > wordsize if that 
   makes you more comfortable with the notion that zero is a power-of-two 
   in any finite representation of 2's complement)

The "zero is special" thing means that if you don't want to accept zero as 
a valid mask (it technically *is* a contiguous set of bits set - it's just 
the empty set) you'd need to check for it specially.

But the "I might have made a mistake" part is worth just remembering, and 
just double-checking it all.

		Linus
