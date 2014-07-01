From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Tue, 1 Jul 2014 14:30:35 +0300
Message-ID: <20140701113035.GC19158@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <20140627111900.GA19158@phil.dovecot.net>
 <CANeU7QkVj1gm3wQ6r1=akKX9W1cQvE3Un32CD=1UBecFCaq18Q@mail.gmail.com>
 <20140630085603.GB19158@phil.dovecot.net>
 <CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:43242 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaGAL3z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Jul 2014 07:29:55 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Q=Z=Xac_T3JRAyqo_fF4LAKD-MM41NYz+nDstDutcVUfA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 30, 2014 at 09:44:35AM -0700, Christopher Li wrote:
> On Mon, Jun 30, 2014 at 1:56 AM, Phil Carmody <phil@dovecot.fi> wrote:
> >> Also, if you only care about warning against up cast "~" of
> >> unsigned type, you can do the checking at cast_to().
> >> It will be simpler. I have a sort patch like this, given that I
> >> did not check for the "unsigned int" type, nor do I check for
> >> binary op. You can still get the idea.
> >
> > It needs to check for unsigned-ness in order to trap zero-extension, though.
> 
> That is right, it is not a complete patch. Just to show you some ideas.

With unsigned, it becomes a lot quieter, but still much noiser than my
original. (I have a v3 which excludes an idiom using '/'.)

> > Will report back in the next day or so what the kernel builds say.
> 
> I did some test against your patch.
> BTW, I just submit a patch for the kernel to save sparse warnings.
> Subject line starts with: [PATCH] sparse: Add CLOG ....
> 
> With that patch in kernel. Here is what I did in the testing:
> 
> $ make allmodconfig
> $ make -j8 C=2 CLOG=std
> 
> # apply your patch and make sparse
> 
> $ make -j8 C=2 CLOG=std-exp
> $ find -name ".*.std.sparse" | while read -r file; do diff -du $file
> ${file/std.sparse/std-exp.sparse} ; done > /tmp/signed-diff
> 
> $ grep "dubious zero" /tmp/signed-diff | wc -l
> 
> That give me 565 new warning. I attach the file here.
> 
> I sample some, all the one I saw are false positive.
> e.g.
> 
> static inline int nlmsg_msg_size(int payload)
> {
>     return NLMSG_HDRLEN + payload; <--------warn here
> }
> 
> /**
>  * nlmsg_total_size - length of netlink message including padding
>  * @payload: length of message payload
>  */
> static inline int nlmsg_total_size(int payload)
> {
>     return NLMSG_ALIGN(nlmsg_msg_size(payload));
> }
> 
> #define NLMSG_ALIGNTO    4U

I consider that, pedantically, to be worth fixing. alignments are defined
by the C standard to be of type size_t. It should either be ((size_t)4)
if you care about the precise type, or 4 if you don't, but not 4U. The 
'U' adds nothing apart from a way to create an incorrect mask.

Fixing that line removes ~110 out of the ~120 warnings in my powerpc build.

> #define NLMSG_ALIGN(len) ( ((len)+NLMSG_ALIGNTO-1) & ~(NLMSG_ALIGNTO-1) )
> #define NLMSG_HDRLEN     ((int) NLMSG_ALIGN(sizeof(struct nlmsghdr)))
> <------------ sizeof cast up the type
> #define NLMSG_LENGTH(len) ((len) + NLMSG_HDRLEN)

However, that's a good example of where the casting back down should shut
the warning up.

Thanks for the time you've put into this, Chris. I'll do a bit more 
head-scratching. I get the feeling that the zero-extend should taint the
expression, and that down-casts should clear that taint. The problem with
that is that you need to trap absolutely everywhere whate taint might
escape.

Phil

