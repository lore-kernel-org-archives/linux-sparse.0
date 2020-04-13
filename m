From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Mon, 13 Apr 2020 10:52:19 -0700
Message-ID: <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com> <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387436AbgDMRwj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 13:52:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED2C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:52:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r7so9585511ljg.13
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:52:38 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c21sm8542851lfh.16.2020.04.13.10.52.35
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:52:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h25so9594819lja.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 10:52:35 -0700 (PDT)
In-Reply-To: <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 9:16 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Note: the label's symbols are still created in the function
>       scope since they belong to a single namespace.

Oh, I saw that 13/17 and was like "yeah, this is the right thing to
do", because I thought you were going in a different direction.

But then here in 15/17 I think you're doing it wrong.

Just give the symbol the proper scope, and make it simply not even
_parse_ right if somebody tries to use a label from the wrong scope,
instead of making the symbol visible, and then having to check whether
the scopes nested right later.

So I think you should just bite the bullet, and change the
bind_symbol() function so that a NS_LABEL is bound to label scope.

Then you can remove this 15/17 entirely (and all the "is this scope
nesting" code - nesting is automatically enforced by the symbol
scope).

I think that's a much cleaner approach. Yes, it gives a different
error from gcc, but I think it's a *better* error.

This:

   int fn1(int arg)
   {
      target:
         return 0;
   }

   int fn2(int arg)
   {
      goto target;
   }

is invalid code, and 'target' isn't even visible in fn2, because it is
a local label to fn1.

I think the exact same thing is the right thing to do for expression
statements, so

   int fn(int arg)
   {
      goto inside;
      return ({ inside: 0; });
   }

should fail with the exact same error message of having an undefined
label (which sparse currently gets wrong too, but you're fixing that
elsewhere).

Because "inside" simply shouldn't be defined at all in the outer
scope, and you can only branch _within_ a statement expression, the
same way you can only branch within a function.

So I think statement expressions should basically work kind of like
local "nested functions": they have access to the state outside, but
the outside doesn't have access to the state inside that statement
expression.

           Linus
