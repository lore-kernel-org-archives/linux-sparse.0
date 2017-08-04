From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/2] take comma expr in account for constant value
Date: Fri, 4 Aug 2017 15:49:32 -0400
Message-ID: <CANeU7QmakT6Q-7oYaG735cUOFt+L4C2JQ_eYHnfho+q5BLBmiQ@mail.gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com> <20170804160622.18260-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38459 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdHDTtd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 15:49:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id h75so2707386pfh.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 12:49:33 -0700 (PDT)
In-Reply-To: <20170804160622.18260-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 12:06 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> It's often the case that we simply need the expr's truth value.
>
> To get the value of an expression or simply if we need to know
> if it's a constant value we can use some functions like
> get_expression_value() or const_expression_value() depending
> on the type of warning needed if the expression is not constant
> (for various definition of constant).
>
> However none of these functions take in account the fact that
> a comma expression can also have a value known at compile time.
>
> In order to not introduce unwanted change elsewheer in the code,
> introduce a new function expr_truth_value() which never warn
> but will return -1 if the expr have no known boolean value.
>
> Note: the whole set of functions should be unified to take comma
>       expressions in account when needed.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  expand.c     | 30 ++++++++++++++++++++++++++++++
>  expression.h |  1 +
>  2 files changed, 31 insertions(+)
>
> diff --git a/expand.c b/expand.c
> index 5f908c971..f436b5b50 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -1281,6 +1281,36 @@ long long get_expression_value_silent(struct expression *expr)
>         return __get_expression_value(expr, 2);
>  }
>
> +int expr_truth_value(struct expression *expr)

Looks fine to me.

One of the very minor note is that. I think this patch can actually merge with
the next one. It is easier to read patch have both the define and usage.
I found myself need to switch between patches to read how it was used.

The test case on the other hand can justify to become a standalone patch.
Some time we want see the how the code change (with or without patches)
impact the test case.

Another minor commend is that, if it is not for RC5.
You actually don't need to worry about code impact range
any more. You might just as well do the full change into the constant
expression value evaluation.

Chris
