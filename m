From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Tue, 23 Dec 2008 18:05:53 +0300
Message-ID: <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
	 <4950A8A2.5090702@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:52385 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbYLWPFz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 10:05:55 -0500
Received: by bwz14 with SMTP id 14so9961898bwz.13
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2008 07:05:53 -0800 (PST)
In-Reply-To: <4950A8A2.5090702@knosof.co.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Tue, Dec 23, 2008 at 12:00, Derek M Jones <derek@knosof.co.uk> wrote:
> Alexey,
>
>>> In the Linux kernel, we've got lots of void * address arithmetics:
>>> linux/linux-2.6$ make -j 8 CC='gcc -Wpointer-arith' 2>&1 | grep
>>> 'warning: pointer of type \'void \*\' used in arithmetic' | uniq | wc
>>> -l
>>> 45095
>>
>> I screwed up, it should be | sort -u | uniq | wc -l
>> But it's still 14488.
>
> This is a sufficiently large number that we ought to consider adding
> checks for the usage, for instance:
>
>   1) Are the arguments really chars of one sort or another and
> therefore the parameter ought to be declared as such?
You mean, if address arithmetics is performed on a void * cast result,
check that the casted type too has sizeof 1?


>   2) The arguments have various structure and/or array types and
> the storage is being walked over in the called function.  Can the
> minimum size ever passed be worked out and this information used in
> the size_void (my proposed name for a pointer that has either sizeof,
> ++ or -- performed on it) function to check for overruns.

This won't be possible without dataflow analysis, and sparse currently
can't do any. This may change in the future, but if so, we will be able to
check for many types of overruns, not only void *.

>
>   3) Are there any restrictions on passing a void pointer to a
> size_void function or vice versa?  I cannot think of any obvious
> ones, but then I don't know the various kinds of circumstances
> in which this happens.
>
>   4) Other possible fault issues, people?
