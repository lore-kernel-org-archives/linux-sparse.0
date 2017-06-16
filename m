From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc2
Date: Fri, 16 Jun 2017 21:46:11 +0200
Message-ID: <20170616194608.z677jz3a2ope3ojw@ltop.local>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
 <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
 <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
 <CANeU7Q=4Uu-64ZX+q2=gchz3owTwkGM85Zchi=jHgEFC22EW5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38522 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdFPTqO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:46:14 -0400
Received: by mail-wm0-f44.google.com with SMTP id u195so19465144wmd.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:46:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=4Uu-64ZX+q2=gchz3owTwkGM85Zchi=jHgEFC22EW5A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 16, 2017 at 10:27:44AM -0700, Christopher Li wrote:
> On Thu, Jun 15, 2017 at 1:20 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Please, drop what you have already pulled and take the
> > following instead.
> 
> Here is the feed back for "finer control over error vs. warnings"
> 
> 
> +#define        ERROR_CURR_PHASE        (1 << 0)
> +#define        ERROR_PREV_PHASE        (1 << 1)
> +extern int has_error;
> 
> The current phase vs previous phase define is a bit messy to
> maintain when you advance to next phase. Currently your
> patch does:
> 
> +
> +       if (has_error & ERROR_CURR_PHASE)
> +               has_error = ERROR_PREV_PHASE;
> 
> I purpose each different phase/stage we have a dedicate bits.
> #define PHASE_PARSING (1 << 0)
> #define PHASE_EVALUATE (1<<1)

It's what I did first because it was obvious to do so but then
I changed my mind because I found that theer was no real
advantages and a few complications too.

But I don't really mind, I can change it.

....
> That will be gone. The rest of the patch should be very similar.
> 
> This has the advantage of:
> - The code clearly show which stage it is in.
But what is less clear is in what is that an advantage.
> - No need to move error bits from current phase to previous phase.
Indeed, one assignment less ...
> - more friendly if we have more than two phase.
In fact no, you expose something that don't need to. With the
one-def-per-phase, it's 'easier' to set the new state (but again,
it's just an assignement) but when you need to use what you really
need is 'what what the status in the previous phase(s)', whatever
the previous state was.

But then again, I really don't care.

-- Luc
