From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 18:18:07 +0000
Message-ID: <CACXZuxe6UNi2ktdAn95-zUGWbchiK7z3NgS-2spe=TnwY5X_tg@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com> <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33621 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbdA0SSI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 13:18:08 -0500
Received: by mail-ua0-f177.google.com with SMTP id i68so210555219uad.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 10:18:08 -0800 (PST)
In-Reply-To: <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

H Luc,

On 27 January 2017 at 17:11, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> On 27 January 2017 at 15:59, Van Oostenryck Luc
> <luc.vanoostenryck@gmail.com> wrote:
>> I think both problems are already addressed but the patches haven't
>> yet been handled.
>>
>> You may look at:
>> - https://patchwork.kernel.org/patch/9469701/

I had a look at the two patches. I think this one is only for
comparison operations? So the particular failure I saw will still
occur I think.

Thanks and Regards
Dibyendu
