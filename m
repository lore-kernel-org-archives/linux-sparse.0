From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Tue, 6 Dec 2016 17:54:58 +0100
Message-ID: <20161206165456.GA19255@macbook.local>
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
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33033 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcLFQzC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Dec 2016 11:55:02 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so22575250wmu.0
        for <linux-sparse@vger.kernel.org>; Tue, 06 Dec 2016 08:55:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Dec 06, 2016 at 02:00:50PM +0800, Christopher Li wrote:
> 1)  name of constexpr_flags is too long.
> 
>  struct expression {
>         enum expression_type type:8;
> -       unsigned flags:8;
> +       unsigned constexpr_flags:8;
> 
> I actually thing that the more generic name "flags" are fine
> without changing. If we need to add other flags not related to
> constant, we will need to rename it all over again.

I'd suggest to also add on th same line a comment like:
	// used for the kinds of constant expression 

- Luc
