From: Jeff Layton <jeff.layton@primarydata.com>
Subject: Re: [sparse PATCH RFC] Revert "Revert "sparse: Bump up
 sizeof(_Bool) to 8 bits""
Date: Wed, 16 Jul 2014 12:24:55 -0400
Message-ID: <20140716122455.33df512f@tlielax.poochiereds.net>
References: <1405439200-27515-1-git-send-email-jlayton@primarydata.com>
	<CANeU7QnRHvOQHHE2EEWNSUEwFRv66gmHfNXmgZxN+_J7=iPbHg@mail.gmail.com>
	<20140715222350.028a7bf6@f20.localdomain>
	<CANeU7QngLBOJ-uMV0DFY6sqyi=SbTGJZ6TNZZYnY1jsVsUf12w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:58722 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347AbaGPQY5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 Jul 2014 12:24:57 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so876212qaq.39
        for <linux-sparse@vger.kernel.org>; Wed, 16 Jul 2014 09:24:57 -0700 (PDT)
In-Reply-To: <CANeU7QngLBOJ-uMV0DFY6sqyi=SbTGJZ6TNZZYnY1jsVsUf12w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Layton <jeff.layton@primarydata.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>

On Tue, 15 Jul 2014 20:21:40 -0700
Christopher Li <sparse@chrisli.org> wrote:

> On Tue, Jul 15, 2014 at 7:23 PM, Jeff Layton
> <jeff.layton@primarydata.com> wrote:
> > On Tue, 15 Jul 2014 12:51:02 -0700
> >> --- a/target.h
> >> +++ b/target.h
> >> @@ -49,7 +49,7 @@ extern int enum_alignment;
> >>
> >>  static inline int bits_to_bytes(int bits)
> >>  {
> >> -       return bits >= 0 ? bits / bits_in_char : -1;
> >> +       return bits >= 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
> >>  }
> >>
> >
> > This makes the bitfield.c validation test fail:
> >
> >      TEST     bitfield to integer promotion (bitfields.c)
> > error: actual error text does not match expected error text.
> > error: see bitfields.c.error.* for further investigation.
> > --- bitfields.c.error.expected  2014-07-15 22:01:09.236942195 -0400
> > +++ bitfields.c.error.got       2014-07-15 22:01:09.237942176 -0400
> > @@ -0,0 +1,2 @@
> > +bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)
> > +bitfields.c:16:19: warning: invalid access past the end of 'y' (0 1)
> >
> > Though I haven't looked in detail yet as to why it's failing.
> 
> Let me take a look and get back to you. I recall there are one more
> place in array handling need to use  bits_to_bytes() instead of reference
> the bit size directly.
> 
> Chris

Thanks, I think I might have found it. init_ctype tries to correct for
the fact that bits_to_bytes rounds up instead of down. With the
corrected function, we don't need that correction anymore.

I'll send the v2 patch soon, which seems to do the right thing.

Thanks!
-- 
Jeff Layton <jlayton@primarydata.com>
