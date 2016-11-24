From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Thu, 24 Nov 2016 08:56:45 +0800
Message-ID: <CANeU7Qm56E34mgRz0ntwQ74gmdmEgzd4jEPw6Uuw5UW8UFR85A@mail.gmail.com>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net> <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local> <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local> <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123204838.GA14875@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:32951 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934958AbcKXA4r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 19:56:47 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so3482564ioi.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 16:56:46 -0800 (PST)
In-Reply-To: <20161123204838.GA14875@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Nov 24, 2016 at 4:48 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There is a problem though, with non-constant args.
> Now the predeclarations of the 3 __builtin_bswap16/32/64
> are gone, no more prototype and thus no more typing information.
>
> For example, if you call __builtin_bswap64() with an int argument,
> there is no way for the next steps to know the arg must first
> be 64 bit extended. Same for the result's type.

That is a very good point. Need more work on that.

The currently problem if I include the function prototype, the
function prototype symbol will over shadow the symbol contain
swap_op. We need to make sure the function prototype symbol
is the one loading with correct swap_op.

Ideally, all the "__builtin_xxx" related stuff should be move to a
separate builtin.c. Right now the function prototype is in lib.c
The implementation is sprinkle around symbol.c, evaluation.c
and expand.c.

Re-attach the V2 patch as last email I forget to CC sparse
mailing list. This V2 patch still have the missing prototype problem
you describe here.


Chris
