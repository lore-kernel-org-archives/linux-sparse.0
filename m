From: josh@joshtriplett.org
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Wed, 22 Jul 2015 17:37:57 -0700
Message-ID: <20150723003757.GA28528@cloud>
References: <87y4i7kdlq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57951 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbbGWAiA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 20:38:00 -0400
Content-Disposition: inline
In-Reply-To: <87y4i7kdlq.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, viro@ZenIV.linux.org.uk

[Side note: for some reason, your mail had your message ordered *after*
your attached diff, so replies quote the diff before the message.]

On Thu, Jul 23, 2015 at 12:54:25AM +0200, Nicolai Stange wrote:
> My initial intent was to rework the current integer constant expression
> handling in order to allow for the recognition of constant subexpressions
> built up by means of __builtin_choose_expr(). Hence the first part.
> 
> However, since I had to touch the whole constant expression handling
> code anyways, I decided to experimentally extend it to support
> arithmetic constant expressions and address constants as well. Hence
> the second part.
> 
> Since the additional information on expressions obtained through the
> first two parts is rather pointless without making any use of it, I
> implemented part three, the checking of static storage duration
> objects' initializers for constness.
> This part is the reason why there is a 'RFC' tag in the subject.
> It is up to you to decide whether letting sparse check for C99
> conformity is a valuable thing to have or whether being stricter than
> GCC is counter-productive/completely idiotic.

I think it's absolutely a valuable thing to have.  It may or may not be
the right *default* behavior, but having an appropriate -W option to
enable it would be a good start.

I've seen kernel maintainers ask people to not rely on GCC's lax
enforcement of constant initializers.

> sparse now finds 519 occurences of non-const initializers of static
> storage duration objects, 474 of which are located in drivers/acpi
> and stem from this subsystem's custom offsetof macro implemented by
> means of taking pointer differences.

Ideally, I'd suggest that ACPICA should add a translation from
ACPI_OFFSET to offsetof as part of its Linux-izing scripts.

That said, I also can't think of an obvious reason why ACPI_OFFSET
*should* be considered non-constant.  Perhaps there's a detail in the
C99 spec that explains why what it does isn't OK, but it *seems* like it
should be a compile-time constant expression.  I've CCed Al Viro, who
knows the C99 constant expression rules very well; Al, could you provide
some clarity here?  The ACPI_OFFSET macro in question expands to this:

(acpi_size) (((u8 *) (void *) ((&(((struct some_struct *) 0)->fieldname)))) - ((u8 *) (void *) (((void *) (void *) 0))))

Does the -> make this non-constant?

- Josh Triplett
