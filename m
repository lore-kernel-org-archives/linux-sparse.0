From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 17:29:57 +0200
Message-ID: <CAExDi1TGogTQWxs1GwW-0a2bE0pf_i6stAiQytFwR1n4ePPEYQ@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com> <CANeU7QkS7CuFkFJyj7jHZwBhCarAm3u0JvZo9gBgsDhZ7uAW4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35145 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdHLP36 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 11:29:58 -0400
Received: by mail-oi0-f51.google.com with SMTP id e124so55492664oig.2
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 08:29:58 -0700 (PDT)
In-Reply-To: <CANeU7QkS7CuFkFJyj7jHZwBhCarAm3u0JvZo9gBgsDhZ7uAW4g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 5:26 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Aug 12, 2017 at 8:55 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> +       if (--max == 0)
>> +               return;
>
> I think actually here need to at least report error very loudly.
> The error message should be clear there is likely a internal
> bug in sparse. Hopefully the user will report back to the mailing
> list.
>
>
> Otherwise sparse will be silence and masking the bugs.
> In that sense, having the dead loop is not that bad compare
> to masking a dead loop.
>
> Silently work around the bug will hurt sparse in the long term.

No disagreement here.

-- Luc
