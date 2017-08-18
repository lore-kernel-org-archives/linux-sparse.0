From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 15:20:42 +0200
Message-ID: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35748 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdHRNUr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 09:20:47 -0400
Received: by mail-wr0-f177.google.com with SMTP id 49so61468695wrw.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 06:20:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

Hi Josh,

I was thinking lately about sparse's context checking.
I had an idea and I wondered if it hasn't already been
tried or discussed.

The context checking essentially works with the instruction
OP_CONTEXT, that do nothing more than adding or subtracting
some constant value to 'the context'. Then, at checking time,
these instructions are interpreted along all the paths and if
there is a disagreement between values from different paths,
it emits a 'context imbalance' warning (there is also the
checks for the expected return value of the context).

My idea/question is the following: this interpretation
is already done for all 'normal' values. So couldn't we
consider the context as a special kind of 'variable',
use a normal pseudo for it, use phi-nodes on them and
let the normal simplification process act on them?
If the context is (proveably) well balanced, there
shouldn't be any phi-node left for this context.

I'm not sure if there would be any significant advantage,
but it seems to me that what is currently done is
somehow redundant with the 'normal' processing.
It could also maybe help to have several independent
contexts.

[of course, we can't really use add/sub for the context
increase/decrease as we want to check if the context
don't become negative].


Best regards,
-- Luc
