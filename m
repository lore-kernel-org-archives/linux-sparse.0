From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Fwd: [PATCH 01/10] Add the __restrict__ keyword
Date: Thu, 07 Aug 2014 21:02:02 +0100
Message-ID: <53E3DB3A.5000909@ramsay1.demon.co.uk>
References: <53DFD1D2.5050600@ramsay1.demon.co.uk>	<CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>	<53E24809.5020603@ramsay1.demon.co.uk>	<CANeU7Qm_pUe55OY0+Nh9OS=ZN5NqFytkB3CaJMTZZOvPqtK7nw@mail.gmail.com> <CANeU7Qn-j4G9Ca=Apa6zX=b07Cba=NuViE0zC3NKpispBOHg9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:56295 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750874AbaHGUCG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Aug 2014 16:02:06 -0400
In-Reply-To: <CANeU7Qn-j4G9Ca=Apa6zX=b07Cba=NuViE0zC3NKpispBOHg9Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 07/08/14 04:04, Christopher Li wrote:
> Send again to the list with plain text mode.
> 
>> No, __restrict__ is only applied to various pointer types in the MinGW
>> header files (see below). So, I agree that validation/reserved.c is not
>> exactly representative of the actual use of __restrict__ (or *any* of the
>> keywords come to that), but that does at least provide a minimal test.
> 
> 
> Let me clarify. I want to have some regression test cover your usage case.
> e.g. If I rewrite some part of sparse and breaks __restrict__ but did not break
> __restrict, I will have not way of knowing it. So please submit corresponding
> test case.

Yep, version 2 of patch coming soon.

> __restrict__ does not seem like part of the stander C. BTW, did you try
> to use gcc -E to find out if __restrict__ expand to any thing like "__restrict"?

Yes, the header is using the keyword __restrict__. (I have found that headers
tend to use __restrict if they are using macros).

>> Having said that, I think I see two tests included for the array declaration
>> usage: abstract-array-declarator-static.c and restrict-array.c.
>>
> I don't see it cover the __restrict__ case as far as I can tell.

Yes, I didn't get that you were talking specifically about __restrict__,
rather than any one of 'restrict', '__restrict' or '__restrict__'.

> Also, do you have run into the case that "__restrict__" was use in abstract
> array? None of your grep example show usage in the array. Your patch seems
> suggest that is possible.

They are very rare in the wild! :-D

The only examples I have come across for real are 'posix_spawn()' (see
<spawn.h>) and 'regexec()' (<regex.h>).

ATB,
Ramsay Jones


