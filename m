From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 5 Nov 2017 16:49:37 +0800
Message-ID: <CANeU7Qk4AGhSzzpPXT1-NmWRzSprUXEjWm6o1iy8yKAb-TceQg@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com> <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:53307 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdKEIti (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 03:49:38 -0500
Received: by mail-yw0-f182.google.com with SMTP id q126so5605351ywq.10
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 01:49:38 -0700 (PDT)
In-Reply-To: <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

>commit 5674da2d1af2467605fcc9b798fb54ee2d28efc7
>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>Date:   Mon Mar 20 15:18:53 2017 +0100
>
>    canonicalize compare instructions
>
>    Currently only commutative instructions are canonicalized
>    (the "simpler" operands, often a constant, is forced, if present
>    to be in the second operand). This improve CSE (more cases are
>    considered as equivalent) and help to reduce the number of "pattern"
>    to be handled at simplification.
>
> const struct opcode_table opcode_table[OP_LAST] = {
>-      [OP_SET_EQ] = { .negate = OP_SET_NE, },
>-      [OP_SET_NE] = { .negate = OP_SET_EQ, },
>-      [OP_SET_LT] = { .negate = OP_SET_GE, },
>-      [OP_SET_LE] = { .negate = OP_SET_GT, },
>-      [OP_SET_GE] = { .negate = OP_SET_LT, },
>-      [OP_SET_GT] = { .negate = OP_SET_LE, },
>-      [OP_SET_B ] = { .negate = OP_SET_AE, },
>-      [OP_SET_BE] = { .negate = OP_SET_A , },
>-      [OP_SET_AE] = { .negate = OP_SET_B , },
>-      [OP_SET_A ] = { .negate = OP_SET_BE, },
>+      [OP_SET_EQ] = { .negate = OP_SET_NE, .swap = OP_SET_EQ, },
>+      [OP_SET_NE] = { .negate = OP_SET_EQ, .swap = OP_SET_NE, },
>+      [OP_SET_LT] = { .negate = OP_SET_GE, .swap = OP_SET_GT, },
>+      [OP_SET_LE] = { .negate = OP_SET_GT, .swap = OP_SET_GE, },
>+      [OP_SET_GE] = { .negate = OP_SET_LT, .swap = OP_SET_LE, },
>+      [OP_SET_GT] = { .negate = OP_SET_LE, .swap = OP_SET_LT, },
>+      [OP_SET_B ] = { .negate = OP_SET_AE, .swap = OP_SET_A , },
>+      [OP_SET_BE] = { .negate = OP_SET_A , .swap = OP_SET_AE, },
>+      [OP_SET_AE] = { .negate = OP_SET_B , .swap = OP_SET_BE, },
>+      [OP_SET_A ] = { .negate = OP_SET_BE, .swap = OP_SET_B , },


Notice that LT and GT and equivalent instructions after swapping the src.
Another way to do it we might just remove one kind of instruction from the
sparse IR. From the linearization point just map GT into LT and swap the source.

So the IR does not allow those duplicated equilateral instructions. There is
less canonization to be done.

Chris
