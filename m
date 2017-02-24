From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 21:11:53 +0100
Message-ID: <20170224201152.7skvolezq4j75su6@macpro.local>
References: <20170224180759.GB16328@bombadil.infradead.org>
 <CA+55aFwwv+tMb1-7u7EzVxLrn1CtdQ2Wu7jXTfxV7DrzrROmvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34314 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdBXUL6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 15:11:58 -0500
Received: by mail-wr0-f194.google.com with SMTP id 89so3560025wrr.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Feb 2017 12:11:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFwwv+tMb1-7u7EzVxLrn1CtdQ2Wu7jXTfxV7DrzrROmvg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Feb 24, 2017 at 10:33:37AM -0800, Linus Torvalds wrote:
> On Fri, Feb 24, 2017 at 10:07 AM, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Maybe sparse could warn about code after an unconditional return
> > statement?
> 
> This is not likely to be a very successful model, I suspect.
> 
> You already partly see the problem:
> 
> > I wouldn't like to see it warn about code after a conditional
> > return statement where the condition is always true; I think that would
> > have a lot of false positives due to macros.
> 
> because the thing is, we actually have tons and tons of unreachable
> code due to things like
> 
>    if (IS_ENABLED(CONFIG_XYZ)) {...
> 
> which allows us much cleaner code than using things like #ifdef's.
> 
> So yes, unreachable code in general is actually very common.
> 

snip snip 

> 
> now, getting back to your "limit it _only_ to code after an
> unconditional 'return' statement" suggestion. The reason I don't
> believe that will be all that useful either, is that a reasonable C
> compiler (or something like sparse) simply doesn't even see many
> conditionals.
> 
> That comes largely from how the C pre-processor is such a separate
> phase and not actually integrated with the C syntax itself. So if any
> of the conditionals above end up being done as cpp macros, it's
> basically pretty much impossible to see them.
> 
> You'd actually likely be better off with something that doesn't
> actually really parse the C code, but parses the code _without_ doing
> preprocessor expansion, and basically look at it without doing the
> full code analysis. More like what tools like checkpatch etc do -
> lookign for the superficial patterns, rather than the patterns that
> you see when you actually expand everything.
> 
> I'm not disputing that you can always find particular cases where a
> warning would make sense, I just have a very strong suspicion that you
> end up having to limit the condition you search for _so_ much that it
> ends up being basically pointless for anything but the one or two
> cases you already knew about and that triggered it.
> 
>               Linus


I'm not very sure what are the cases in wich Matthew is really
interested but I suppose that, even after preprocessing and
elimination of if (0) {...}, a return statement in the middle
of a compound statement is very often unintentional. 
That should be easy to check.


Luc Van Oostenryck
