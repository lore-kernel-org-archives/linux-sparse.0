From: "Russ Cox" <rsc@swtch.com>
Subject: Re: constness bug in include/linux/compiler.h
Date: Wed, 14 Mar 2007 15:10:35 -0400
Message-ID: <ee9e417a0703141210n7d8e8834j56c17b69ce68ff2c@mail.gmail.com>
References: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>
	 <45F8206E.8030706@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:7975 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830AbXCNTKf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Mar 2007 15:10:35 -0400
Received: by an-out-0708.google.com with SMTP id b33so296507ana
        for <linux-sparse@vger.kernel.org>; Wed, 14 Mar 2007 12:10:35 -0700 (PDT)
In-Reply-To: <45F8206E.8030706@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Tom Bergan <tbergan@ucla.edu>

> Yes, that makes sense.  These functions just check for the annotation on their
> pointer argument, and having the const annotation would allow them to check
> const pointers without provoking a warning due to the lack of const.

They don't provoke a warning now.  Sparse is silent on this program:

	#define __user __attribute__((noderef, address_space(1)))

	extern void __chk_user_ptr(void __user *);

	void
	f(const void __user *p)
	{
		__chk_user_ptr(p);
	}

but arguably they should (and then be changed to const void __user*).

For an actual example, __copy_from_user_inatomic has a
const void __user* argument which it passes (via __get_user_size)
to __chk_user_ptr.

Russ
