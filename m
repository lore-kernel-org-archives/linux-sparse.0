From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: __user with scalar data types
Date: Mon, 19 Jun 2017 21:46:37 +0100
Message-ID: <20170619204637.GJ10672@ZenIV.linux.org.uk>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
 <20170619203217.yj55siq433mt2x5i@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49404 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdFSUqk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 16:46:40 -0400
Content-Disposition: inline
In-Reply-To: <20170619203217.yj55siq433mt2x5i@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Jun 19, 2017 at 10:32:18PM +0200, Luc Van Oostenryck wrote:
> On Mon, Jun 19, 2017 at 10:15:09AM -0600, Jordan Crouse wrote:
> > struct uapistruct {
> > 	...
> > 	__u64 __user myptr;
> > 	---
> > };
> > 
> > And then converting it for use in the kernel as such:
> > 
> > {
> > 	void __user *userptr = (void __user *)(uintptr_t)args->myptr;
> > 
> > 	copy_from_user(local, userptr, size);
> > 	...
> > }
> > 
> > The problem is that sparse doesn't like the momentary switch to
> > uintptr_t:
> > 
> > 	warning: dereference of noderef expression
> 
> This warning doesn't come from the cast to uintptr_t but
> simply from dereferencing the field which can't be dereferenced
> since it's marked as '__user'. In other words, doing
> 'args->myptr' rightfully trigger the warning and no cast
> will or should stop that.
> 
> Also, you can't expect the '__user' to be transmitted from
> 'myptr' to the pointer (without taking the address of 'myptr').
> It's exactly like 'const int' vs. 'const int *': the '__user' or
> the 'const' is not at the same level in the type hierarchy
> ('const object' vs. 'non-const pointer to const object').

Besides, suppose you add a special type for that.  How would it
have to behave, really?  AFAICS, you want something similar to
__bitwise, except that (assuming this type is T)
	T + integer => T
	T - integer => T
	T & integer => integer
	T | integer => T
	T - T => integer (quietly decay to underlying type for both
arguments, then treat as normal -)
	T & T => T (probably, but might be worth a warning)
	T | T => T (ditto)
	comparison - same as for __bitwise
	constant conversion: 0 should convert clean, anything else - a warning
	cast to pointer => warn unless the target type is __user?  But that's
not going to help with cast through uintptr_t...
	?: as usual
	any other arithmetics => warn and decay to underlying integer type

It might be not impossible to implement, but it sure as hell won't be __user
and it'll need careful thinking about the semantics of those annotations.
The outline above is just that - figuring out if there are any nasty corner
cases will take some work.
