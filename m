From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 03/13] expression: examine constness of binops and
 alike at evaluation only
Date: Tue, 26 Jan 2016 18:24:40 +0100
Message-ID: <20160126172438.GA989@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87h9i1g19d.fsf@gmail.com>
 <20160126001412.GA45368@macpro.local>
 <87r3h4bas0.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35994 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966811AbcAZRYn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jan 2016 12:24:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so18573484wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2016 09:24:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r3h4bas0.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Jan 26, 2016 at 04:50:07PM +0100, Nicolai Stange wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> 
> > On Mon, Jan 25, 2016 at 03:52:14PM +0100, Nicolai Stange wrote:
> >> +	[0 < 0.] = 0,						// KO
> >
> > It's not clear to me what the standrad says about this case.
> > What about the constness of 'usual artihmetic conversions' ?
> > Also GCC don't complain on this one.
> 
> Within the square brackets, an integer constant expression is needed.
> 
> That's 6.6(6). "Floating constants that are immediate operands of casts"
> are allowed. Implicitly promoted types are not, at least to my
> interpretation.

Yes, I saw that the standard isn't explicit about it.
The way I see things is:
- I don't see any reason why an explicit conversion would preserve
  constness while an implicit one would not.
- intuitively, when I read the code I see that the result of this
  expression is can be known at compile time.

But well ... I have the same issue with [(int) (0 + 0.0)] which
is clearly not allowed by the standard while [(int) 0.0] is.

Maybe those should be relaxed latter and we can invoke 6.6(10):
	An implementation may accept other forms of constant expressions

OTOH, who cares about floats ;)


Reading a bit more about it ...

For the designator in the array initializer (but also probably elsewhere)
6.7.8(6) first uses 
	 [ <i>constant-expression<\i> ]
and then
	and the expression shall be an integer constant expression.

Can this last 'integer constant expression' be interpreted as 'constant
expression of integer type'?
This could be considered to be coherent with the footnote 99) in 6.6(6)
followed by 6.6(7).

I don't know, it's something for language lawyers.


Luc
