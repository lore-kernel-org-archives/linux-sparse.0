From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Mon, 22 Dec 2008 21:38:05 -0800
Message-ID: <70318cbf0812222138v3c62cd97u11690694655bec72@mail.gmail.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
	 <20081215002610.16107.25437.stgit@zaytsev.su>
	 <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
	 <f19298770812222046l305f1a30ne8fa554d8cb8772e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:62643 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYLWFiG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 00:38:06 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2234312rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 21:38:05 -0800 (PST)
In-Reply-To: <f19298770812222046l305f1a30ne8fa554d8cb8772e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, Blue Swirl <blauwirbel@gmail.com>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

On Mon, Dec 22, 2008 at 8:46 PM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Are you sre this is worth the effort (and code complication)? Struct
> instruction is not exactly a tiny one, and a pointer would bloat it
> by about 10%. On the other hand, I don't really unerstand why

That complexity is needed for the back end to generated C
code any way. Currently, if you save the full C type into instruction.
The back end needs to look into the C type and determinate which
native machine type it should use.

While if you do that up front, the back end side will have a simple
1 to 1 mapping. It will make David's back end code simpler.

On my machine(64 bit). It jump from 56 to 64.  That is 14%.

> the type information is associated with the instructions, and not
> with the pseudos. Am I missing something?

If you have it in the pseudos, the instruction size will depend on
the type of the instruction. There is no universal pseudo member
can be access for all the instruction types. One instruction
can have more than one pseudo, so you are likely to increase the
over all size.

>> That have the extra benefit of, different architecture can share
>> the same byte code.
> Didn't understand this comment.

I am thinking that, if you dump the byte code into file. Then
different back end will need to have different byte code binary,
because difference in the basic type size.

I just realized that because we store the sizeof operation into
binary values, so they are going to have different binary any way.
So this does not matter.

Chris
