From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4] sparse: add support for _Static_assert
Date: Wed, 3 May 2017 23:03:22 -0400
Message-ID: <CANeU7Q=pC0Q2z3xtACq1AJ89Y3mr8aNEpo6GO42y6n0MuxV0ug@mail.gmail.com>
References: <20170503165518.7625-1-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:37303 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbdEDDDX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 23:03:23 -0400
Received: by mail-it0-f42.google.com with SMTP id x188so1432143itb.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 20:03:23 -0700 (PDT)
In-Reply-To: <20170503165518.7625-1-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 3, 2017 at 12:55 PM, Lance Richardson <lrichard@redhat.com> wrote:
> +               } else if (token_type(token) == TOKEN_IDENT &&
> +                          (keyword = lookup_keyword(token->ident, NS_KEYWORD)) &&
> +                          keyword->op == &static_assert_op) {

I think you should add _Static_assert into header file "ident-list.h"
then you can simplify this test as:

else if (token_type(token) == TOKEN_IDENT &&
            token->ident == &_Static_assert_ident)

We don't need to go through a keyword look up then test
the keyword->op == &static_assert_op.

Chris
