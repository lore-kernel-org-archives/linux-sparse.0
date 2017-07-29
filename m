From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Sun, 30 Jul 2017 01:38:07 +0200
Message-ID: <20170729233805.lvdhpk5bnyaj5zq6@ltop.local>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
 <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35147 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdG2XiL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 19:38:11 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so47820345wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 16:38:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 09:26:29AM -0400, Christopher Li wrote:
> On Tue, Jul 18, 2017 at 8:07 PM, Christopher Li <sparse@chrisli.org> wrote:
> > ======================
> > test_menu_iteminfo:
> > .L0:
> >         <entry-point>
> >         phisrc.32   %phi3(ansi) <- $1
> >         br          .L1
> >
> > .L1:
> >         phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
> >         cbr         %r1(ansi), .L4, .L5
> >
> > .L4:
> >         cast.64     %r3 <- (64) stringA
> >         br          .L5
> >
> > .L5:
> >         cbr         %r1(ansi), .L6, .L2
> >
> > .L6:
> >         ptrcast.64  %r6 <- (64) %r3
> >         ptrcast.64  %r8 <- (64) VOID
> >         call.64     %r9 <- strcpy, %r6, %r8
> >         br          .L2   <=============== L2 merge with L7
> >
> > .L2:
> >         seteq.32    %r11 <- %r1(ansi), $0
> >         phisrc.32   %phi4(ansi) <- %r11
> >         cbr         %r1(ansi), .L1, .L3
> >
> > .L3:
> >         ret
> > ======================
> > test_menu_iteminfo:
> > .L0:
> >         <entry-point>
> >         br          .L4 <========= phisrc3 get optimize away. This seems wrong
> 
> I see more what is going on there now.
> Basically we have %phi3 = 1, a constant.
> There for when control flow go from L0->L1, %r1 = %phi3 = 1.
> It will go to L4 for sure.
> 
> So L0 modify to goto L4 directly. That is fine.

My first analysis was wrong, the real problem is closer from here.

As far as I can currently see, the problem is related to the fact that:
- the joint was at L1 (who had 2 parents: L0 & L2)
- L4 wasn't a joint (the only parent was L1)
but after the first call to try_to_simplify_bb() it's not true anymore:
- L1 is not a trivial joint, this is fine
- L4 become a *real* joint (it can receive %r1 value from L1 or
  implicitely from L0). This is still fine for L4 but not anymore
  for its successor L5.
One way to see the problem is that the fix 852801f8b is not enough.
My first guess would be that the simplification made by try_to_simplify_bb()
is valid only if the controlling pseudo is local to the current BB.

Still looking at this.

-- Luc
