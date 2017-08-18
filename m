From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 13/29] add insert_phi_node()
Date: Fri, 18 Aug 2017 22:52:15 +0200
Message-ID: <CAExDi1Q=bKkbz6Ggz4YBYTFUOm_LKW8Oo6U=9XAmtfFaLeERvQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-14-luc.vanoostenryck@gmail.com> <CANeU7QkAM=5Z+Ksn+Wjx66kF=Hz3pumfADiHQAs74AoKdYC4=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33393 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdHRUwQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 16:52:16 -0400
Received: by mail-oi0-f49.google.com with SMTP id f11so108129341oic.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 13:52:16 -0700 (PDT)
In-Reply-To: <CANeU7QkAM=5Z+Ksn+Wjx66kF=Hz3pumfADiHQAs74AoKdYC4=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 10:39 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> You do need to preserve the order of the phi node, right?
> At first I was thinking always insert the phi at the first instruction.
> Then I realized that, it is possible some phi node use some other
> phi node as source in case of a loop. So the order does need
> to be preserved some how.

It's not needed because:
1) phi-nodes need to have 'parallel-assignment' semantics anyway
    like in languages where you can write 'a, b = b, a' to exchange
    two variables. In other words, if the order would matter it would
    be a bug.
2) you can never have (the target of) a phi-node (OP_PHI)
    as another phi-node' source because all such sources are
    created by OP_PHISOURCEs.

-- Luc
