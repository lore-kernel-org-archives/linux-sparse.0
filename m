From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 10:33:37 -0800
Message-ID: <CA+55aFwwv+tMb1-7u7EzVxLrn1CtdQ2Wu7jXTfxV7DrzrROmvg@mail.gmail.com>
References: <20170224180759.GB16328@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ot0-f181.google.com ([74.125.82.181]:36236 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXSdi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 13:33:38 -0500
Received: by mail-ot0-f181.google.com with SMTP id j38so19625552otb.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Feb 2017 10:33:38 -0800 (PST)
In-Reply-To: <20170224180759.GB16328@bombadil.infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, Feb 24, 2017 at 10:07 AM, Matthew Wilcox <willy@infradead.org> wrote:
>
> Maybe sparse could warn about code after an unconditional return
> statement?

This is not likely to be a very successful model, I suspect.

You already partly see the problem:

> I wouldn't like to see it warn about code after a conditional
> return statement where the condition is always true; I think that would
> have a lot of false positives due to macros.

because the thing is, we actually have tons and tons of unreachable
code due to things like

   if (IS_ENABLED(CONFIG_XYZ)) {...

which allows us much cleaner code than using things like #ifdef's.

So yes, unreachable code in general is actually very common.

And it's not just in Linux - think of all the code you've ever seen
that has used "ASSERT()", which often ends up doing exactly the same
things. Even if you'd think that "when debugging isn't enabled, it
just goes away entirely", you often end up having things that
basically end up expanding to things like

    do { if (0) {..} } while (0)

inside macros very consciously in order to avoid compiler warnings
about unused variables etc when the variable is only used inside that
debug statement.

I realize that on the face of it, such a "if (0)" sounds insane, but
you can seriously just grep for that pattern in Linux:

    [torvalds@i7 linux]$ git grep 'if (0)' | wc -l
    156

now, getting back to your "limit it _only_ to code after an
unconditional 'return' statement" suggestion. The reason I don't
believe that will be all that useful either, is that a reasonable C
compiler (or something like sparse) simply doesn't even see many
conditionals.

That comes largely from how the C pre-processor is such a separate
phase and not actually integrated with the C syntax itself. So if any
of the conditionals above end up being done as cpp macros, it's
basically pretty much impossible to see them.

You'd actually likely be better off with something that doesn't
actually really parse the C code, but parses the code _without_ doing
preprocessor expansion, and basically look at it without doing the
full code analysis. More like what tools like checkpatch etc do -
lookign for the superficial patterns, rather than the patterns that
you see when you actually expand everything.

I'm not disputing that you can always find particular cases where a
warning would make sense, I just have a very strong suspicion that you
end up having to limit the condition you search for _so_ much that it
ends up being basically pointless for anything but the one or two
cases you already knew about and that triggered it.

              Linus
