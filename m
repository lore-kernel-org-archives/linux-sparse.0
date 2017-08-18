From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 07:26:54 -0700
Message-ID: <52FF1757-7F61-4195-9CE7-DCF1662E6E90@joshtriplett.org>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54702 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdHRO07 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 10:26:59 -0400
In-Reply-To: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On August 18, 2017 6:20:42 AM PDT, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
>Hi Josh,
>
>I was thinking lately about sparse's context checking.
>I had an idea and I wondered if it hasn't already been
>tried or discussed.
>
>The context checking essentially works with the instruction
>OP_CONTEXT, that do nothing more than adding or subtracting
>some constant value to 'the context'. Then, at checking time,
>these instructions are interpreted along all the paths and if
>there is a disagreement between values from different paths,
>it emits a 'context imbalance' warning (there is also the
>checks for the expected return value of the context).
>
>My idea/question is the following: this interpretation
>is already done for all 'normal' values. So couldn't we
>consider the context as a special kind of 'variable',
>use a normal pseudo for it, use phi-nodes on them and
>let the normal simplification process act on them?
>If the context is (proveably) well balanced, there
>shouldn't be any phi-node left for this context.
>
>I'm not sure if there would be any significant advantage,
>but it seems to me that what is currently done is
>somehow redundant with the 'normal' processing.
>It could also maybe help to have several independent
>contexts.

I'd love to see sparse doing more general value tracking, for this and other purposes. And yes, that would help with tracking multiple contexts.

