From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] predefine: add a macro telling about named address spaces
Date: Tue, 16 Jun 2020 22:51:45 +0200
Message-ID: <20200616205145.gtg3vybznxfx62tx@ltop.local>
References: <20200616005012.66141-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whHKXbJS62Nrcsn6cy0EcHh3PrGbESBkM0MOAjFx-CVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFPUvt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 16:51:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2977C061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 13:51:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so23172734ejm.12
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 13:51:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=whHKXbJS62Nrcsn6cy0EcHh3PrGbESBkM0MOAjFx-CVsQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jun 16, 2020 at 12:13:18PM -0700, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 5:50 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Sparse supports named address spaces since v0.6.0-rc1.
> > This gives much nicer warnings ('... __user' instead of '... <asn:1>')
> > but this featres is not yet used in the kernel since it could be
> > a problem for people using an older version of Sparse.
> 
> Actually, I think it's more that nobody has sent a tested patch.

Yes, I should have done this many months ago. I admit that it bothers
me when people complain that something doesn't work with sparse and
it's just that they using an old version (sometimes quite old).
 
> I don't think it's a big burden to say "you need a newer version of
> sparse" for kernel checkers, and in fact a number of the problems
> people report then get answered with "update your sparse version"
> anyway for other reasons.
> 
> In fact, I'd personally like to just make the kernel use _Generic()
> everywhere now that we started getting our toes wet, but the fact that
> we would have to require gcc-4.9 (instead of gcc-4.8 which is
> currently the minimum version) is holding us back.
> 
> So I'd be perfectly happy to take a patch to do the ASN names, and to
> remove the __CHECKER__ thing that holds us back from using _Generic()
> with sparse. And just document that you need to have a recent enough
> release..

OK. The one for the ASNs is already prepared anyway and I'll do the
one for _Generic() tomorrow.

-- Luc
