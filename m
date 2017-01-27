From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 20:07:17 +0100
Message-ID: <20170127190716.e7ux5guhg7sbomar@macpro.local>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
 <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
 <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36788 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdA0THV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 14:07:21 -0500
Received: by mail-wj0-f195.google.com with SMTP id kq3so6574171wjc.3
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 11:07:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, Jan 27, 2017 at 06:18:07PM +0000, Dibyendu Majumdar wrote:
> H Luc,
> 
> On 27 January 2017 at 17:11, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> > On 27 January 2017 at 15:59, Van Oostenryck Luc
> > <luc.vanoostenryck@gmail.com> wrote:
> >> I think both problems are already addressed but the patches haven't
> >> yet been handled.
> >>
> >> You may look at:
> >> - https://patchwork.kernel.org/patch/9469701/
> 
> I had a look at the two patches. I think this one is only for
> comparison operations? So the particular failure I saw will still
> occur I think.

Yes, indeed.
I've quickly looked at your test case;
It seems to be related to a type problem, probably related to
size_t.(I see:
	... call i8* @alloc(i0 4)
and this 'i0' is very suspect.
The following also fail because of a type problem but with the pointer.
Even with replacing the pointers by void pointers it gives:
	i64  %0 = call i8* @malloc(i0 4)
where the i64 is clearly wrong.
It's possible that this late problem is a side effect of my second
patch, I'll  investigate this tommorow.

Regards,
Luc
