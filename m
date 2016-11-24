From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Thu, 24 Nov 2016 02:31:27 +0100
Message-ID: <20161124013125.GA18072@macpro.local>
References: <20161117095503.8754-1-johannes@sipsolutions.net>
 <CANeU7Q=vFZ2CtMYjMEYSNcJmdEGbg+_f_wYCRwmKZh3Jc76jEA@mail.gmail.com>
 <1479721551.8662.10.camel@sipsolutions.net>
 <CANeU7QmSSPT9cq1fNqUxqk5DNWDn7RNLjKnFVdKUdJtCrqfBLg@mail.gmail.com>
 <20161122131543.GA8370@macbook.local>
 <CANeU7QmSd5Zd_H2jDQyTjUMg7C4_6wQOyCR73R=FTdJ=f4+ygg@mail.gmail.com>
 <20161122201650.GA12172@macpro.local>
 <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
 <20161123204838.GA14875@macpro.local>
 <CANeU7Qm56E34mgRz0ntwQ74gmdmEgzd4jEPw6Uuw5UW8UFR85A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33700 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbcKXBuI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 20:50:08 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so2253421wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 17:49:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm56E34mgRz0ntwQ74gmdmEgzd4jEPw6Uuw5UW8UFR85A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Nov 24, 2016 at 08:56:45AM +0800, Christopher Li wrote:
> On Thu, Nov 24, 2016 at 4:48 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > There is a problem though, with non-constant args.
> > Now the predeclarations of the 3 __builtin_bswap16/32/64
> > are gone, no more prototype and thus no more typing information.
> >
> > For example, if you call __builtin_bswap64() with an int argument,
> > there is no way for the next steps to know the arg must first
> > be 64 bit extended. Same for the result's type.
> 
> That is a very good point. Need more work on that.
> 
> The currently problem if I include the function prototype, the
> function prototype symbol will over shadow the symbol contain
> swap_op. We need to make sure the function prototype symbol
> is the one loading with correct swap_op.

Yes indeed.

Maybe another approach is possible:
- note the fact that "stuff" (I intentionally don't want to use
  "function") like __builtin_bswap*() behave like an operator
  or a function in the mathematical sense: they only depend on
  their args, have no side-effect, ... in others word they are "pure"
  like in MOD_PURE.
- because they're pure they necessarily return constant value if given
  constant args. This may be used early, the value itself is only needed
  in later phases.

It may also not be a bad idea to have a specific instructions for these
(like a few others, I'm thinking to rotate), after all it's not without
reasons that common CPU archs have these as real instructions
(but this won't directly help our present problem).
 
> Ideally, all the "__builtin_xxx" related stuff should be move to a
> separate builtin.c. Right now the function prototype is in lib.c
> The implementation is sprinkle around symbol.c, evaluation.c
> and expand.c.

It would be good, yes.
 
Luc
