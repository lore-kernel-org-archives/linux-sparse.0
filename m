From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 03/13] expression: examine constness of binops and
 alike at evaluation only
Date: Wed, 27 Jan 2016 19:00:03 +0100
Message-ID: <20160127180000.GA13556@macbook.lan>
References: <87twm1g1go.fsf@gmail.com>
 <87h9i1g19d.fsf@gmail.com>
 <20160126001412.GA45368@macpro.local>
 <87r3h4bas0.fsf@gmail.com>
 <20160126172438.GA989@macpro.local>
 <87vb6f8fs7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35890 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643AbcA0SAM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jan 2016 13:00:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id l65so4755801wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 27 Jan 2016 10:00:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87vb6f8fs7.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Jan 27, 2016 at 11:42:32AM +0100, Nicolai Stange wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

...

> > Maybe those should be relaxed latter and we can invoke 6.6(10):
> > 	An implementation may accept other forms of constant expressions
> >
> > OTOH, who cares about floats ;)
> 
> A true word. Thus, I suggest not to introduce any additional form of
> constness at this moment. In the end, we wanted to be stricter than gcc.
> 
> If real world problems arise, we can easily return to that question.

It's exactly what I meant.
 
...

> I'm sure that if the standard authors' real intents had been to allow
> arithmetic constant expressions of integer types at this place, they
> would have said so and not used the well defined term "integer constant
> expression" at this point.

I would definitively appreciate the standard being less ambiguous.
And I find the footnote 99) in 6.6 really confusing.
 
> > This could be considered to be coherent with the footnote 99) in 6.6(6)
> > followed by 6.6(7).
> >
> > I don't know, it's something for language lawyers.
> 
> If you don't agree with my interpretation, we could very well try to get
> some language layer into our boat.
> 
> OTOH, if you agree that we could safely leave the semantics as they
> currently are, I could just go on and prepare v3...

It's not that I really disagree with your interpretation, nor that I totally agree
with it. It's more me playing devil's advocate, insuring that the reasonable cases
are well covered.
It's the fact that GCC and your code differ on this point that made me stop at it
because it could make your changes less valuable which we don't want.

My remark about a language lawyer was not a serious one, it was more a way to say
	"let's not spend more time on it for now".

Please go on.
And with what you have put in place for the expression constness it will be very easy
to relax some of the rules when there will be some needs for it.


Luc
