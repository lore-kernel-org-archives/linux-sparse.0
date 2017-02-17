From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Fri, 17 Feb 2017 15:16:15 +0100
Message-ID: <20170217141613.ndkbib7a3cjz7y4n@macbook.local>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
 <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
 <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
 <20170217123744.jtog4rwpt6k6pyg3@macbook.local>
 <76b5465a-ef93-0ab1-f81a-c2d4c406482f@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38412 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934519AbdBQOQV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 09:16:21 -0500
Received: by mail-wm0-f44.google.com with SMTP id r141so11128550wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 06:16:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <76b5465a-ef93-0ab1-f81a-c2d4c406482f@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 17, 2017 at 01:13:51PM +0000, Edward Cree wrote:
> On 17/02/17 12:37, Luc Van Oostenryck wrote:
> > In fact this warning is correct, by design.
> > Your not supposed to cast a bitwise type, even zero.
> But you _are_ allowed to initialise a bitwise typed variable with zero...
> This is inconsistent; if a value is implicitly convertible to a type, it
>  should also be legal to cast it explicitly to that type.  Such is the
>  case with all types in standard C.
> So it's my opinion that the design is wrong.
> > Here is a few examples that doesn't give a warning:
> >       mask[1] = 0;
> >       mask[2] = ~msk;
> >       mask[3] = ~(__force __be32) 0;
> >       mask[4] = ~({ __be32 msk = 0; msk; });
> >
> > The canonical way to do what you need is via the (__force ...) cast.
> > In fact, in the driver you're talking about, just a few lines above
> > this fill_mask() function, there is a few masks already defined that
> > do exactly this, like IP4_ADDR_FULL_MASK.
> Yes, and I'd actually like to be able to remove __force from those casts as
>  well; __forced casts are a very big hammer that imho should be confined to
>  things like architecture-specific code.  They should not be needed in
>  drivers; they certainly should not be needed for a conversion that can
>  occur implicitly.

Well, it's a bit the same for all casts: you should not abuse them but theys
have their uses.

> You mention that ({ __be32 msk = 0; msk; }) works.  But surely that is a
>  strictly less forceful cast than (__be32)0, since it is using an implicit
>  conversion, and if that doesn't give a warning, then neither should the
>  explicit cast.
> 
> So can you explain to me why 0 should be treated specially by _everything
>  except_ the cast operator?

It was a design decision, justified (I think) by:
- 0 is already magic in C (can be used to initialize integer *and* pointers)
- since 0 is a constant that make sense for all sizes, have the same 
  representation in big endian and little endian, ... it can be used for
  all bitwise types.

I think the answer to your question could be: "since it's best to avoid casts,
especially unnneded ones for 0 zero you don't need a cast, it's good to warn
about it".

Luc
