From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/5] simplify '(x / 1)' to 'x'
Date: Tue, 7 Feb 2017 15:52:27 +0100
Message-ID: <20170207145226.vnxmuyk3rwbpqcse@macbook.local>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
 <20161207154655.98109-3-luc.vanoostenryck@gmail.com>
 <CANeU7QmSHZf9p+0riTgtMFtSuopkHgmcwG_t1izjwg5sDa1B6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33472 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbdBGOwd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 09:52:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so28675860wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 06:52:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmSHZf9p+0riTgtMFtSuopkHgmcwG_t1izjwg5sDa1B6g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 07, 2017 at 10:53:16AM +0800, Christopher Li wrote:
> On Wed, Dec 7, 2016 at 11:46 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Currently we simplify multiplication by 1 but nothing
> > for the similar divide by 1.
> >
> > --- a/simplify.c
> > +++ b/simplify.c
> > @@ -320,6 +320,10 @@ static int simplify_mul_div(struct instruction *insn, long long value)
> >         case OP_MULU:
> >                 if (value == 0)
> >                         return replace_with_pseudo(insn, insn->src2);
> > +       /* Fall through */
> > +       case OP_DIVS:
> > +       case OP_DIVU:
> > +               break;
> 
> This patch has already applied to sparse-next. Just one minor comment that
> if the fall through is just a break. It is better just break there. If
> the later code
> need to use the fall though, just add the fall through part with the later code.

Mmmh yes. In fact here these 4 lines are not needed at all.
It's most probably leftover of some code restructuration.

Do you want that I send a new version of this patch?

Luc
