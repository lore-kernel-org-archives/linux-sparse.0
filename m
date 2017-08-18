From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 13/29] add insert_phi_node()
Date: Fri, 18 Aug 2017 23:43:29 +0200
Message-ID: <CAExDi1RQ=POx6FY8sLu0jG-CHQ=Ek002OF_ctwuTzMT6rgCt9g@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-14-luc.vanoostenryck@gmail.com> <CANeU7QkAM=5Z+Ksn+Wjx66kF=Hz3pumfADiHQAs74AoKdYC4=A@mail.gmail.com>
 <CAExDi1Q=bKkbz6Ggz4YBYTFUOm_LKW8Oo6U=9XAmtfFaLeERvQ@mail.gmail.com> <CANeU7QkZsxrv5K0Ey1KfdSxFSsP+dwpZu2R48L3pbknxvQ+Uww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33994 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdHRVna (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:43:30 -0400
Received: by mail-oi0-f45.google.com with SMTP id x3so109182942oia.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:43:30 -0700 (PDT)
In-Reply-To: <CANeU7QkZsxrv5K0Ey1KfdSxFSsP+dwpZu2R48L3pbknxvQ+Uww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 11:17 PM, Christopher Li <sparse@chrisli.org> wrote:

>> 2) you can never have (the target of) a phi-node (OP_PHI)
>>     as another phi-node' source because all such sources are
>>     created by OP_PHISOURCEs.
>
> I see. So that means you can just insert into the first instruction?

Yes, you would also, for example, add a list in the BB and just add
them in this list in any order. They are not really instructions, the best
way to see them in the see them in a kind of BB prologue where they
(virtually) select the value for their target pseudo (and if you know for
 sure from which patch the BB will always come, you can remove them
completely.On the other hand, it' an error when merging BB to leave
a phi-node in the middle of the new bigger BB, it needs special care
but also often it doesn't matter).

-- Luc
