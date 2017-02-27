From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] CSE: relax type checking in hashing/compare
Date: Mon, 27 Feb 2017 10:40:13 +0100
Message-ID: <20170227094013.pevbixjonnebaaxa@macbook.local>
References: <20170217000608.6433-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=Uv0Xb=9PvpSdeoe4epMD0d5UTHED+xx2N7e7XmDkY9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33163 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdB0JkY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 04:40:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so12474883wmv.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 01:40:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=Uv0Xb=9PvpSdeoe4epMD0d5UTHED+xx2N7e7XmDkY9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Feb 27, 2017 at 04:11:44PM +0800, Christopher Li wrote:
> On Fri, Feb 17, 2017 at 8:06 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > I'm missing something?
> >
> > If not, then the following simple patch should be correct.
> 
> This patch is missing a S-O-B. Can you add one?

I did this purposely because it was a RFC.
Also:
- I still have some doubts about this patch
- It won't solve anything, only allow more CSE (but maybe more than
  really wanted)
- There is no urgency at all.

So I think it would be better to not include it in the coming release
and instead let it ripe a little bit.

But if you really prefer to include it, maybe not in a release but
in another branch, it's fine for me also.

    Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
