From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: pre-process.c:569:18: error: bad constant expression
Date: Sat, 31 Dec 2005 13:19:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512311314000.3249@g5.osdl.org>
References: <20051231073006.GA3583@localhost> <Pine.LNX.4.64.0512311122400.3249@g5.osdl.org>
 <Pine.LNX.4.64.0512311140290.3249@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVLaVTZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 16:19:25 -0500
In-Reply-To: <Pine.LNX.4.64.0512311140290.3249@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alecs King <alecsk@gmail.com>
Cc: linux-sparse <linux-sparse@vger.kernel.org>



On Sat, 31 Dec 2005, Linus Torvalds wrote:
> 
> Just in case somebody cares, a partial list of the problems I know 
> about with variable-sized arrays as far as current sparse is concerned:
> 
>  - sparse just generates a list of symbols per block (and per function). 

Ok, I fixed this one. Instead of having just a list of symbols per block, 
declarations are not a special kind of statement in the block. It wasn't 
even that hard to do, although the amount of testing my change-over has 
gotten is pretty minimal.

So sparse now gets

	int test(int arg)
	{
		int a = arg;
		arg++;
		int b = arg;
		return a+b;
	}

right, which it didn't use to do (it would end up rewriting the above as

	symbol_list: a = arg; b = arg;

	statement_list: arg++;
			return a+b;

and thus return "arg+arg" rather than "arg+arg+1".

It still warns about mixing code and declarations, and there are still 
other issues that keep it from handling variable-sized arrays, but I think 
this was the main "conceptual" difficulty in sparse to handling some of 
it.

		Linus
