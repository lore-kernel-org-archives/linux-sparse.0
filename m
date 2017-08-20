From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse parsing question: symbols in parse tree
Date: Sun, 20 Aug 2017 23:15:31 +0100
Message-ID: <CACXZuxcV3qyhTj_GWeJ0cTqRS+TKbuzzOvHh7svdYqfSP3mrTA@mail.gmail.com>
References: <CACXZuxctG4_rqA0v2KNmxNvK693wH8EMVGhCjPEcHisiKUdUBA@mail.gmail.com>
 <CA+55aFwpbwTM32PiBME0YDnCCZ58_Qq+shJ0BvagnKL5YDyk+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34448 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbdHTWPc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 18:15:32 -0400
Received: by mail-ua0-f173.google.com with SMTP id i3so20993108uad.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 15:15:32 -0700 (PDT)
In-Reply-To: <CA+55aFwpbwTM32PiBME0YDnCCZ58_Qq+shJ0BvagnKL5YDyk+Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Linus,

On 20 August 2017 at 23:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Aug 20, 2017 at 2:51 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Whenever an EXPR_SYMBOL is encountered does this actually equate to
>> the address of the symbol?
>
> Yes, it should.
>
> Note that not all EXPR_SYMBOL are really symbols in the C sense. As
> mentioned in another thread, you can also have anonymous symbols -
> they act kind of like a named variable, just without the name.
>
> The most common case of an anonymous symbol is a constant string, but
> we do the general case of "cast followed by an initializer" as an
> anonymous symbol of any type.
>

That's interesting - thanks!

Regards
Dibyendu
