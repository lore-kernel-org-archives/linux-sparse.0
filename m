From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: sparse using insane amounts of memory
Date: Thu, 8 Mar 2007 20:02:41 +0100
Message-ID: <20070308190241.GA9792@uranus.ravnborg.org>
References: <1173319356.3546.54.camel@johannes.berg> <1173375270.15842.24.camel@dv> <1173375791.3248.37.camel@johannes.berg> <200703081908.40997.IvDoorn@gmail.com> <Pine.LNX.4.64.0703081023490.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703081023490.10832-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Pavel Roskin <proski-mXXj517/zsQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sparse-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-sparse@vger.kernel.org

> 
> You can then make it a compile-time failure with something like
> 
> 	extern unsigned int this_doesnt_exist_and_wont_link;
> 
> 	is_contiguous_mask(x) ? (x) : this_doesnt_exist_and_wont_link;
> 
> which returns "x" if it's ok, and an unlinkable expression if it isn't.

Or you can use the already defined macros in kernel.h for this:

/* Force a compilation error if condition is true */
#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))

/* Force a compilation error if condition is true, but also produce a
   result (of value 0 and type size_t), so the expression can be used
   e.g. in a structure initializer (or where-ever else comma expressions
   aren't permitted). */
#define BUILD_BUG_ON_ZERO(e) (sizeof(char[1 - 2 * !!(e)]) - 1)

	Sam
