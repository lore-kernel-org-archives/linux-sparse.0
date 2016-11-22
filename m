From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Tue, 22 Nov 2016 18:12:24 +0100
Message-ID: <20161122171224.GA4146@macpro.local>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local>
 <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33134 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755614AbcKVRM2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 12:12:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so5206276wmu.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 09:12:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 12:32:52AM +0800, Christopher Li wrote:
> > I think it would be best to do any change related tos handling
> > of constant expressions on to of Nicolai Stange's serie:
> >         http://marc.info/?l=linux-sparse&m=145429372932235
> 
> Yes, it is on my patch list. That series can still apply clean.
> I just check it.
Great.
 
> My current strategy is apply other patches which have impact
> on the sparse warning first. Otherwise my anxiety level is too
> high, make me hard to pick up and hack sparse. That integer
> series needs a relative big chunk of time to review it. For me
> it is more important to keep on making progress rather than
> solve all problem in one blow.
I understand.

> I think I have been catch up with most of the patches.
Yes, just from memory, there is still one from Oleg, about dissect.

> Should be able to work on that soon.
Great.
 

Luc
