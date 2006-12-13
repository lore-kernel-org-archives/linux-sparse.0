From: Christopher Li <sparse@chrisli.org>
Subject: Re: basic block output order?
Date: Tue, 12 Dec 2006 17:15:49 -0800
Message-ID: <20061213011549.GA12570@chrisli.org>
References: <20061212102422.GA6013@chrisli.org> <Pine.LNX.4.64.0612120824420.6452@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:36065 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964879AbWLMBka (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 20:40:30 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612120824420.6452@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

Thanks for your explain. I see, you want to generate the dominator
first.

Chris

On Tue, Dec 12, 2006 at 08:36:43AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 12 Dec 2006, Christopher Li wrote:
> 
> They don't have to. But it generated nicer code, iirc, mainly because it 
> did the storage allocation the natural way. In particular, if I recall 
> correctly, it causes loops to have the storage for the _innermost_ loop to 
> be done first.
> 
> Notes off the top of my head, without actually looking at the code: 
> because when you hit a loop, the "parent" set is actually both the entry 
> and the BB that ha the loopback, so you actually end up going to the 
> loopback thing, which goes to _its_ parents, etc etc, until you actually 
> get back to the _top_ of the loop (and now the "generation" count triggers 
> you to break the looping), so you end up doing the actual register 
> allocation at tops of loops, but because you do this all recursively, and 
> the inner loop will have _its_ parents point to the callback too, you 
> generally tend to have started storage allocation at loop-tops.
> 
> HOWEVER. There's a reason the thing is called "example.c". The reason is 
> simply that it's stupid, idiotic, and not meant to be taken seriously. I 
> also ended up just hackign things around randomly to make it output 
> something that looked half-way sane, _and_ I ended up changign it to use 
> the "unssa" pass by Luc, _and_ I'm border-line psychotic when it comes to 
> compilers anyway.
> 
> In other words, what I'm trying to say is that you shouldn't take anything 
> I say too seriously, and that the "example.c" code wasn't really even 
> meant to be serious. I always wanted somebody else to write the back-end, 
> and held back as long as I could from writing example.c, and when I wrote 
> it, it was more a case of desperately trying to find somebody interested 
> in it, and having it as an example of how things _might_ work.
> 
> So as far as I am concerned, the whole "example.c" is just total 
> throw-away code. Go wild with it.
> 
> 		Linus
