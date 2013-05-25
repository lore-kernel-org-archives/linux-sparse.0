From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Sat, 25 May 2013 13:30:27 -0700
Message-ID: <20130525203027.GA31179@leaf>
References: <519BC851.5090202@ramsay1.demon.co.uk>
 <20130521220546.GD11463@jtriplet-mobl1>
 <519D4031.8010004@ramsay1.demon.co.uk>
 <20130522225410.GA12285@jtriplet-mobl1>
 <51A11077.2000605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49694 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757944Ab3EYUag (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 May 2013 16:30:36 -0400
Content-Disposition: inline
In-Reply-To: <51A11077.2000605@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, May 25, 2013 at 08:26:47PM +0100, Ramsay Jones wrote:
> Josh Triplett wrote:
> > On Wed, May 22, 2013 at 11:01:21PM +0100, Ramsay Jones wrote:
> >> Josh Triplett wrote:
> >>> On Tue, May 21, 2013 at 08:17:37PM +0100, Ramsay Jones wrote:
> 
> >> The current "compat" layer has an string_to_ld() function, so maybe
> >> there should be an ld_to_string()? dunno.
> > 
> > That seems like the best plan, if you can find a portable one to
> > include.
> 
> Hmm, I'm not sure I understand; in this case, ld_to_string() would just
> cast to double in order to sprintf. ;-)

I meant, you could find some code that actually knows how to turn a
long double into a string directly, and include that for compatibility.

> >>>> --- a/pre-process.c
> >>>> +++ b/pre-process.c
> >>>> @@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
> >>>>  	} else if (token->ident == &__DATE___ident) {
> >>>>  		if (!t)
> >>>>  			time(&t);
> >>>> +#if !defined(__MINGW32__)
> >>>>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
> >>>> +#else
> >>>> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
> >>>> +		if (buffer[4] == '0') buffer[4] = ' ';
> >>>> +#endif
> >>> To the best of my knowledge, nothing guarantees the length of %b, so the
> >>> [4] here seems wrong.
> >>
> >> Yes, this was just a quick hack to compensate for the lack of the
> >> "%e" format specifier in the msvc strftime(). (elsewhere the lack
> >> of "%T" was easier to replace). I will have to think about this.
> >> Any ideas?
> > 
> > strftime returns the number of characters it generated; just format the
> > "%b " separately so you have the offset needed for the %d and the
> > modification.
> 
> Yep, I'll look into it. Having said that, I'm not sure we need to make
> this string identical on all systems. dunno.

It needs to exactly match what GCC would produce on the same system.

- Josh Triplett
