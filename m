From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Tue, 22 Nov 2016 21:16:52 +0100
Message-ID: <20161122201650.GA12172@macpro.local>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local>
 <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36821 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755837AbcKVUQ4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 15:16:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so6373489wma.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 12:16:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 12:32:52AM +0800, Christopher Li wrote:
> On Tue, Nov 22, 2016 at 9:15 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>
> >> I will see if I can hack up some thing very quick.
> 
> I get it working in the end. Not too far from what I thought.
> Patch attach here for review.

Work great here.
 
If needed here is my
Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
