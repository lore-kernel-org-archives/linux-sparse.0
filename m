From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: Nasal demons in preprocessor use (Re: [PATCH] test-suite: new
	preprocessor test case)
Date: Sat, 21 Mar 2009 00:16:17 +0100
Message-ID: <19f34abd0903201616v4175b5afn5630fcae02d7ff4f@mail.gmail.com>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
	 <20090319182628.GB28946@ZenIV.linux.org.uk>
	 <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com>
	 <20090319190730.GC28946@ZenIV.linux.org.uk>
	 <20090319192758.GB24318@elte.hu>
	 <19f34abd0903191320qdd73530ud85081d23e17b266@mail.gmail.com>
	 <20090320180853.GA24154@elte.hu>
	 <20090320190409.GH28946@ZenIV.linux.org.uk>
	 <20090320191407.GI28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:34073 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761554AbZCTXQU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Mar 2009 19:16:20 -0400
In-Reply-To: <20090320191407.GI28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Hannes Eder <hannes@hanneseder.net>, linux-kernel@vger.kernel.org

[removed duplicate Al Viro from Cc]

2009/3/20 Al Viro <viro@zeniv.linux.org.uk>:
> On Fri, Mar 20, 2009 at 07:04:09PM +0000, Al Viro wrote:
>> On Fri, Mar 20, 2009 at 07:08:53PM +0100, Ingo Molnar wrote:
>> >
>> > * Vegard Nossum <vegard.nossum@gmail.com> wrote:
>> >
>> > > I guess this means that kmemcheck branch should be withdrawn from
>> > > linux-next, at least temporarily, as I have no immediate
>> > > workarounds/alternatives. Stephen, can you drop it?
>> >
>> > Al Viro, well done :-(

[snip]

> Ingo, care to explain what the hell had your reply above been about?
> Especially since we both apparently agree that code in question did
> need fixing, what with your immediate ACK upthread...
>

Hi,

I think it is simply the frustration of discovering this rather
serious flaw just when the dust has settled, and with no capacity to
really fix it in a satisfactory way. But we should be thankful for the
heads up and try again to remember the value of linux-next and those
who test it!

(The solution you sketched is still quite an uglification of the
original code, something we tried to minimize using the construct you
saw.)

So, Ingo: There's no way this could have been merged in mainline with
such a defect, and it would be a lot worse if it wasn't discovered at
this point. We'll just have to be creative (again!) and I'm sure
Stephen can revive the tree when it's been fixed.


Vegard
