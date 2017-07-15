From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Sat, 15 Jul 2017 20:22:00 +0200
Message-ID: <20170715182159.ltikqlbe6rktxfhz@ltop.local>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34279 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdGOSWE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Jul 2017 14:22:04 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so79587771wrb.1
        for <linux-sparse@vger.kernel.org>; Sat, 15 Jul 2017 11:22:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 14, 2017 at 10:48:57AM -0700, Christopher Li wrote:
> I have push a preview version of 0.5.1-rc5 to sparse-next.
> 
> https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next
> 
> If no big surprise, I will push RC5 to master and tag it tomorrow.

[Sorry, I'm on vacation and very little computer access].

I still object to the kill_unreachable_bbs() patch and I ask
to reconsider it in favor of the original one.

Since this has already been discussed, I can only invite to read
again the original patch and the one it fixes where the situation
is explained, I think, clearly.

-- Luc
