From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: __user with scalar data types
Date: Mon, 19 Jun 2017 22:32:18 +0200
Message-ID: <20170619203217.yj55siq433mt2x5i@ltop.local>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34931 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFSUcW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 16:32:22 -0400
Content-Disposition: inline
In-Reply-To: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Jun 19, 2017 at 10:15:09AM -0600, Jordan Crouse wrote:
> struct uapistruct {
> 	...
> 	__u64 __user myptr;
> 	---
> };
> 
> And then converting it for use in the kernel as such:
> 
> {
> 	void __user *userptr = (void __user *)(uintptr_t)args->myptr;
> 
> 	copy_from_user(local, userptr, size);
> 	...
> }
> 
> The problem is that sparse doesn't like the momentary switch to
> uintptr_t:
> 
> 	warning: dereference of noderef expression

This warning doesn't come from the cast to uintptr_t but
simply from dereferencing the field which can't be dereferenced
since it's marked as '__user'. In other words, doing
'args->myptr' rightfully trigger the warning and no cast
will or should stop that.

Also, you can't expect the '__user' to be transmitted from
'myptr' to the pointer (without taking the address of 'myptr').
It's exactly like 'const int' vs. 'const int *': the '__user' or
the 'const' is not at the same level in the type hierarchy
('const object' vs. 'non-const pointer to const object').


-- Luc Van Oostenryck
