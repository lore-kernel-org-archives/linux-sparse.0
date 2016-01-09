From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC 00/13] improve constexpr handling
Date: Sat, 9 Jan 2016 19:25:32 +0100
Message-ID: <20160109182531.GB2718@macpro.local>
References: <87y4i7kdlq.fsf@gmail.com>
 <20150723003757.GA28528@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33810 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbcAISZh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 13:25:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id b14so20421316wmb.1
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 10:25:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150723003757.GA28528@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, viro@ZenIV.linux.org.uk, Josh Tripplet <josh@joshtriplett.org>

On Wed, Jul 22, 2015 at 05:37:57PM -0700, josh@joshtriplett.org wrote:
> [Side note: for some reason, your mail had your message ordered *after*
> your attached diff, so replies quote the diff before the message.]
> 
> On Thu, Jul 23, 2015 at 12:54:25AM +0200, Nicolai Stange wrote:
> > My initial intent was to rework the current integer constant expression
> > handling in order to allow for the recognition of constant subexpressions
> > built up by means of __builtin_choose_expr(). Hence the first part.
> > 
> > However, since I had to touch the whole constant expression handling
> > code anyways, I decided to experimentally extend it to support
> > arithmetic constant expressions and address constants as well. Hence
> > the second part.
> > 
> > Since the additional information on expressions obtained through the
> > first two parts is rather pointless without making any use of it, I
> > implemented part three, the checking of static storage duration
> > objects' initializers for constness.
> > This part is the reason why there is a 'RFC' tag in the subject.
> > It is up to you to decide whether letting sparse check for C99
> > conformity is a valuable thing to have or whether being stricter than
> > GCC is counter-productive/completely idiotic.
> 
> I think it's absolutely a valuable thing to have.  It may or may not be
> the right *default* behavior, but having an appropriate -W option to
> enable it would be a good start.
> 
> I've seen kernel maintainers ask people to not rely on GCC's lax
> enforcement of constant initializers.

I also think it's a very valuable thing to have.
After all, it's the raison d'etre of sparse to make stricter checks
than the standard or GCC.

But then I wonder what's must be done for things like GCC's builtins?
Shouldn't, for example, __builtin_bswap32(..) always propagte the constantness
of it's argument or it specifically this sort of things that are the target of
this patch serie?


Regards,
Luc,
