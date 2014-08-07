From: Christopher Li <sparse@chrisli.org>
Subject: Fwd: [PATCH 01/10] Add the __restrict__ keyword
Date: Wed, 6 Aug 2014 20:04:57 -0700
Message-ID: <CANeU7Qn-j4G9Ca=Apa6zX=b07Cba=NuViE0zC3NKpispBOHg9Q@mail.gmail.com>
References: <53DFD1D2.5050600@ramsay1.demon.co.uk>
	<CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>
	<53E24809.5020603@ramsay1.demon.co.uk>
	<CANeU7Qm_pUe55OY0+Nh9OS=ZN5NqFytkB3CaJMTZZOvPqtK7nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:58168 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbaHGDE6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Aug 2014 23:04:58 -0400
Received: by mail-qg0-f45.google.com with SMTP id f51so3795095qge.32
        for <linux-sparse@vger.kernel.org>; Wed, 06 Aug 2014 20:04:58 -0700 (PDT)
In-Reply-To: <CANeU7Qm_pUe55OY0+Nh9OS=ZN5NqFytkB3CaJMTZZOvPqtK7nw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Send again to the list with plain text mode.

---------- Forwarded message ----------
From: Christopher Li <sparse@chrisli.org>
Date: Wed, Aug 6, 2014 at 6:26 PM
Subject: Re: [PATCH 01/10] Add the __restrict__ keyword
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>




On Wednesday, August 6, 2014, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
>
> No, __restrict__ is only applied to various pointer types in the MinGW
> header files (see below). So, I agree that validation/reserved.c is not
> exactly representative of the actual use of __restrict__ (or *any* of the
> keywords come to that), but that does at least provide a minimal test.


Let me clarify. I want to have some regression test cover your usage case.
e.g. If I rewrite some part of sparse and breaks __restrict__ but did not break
__restrict, I will have not way of knowing it. So please submit corresponding
test case.
.
>
> Also, I can't believe that Al did not intend to include __restrict__ in the
> original commit d5c9c2431; well actually he *did* include it in the test, he
> just didn't notice some of the missing implementation! ;-D


__restrict__ does not seem like part of the stander C. BTW, did you try
to use gcc -E to find out if __restrict__ expand to any thing like "__restrict"?
That will determine if __restrict__ is part of a macro or not. If __restrict__
is just a macro, then the implementation will be different from your patch.

> Having said that, I think I see two tests included for the array declaration
> usage: abstract-array-declarator-static.c and restrict-array.c.
>

I don't see it cover the __restrict__ case as far as I can tell.

Also, do you have run into the case that "__restrict__" was use in abstract
array? None of your grep example show usage in the array. Your patch seems
suggest that is possible.

> I have included, below, the output of a grep for __restrict__ in the
> header files, which returned 50 matching lines (note that the one and
> only use of __restrict in the declaration of strtoll which must have
> been a typo!).


Yes, please take one or two example how __restrict__ is typically used.
Merge it into the test case. That is all I am asking.

Chris
