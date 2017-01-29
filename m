From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Sun, 29 Jan 2017 00:26:40 +0000
Message-ID: <CACXZuxeAJ5Re_9RzeoAdK+1KbKadHd4=wm+PXUCSt3aRGqOE6g@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
 <20170127190716.e7ux5guhg7sbomar@macpro.local> <20170127204319.agxtocpiblrcmrbj@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36472 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdA2A1j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 28 Jan 2017 19:27:39 -0500
Received: by mail-vk0-f54.google.com with SMTP id t8so197171990vke.3
        for <linux-sparse@vger.kernel.org>; Sat, 28 Jan 2017 16:26:41 -0800 (PST)
In-Reply-To: <20170127204319.agxtocpiblrcmrbj@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hi Luc,

On 27 January 2017 at 20:43, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> To get the type of malloc()'s arg and this is done by calling
> pseudo_to_value() with the malloc instruction and the pseudo
> for the size (but no info about this pseudo being malloc()'s arg).
> LLVMConstInt() is then called with the constant value and the type
> is given by calling insn_symbol_type() with the malloc instruction
> but again, it's not possible to get the right type without specifying
> we try to get the type of the first argument of the called function
> and not the type of the result.
>

I think that there is a problem wherever pseudo_to_value() is being
used and the pseudo is an integer constant. Firstly the logic for
determining the size of the constant needs to cover all cases and
secondly depending upon the context the constant may need to be cast
to a pointer. So while the patch you mentioned before tries to solve
this for comparison operations, I think that the solution needs to
cater for all use cases not just those. The handling of arguments is
an example of this.

My suggestion is that pseudo_to_value() for PSEUDO_VAL should always
return an integer constant of type 'long long'  and the caller of
pseudo_to_value() should adjust the constant to right size (by
truncating or extending) or to pointer type if necessary as the caller
has more information. For instance, in the handling of OP_CALL, the
function output_op_call() knows when the call is for an argument, etc.
Currently pseudo_to_value() tries to work out the integer size, but
cannot do this correctly due to lack of information, and also even if
it did work out the size, the cast to pointer would be missed I think.

Does this make sense?

Thanks and Regards
Dibyendu
