From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Wed, 05 Aug 2015 09:24:39 +0200
Message-ID: <878u9qci4o.fsf@gmail.com>
References: <87y4i7kdlq.fsf@gmail.com> <20150723003757.GA28528@cloud>
	<871tfzi6cq.fsf@gmail.com> <20150723184723.GA1605@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33162 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbHEHYo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Aug 2015 03:24:44 -0400
Received: by wijp15 with SMTP id p15so35814105wij.0
        for <linux-sparse@vger.kernel.org>; Wed, 05 Aug 2015 00:24:43 -0700 (PDT)
In-Reply-To: <20150723184723.GA1605@cloud> (josh@joshtriplett.org's message of
	"Thu, 23 Jul 2015 11:47:23 -0700")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, viro@ZenIV.linux.org.uk, josh@joshtriplett.org

josh@joshtriplett.org writes:
> On Thu, Jul 23, 2015 at 11:13:57AM +0200, Nicolai Stange wrote:
>> josh@joshtriplett.org writes:
>> >> Since the additional information on expressions obtained through the
>> >> first two parts is rather pointless without making any use of it, I
>> >> implemented part three, the checking of static storage duration
>> >> objects' initializers for constness.
>> >> This part is the reason why there is a 'RFC' tag in the subject.
>> >> It is up to you to decide whether letting sparse check for C99
>> >> conformity is a valuable thing to have or whether being stricter than
>> >> GCC is counter-productive/completely idiotic.
>> >
>> > I think it's absolutely a valuable thing to have.  It may or may not be
>> > the right *default* behavior, but having an appropriate -W option to
>> > enable it would be a good start.
>> 
>> My next resend will contain such a -Wcheck-static-initializers then.
>
> <bikeshed>Shouldn't it be something like -Wnon-constant-initializer,
> since that's what it checks for?</bikeshed>
>
>> However, I will delay that resend in order to be able to incorporate
>> other reviews arriving in the meantime.
>
> Sounds reasonable.
>
>> > On Thu, Jul 23, 2015 at 12:54:25AM +0200, Nicolai Stange wrote:
>> >> sparse now finds 519 occurences of non-const initializers of static
>> >> storage duration objects, 474 of which are located in drivers/acpi
>> >> and stem from this subsystem's custom offsetof macro implemented by
>> >> means of taking pointer differences.
>> >
>> > Ideally, I'd suggest that ACPICA should add a translation from
>> > ACPI_OFFSET to offsetof as part of its Linux-izing scripts.
>> >
>> > That said, I also can't think of an obvious reason why ACPI_OFFSET
>> > *should* be considered non-constant.  Perhaps there's a detail in the
>> > C99 spec that explains why what it does isn't OK, but it *seems* like it
>> > should be a compile-time constant expression.  I've CCed Al Viro, who
>> > knows the C99 constant expression rules very well; Al, could you provide
>> > some clarity here?  The ACPI_OFFSET macro in question expands to this:
>> >
>> > (acpi_size) (((u8 *) (void *) ((&(((struct some_struct *) 0)->fieldname)))) - ((u8 *) (void *) (((void *) (void *) 0))))
>> >
>> > Does the -> make this non-constant?
>> 
>> No, it is the pointer difference. At least to my interpretion of C99
>> [6.6(9)] which might be arguable.
>> Upon your request, I could relax these constraints as I have did already for
>> some special cases of conditionals in [11/13].
>
> Ah, I see.  I don't know whether relaxing that makes sense or not; Al?

Just a friendly ping to get some more reviews to consider in my next
resend, especially on [13/13] and whether to relax the constant
expression rules to treat pointer differences of address constants as
(arithmetic or integer) constant expressions.
