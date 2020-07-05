From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 14/15] cleanup: move parsing helpers to parse.c
Date: Sun, 5 Jul 2020 22:45:00 +0200
Message-ID: <20200705204500.sl7xgkukhsittq56@ltop.local>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
 <20200705130220.26230-15-luc.vanoostenryck@gmail.com>
 <CAHk-=wh-Eb-LZawa7fH7BOmbq-t8t8GvaY7o9bEW9cGXZgKGsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgGEUpE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 16:45:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC6C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 13:45:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so32984457edb.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 13:45:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-Eb-LZawa7fH7BOmbq-t8t8GvaY7o9bEW9cGXZgKGsQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 05, 2020 at 10:27:36AM -0700, Linus Torvalds wrote:
> On Sun, Jul 5, 2020 at 6:02 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > lib.c contains 2-3 helpers for parsing. Move them to parse.c.
> 
> This makes sense, because it's not a "library" function if it's only
> used in one place.
> 
> HOWEVER.
> 
> When doing things like this, please also mark the resulting function
> static and remove the declaration from lib.h.
> 
> Otherwise it's entirely pointless, I feel.
> 
> Either it's a library function that gets used from other places (and
> lib.c/lib.h is an appropriate place), or it's a parsing-only helper
> function that _doesn't_ get used from other places (and it should be
> moved to parse.c and be static).
> 
> Not this half-way state that this patch seems to create.

Yes, I agree.
I see them as parsing-only helpers hence the move but (just)
expect() is also used in expression.c. I suppose it should be
fine to move the declaration to parse.h despite not being ideal.
Or maybe, I should just leave them in lib.c

-- Luc
