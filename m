From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: basic block output order?
Date: Tue, 12 Dec 2006 17:44:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121740420.3535@woody.osdl.org>
References: <20061212102422.GA6013@chrisli.org> <Pine.LNX.4.64.0612120824420.6452@woody.osdl.org>
 <20061213011549.GA12570@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:40432 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964879AbWLMCEa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 21:04:30 -0500
In-Reply-To: <20061213011549.GA12570@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org



On Tue, 12 Dec 2006, Christopher Li wrote:
>
> Thanks for your explain. I see, you want to generate the dominator
> first.

Basically, yes. That way, when we start generating code in any basic 
block, we usually either (a) have the outputs from the dominators or (b) 
we're the top block in a loop and any freedom we can use to pick our 
preferred registers is probably a good thing.

The current "example.c" was very much written with the intent that it 
would not ever do any _smart_ register allocation, but just allocate 
registers on-the-fly. But doing that requires that you set things up so 
that the stupid approach can still get reasonable results.

The way the death-notes work etc was all designed exactly so that the 
register "allocator" never really needed any global visibility at all, it 
could just work on an instruction-per-instruction basis.

That said, the simplicity of it all in example.c still doesn't mean that 
it _works_. It really doesn't, and isn't even really close. But it 
occasionally results in code that looks _almost_ like it could be run ;)

		Linus
