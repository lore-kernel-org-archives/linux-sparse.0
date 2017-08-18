From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 28/29] sssa: switch to the new SSA construction
Date: Fri, 18 Aug 2017 23:58:40 +0200
Message-ID: <CAExDi1Tz1gJ789fu83MT2jpd_eSoY+9j+4Cn+VFHRCdD4H1NUA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-29-luc.vanoostenryck@gmail.com> <CANeU7Qnag6mAy-opTWoM-pzGaipgVZxMTrEHzjXOgWWqmrT2SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34140 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdHRV6l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:58:41 -0400
Received: by mail-oi0-f42.google.com with SMTP id x3so109455202oia.1
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:58:40 -0700 (PDT)
In-Reply-To: <CANeU7Qnag6mAy-opTWoM-pzGaipgVZxMTrEHzjXOgWWqmrT2SA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 18, 2017 at 11:47 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck wrote:

>> to use the new SA construction method.
>
> You mean SSA construction method :-)

I'm used to more often use 'SSSA' for Simple SSA and thus refering
the method & implementation. Here I removed one more 'S'.

-- Luc
