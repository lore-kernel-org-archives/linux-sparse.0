From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Wed, 24 Dec 2008 05:39:40 +0300
Message-ID: <f19298770812231839n1aaaf84fla96dda04b11e0944@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
	 <4950A8A2.5090702@knosof.co.uk>
	 <f19298770812230705o2bdd87e2j8446b292dda5f495@mail.gmail.com>
	 <495181C0.7070803@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41208 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYLXCjn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 21:39:43 -0500
Received: by bwz14 with SMTP id 14so10934510bwz.13
        for <linux-sparse@vger.kernel.org>; Tue, 23 Dec 2008 18:39:40 -0800 (PST)
In-Reply-To: <495181C0.7070803@knosof.co.uk>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Wed, Dec 24, 2008 at 03:26, Derek M Jones <derek@knosof.co.uk> wrote:
> Alexey,
>
> I have been looking through the source to look at the contexts
> in which arithmetic is performed on void pointers.
>
>>>  1) Are the arguments really chars of one sort or another and
>>> therefore the parameter ought to be declared as such?
>>
>> You mean, if address arithmetics is performed on a void * cast result,
>> check that the casted type too has sizeof 1?
>
> I was thinking more along the lines of pointer to a character type being
> converted to void * for no obvious reason, or a value being converted to
> void * having an arithmetic operation performed and then converted to
> a pointer to character type.
> For an example see line 156 of arch/x86/kernel/module_64.
>
> I would expect the void * to come from/go to a type that had a
> size greater than 1.
>
>>>  4) Other possible fault issues, people?
>
> I have found an instance (arch/x86/kernel/kprobes.c:834) that
> effectively does:
>
> (void *)long_val + an_int_calculation
>
> when it should have done:
>
> (void *)(long_val + an_int_calculation)
>
> hardly an earth shattering misuse.
There is nothing wrong here. Just depends on the way you think
about it. In the first case you convert a long to a pointer, and add
an int, the the second, you convert the sum. The result is of course
the same. And this has nothing to do with void*, it would be the
same with char*.

So far the only concern with void* is that not everyone knows
the it is sizeof 1. So if you propose repulsing void* with char*
when we don't really need a void*, that's probably fine. But don't
you think there are more useful ways to spend your time?
With open issues like the Global Warming, World Hunger and
standing 2.6.28 regressions, I don't see anyone bothered with
replacing unnecessary void* casts.
