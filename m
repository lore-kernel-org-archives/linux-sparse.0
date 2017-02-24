From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 12:43:56 -0800
Message-ID: <20170224204356.hhfvnd6ballotrqu@x>
References: <20170224180759.GB16328@bombadil.infradead.org>
 <CA+55aFwwv+tMb1-7u7EzVxLrn1CtdQ2Wu7jXTfxV7DrzrROmvg@mail.gmail.com>
 <20170224201152.7skvolezq4j75su6@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:51202 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdBXUoE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 15:44:04 -0500
Content-Disposition: inline
In-Reply-To: <20170224201152.7skvolezq4j75su6@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Feb 24, 2017 at 09:11:53PM +0100, Luc Van Oostenryck wrote:
> I'm not very sure what are the cases in wich Matthew is really
> interested but I suppose that, even after preprocessing and
> elimination of if (0) {...}, a return statement in the middle
> of a compound statement is very often unintentional. 
> That should be easy to check.

By "middle of a compound statement", you mean an unconditional return
followed by more code?  Yes, that seems like something reasonable to
statically check.

- Josh Triplett
