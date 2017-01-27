From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 17:11:32 +0000
Message-ID: <CACXZuxe=L+DZzzax2vQCrty9ZYK60dJbnWp98Cz+NJmiaoRL4A@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
 <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33843 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932750AbdA0RLj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 12:11:39 -0500
Received: by mail-vk0-f45.google.com with SMTP id r136so179581258vke.1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 09:11:38 -0800 (PST)
In-Reply-To: <CAExDi1SVaW1ZrcGZLHS+2T22zaAEiMKiNVzVnX4PdgurwoizXA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

Hi Luc,

On 27 January 2017 at 15:59, Van Oostenryck Luc
<luc.vanoostenryck@gmail.com> wrote:
> I think both problems are already addressed but the patches haven't
> yet been handled.
>
> You may look at:
> - https://patchwork.kernel.org/patch/9469701/
> - https://patchwork.kernel.org/patch/9516077/
>

Thank you - I will review these and any other patches.

>> Also the output from test-linearize and test-parsing do not seem to
>> dump the types. How can I get the types dumped out as well?
>
> Yes, it's sometimes annoying.
> Generaly, I when I need this, I add a few printf( .... show_typename(sym))
>

I see. I will try that.

Thanks again.

Regards
Dibyendu
