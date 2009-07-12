From: Christopher Li <sparse@chrisli.org>
Subject: Re: bitwise with memcpy and void*
Date: Sun, 12 Jul 2009 10:37:17 -0700
Message-ID: <70318cbf0907121037j6a64a565k726a389df3f034ed@mail.gmail.com>
References: <AcoCR0k8a89nhOCfTzWiwUhqEVZAPg==>
	 <DD2D1CDF962D7346A5B0E5EE9CA3612711422805@ZIPPY.Emea.Arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f199.google.com ([209.85.212.199]:61348 "EHLO
	mail-vw0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbZGLRhR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 12 Jul 2009 13:37:17 -0400
Received: by mail-vw0-f199.google.com with SMTP id 37so1529674vwj.33
        for <linux-sparse@vger.kernel.org>; Sun, 12 Jul 2009 10:37:17 -0700 (PDT)
In-Reply-To: <DD2D1CDF962D7346A5B0E5EE9CA3612711422805@ZIPPY.Emea.Arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Robert Catherall <Robert.Catherall@arm.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Jul 11, 2009 at 9:47 AM, Robert
Catherall<Robert.Catherall@arm.com> wrote:
> 1. Specifically data was copied from a buffer in BE format to a buffer
> in LE format using memcpy(). Using memcpy is kind of implying that the
> programmer believes the types of the source and destination buffers are
> compatible, so it would be nice if sparse could issue a warning when
> they are not.

I think what you want is:

memcpy(pLE, pBE, len); // warning
memcpy(pBE, pLE, len); // warning
memcpy(pLE1, pLE2, len); // no warning
memcpy(pBE1, pBE2, len); // no warning

That can no be done with stock sparse checking.
Because you need correlation between the first and
second argument.

You can get that kind of feature by extending your own
version of the checking. You just need to implement your
own version of check_memcpy in sparse.c.

>
> 2. Next I tried writing my own memcpy in the hope that I would then get
> warnings in the normal way but got a warning implying that sparse knows
> about memcpy
>
> warning: conflicting types for built-in function "memcpy"
> foo.c: In function "memcpy":

Are you sure it is from sparse not gcc? Sparse has prototypes for
the built-in function "__builtin_memcpy" that is about it.

>

> Is this treatment of void* expected behaviour?

Right. void* means you don't care about the type of the pointer.

BTW, I just find out the Wbitwise is not used any where.
Which means you can't turn Wbitwise off. Should be easy enough to
fix though.

Chris
