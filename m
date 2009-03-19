From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: Nasal demons in preprocessor use (Re: [PATCH] test-suite: new
	preprocessor test case)
Date: Thu, 19 Mar 2009 21:20:51 +0100
Message-ID: <19f34abd0903191320qdd73530ud85081d23e17b266@mail.gmail.com>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
	 <20090319182628.GB28946@ZenIV.linux.org.uk>
	 <154e089b0903191151q37ab7b20o43838845af12966f@mail.gmail.com>
	 <20090319190730.GC28946@ZenIV.linux.org.uk>
	 <20090319192758.GB24318@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49634 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbZCSUUz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 16:20:55 -0400
In-Reply-To: <20090319192758.GB24318@elte.hu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Hannes Eder <hannes@hanneseder.net>, linux-kernel@vger.kernel.org

2009/3/19 Ingo Molnar <mingo@elte.hu>:
>
> * Al Viro <viro@ZenIV.linux.org.uk> wrote:
>
>> On Thu, Mar 19, 2009 at 07:51:22PM +0100, Hannes Eder wrote:
>> > When currently running sparse agains the current linux-next tree, =
a
>> > lot of checks produce error messages like this:
>> >
>> > include/linux/skbuff.h:381:9: error: expected preprocessor identif=
ier
>>
>> Cute. =C2=A0If anything, this kmemcheck_define_bitfield stuff needs =
to be moved
>> inside the ifdefs.
>>
>> Folks, this is not a valid C, period. =C2=A0And no, there's no promi=
se
>> that gcc won't change its behaviour on such constructs whenever
>> they feel like that.
>>
>> Preprocessor directives do not belong in argument lists. =C2=A0Not
>> #ifdef, not #define, not #include; this is undefined behaviour.
>
> Agreed.
>
> Vegard, it's this bit:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kmemcheck_define_bitfield(flags2, {
> #ifdef CONFIG_IPV6_NDISC_NODETYPE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ndisc_nodety=
pe:2;
> #endif
> #if defined(CONFIG_MAC80211) || defined(CONFIG_MAC80211_MODULE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_not_encry=
pt:1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0requeue:1;
> #endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0});
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Ingo
>

Hm.

Is this really not valid C?

It worked with GCC, so I assumed it was. My mistake.

Okay, that puts us in a bit of a tight spot, with regards to kmemcheck,=
 I mean.

Maybe I should just take up GCC development instead, and implement a
-fkmemcheck or something.

(To get rid of the bitfield false positives, I mean.)

I guess this means that kmemcheck branch should be withdrawn from
linux-next, at least temporarily, as I have no immediate
workarounds/alternatives. Stephen, can you drop it?


Vegard

--=20
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
