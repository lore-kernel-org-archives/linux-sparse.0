From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [SPARSE PATCH] univ-init: conditionally accept { 0 } without
 warnings
Date: Wed, 20 May 2020 23:03:27 +0100
Message-ID: <0e81e382-5dde-6029-35d7-0de72e5a0a99@ramsayjones.plus.com>
References: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
 <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
 <20200520204001.2nkuowfeftp7uhpl@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout01.plus.net ([84.93.230.227]:60374 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgETWDd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 18:03:33 -0400
In-Reply-To: <20200520204001.2nkuowfeftp7uhpl@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>



On 20/05/2020 21:40, Luc Van Oostenryck wrote:
> On Wed, May 20, 2020 at 01:22:22AM +0100, Ramsay Jones wrote:
[snip]

>>
>> I remember the discussion (on lkml and sparse ml) in which
>> there was general agreement that '{}' would be preferred
>> solution (if only it was standard C!). However, I thought
>> that (since some compilers don't support it e.g. msvc) the
>> next best solution would be for sparse to suppress the
>> warning if given the '= { 0 }' token sequence. (ie. no mention
>> of it being conditional on a option).
> 
> Yes, I kinda agree but concerning the kernel, my understanding is
> that the warning is desired (cfr. https://marc.info/?t=154704602900003 ) 

Oh, my lord, I had no recollection of that thread - and it was
only just over a year ago! ;-P

Hmm, yes it's a shame, but I guess the kernel usage takes precedence.

> For example, for cases like:
> 	int *array[16] = { 0 };
> 
> So, I want to keep the current behavior as the default.
> 
>>> @@ -2750,6 +2750,13 @@ static struct token *initializer_list(struct expression_list **list, struct toke
>>>  {
>>>  	struct expression *expr;
>>>  
>>> +	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
>>> +	// warnings about using '0' to initialize a null-pointer.
>>> +	if (!Wuniversal_initializer) {
>>> +		if (match_token_zero(token) && match_op(token->next, '}'))
>>> +			token = token->next;
>>> +	}
>>> +
>>
>> Ha! This made me LOL! (see my patch below).
>>
>> So simple. (I did think, at first, that deleting the '0' token was
>> not a good idea - then I realized that it's more like skipping/ignoring
>> the token than deleting it.)
> 
> Well ... I'm lazy, so ... and it gave me the garantee that it will
> behave exactly like '{ }'.
> 
>> The patch below was (I think) my third attempt. If memory serves
>> me, the first patch attempted to determine the '{0}' initializer
>> from the 'struct expession *' passed to bad_null() alone. However,
>> that did not allow me to distinguish '= { 0 }' from '= { 0, }',
>> so I needed to backup from evaluation to the parse.
> 
> I think it's fine to allow the comma, I probably need to change
> this is my version.

No, No, that would definitely be wrong. In fact, I would go further
and say _only_ '= { 0 } ;' should suppress the warning (yes I added
the semi-colon). (I did think that maybe other forms of 'integer
constant with value zero' could be added; e.g. 0x0, but I am not
sure even that is useful).

['designated initializers' would also not work to suppress the
warnings, of course!]

BTW, I was not entirely convinced by the git-list discussion which
lead to this patch. However, limiting the suppression of the warning
to _just_ '= { 0 } ;' would leave the majority of use-cases issuing
the warning anyway. The main benefit would be, as argued by others,
that when you switch the order/type of fields in a struct (say) that
you would not have to change the initializer from/to {0}/{NULL}.
(Again, I don't see that as a huge advantage ...)

>> Also, I didn't test the initialization of embedded struct/array fields
>> (and what should happen anyway? should '{ 0 }' also work for initializing
>> the sub-structure(s), or should it only work at the top-level?).

And so, given the above, I don't think the warnings should be suppressed
on sub-structures.

> In fact, it works for literally anything: simple arrays, multi-dimensional
> arrays (it must be because the braces doesn't need to match:
> 	int a[2][2] = { 1, 2, 3, 4 };

Heh, yes indeed.

> is perfectly legal), structures with a scalar as first member, more complex
> strutures, sub-structures, and more suprisingly even for simple types:
> 	int a = { 0 };
> 	_Bool b = { 0 };
> 	double f = { 0 };
> 	int *ptr = { 0 };

Ah, yes, I wonder if that would be a problem. ;-)
My initial reaction would be that non-aggregate types would still
issue warnings (even with ={0};), but that starts getting harder
to do ... :(

I don't have any simple answers.

ATB,
Ramsay Jones
