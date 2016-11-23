From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Wed, 23 Nov 2016 21:48:39 +0100
Message-ID: <20161123204838.GA14875@macpro.local>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local>
 <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local>
 <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36579 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755533AbcKWUsv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 15:48:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so3102639wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 12:48:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 09:25:18AM +0800, Christopher Li wrote:
> On Wed, Nov 23, 2016 at 4:16 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Work great here.
> >
> > If needed here is my
> > Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 

There is a problem though, with non-constant args.
Now the predeclarations of the 3 __builtin_bswap16/32/64
are gone, no more prototype and thus no more typing information.

For example, if you call __builtin_bswap64() with an int argument,
there is no way for the next steps to know the arg must first
be 64 bit extended. Same for the result's type.

Luc
