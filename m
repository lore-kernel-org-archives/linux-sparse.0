From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 15:47:14 +0200
Message-ID: <20170707134713.3kirm7f4lqexxrot@ltop.local>
References: <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local>
 <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
 <CACXZuxf5JSfECtZni5OLmh3_iTarC39nu9-DqRNsivTT6iHb7g@mail.gmail.com>
 <CAExDi1TRKuokxpUH3BNC5rQ8TFfpHH=Xoj-M3DU1TfVMopKFeA@mail.gmail.com>
 <CACXZuxcaR7DbmgxVyLHWuEJW-_aCqsxtd=ajsKVXjksnqcf2vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34267 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbdGGNrR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:47:17 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so47879188wrb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:47:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcaR7DbmgxVyLHWuEJW-_aCqsxtd=ajsKVXjksnqcf2vg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 07, 2017 at 02:29:56PM +0100, Dibyendu Majumdar wrote:
> Agree that if refcount is used as a lock to prevent inner loops from
> amending the list then it is the same. But I think Chris is trying to
> do more - i.e. allow an inner loop to amend the list. That might
> simply not be possible to handle safely.

We have to do something more (or something less :)) otherwise
the refcount can only be used to detect a problem. In other words,
having a situation like "OK, I can't safely do XYZ here" is maybe
better than the current situation but doesn't help when you need
to do XYZ.

-- Luc
