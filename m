From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 21:47:10 +0100
Message-ID: <20170224204710.hlhjv7ncir25ptd6@macpro.local>
References: <20170224180759.GB16328@bombadil.infradead.org>
 <CA+55aFwwv+tMb1-7u7EzVxLrn1CtdQ2Wu7jXTfxV7DrzrROmvg@mail.gmail.com>
 <20170224201152.7skvolezq4j75su6@macpro.local>
 <20170224204356.hhfvnd6ballotrqu@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34399 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXUrU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 15:47:20 -0500
Received: by mail-wm0-f43.google.com with SMTP id 196so10575511wmm.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Feb 2017 12:47:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170224204356.hhfvnd6ballotrqu@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Feb 24, 2017 at 12:43:56PM -0800, Josh Triplett wrote:
> On Fri, Feb 24, 2017 at 09:11:53PM +0100, Luc Van Oostenryck wrote:
> > I'm not very sure what are the cases in wich Matthew is really
> > interested but I suppose that, even after preprocessing and
> > elimination of if (0) {...}, a return statement in the middle
> > of a compound statement is very often unintentional. 
> > That should be easy to check.
> 
> By "middle of a compound statement", you mean an unconditional return
> followed by more code?  Yes, that seems like something reasonable to
> statically check.
> 
> - Josh Triplett

Yes, it's what I meant.

Luc
