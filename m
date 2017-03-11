From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 13:30:40 +0100
Message-ID: <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local>
 <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36360 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755485AbdCKMap (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 07:30:45 -0500
Received: by mail-wm0-f44.google.com with SMTP id n11so11996989wma.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 04:30:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Mar 11, 2017 at 11:54:56AM +0000, Dibyendu Majumdar wrote:
> PSEUDO_VAL strikes again!
> 
> struct avl_node {
>  struct avl_node *right;
>  struct avl_node *left;
> };
> #define NULL ((void *)0)
> static int test_null_comp(int height_changed, struct avl_node *node) {
>  return node != NULL && height_changed;
> }

See the message of "llvm: fix translation of PSEUDO_VALs into a ValueRefs"
    Note: while this patch improve the situation, like for example for the
    test cases added here, it's still not correct because now we're making
    the assumption that 'insn->type' is the type we need for the pseudo.
    This is often true, but certainly not always.
    For example this is not true for:
    - OP_STORE/OP_LOAD's insn->src
    - OP_SET{EQ,...}'s   insn->src[12]
    - probably some  others ones
    - in general, obviously, for any instructions where the target has
      a different type than the operands.

Here you're hitting the OP_SET{EQ,...} case.

-- Luc
