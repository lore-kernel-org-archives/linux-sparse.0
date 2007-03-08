From: Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 8 Mar 2007 20:26:15 +0100
Message-ID: <200703082026.15305.IvDoorn@gmail.com>
References: <1173319356.3546.54.camel@johannes.berg> <200703081908.40997.IvDoorn@gmail.com> <Pine.LNX.4.64.0703081023490.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0703081023490.10832-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

> > 	#define is_power_of_two(x) (!((x) & ((x)-1)))
> > 	#define low_bit_mask(x) (((x)-1) & ~(x))
> > 	#define is_contiguous_mask(x) is_power_of_two(1 + (x) + low_bit_mask(x))
> 
> Side note: I didn't check this. So if you actually do this, please 
> double-check. The math should all be good, but there's a few caveats:

Checked, and seems to work. Even sparse appears to be very happy. :)
I'll do some more extensive testing later today before submitting a patch.
 
> The "zero is special" thing means that if you don't want to accept zero as 
> a valid mask (it technically *is* a contiguous set of bits set - it's just 
> the empty set) you'd need to check for it specially.

Good point, I'll add a check for that as well.

> Thus endeth Linus' "games with bits" lecture. It was probably more than 
> you really wanted to know. There's a ton of games you can play with simple 
> "x-1" and bitmasking ops like this).

Thanks, for both the macro's and the lecture. ;)

Ivo
