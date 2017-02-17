From: Edward Cree <ecree@solarflare.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Fri, 17 Feb 2017 13:13:51 +0000
Message-ID: <76b5465a-ef93-0ab1-f81a-c2d4c406482f@solarflare.com>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
 <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
 <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
 <20170217123744.jtog4rwpt6k6pyg3@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo02.seg.att.com ([209.65.160.78]:54664 "EHLO
        nbfkord-smmo02.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755550AbdBQNOC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 08:14:02 -0500
In-Reply-To: <20170217123744.jtog4rwpt6k6pyg3@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On 17/02/17 12:37, Luc Van Oostenryck wrote:
> In fact this warning is correct, by design.
> Your not supposed to cast a bitwise type, even zero.
But you _are_ allowed to initialise a bitwise typed variable with zero...
This is inconsistent; if a value is implicitly convertible to a type, it
 should also be legal to cast it explicitly to that type.  Such is the
 case with all types in standard C.
So it's my opinion that the design is wrong.
> Here is a few examples that doesn't give a warning:
>       mask[1] = 0;
>       mask[2] = ~msk;
>       mask[3] = ~(__force __be32) 0;
>       mask[4] = ~({ __be32 msk = 0; msk; });
>
> The canonical way to do what you need is via the (__force ...) cast.
> In fact, in the driver you're talking about, just a few lines above
> this fill_mask() function, there is a few masks already defined that
> do exactly this, like IP4_ADDR_FULL_MASK.
Yes, and I'd actually like to be able to remove __force from those casts as
 well; __forced casts are a very big hammer that imho should be confined to
 things like architecture-specific code.  They should not be needed in
 drivers; they certainly should not be needed for a conversion that can
 occur implicitly.
You mention that ({ __be32 msk = 0; msk; }) works.  But surely that is a
 strictly less forceful cast than (__be32)0, since it is using an implicit
 conversion, and if that doesn't give a warning, then neither should the
 explicit cast.

So can you explain to me why 0 should be treated specially by _everything
 except_ the cast operator?

-Ed
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
