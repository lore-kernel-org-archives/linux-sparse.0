From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 03/15] Add type information to struct instruction.
Date: Tue, 23 Dec 2008 07:46:24 +0300
Message-ID: <f19298770812222046l305f1a30ne8fa554d8cb8772e@mail.gmail.com>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
	 <20081215002610.16107.25437.stgit@zaytsev.su>
	 <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:7913 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYLWEq1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 23:46:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so901942fgg.17
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 20:46:25 -0800 (PST)
In-Reply-To: <70318cbf0812221921q5e53a8edhad06369537dc3a6c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, Blue Swirl <blauwirbel@gmail.com>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

On Tue, Dec 23, 2008 at 06:21, Christopher Li <sparse@chrisli.org> wrote:
> I think this patch can have more discussion.
>
> If possible, I would rather no increase the instruction struct size.
> It is a very common structure, which responsible for a large part
> of the byte code memory usage. There is only one person
> (David) can benefit from it so far.
>
> I think what David need is just distinction of int vs pointer.
> We can do that by save an array of the known basic types.
> Including the abstract pointer type. Then we just use an
> index to the array rather than use the raw size directly.
>
Are you sre this is worth the effort (and code complication)? Struct
instruction is not exactly a tiny one, and a pointer would bloat it
by about 10%. On the other hand, I don't really unerstand why
the type information is associated with the instructions, and not
with the pseudos. Am I missing something?

> That have the extra benefit of, different architecture can share
> the same byte code.
Didn't understand this comment.

> Chris
