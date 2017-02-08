From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 0/8] fix uses of killed instructions
Date: Wed, 8 Feb 2017 17:50:56 +0100
Message-ID: <20170208165055.ibu47j2axwi2j53f@macpro.local>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
 <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35894 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdBHRSd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 12:18:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so34397438wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 09:16:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAExDi1RJ8rPE7n7eGmBRnSe3FudW28HF7DkVErmVmniZrwSQJQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

On Tue, Feb 07, 2017 at 08:30:19PM +0100, Van Oostenryck Luc wrote:
> On Sun, Jan 29, 2017 at 11:48 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > - drop patch 2 ("fix killing of OP_SETVAL instructions") as it causes
> >   a strange unexpected change at a single place when testing on a kernel
> >   allyesconfig on x86.
> 
> I've investigated what was happening with this one.
> Everything is all right.
> What was happening was that the absence of the patch
> "fix value of label statement" created a lot of dead OP_SETVAL.
> The patch "fix killing of OP_SETVAL instructions" did its job
> but the code was wrong anyway and created a lot of changes
> in kernel's allyesconfig's output.
> 
> So now that "fix value of label statement" is applied, you can
> safely apply "fix killing of OP_SETVAL instructions" somewhere
> after it, it won't create useless noise.

I just noticed that you have added it at the top of sparse-next
but what you applied (basically adding "case OP_SETVAL" in 
simplify_instruction()) is *not* what the patch I sent did
(adding "case OP_SETVAL" in kill_instruction())s and causes
quick crashes..
I suppose there was a conflict or so.

Do you want that I sent a new patch or can you solve it
directly?

Luc
