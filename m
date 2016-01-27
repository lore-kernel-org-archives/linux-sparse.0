From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v2 03/13] expression: examine constness of binops and alike at evaluation only
Date: Wed, 27 Jan 2016 11:42:32 +0100
Message-ID: <87vb6f8fs7.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com> <87h9i1g19d.fsf@gmail.com>
	<20160126001412.GA45368@macpro.local> <87r3h4bas0.fsf@gmail.com>
	<20160126172438.GA989@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35033 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcA0Kmg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jan 2016 05:42:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so2521945wmz.2
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2016 02:42:35 -0800 (PST)
In-Reply-To: <20160126172438.GA989@macpro.local> (Luc Van Oostenryck's message
	of "Tue, 26 Jan 2016 18:24:40 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Tue, Jan 26, 2016 at 04:50:07PM +0100, Nicolai Stange wrote:
>> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
>> 
>> > On Mon, Jan 25, 2016 at 03:52:14PM +0100, Nicolai Stange wrote:
>> >> +	[0 < 0.] = 0,						// KO
>> >
>> > It's not clear to me what the standrad says about this case.
>> > What about the constness of 'usual artihmetic conversions' ?
>> > Also GCC don't complain on this one.
>> 
>> Within the square brackets, an integer constant expression is needed.
>> 
>> That's 6.6(6). "Floating constants that are immediate operands of casts"
>> are allowed. Implicitly promoted types are not, at least to my
>> interpretation.
>
> Yes, I saw that the standard isn't explicit about it.
> The way I see things is:
> - I don't see any reason why an explicit conversion would preserve
>   constness while an implicit one would not.

Just to make it explicit here, we're not talking about "arithmetic
constant expressions", but "integer constant expressions".

I think the standard designers made this distinction in order to
differentiate between something so const that it can be used in static
initializers (arith. constexpr.) vs. sth. so const and _free of
surprises_ (integer constexpr.) that it can safely be used in various
sensitive places.

For example:

  #define PI 3.14

  switch(foo) {
    case PI:
     ...
  };

should certainly not be allowed, while a

  #define PI 3.14

  switch(foo) {
    case (int)PI:
     ...
  };

signals the compiler that the programmer knows (or pretends to know)
what he's doing, so it should be allowed.

OTOH,
  0 < 0.
is clearly an arithmetic constant expression and can be used in static
initializers or wherever.

This is *my* interpretation of why the standard designers did it that
way. Of course I might be wrong though.


> - intuitively, when I read the code I see that the result of this
>   expression is can be known at compile time.

Yes, the compiler knows that it's an _arithmetic_ constant expression.

>
> But well ... I have the same issue with [(int) (0 + 0.0)] which

Again, programmers writing code like this don't even pretend that they
know what they're doing. Why should a compiler or even sparse trust
them?

> is clearly not allowed by the standard while [(int) 0.0] is.


>
> Maybe those should be relaxed latter and we can invoke 6.6(10):
> 	An implementation may accept other forms of constant expressions
>
> OTOH, who cares about floats ;)

A true word. Thus, I suggest not to introduce any additional form of
constness at this moment. In the end, we wanted to be stricter than gcc.

If real world problems arise, we can easily return to that question.

But as you said, certainly nobody cares.

>
>
> Reading a bit more about it ...
>
> For the designator in the array initializer (but also probably elsewhere)
> 6.7.8(6) first uses 
> 	 [ <i>constant-expression<\i> ]
> and then
> 	and the expression shall be an integer constant expression.
>
> Can this last 'integer constant expression' be interpreted as 'constant
> expression of integer type'?

I'm sure that if the standard authors' real intents had been to allow
arithmetic constant expressions of integer types at this place, they
would have said so and not used the well defined term "integer constant
expression" at this point.

> This could be considered to be coherent with the footnote 99) in 6.6(6)
> followed by 6.6(7).
>
> I don't know, it's something for language lawyers.

If you don't agree with my interpretation, we could very well try to get
some language layer into our boat.

OTOH, if you agree that we could safely leave the semantics as they
currently are, I could just go on and prepare v3...

Nicolai
