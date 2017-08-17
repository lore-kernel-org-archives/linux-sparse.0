From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 02:16:35 -0400
Message-ID: <CANeU7Q=E1TzKMZWaN7rMynG+K_v=RPMZ=_CyL40Txe5k0tc55A@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
 <20170817051607.7tydij5q4zny3zxo@ltop.local> <CAExDi1QztpLweagbMV6kA=K+O4H0F401JQwV=BF88CK69JMiEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36243 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdHQGQg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 02:16:36 -0400
Received: by mail-yw0-f180.google.com with SMTP id u207so35426976ywc.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 23:16:36 -0700 (PDT)
In-Reply-To: <CAExDi1QztpLweagbMV6kA=K+O4H0F401JQwV=BF88CK69JMiEg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 2:09 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I just took a quick look at this one. It's interesting.
> The IR seems correct, the locking is correct too.
> The problem seems that the 'correct' presence of phi-nodes make
> that some BB that were merged are not anymore. Nothing is wrong,

I assume you need the phi-node relocation similar to the one used
in "dead code elimination using ssa". That will get merge the block
with phi node in it.

> just different code. But the context checking is quite limited and see now
> a path where the context could differ. I practice they won't differ and with
> previous code the context checking saw that because this patch was
> unexisting due to more aggressive merge of BB.

Interesting.Context checking is very sensitive and give a lot of false
positives.

> One way to see at it is this is a false warning that appears because
> of a lack of BB optimizations.
> I've a vague idea of what can be done here. I'll look at it later, this evening.

Thanks. I will take a look at your patches series.

Chris
