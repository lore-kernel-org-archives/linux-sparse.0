From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Wed, 23 Nov 2016 09:25:18 +0800
Message-ID: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local> <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34350 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754413AbcKWBZk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 20:25:40 -0500
Received: by mail-io0-f193.google.com with SMTP id r94so3470038ioe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 17:25:20 -0800 (PST)
In-Reply-To: <20161122201650.GA12172@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Wed, Nov 23, 2016 at 4:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Work great here.
>
> If needed here is my
> Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Great, that is what I am looking for.

Will apply that patch.

Chris
