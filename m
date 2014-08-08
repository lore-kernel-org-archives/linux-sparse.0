From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Fwd: [PATCH 01/10] Add the __restrict__ keyword
Date: Fri, 08 Aug 2014 12:13:24 +0100
Message-ID: <53E4B0D4.4010502@ramsay1.demon.co.uk>
References: <53DFD1D2.5050600@ramsay1.demon.co.uk>	<CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>	<53E24809.5020603@ramsay1.demon.co.uk>	<CANeU7Qm_pUe55OY0+Nh9OS=ZN5NqFytkB3CaJMTZZOvPqtK7nw@mail.gmail.com> <CANeU7Qn-j4G9Ca=Apa6zX=b07Cba=NuViE0zC3NKpispBOHg9Q@mail.gmail.com> <53E3DB3A.5000909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:56465 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752889AbaHHLN2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Aug 2014 07:13:28 -0400
In-Reply-To: <53E3DB3A.5000909@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 07/08/14 21:02, Ramsay Jones wrote:
> On 07/08/14 04:04, Christopher Li wrote:
>>>
>> I don't see it cover the __restrict__ case as far as I can tell.
> 
> Yes, I didn't get that you were talking specifically about __restrict__,
> rather than any one of 'restrict', '__restrict' or '__restrict__'.
> 
>> Also, do you have run into the case that "__restrict__" was use in abstract
>> array? None of your grep example show usage in the array. Your patch seems
>> suggest that is possible.
> 
> They are very rare in the wild! :-D
> 
> The only examples I have come across for real are 'posix_spawn()' (see
> <spawn.h>) and 'regexec()' (<regex.h>).
> 

And once again I didn't get that you were talking specifically about
__restrict__! *blush* (I should learn to read. :-P ) Just for the
record, I don't know of any use of __restrict__ in an abstract array
declaration on _any_ platform.

ATB,
Ramsay Jones


