From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Sparse preprocessing bug with zero-arg variadic macros
Date: Thu, 31 Aug 2017 21:54:33 +0100
Message-ID: <20170831205433.GQ5426@ZenIV.linux.org.uk>
References: <20170831133400.zjeaxhf25rbdftic@treble>
 <CA+55aFy8sXZKibU_RK-+hu_SD-QMaWxxsAQNYALkmvMiYfEo=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:53102 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdHaUyg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 16:54:36 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFy8sXZKibU_RK-+hu_SD-QMaWxxsAQNYALkmvMiYfEo=Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Aug 31, 2017 at 10:19:32AM -0700, Linus Torvalds wrote:
> On Thu, Aug 31, 2017 at 6:34 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > I think I'm seeing a bug in the sparse preprocessor.  I've reduced it to
> > the following test case.
> 
> I think the real reduced test-case is just this:
> 
>     #define ARGS_APPEND(...) ,## __VA_ARGS__
>     ARGS_APPEND()
> 
> and you can run if through "sparse -E" to see the comma (while gcc -E
> does not have it).
> 
> I'm adding Al to the cc list because he's the pre-processor person.
> Hopefully he has gotten out from under most of his emails from his
> move.
> 
> sparse gets it right if there is any non-VA_ARGS argument to the
> symbol, but not if __VA_ARGS__ is all of the argument to the macro.

Umm...  The problem is in collect_arguments() - it treats that as "argument
present, expands to empty" rather than "argument absent" in case when the
argument list consists of ... and no arguments are given.

What a mess...  Note that for non-vararg it *is* the right interpretation
(with #define A(x) [x] we will have A() interpreted as "empty token sequence
as the only argument", not "no arguments given").  For vararg case we
normally do not need to distinguish "not given" and "empty" - the only
thing that cares is exactly the ,## kludge.  There with
#define B(x,...) [x,##__VA_ARGS__]
B(1) and B(1,) yield [1] and [1,] resp.  And for everything other than
"just ..." we even get it right...

I see what's going on there; will post a fix in a few.
