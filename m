From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Output from linearize and LLVM error
Date: Sun, 29 Jan 2017 10:15:19 +0100
Message-ID: <20170129091518.jbyfkm2xw2ooqufd@macbook.local>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
 <20170127190716.e7ux5guhg7sbomar@macpro.local>
 <20170127204319.agxtocpiblrcmrbj@macpro.local>
 <CACXZuxeAJ5Re_9RzeoAdK+1KbKadHd4=wm+PXUCSt3aRGqOE6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33293 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdA2JPw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 04:15:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so8474906wmv.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 01:15:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeAJ5Re_9RzeoAdK+1KbKadHd4=wm+PXUCSt3aRGqOE6g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sun, Jan 29, 2017 at 12:26:40AM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 27 January 2017 at 20:43, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > To get the type of malloc()'s arg and this is done by calling
> > pseudo_to_value() with the malloc instruction and the pseudo
> > for the size (but no info about this pseudo being malloc()'s arg).
> > LLVMConstInt() is then called with the constant value and the type
> > is given by calling insn_symbol_type() with the malloc instruction
> > but again, it's not possible to get the right type without specifying
> > we try to get the type of the first argument of the called function
> > and not the type of the result.
> >
> 
> I think that there is a problem wherever pseudo_to_value() is being
> used and the pseudo is an integer constant.

Indeed, and possibly in other cases too.

> Firstly the logic for
> determining the size of the constant needs to cover all cases and
> secondly depending upon the context the constant may need to be cast
> to a pointer. So while the patch you mentioned before tries to solve
> this for comparison operations, I think that the solution needs to
> cater for all use cases not just those. The handling of arguments is
> an example of this.

Absolutely, the patch I wrote was only to fix a sparse-llvm breakage
I saw after some changes with sparse dealing of comparisons.
I didn't realized that the problem was bigger.

> 
> My suggestion is that pseudo_to_value() for PSEUDO_VAL should always
> return an integer constant of type 'long long'  and the caller of
> pseudo_to_value() should adjust the constant to right size (by
> truncating or extending) or to pointer type if necessary as the caller
> has more information. For instance, in the handling of OP_CALL, the
> function output_op_call() knows when the call is for an argument, etc.
> Currently pseudo_to_value() tries to work out the integer size, but
> cannot do this correctly due to lack of information, and also even if
> it did work out the size, the cast to pointer would be missed I think.
> 
> Does this make sense?

Yes, it make a lot of sense but I'm not so sure about the approach.
* I'm not sure how easy it is to adjust the constant size/type.
* adjusting the constant size/type instead of gettign directly the
  right type will create a superfluous cast (not a big deal as LLVM
  will optimize it away later but well ...).
* I think that in general passing the pointer to the instruction to
  pseudo_to_value() and insn_symbol_type() is an error since what is
  really needed is the type, thus those function can only make assumptions
  about the type, maybe most of the time a correct one, but they can't do
  for all cases.
* I think that this problem would be better handled if the caller could
  directly give the type information to pseudo_to_value() instead of 
  adjusting it after the fact (but I have no idea how difficult and
  how much work it will be).
* I have no idea about the constant-to-pointer case.
* I think you will have a problem with void pointer since in this case
  sparse doesn't have the information about the real type (but maybe it
  will be easy to solve, I have no idea).

Note: I known next to nothing about LLVM
Note: I've added in CC the authors of sparse-llvm.c


Regards,
Luc Van Oostenryck
