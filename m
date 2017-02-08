From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Wed, 8 Feb 2017 22:35:45 +0100
Message-ID: <20170208213544.ahkbsgvikwdb7nsu@macpro.local>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
 <20170208165055.ibu47j2axwi2j53f@macpro.local>
 <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33311 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdBHWh5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 17:37:57 -0500
Received: by mail-wr0-f182.google.com with SMTP id i10so70168019wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 14:37:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Feb 09, 2017 at 04:40:07AM +0800, Christopher Li wrote:
> On Thu, Feb 9, 2017 at 12:50 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> So now that "fix value of label statement" is applied, you can
> >> safely apply "fix killing of OP_SETVAL instructions" somewhere
> >> after it, it won't create useless noise.
> >
> > I just noticed that you have added it at the top of sparse-next
> > but what you applied (basically adding "case OP_SETVAL" in
> > simplify_instruction()) is *not* what the patch I sent did
> > (adding "case OP_SETVAL" in kill_instruction())s and causes
> > quick crashes..
> > I suppose there was a conflict or so.
> >
> > Do you want that I sent a new patch or can you solve it
> > directly?
> 
> Strange. That is the only patch I found in my series.

Well, it was the rigth patch in the sense that it had the right
log message and stuff but the resulting diff was only correct
within a 1 line context. With a 3 lines context 'git am' or
a pure 'patch < ...' should have given a conflict as one of
the patch that was initialy just after it
(1856b3461 "fix killing OP_CAST & friends") made also some
changes in the same lines and these two patch have now been
exchanged.

> Sure, go ahead and send me the new one. I will take out the
> one in sparse-next and replace to your new one.

Done.

Luc 
