From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Sparse preprocessing bug with zero-arg variadic macros
Date: Thu, 31 Aug 2017 22:48:10 +0100
Message-ID: <20170831214810.GS5426@ZenIV.linux.org.uk>
References: <20170831133400.zjeaxhf25rbdftic@treble>
 <CA+55aFy8sXZKibU_RK-+hu_SD-QMaWxxsAQNYALkmvMiYfEo=Q@mail.gmail.com>
 <20170831205433.GQ5426@ZenIV.linux.org.uk>
 <20170831210922.GA9227@ZenIV.linux.org.uk>
 <20170831213444.6yeyfcrry6utaeih@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54210 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdHaVsM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 17:48:12 -0400
Content-Disposition: inline
In-Reply-To: <20170831213444.6yeyfcrry6utaeih@cloud>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Aug 31, 2017 at 02:34:44PM -0700, Josh Triplett wrote:
> On Thu, Aug 31, 2017 at 10:09:22PM +0100, Al Viro wrote:
> > On Thu, Aug 31, 2017 at 09:54:33PM +0100, Al Viro wrote:
> > > What a mess...  Note that for non-vararg it *is* the right interpretation
> > > (with #define A(x) [x] we will have A() interpreted as "empty token sequence
> > > as the only argument", not "no arguments given").  For vararg case we
> > > normally do not need to distinguish "not given" and "empty" - the only
> > > thing that cares is exactly the ,## kludge.  There with
> > > #define B(x,...) [x,##__VA_ARGS__]
> > > B(1) and B(1,) yield [1] and [1,] resp.  And for everything other than
> > > "just ..." we even get it right...
> > > 
> > > I see what's going on there; will post a fix in a few.
> > 
> > 
> > Fix macro argument parsing for (...) case
> > 
> > Nasty corner case for the sake of ,##__VA_ARGS__ perversion - for something
> > like #define A(x,...) [x,##__VA_ARGS] we want A(1) to expand to [1] and
> > A(1,) - to [1,].  In other words, "no vararg given" and "vararg empty" are
> > different and need to be distinguished.  Unfortunately, in case when there
> > was nothing but vararg we got it wrong - #define A(...) ,##__VA_ARGS ended
> > up with A() interpreted as "one empty argument" (as it would in non-vararg
> > case) rather than "zero arguments".
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> > diff --git a/pre-process.c b/pre-process.c
> > index 74414df..8800dce 100644
> > --- a/pre-process.c
> > +++ b/pre-process.c
> > @@ -296,9 +296,11 @@ static int collect_arguments(struct token *start, struct token *arglist, struct
> >  		for (count = 0; count < wanted; count++) {
> >  			struct argcount *p = &arglist->next->count;
> >  			next = collect_arg(start, p->vararg, &what->pos, p->normal);
> > -			arglist = arglist->next->next;
> >  			if (eof_token(next))
> >  				goto Eclosing;
> > +			if (p->vararg && wanted == 1 && eof_token(start->next))
> > +				break;
> > +			arglist = arglist->next->next;
> >  			args[count].arg = start->next;
> >  			args[count].n_normal = p->normal;
> >  			args[count].n_quoted = p->quoted;
> 
> This looks plausible; we should also add a test for it, though.

throw this in, perhaps?

diff --git a/validation/preprocessor/preprocessor23.c b/validation/preprocessor/preprocessor23.c
index 25be508..a778483 100644
--- a/validation/preprocessor/preprocessor23.c
+++ b/validation/preprocessor/preprocessor23.c
@@ -12,6 +12,9 @@ I(,)
 I(x,)
 I(,x)
 I(x,x)
+#define J(...) ,##__VA_ARGS__
+J()
+J(x)
 /*
  * check-name: Preprocessor #23
  * check-command: sparse -E $file
@@ -29,6 +32,7 @@ I(x,x)
 ,x
 ,x
 ,xx
+,x
  * check-output-end
  *
  * check-error-start
