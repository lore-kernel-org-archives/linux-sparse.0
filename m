From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] make for-loop statement simpler
Date: Thu, 29 Jun 2017 05:18:05 +0200
Message-ID: <20170629031804.tptm423ouo3a5ma4@ltop.local>
References: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
 <20170628204918.25853-3-luc.vanoostenryck@gmail.com>
 <CANeU7Qm8Qjf--w-7dc1J5qXhORPoPduc859-tk0-75L8Gx5iww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37695 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdF2DSK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Jun 2017 23:18:10 -0400
Received: by mail-wm0-f44.google.com with SMTP id i127so302272wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 20:18:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm8Qjf--w-7dc1J5qXhORPoPduc859-tk0-75L8Gx5iww@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jun 28, 2017 at 05:18:18PM -0700, Christopher Li wrote:
> On Wed, Jun 28, 2017 at 1:49 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The for-statement needs a lot of fields in struct statement, much
> > more than any other statement. This is due to the complexity of
> > the for-statement.
> >
> > However part of this complexity can be removed by processing the
> > 'pre-' statement separately from the loop. This is equivalent to
> > transform a single-statement for-loop like:
> >         for (pre; cond; post)
> >                 body
> > into a compound statement like:
> >         pre;
> >         for (;cond; post)
> >                 body;
> 
> Notice that the two are not exactly the same.
> 
> quote 6.8.5 3"The declaration part of a for statement shall only
> declare identifiers for
> objects having storage class auto or register."
> 
> However sparse already validate the for statement declaration in function
> "validate_for_loop_decl()" so I think it is fine.

Yes, and the patch take care of the scope too.

-- Luc
