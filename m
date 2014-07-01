From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Tue, 1 Jul 2014 12:42:51 -0700
Message-ID: <CANeU7QnQHzUHwP3imkcX2JX0NrR50rYjjXdObO1D03oHXQ82aA@mail.gmail.com>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
	<1402386847-23477-1-git-send-email-phil@dovecot.fi>
	<20140627111900.GA19158@phil.dovecot.net>
	<CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
	<20140630085603.GB19158@phil.dovecot.net>
	<CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
	<20140701113035.GC19158@phil.dovecot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:54598 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaGATmw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jul 2014 15:42:52 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so8180178qab.31
        for <linux-sparse@vger.kernel.org>; Tue, 01 Jul 2014 12:42:51 -0700 (PDT)
In-Reply-To: <20140701113035.GC19158@phil.dovecot.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 1, 2014 at 4:30 AM, Phil Carmody <phil@dovecot.fi> wrote:
>
> With unsigned, it becomes a lot quieter, but still much noiser than my
> original. (I have a v3 which excludes an idiom using '/'.)
>

Yes, because it cover more than just binary operations.
If you consider zero extend the unsigned type introducing error,
the binary operation just how you use the error bits.

>> #define NLMSG_ALIGNTO    4U
>
> I consider that, pedantically, to be worth fixing. alignments are defined
> by the C standard to be of type size_t. It should either be ((size_t)4)

((size_t)4) is hell ugly.


> if you care about the precise type, or 4 if you don't, but not 4U. The
> 'U' adds nothing apart from a way to create an incorrect mask.

That is debatable. Enforcing 4U vs 4 is annoying and buy you nothing
most of the case.

I don't consider alignment  being 4U as wrong by itself.  The key question
is how you use it.

if we introduce:

#define ALIGNMASK(align)   (size_t)(~((align) -1))

And we always use the macro to create mask from alignment value.
Then there is no need to enforce signedness of the var passed into the
macro. Hey, it might even read better.


Chris
