From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking
 pre-process.c
Date: Mon, 31 Jul 2017 17:21:49 +0100
Message-ID: <3cc11c1f-380a-cfb6-3192-b91ebd09d14c@ramsayjones.plus.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
 <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
 <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
 <98295bf9-09e7-84ca-382b-3f479ed2e0f9@ramsayjones.plus.com>
 <6545856e-5cb3-aad0-af87-bea7c0ccafd7@ramsayjones.plus.com>
 <CANeU7QmDjsviVwSU-WDNGc=tF4V8nObs4-Ao0C29B2nPvsZS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:43810 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdGaQVw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 12:21:52 -0400
In-Reply-To: <CANeU7QmDjsviVwSU-WDNGc=tF4V8nObs4-Ao0C29B2nPvsZS-w@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 31/07/17 16:51, Christopher Li wrote:
> On Mon, Jul 31, 2017 at 11:29 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>>>> Ah, I see what you mean here. You want to distinguish
>>>> CFLAGS for gcc, CHECKER_FLAGS for sparse specific
>>>> flags.
>>>
>>> Err, ... well, yes and no! :-D
>>>
>>> The main idea is to separate the 'additional' flags passed to
>>> sparse for the $(CHECKER) target - not necessarily for sparse
>>> specific flags.
> 
> Yes, my mental model was CHECKER_FLAGS for flags sparse
> to use. I haven't notice the small detail that -Wvla works for gcc
> as well.
> 
>> Hmm, actually the following may be a better patch. what do you
>> think?
> 
> Hmm. When I write the BASIC_CFLAGS, I was thinking to use it for the
> common part of the CFLAGS impact the whole directory or project. Some
> thing as base line, like architecture related stuff etc, nothing fancy.

I thought of it more as a non-override-able list of cflags, which
are required for 'correct'/'desired' behaviour. The CFLAGS are
supposed to be user settable from the command line. So, for example,
if you wanted to compile c2xml and override the CFLAGS, then you must
know to add the output of '$(PKG_CONFIG) --cflags libxml-2.0' manually.

> Each C file might have specific different requirement, like include path etc,
> Those goes to CFLAGS. The stuff get overwrite more often should have
> a slightly shorter name for readability.

Hmm, but see above!

> At least that was my mental model. Either one of the three we discuss here
> is acceptable. If you have to ask me to pick, my order goes to the simplest
> one line change, then introducing $(CHECKER_CFLAGS), then this one.

I'm OK with any of the three too, but I actually think the last
patch is the best. ;-)

ATB,
Ramsay Jones


