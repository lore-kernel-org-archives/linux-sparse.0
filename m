From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 21:43:20 +0100
Message-ID: <20170127204319.agxtocpiblrcmrbj@macpro.local>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
 <20170127190716.e7ux5guhg7sbomar@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35601 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdA0Wfy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 17:35:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id r126so136980510wmr.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 14:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170127190716.e7ux5guhg7sbomar@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, Jan 27, 2017 at 08:07:17PM +0100, Luc Van Oostenryck wrote:
> On Fri, Jan 27, 2017 at 06:18:07PM +0000, Dibyendu Majumdar wrote:
> > H Luc,
> > 
> > On 27 January 2017 at 17:11, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> > > On 27 January 2017 at 15:59, Van Oostenryck Luc
> > > <luc.vanoostenryck@gmail.com> wrote:
> > >> I think both problems are already addressed but the patches haven't
> > >> yet been handled.
> > >>
> > >> You may look at:
> > >> - https://patchwork.kernel.org/patch/9469701/
> > 
> > I had a look at the two patches. I think this one is only for
> > comparison operations? So the particular failure I saw will still
> > occur I think.
> 
> Yes, indeed.
> I've quickly looked at your test case;
> It seems to be related to a type problem, probably related to
> size_t.(I see:
> 	... call i8* @alloc(i0 4)
> and this 'i0' is very suspect.
> The following also fail because of a type problem but with the pointer.
> Even with replacing the pointers by void pointers it gives:
> 	i64  %0 = call i8* @malloc(i0 4)
> where the i64 is clearly wrong.
> It's possible that this late problem is a side effect of my second
> patch, I'll  investigate this tommorow.
> 

It seems that (at least a part of) your problem that malloc()
is called with a constant value and this is not handled correctly
by sparse-llvm. If the size is not a constant but given as argument
to testfunc() things are OK.

To get the type of malloc()'s arg and this is done by calling
pseudo_to_value() with the malloc instruction and the pseudo
for the size (but no info about this pseudo being malloc()'s arg).
LLVMConstInt() is then called with the constant value and the type
is given by calling insn_symbol_type() with the malloc instruction
but again, it's not possible to get the right type without specifying
we try to get the type of the first argument of the called function
and not the type of the result.

But maybe, you have already see this.

Luc
