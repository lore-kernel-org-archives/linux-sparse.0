From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Thu, 23 Jul 2015 11:13:57 +0200
Message-ID: <871tfzi6cq.fsf@gmail.com>
References: <87y4i7kdlq.fsf@gmail.com> <20150723003757.GA28528@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34155 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbGWJOB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Jul 2015 05:14:01 -0400
Received: by wibud3 with SMTP id ud3so14769813wib.1
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2015 02:13:59 -0700 (PDT)
In-Reply-To: <20150723003757.GA28528@cloud> (josh@joshtriplett.org's message
	of "Wed, 22 Jul 2015 17:37:57 -0700")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, viro@ZenIV.linux.org.uk

josh@joshtriplett.org writes:
> [Side note: for some reason, your mail had your message ordered *after*
> your attached diff, so replies quote the diff before the message.]
Yes, I messed it up for some reason. Sorry for that.

>> Since the additional information on expressions obtained through the
>> first two parts is rather pointless without making any use of it, I
>> implemented part three, the checking of static storage duration
>> objects' initializers for constness.
>> This part is the reason why there is a 'RFC' tag in the subject.
>> It is up to you to decide whether letting sparse check for C99
>> conformity is a valuable thing to have or whether being stricter than
>> GCC is counter-productive/completely idiotic.
>
> I think it's absolutely a valuable thing to have.  It may or may not be
> the right *default* behavior, but having an appropriate -W option to
> enable it would be a good start.

My next resend will contain such a -Wcheck-static-initializers then.
However, I will delay that resend in order to be able to incorporate
other reviews arriving in the meantime.


> On Thu, Jul 23, 2015 at 12:54:25AM +0200, Nicolai Stange wrote:
>> sparse now finds 519 occurences of non-const initializers of static
>> storage duration objects, 474 of which are located in drivers/acpi
>> and stem from this subsystem's custom offsetof macro implemented by
>> means of taking pointer differences.
>
> Ideally, I'd suggest that ACPICA should add a translation from
> ACPI_OFFSET to offsetof as part of its Linux-izing scripts.
>
> That said, I also can't think of an obvious reason why ACPI_OFFSET
> *should* be considered non-constant.  Perhaps there's a detail in the
> C99 spec that explains why what it does isn't OK, but it *seems* like it
> should be a compile-time constant expression.  I've CCed Al Viro, who
> knows the C99 constant expression rules very well; Al, could you provide
> some clarity here?  The ACPI_OFFSET macro in question expands to this:
>
> (acpi_size) (((u8 *) (void *) ((&(((struct some_struct *) 0)->fieldname)))) - ((u8 *) (void *) (((void *) (void *) 0))))
>
> Does the -> make this non-constant?

No, it is the pointer difference. At least to my interpretion of C99
[6.6(9)] which might be arguable.
Upon your request, I could relax these constraints as I have did already for
some special cases of conditionals in [11/13].
