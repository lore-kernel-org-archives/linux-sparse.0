From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 21:51:30 +0100
Message-ID: <20170127205130.c4nbpfyoukudygjo@macpro.local>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
 <20170127190716.e7ux5guhg7sbomar@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33834 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdA0VA1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 16:00:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so60753624wmi.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 13:00:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170127190716.e7ux5guhg7sbomar@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, Jan 27, 2017 at 08:07:17PM +0100, Luc Van Oostenryck wrote:
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

Another problem you will have is with cast related void pointers.
For casts, sparse consider void pointers like an integer type
(because void pointers can't be used as such, they need to be casted
to a real pointer type to do something useful with them).
This means that a cast to a void pointer will produce an OP_CAST and
not an OP_PTRCAST.
And I guess this will be a problem for sparse-llvm.

Luc
