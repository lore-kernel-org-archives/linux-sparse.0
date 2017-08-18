From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 13/29] add insert_phi_node()
Date: Fri, 18 Aug 2017 17:17:12 -0400
Message-ID: <CANeU7QkZsxrv5K0Ey1KfdSxFSsP+dwpZu2R48L3pbknxvQ+Uww@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-14-luc.vanoostenryck@gmail.com> <CANeU7QkAM=5Z+Ksn+Wjx66kF=Hz3pumfADiHQAs74AoKdYC4=A@mail.gmail.com>
 <CAExDi1Q=bKkbz6Ggz4YBYTFUOm_LKW8Oo6U=9XAmtfFaLeERvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34354 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdHRVRN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:17:13 -0400
Received: by mail-yw0-f170.google.com with SMTP id s143so65932063ywg.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:17:13 -0700 (PDT)
In-Reply-To: <CAExDi1Q=bKkbz6Ggz4YBYTFUOm_LKW8Oo6U=9XAmtfFaLeERvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 4:52 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Aug 18, 2017 at 10:39 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>
> It's not needed because:
> 1) phi-nodes need to have 'parallel-assignment' semantics anyway
>     like in languages where you can write 'a, b = b, a' to exchange
>     two variables. In other words, if the order would matter it would
>     be a bug.

I need to think more about that.

> 2) you can never have (the target of) a phi-node (OP_PHI)
>     as another phi-node' source because all such sources are
>     created by OP_PHISOURCEs.

I see. So that means you can just insert into the first instruction?

Chris
