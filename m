From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sparse parsing question: symbols in parse tree
Date: Sun, 20 Aug 2017 15:09:15 -0700
Message-ID: <CA+55aFwpbwTM32PiBME0YDnCCZ58_Qq+shJ0BvagnKL5YDyk+Q@mail.gmail.com>
References: <CACXZuxctG4_rqA0v2KNmxNvK693wH8EMVGhCjPEcHisiKUdUBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33471 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbdHTWJQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 18:09:16 -0400
Received: by mail-oi0-f43.google.com with SMTP id f11so138679993oic.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 15:09:16 -0700 (PDT)
In-Reply-To: <CACXZuxctG4_rqA0v2KNmxNvK693wH8EMVGhCjPEcHisiKUdUBA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 2:51 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Whenever an EXPR_SYMBOL is encountered does this actually equate to
> the address of the symbol?

Yes, it should.

Note that not all EXPR_SYMBOL are really symbols in the C sense. As
mentioned in another thread, you can also have anonymous symbols -
they act kind of like a named variable, just without the name.

The most common case of an anonymous symbol is a constant string, but
we do the general case of "cast followed by an initializer" as an
anonymous symbol of any type.

              Linus
