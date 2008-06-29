From: Tommy Thorn <tommy@numba-tu.com>
Subject: Re: Pointer arithmetic error
Date: Sat, 28 Jun 2008 17:38:36 -0700
Message-ID: <4866D98C.3070604@numba-tu.com>
References: <486428D7.8080603@cowlark.com>	 <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>	 <48643191.307@cowlark.com> <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com>	 <1214565644.20755.80.camel@tara.firmix.at>	 <4864F31C.3090606@cowlark.com>	 <1214577926.20755.98.camel@tara.firmix.at>	 <48650B35.5040505@cowlark.com> <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com> <486578A9.7000900@cowlark.com> <48658B28.6010301@numba-tu.com> <4866D79A.4000402@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server204.webhostingpad.com ([69.65.0.218]:58793 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682AbYF2Aij (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2008 20:38:39 -0400
In-Reply-To: <4866D79A.4000402@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

David Given wrote:
> sparse is working rather well, and seems to be one of the better
> compiler front ends that I've found. The linearising support is
> particularly helpful. I have, however, been finding that the learning
> curve is rather steep --- the API shows a lot of signs of having grown
> organically over time --- and I've had to build big chunks of code that
> I'm sure are unnecessary. For example, in order to generate the right
> kind of code, I need to figure out whether a pseudo contains an integer,
> float or pointer. The only way I've found out to do this is to
> recursively follow the chain of pseudo->def pointers until I find an
> instruction with enough type information attached to it to figure it
> out. I'm sure there must be an easier way of doing this...
>
> (BTW, given a function symbol, how do I find its return type? I can find
> the list of arguments, but there's nothing in struct symbol that seems
> to refer to the return value...)
>
> I am intending to release my project once done, of course, and I hope
> people will find it useful, but I'm not sure how much general use it
> will be; I've basically ripped out and replaced the register allocator /
> storage mechanism from my back end as I didn't understand it and didn't
> need the complexity. That should probably all get rewritten properly at
> some stage, but right now I'm focusing on getting things working...
>   

What I had in mind would not even perform register allocation or any 
attempt at optimization. Such only obscures how to use sparse as a compiler.

Cheers,
Tommy

