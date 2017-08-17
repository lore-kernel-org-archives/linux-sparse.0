From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 21:58:55 +0200
Message-ID: <CAExDi1SspEPQKsAwQQ+aHTB-K8-BM53z0JKHC91OJUHtLMbJ9w@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
 <20170817051607.7tydij5q4zny3zxo@ltop.local> <CAExDi1QztpLweagbMV6kA=K+O4H0F401JQwV=BF88CK69JMiEg@mail.gmail.com>
 <CANeU7Q=E1TzKMZWaN7rMynG+K_v=RPMZ=_CyL40Txe5k0tc55A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32979 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHQT64 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:58:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id e124so7399114oig.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:58:56 -0700 (PDT)
In-Reply-To: <CANeU7Q=E1TzKMZWaN7rMynG+K_v=RPMZ=_CyL40Txe5k0tc55A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 8:16 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Aug 17, 2017 at 2:09 AM, Luc Van Oostenryck wrote:
>
> I assume you need the phi-node relocation similar to the one used
> in "dead code elimination using ssa". That will get merge the block
> with phi node in it.

No, it doesn't seems to be related. It's a miised opportunity of
'try_to_simplify_bb()'.

One of the patches in my complete series solves it (and, it seems,
the other differences too but I didn't yet checked it thoroughly).
It's totally independent of the series, I can send it just after the
series.

>> just different code. But the context checking is quite limited and see now
>> a path where the context could differ. I practice they won't differ and with
>> previous code the context checking saw that because this patch was
>> unexisting due to more aggressive merge of BB.
>
> Interesting.Context checking is very sensitive and give a lot of false
> positives.

Yes, but of course, the general case is impossible to have correctly.

-- Luc
