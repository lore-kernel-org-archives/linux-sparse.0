From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 20:18:52 +0200
Message-ID: <b739fb9ad6e68bfe5d2a4b839abc8ea4@kernel.crashing.org>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:44224 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbXFXST7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 14:19:59 -0400
In-Reply-To: <20070624174732.GZ21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

>> Hopefully correct handling of integer constant expressions.  Please, 
>> review.
>
> Heh...  The first catches are lovely:
>                  struct fxsrAlignAssert {
>                          int _:!(offsetof(struct task_struct,
>                                          thread.i387.fxsave) & 15);
>                  };

That's...  wow?

> #define _IOC_TYPECHECK(t) \
>         ((sizeof(t) == sizeof(t[1]) && \
>           sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
>           sizeof(t) : __invalid_size_argument_for_IOC)
> poisoning _IOW() et.al., so those who do something like
>
> static const char *v4l1_ioctls[] = {
>         [_IOC_NR(VIDIOCGCAP)]       = "VIDIOCGCAP",
>
> run into trouble.

> The only reason that doesn't break gcc to hell and back is
> that gcc has unfixed bugs in that area.

If I understand correctly what bugs you are talking about,
most (all?) of those were solved in the dark ages already
(i.e., the 3.x series).

> It certainly is not a valid C

Why not?  Nothing in the C standard says all your externs
have to be defined in some other translation unit you link
with AFAIK.

> or even a remotely sane one.

It's unusual at least :-)


Segher
