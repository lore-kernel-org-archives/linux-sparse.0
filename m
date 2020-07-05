From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] test-inspect: reset locale after gtk_init()
Date: Sun, 5 Jul 2020 22:35:02 +0200
Message-ID: <20200705203502.dwctpjxtqfwaz7bd@ltop.local>
References: <20200705185013.8578-1-davidsondfgl@gmail.com>
 <CAHk-=wjqh1KOVWaP=xPZH_9grwDVtCMitWOb4vtKj+cB0jghBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgGEUfF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 16:35:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A910C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 13:35:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z17so32966749edr.9
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 13:35:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wjqh1KOVWaP=xPZH_9grwDVtCMitWOb4vtKj+cB0jghBw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidson Francis <davidsondfgl@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 05, 2020 at 12:12:55PM -0700, Linus Torvalds wrote:
> On Sun, Jul 5, 2020 at 11:51 AM Davidson Francis <davidsondfgl@gmail.com> wrote:
> >
> > The test-inspect tool uses GTK to visualize symbol nodes. It turns
> > out that gtk_init() implicitly sets the locale to the system locale,
> > and since Sparse uses strtod()/strtold() for parsing floating-point
> > numbers in expressions, parsing becomes locale-dependent.

Oh yes, indeed :(
Thanks for the patch.
 
> We probably shouldn't be using strtod/strtold in the first place
> because of issues like this, but I think your patch is likely the
> simplest fix.

Yes. 
 
> It _might_ be a good idea to limit it to LC_NUMERIC instead of LC_ALL,
> but who knows.. I'm not sure what else might be affected (and I'm not
> sure how good LC_NUMERIC support is on all platforms)

Well, checking the standard, I see that strtold() first strips
whitespaces as defined by isspace() and isspace() itself depends
on LC_CTYPE. So, for the moment, I prefer to take Davidson's
patch as is this (OTOH, we already depend on isspace() anyway).

-- Luc
