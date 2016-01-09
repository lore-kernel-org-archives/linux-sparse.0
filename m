From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Sat, 09 Jan 2016 23:05:21 +0100
Message-ID: <87lh7ywgri.fsf@gmail.com>
References: <87y4i7kdlq.fsf@gmail.com> <20150723003757.GA28528@cloud>
	<20160109182531.GB2718@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33970 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051AbcAIWFY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 17:05:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so20872684wmb.1
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 14:05:24 -0800 (PST)
In-Reply-To: <20160109182531.GB2718@macpro.local> (Luc Van Oostenryck's
	message of "Sat, 9 Jan 2016 19:25:32 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, viro@ZenIV.linux.org.uk, Josh Tripplet <josh@joshtriplett.org>

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Wed, Jul 22, 2015 at 05:37:57PM -0700, josh@joshtriplett.org wrote:
>> [Side note: for some reason, your mail had your message ordered *after*
>> your attached diff, so replies quote the diff before the message.]
>> 
>> On Thu, Jul 23, 2015 at 12:54:25AM +0200, Nicolai Stange wrote:
>> > My initial intent was to rework the current integer constant expression
>> > handling in order to allow for the recognition of constant subexpressions
>> > built up by means of __builtin_choose_expr(). Hence the first part.
>> > 
>> > However, since I had to touch the whole constant expression handling
>> > code anyways, I decided to experimentally extend it to support
>> > arithmetic constant expressions and address constants as well. Hence
>> > the second part.
>> > 
>> > Since the additional information on expressions obtained through the
>> > first two parts is rather pointless without making any use of it, I
>> > implemented part three, the checking of static storage duration
>> > objects' initializers for constness.
>> > This part is the reason why there is a 'RFC' tag in the subject.
>> > It is up to you to decide whether letting sparse check for C99
>> > conformity is a valuable thing to have or whether being stricter than
>> > GCC is counter-productive/completely idiotic.
>> 
>> I think it's absolutely a valuable thing to have.  It may or may not be
>> the right *default* behavior, but having an appropriate -W option to
>> enable it would be a good start.
>> 
>> I've seen kernel maintainers ask people to not rely on GCC's lax
>> enforcement of constant initializers.
>
> I also think it's a very valuable thing to have.
> After all, it's the raison d'etre of sparse to make stricter checks
> than the standard or GCC.

First of all, thank you very much for your review, Luc!

>
> But then I wonder what's must be done for things like GCC's builtins?
> Shouldn't, for example, __builtin_bswap32(..) always propagte the constantness
> of it's argument or it specifically this sort of things that are the target of
> this patch serie?

Hmm. I guess it depends on the particular __builtin_*() thingie at hand.
In general, unless explicitly documented, I personally would neither
assume consistent constness rules nor that those are stable across GCC
releases and architectures.

In the case of __builtin_bswap32(..), the kernel seems to follow that line
of reasoning: for example in include/uapi/linux/swab.h, we have

  #define __swab32(x)                             \
          (__builtin_constant_p((__u32)(x)) ?     \
          ___constant_swab32(x) :                 \
          __fswab32(x))

where __fswap32(..) is essentially just a wrapper around
__builtin_bswap32(..).


But of course, if one decides that some __builtin_foo(<constexpr>) is a
constexpr again, we would have to teach it sparse explicitly. AFAICS,
this is nothing new introduced by this patch series though.
