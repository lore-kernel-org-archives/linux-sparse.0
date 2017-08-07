From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Mon, 7 Aug 2017 03:21:00 +0200
Message-ID: <20170807012059.3xfmohmfebof4bot@ltop.local>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com>
 <20170806234441.vcpux6zyhfsfef3c@ltop.local>
 <CANeU7QnxyV2cXvvErVsX_7MivK5AO+7TEsxf=rCvX+seoOf94A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36294 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdHGBVD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:21:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id t201so56882278wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnxyV2cXvvErVsX_7MivK5AO+7TEsxf=rCvX+seoOf94A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 08:33:51PM -0400, Christopher Li wrote:
> On Sun, Aug 6, 2017 at 7:44 PM, Luc Van Oostenryck wrote:
>
> >> That I am very curios how it was done. See the above
> >> question.
> >
> > IMO, the best is to read the article. My code is
> > still very close to the article's pseudo-code.
> >
> > Basically, it's a lazy approach. Things are done
> > when possible and are delayed if not.
> 
> So you are building the SSA for the memory variable
> I assume?

No, directly from symbol to pseudos.
It's the beauty of this approach.
 
> Directly from the linearize process?

Yes, only the add_load() & add_store() is modified and 
instead of storing stuff in memory, it's directly translated
to pseudos & phi-nodes are created when needed.

> > More specifically, you can do what is needed in a BB
> > once you have all the parents, otherwise you need to
> > delay things. The article call this 'BB is sealed'
> > and there is a 'seal' operation that need to be called
> > to process what was delayed.
> > Complications arise with gotos (and the article doesn't
> > talk about them) but I've added a solution for it
> > (but I would like to return to it later).
> 
> I am missing the obvious. Where is this article?

I've put the reference at the top of the new file sssa.c:
/*
 * This is an implementation of the SSA construction algorithm:
 *	"Simple and Efficient Construction of Static Single Assignment Form"
 * by Matthias Braun, Sebastian Buchwald, Sebastian Hack, Roland Leissa,
 *    Christoph Mallon and Andreas Zwinkau.
 * cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf
 */

> > From what I've seen/heard this algo have been pretty well
> > received. Personnaly, I'm very happy with its simplicity
> > and its result.
> 
> Great!
> 
> >
> > One thing that is missing is the more complex cases
> > with trivial phi-nodes.
> 
> Can you clarify?

It's a question of related cycles of phi-nodes.
Some can be simplified away, it's described in the article.
The simple case of a simple cycle is already handled.

> > Another thing I would like to change is the ptrmap
> > implementation I've added: it need to be hash-table based
> > (but it's only an implementation detail that matters
> > for performance on really big functions).
> 
> Which ptrmap? The one used for CSE?

No, no.
I needed a map between symbols and pseudos.
It's in a separate file: ptrmap.c

-- Luc
