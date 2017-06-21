From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix: __builtin_bswap{16,32,64}() constantness
Date: Tue, 20 Jun 2017 21:50:33 -0700
Message-ID: <CANeU7QmjPsZiv-oqMdxZnWc=VwCYcSUegFPpCaocwT5iGiDCQA@mail.gmail.com>
References: <20170620164253.76292-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38290 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFUEuf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 00:50:35 -0400
Received: by mail-it0-f45.google.com with SMTP id b205so25665479itg.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 21:50:35 -0700 (PDT)
In-Reply-To: <20170620164253.76292-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jun 20, 2017 at 9:42 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When expanding those builtins, we directly excludes a non-constant
> arg (via the expression expansion cost) and the to retrieve the
> value we use const_expression_value().
>
> But const_expression_value() is to be used for expressions that
> qualify as 'integer constant expression' as per the C standard.
> However we want to be able to use this builtin with all integer
> expressions having a known value at compile time, even those
> not qualified as true 'integer constant expression'.
>
> Fix this by using get_expression_value_silent() instead of
> const_expression_value().

Looks good to me.

Chris
