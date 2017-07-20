From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] lib: workaround the 'redeclared with different type' errors
Date: Thu, 20 Jul 2017 07:57:16 -0400
Message-ID: <CANeU7QkTGmvv6Wgh4NWAX_shhHKKMie89EoCVtfp5dPVER-ZDw@mail.gmail.com>
References: <74a1852c-a9ef-ec91-d9da-925c7e8def94@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35195 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934876AbdGTL5S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 07:57:18 -0400
Received: by mail-pg0-f44.google.com with SMTP id v190so13922721pgv.2
        for <linux-sparse@vger.kernel.org>; Thu, 20 Jul 2017 04:57:18 -0700 (PDT)
In-Reply-To: <74a1852c-a9ef-ec91-d9da-925c7e8def94@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 4:05 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> The 'selfcheck' make target issues sparse errors for function symbols
> 'error_die' and 'die', like so:
>
>        CHECK    lib.c
>   lib.c:194:6: error: symbol 'error_die' redeclared with different type \
>         (originally declared at lib.h:98) - different modifiers
>   lib.c:203:6: error: symbol 'die' redeclared with different type \
>         (originally declared at lib.h:94) - different modifiers
>
> This is caused by the 'noreturn' attribute being treated similar to a
> type qualifier and insisting that, not only the declaration and the
> definition of the function have the 'noreturn', but that they have the
> attribute in the same position.
>
> In order to suppress the error, move the attribute(s) to the beginning
> of the declaration, in the header file, and add an 'noreturn' attribute
> at the beginning of the definition (in lib.c).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Applied to sparse-next.

Chris
