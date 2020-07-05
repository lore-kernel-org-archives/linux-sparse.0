From: Davidson Francis <davidsondfgl@gmail.com>
Subject: Re: [PATCH] test-inspect: reset locale after gtk_init()
Date: Sun, 5 Jul 2020 20:28:48 -0300
Message-ID: <5f026233.1c69fb81.43be0.0187@mx.google.com>
References: <20200705185013.8578-1-davidsondfgl@gmail.com>
 <CAHk-=wjqh1KOVWaP=xPZH_9grwDVtCMitWOb4vtKj+cB0jghBw@mail.gmail.com>
 <20200705203502.dwctpjxtqfwaz7bd@ltop.local>
Reply-To: 20200705203502.dwctpjxtqfwaz7bd@ltop.local
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgGEX2y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 19:28:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5EEC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 16:28:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so27716975qtv.8
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 16:28:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200705203502.dwctpjxtqfwaz7bd@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 05, 2020 at 10:35:02PM +0200, Luc Van Oostenryck wrote:
> On Sun, Jul 05, 2020 at 12:12:55PM -0700, Linus Torvalds wrote:
> > It _might_ be a good idea to limit it to LC_NUMERIC instead of
> > LC_ALL,
> > but who knows.. I'm not sure what else might be affected (and I'm
> > not
> > sure how good LC_NUMERIC support is on all platforms)
>
> Well, checking the standard, I see that strtold() first strips
> whitespaces as defined by isspace() and isspace() itself depends
> on LC_CTYPE. So, for the moment, I prefer to take Davidson's
> patch as is this (OTOH, we already depend on isspace() anyway).
>
> -- Luc

I was also in doubt as to what would be the most appropriate
option. Anyway, thanks for accepting the patch.

Regards,
Davidson Francis.
