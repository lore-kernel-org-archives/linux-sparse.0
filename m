From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: __user with scalar data types
Date: Mon, 19 Jun 2017 21:27:20 +0200
Message-ID: <20170619192720.2cvcz7rgvgtl4xxh@ltop.local>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36840 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbdFST1a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 15:27:30 -0400
Content-Disposition: inline
In-Reply-To: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Jun 19, 2017 at 10:15:09AM -0600, Jordan Crouse wrote:
> A number of us over in DRM land have been using __u64 scalar types
> to store pointers for uapi structures in accordance with Daniel Vetter's
> now classic treatise on ioctls:
> 
> http://blog.ffwll.ch/2013/11/botching-up-ioctls.html
> 
> A smaller number of us have further been marking the __u64 with __user,
> to wit:
> 
> struct uapistruct {
> 	...
> 	__u64 __user myptr;
> 	---
> };

It wouldn't make sense to have this:
	struct uapistruct {
		__u64 __user myptr;
		__u64        anothermember;
	};
In other words, eiter all members are in the user address space
or none are. So, a struct member should not be marked __user
(exactly as for 'const' or 'volatile').

It wouldn't also make sense to move the __user to the whole struct,
giving something like:
	struct uapistruct {
		__u64 myptr;
		__u64 anothermember;
	} __user;
because it's not the type that belong to the user address space
but some specific objects.

Of course, your real problem here is that you're using a __u64 to
store a pointer and then expect this __u64 to have some properties
unique to pointers.


-- Luc Van Oostenryck (sparse hacker)
