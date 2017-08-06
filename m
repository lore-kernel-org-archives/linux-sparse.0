From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 20:31:20 +0200
Message-ID: <20170806183119.jteslrnhflpsr7bg@ltop.local>
References: <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local>
 <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <CAMHZB6FH7431uaYzuQN4jxhwMSYHLXjrVkUs4xuwsvUsAgkDBQ@mail.gmail.com>
 <CACXZuxcQEnZopJEcvRTAEpU=giRfykLP_rZLkqdRZ=hFJBpVAA@mail.gmail.com>
 <CAMHZB6Eq2D9NhZ_xiq1PZ_vioodQWVU85CnPvwg5fwwU+nZW=Q@mail.gmail.com>
 <CACXZuxfyC1KPVviEGCJkFmt9MQ-C8LT73kxNPk2kPy-QAooRTg@mail.gmail.com>
 <CAMHZB6FotFBkEcx2_RDRX4OmNYzE9arh8gtreFYAsc2v21HHRw@mail.gmail.com>
 <CACXZuxdy5MhVsLuWjghfEfxUbG2ZL5jER_Fbrg8Fp7OzHuX94Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34348 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdHFSbX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 14:31:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id t138so22046062wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 11:31:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdy5MhVsLuWjghfEfxUbG2ZL5jER_Fbrg8Fp7OzHuX94Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 07:18:20PM +0100, Dibyendu Majumdar wrote:
> On 6 August 2017 at 19:15, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sun, Aug 6, 2017 at 7:58 PM, Dibyendu Majumdar
> > <mobile@majumdar.org.uk> wrote:
> >> On 6 August 2017 at 18:45, Luc Van Oostenryck
> >> <luc.vanoostenryck@gmail.com> wrote:
> >>> On Sun, Aug 6, 2017 at 7:04 PM, Dibyendu Majumdar
> >>> <mobile@majumdar.org.uk> wrote:
> >>>> Wouldn't have thought so - as the variable is not initialized at the
> >>>> point of declaration. The assignment occurs after declaring the struct
> >>>> variable s3.
> >>>
> >>> IIRC, this patch was written specifically for the case you reported here.
> >>>
> >>>> I haven't tried that patch though.
> >>>
> >>> You'll need the full series:
> >>> https://github.com/lucvoo/sparse/tree/fix-bitfield-init-v3
> >>>
> >>
> >> I will have a look at it. I did report separately the issue of not
> >> zeroing out structs when they are initialized and the change you
> >> mentioned earlier looks more for addressing that issue.
> >
> > Indeed.
> > I mixed up both (or more exactly, I thought it solved both).
> >
> 
> The tests in your tree all are for initialization scenario - are you
> sure you fixed the issue mentioned in this thread? I will check later
> tonight and report back.

No no.
By "Indeed, I mixed up both" I meant that you're right and that this patch
doesn't solve your issue here.

The issue here is a problem of (partially)-uninitialized var (only
s3.onebit is initialized but the whole s3 is first read) coupled
by some missing simplification of masking operation.
When using a version that handle more correctly uninitialized vars,
we get the following:
	foo:
	.L0:
		<entry-point>
		and.32      %r2 <- UNDEF, $-65
		or.32       %r3 <- %r2, $64
		lsr.32      %r4 <- %r3, $6
		cast.1      %r5 <- (32) %r4
		cast.32     %r6 <- (1) %r5
		setne.32    %r7 <- %r6, $1
		ret.32      %r7 

The UNDEF is for the load of s3 and the masking should get rid of it
but doesn't (yet).

-- Luc
