From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Wed, 22 May 2013 15:54:10 -0700
Message-ID: <20130522225410.GA12285@jtriplet-mobl1>
References: <519BC851.5090202@ramsay1.demon.co.uk>
 <20130521220546.GD11463@jtriplet-mobl1>
 <519D4031.8010004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57597 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756843Ab3EVWyS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 18:54:18 -0400
Content-Disposition: inline
In-Reply-To: <519D4031.8010004@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, May 22, 2013 at 11:01:21PM +0100, Ramsay Jones wrote:
> Josh Triplett wrote:
> > On Tue, May 21, 2013 at 08:17:37PM +0100, Ramsay Jones wrote:
> >> @@ -336,10 +337,14 @@ const char *show_instruction(struct instruction *insn)
> >>  			
> >>  		switch (expr->type) {
> >>  		case EXPR_VALUE:
> >> -			buf += sprintf(buf, "%lld", expr->value);
> >> +			buf += sprintf(buf, "%"PRId64, expr->value);
> >>  			break;
> >>  		case EXPR_FVALUE:
> >> +#if !defined(__MINGW32__)
> >>  			buf += sprintf(buf, "%Lf", expr->fvalue);
> >> +#else
> >> +			buf += sprintf(buf, "%f", (double)expr->fvalue);
> >> +#endif
> > 
> > This seems really sad; does MinGW really have long double but no way to
> > print it?  Can we at least emit something here to indicate possible
> > truncation or loss of precision, if no means exists to print a long
> > double?
> 
> I couldn't find any means to do so, just from experimentation (I didn't
> have any MinGW specific gcc documentation). Thus, I tried:
[...]
> So, msvc knows about the L size modifier, but it treats a 'long double'
> the same as a 'double'.

Sigh.  Odd that GCC has different behavior there, but since MinGW uses
the same C library as Visual C (msvcrt), it does seem likely that the
underlying behavior would need to match.

> The current "compat" layer has an string_to_ld() function, so maybe
> there should be an ld_to_string()? dunno.

That seems like the best plan, if you can find a portable one to
include.

> >> @@ -463,7 +468,7 @@ const char *show_instruction(struct instruction *insn)
> >>  	}
> >>  
> >>  	if (buf >= buffer + sizeof(buffer))
> >> -		die("instruction buffer overflowed %td\n", buf - buffer);
> >> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
> > 
> > No, ptrdiff_t does not portably fit in int; it generally has the same
> > size as size_t (64-bit on 64-bit platforms).  Cast to "long long" and
> > use PRId64 if you must.
> 
> Yes, for the same reason, git does:
> 
>     printf("...%" PRIuMAX "...", (uintmax_t)(buf - buffer));
> 
> so I'll do that in the re-roll.

uintmax_t works; I suspect it might be overkill, but it'll work.

> >> --- a/pre-process.c
> >> +++ b/pre-process.c
> >> @@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
> >>  	} else if (token->ident == &__DATE___ident) {
> >>  		if (!t)
> >>  			time(&t);
> >> +#if !defined(__MINGW32__)
> >>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
> >> +#else
> >> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
> >> +		if (buffer[4] == '0') buffer[4] = ' ';
> >> +#endif
> > To the best of my knowledge, nothing guarantees the length of %b, so the
> > [4] here seems wrong.
> 
> Yes, this was just a quick hack to compensate for the lack of the
> "%e" format specifier in the msvc strftime(). (elsewhere the lack
> of "%T" was easier to replace). I will have to think about this.
> Any ideas?

strftime returns the number of characters it generated; just format the
"%b " separately so you have the offset needed for the %d and the
modification.

> >> --- a/tokenize.c
> >> +++ b/tokenize.c
> >> @@ -547,8 +547,8 @@ static int get_one_number(int c, int next, stream_t *stream)
> >>  	}
> >>  
> >>  	if (p == buffer_end) {
> >> -		sparse_error(stream_pos(stream), "number token exceeds %td characters",
> >> -		      buffer_end - buffer);
> >> +		sparse_error(stream_pos(stream), "number token exceeds %d characters",
> >> +		      (int)(buffer_end - buffer));
> > 
> > Same comment as above regarding ptrdiff_t.
> > 
> > - Josh Triplett
> 
> Thanks Josh. You hit every part of the patch that I wanted to
> tidy up! :-D

No problem; thanks for working on this!  I'd love to see sparse used for
Windows compilation.

Have you managed to use it with a mingw cross-compiler, by any chance?

- Josh Triplett
