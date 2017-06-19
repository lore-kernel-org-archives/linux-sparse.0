From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: __user with scalar data types
Date: Mon, 19 Jun 2017 10:15:09 -0600
Message-ID: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-sparse@vger.kernel.org

A number of us over in DRM land have been using __u64 scalar types
to store pointers for uapi structures in accordance with Daniel Vetter's
now classic treatise on ioctls:

http://blog.ffwll.ch/2013/11/botching-up-ioctls.html

A smaller number of us have further been marking the __u64 with __user,
to wit:

struct uapistruct {
	...
	__u64 __user myptr;
	---
};

And then converting it for use in the kernel as such:

{
	void __user *userptr = (void __user *)(uintptr_t)args->myptr;

	copy_from_user(local, userptr, size);
	...
}

The problem is that sparse doesn't like the momentary switch to
uintptr_t:

	warning: dereference of noderef expression

Which raised a bikeshed debate over whether it is appropriate to mark a scalar
type as __user.  My opinion is that it is appropriate because __user should mark
user memory regardless of the container.

I'm looking for opinions or semi-authoritative edicts to determine if we should
either start changing our uapi headers or go off and try to figure out how to
make sparse understand this particular usage.

Thanks!
Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
