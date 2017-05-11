From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v7] sparse: add support for _Static_assert
Date: Thu, 11 May 2017 09:59:58 -0700
Message-ID: <CANeU7QkgoeW9JRG2xPs5Pa+YZ7ikQtoWFNSgXpp54m5FWXYgTg@mail.gmail.com>
References: <20170509184630.24086-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36939 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdEKQ77 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 12:59:59 -0400
Received: by mail-it0-f54.google.com with SMTP id g126so23522795ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 09:59:59 -0700 (PDT)
In-Reply-To: <20170509184630.24086-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, May 9, 2017 at 11:46 AM, Lance Richardson <lrichard@redhat.com> wrote:
> This patch introduces support for the C11 _Static_assert() construct.
>
> Per the N1539 draft standard, the syntax changes for this construct
> include:
>
>     declaration:
>         <declaration-specifiers> <init-declarator-list>[opt] ;
>         <static_assert-declaration>
>
>     struct-declaration:
>         <specifier-qualifier-list> <struct-declarator-list>[opt] ;
>         <static_assert-declaration>
>
>     static_assert-declaration:
>         _Static_assert ( <constant-expression> , <string-literal> ) ;
>
> Signed-off-by: Lance Richardson <lrichard@redhat.com>
> ---
> v7: Incorporated additional feedback from Christopher Li and
>     Luc van Oostenryck. Tested via "make check", also redefined
>     Linux compiletime_assert() to use _Static_assert() when
>     running sparse (gcc had issues with _Static_assert() in
>     *.s files), no additional warnings were emitted.

This version looks perfect for me.

Signed-off-by: Chris Li <sparse@chrisli.org>

Luc, do you want to apply the v7 and then I pull from your branch with
the other identifier improvements? I can apply it but it might disrupt your
branch.

Chris
