From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 29 Mar 2017 16:42:35 +0200
Message-ID: <20170329144233.7hjyhshb72pbtv7s@macpro.local>
References: <20161123040528.GA74337@macpro.local>
 <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com>
 <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com>
 <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com>
 <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com>
 <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34955 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdC2Omj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 29 Mar 2017 10:42:39 -0400
Received: by mail-wr0-f182.google.com with SMTP id k6so12085297wre.2
        for <linux-sparse@vger.kernel.org>; Wed, 29 Mar 2017 07:42:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Dec 06, 2016 at 02:00:50PM +0800, Christopher Li wrote:
> Hi Nicolai,
> 
> I finally finish up my more serious review of your patch series.
> So this email is going to be long. Sorry for the long delay.
> 
> Over all pretty good.
> 
...
> 
> 4) in patch 12:
>  static struct symbol *evaluate_ptr_add(struct expression *expr,
> struct symbol *itype)
>  {
>         struct expression *index = expr->right;
>         struct symbol *ctype, *base;
>         int multiply;
> 
>         classify_type(degenerate(expr->left), &ctype);
>         base = examine_pointer_target(ctype);
> 
> +       /*
> +        * An address constant +/- an integer constant expression
> +        * yields an address constant again [6.6(7)].
> +        */
> +       if ((expr->left->constexpr_flags & CONSTEXPR_FLAG_ADDR_CONST) &&
> +               (expr->right->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
> +               expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
> +
> The constant flags should be set regardless. Otherwise it is not consistent
> with the rest of the code.

Chris, I don't really understand your remark here (regardless what ?).
Can you explain it a bit more please?

-- Luc
