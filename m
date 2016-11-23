From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Thu, 24 Nov 2016 02:23:35 +0800
Message-ID: <CANeU7Q=aoP_ZBVHcZ8qYOBN9zt-y_k_CYY1nSjLd4OqQz7XDcw@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33755 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbcKWSXh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 13:23:37 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so2547594ioi.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 10:23:37 -0800 (PST)
In-Reply-To: <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Nov 24, 2016 at 1:38 AM, Christopher Li <sparse@chrisli.org> wrote:

> In your patch:
>
> static struct token *builtin_types_compatible_p_expr(struct token *token,
>                                                      struct expression **tree)
>  {
>         struct expression *expr = alloc_expression(
>                 token->pos, EXPR_COMPARE);
> -       expr->flags = Int_const_expr;
>         expr->op = SPECIAL_EQUAL;
>         token = token->next;
>         if (!match_op(token, '('))
>
> I think __builtin_xxx function expand similar to the processor
> macro. In that sense, we might want to the consider this expression
> as integer constant express as if the __builtin_xxx call is either 0 or 1.

Never mind, I think you move it to the evaluation phase.

Chris
