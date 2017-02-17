From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Fri, 17 Feb 2017 13:37:46 +0100
Message-ID: <20170217123744.jtog4rwpt6k6pyg3@macbook.local>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
 <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
 <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34971 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbdBQMhw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 07:37:52 -0500
Received: by mail-wm0-f43.google.com with SMTP id v186so13822792wmd.0
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 04:37:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 17, 2017 at 11:01:53AM +0000, Edward Cree wrote:
> (The actual code that is hitting this is drivers/net/ethernet/sfc/ethtool.c
>  in recent Linux trees.)
> From this I was able to create a new synthetic example, which *does*
>  reproduce the warning:
> 
>     typedef unsigned int __attribute__((bitwise)) __be32;
> 
>     static inline void ip6_fill_mask(__be32 *mask)
>     {
>         mask[0] = mask[1] = mask[2] = mask[3] = ~(__be32)0;
>     }
> 
>     static void f(void)
>     {
>         __be32 mask[4];
> 
>         ip6_fill_mask(mask);
>     }
> 
> Feeding the above program to sparse yields the output
> "test.c:5:51: warning: cast to restricted __be32"
> 
> In fact the example can be reduced even further:
> 
>     typedef unsigned int __attribute__((bitwise)) __be32;
> 
>     static __be32 foo = (__be32)0;
> 
> yields "test.c:3:22: warning: cast to restricted __be32"
> 
> My apologies for previously providing an incorrect example; I should have
>  tested it rather than assuming, as I did, that a static inline that was
>  never called would still be type-checked.

No worries.

In fact this warning is correct, by design.
Your not supposed to cast a bitwise type, even zero.
Here is a few examples that doesn't give a warning:
	mask[1] = 0;
	mask[2] = ~msk;
	mask[3] = ~(__force __be32) 0;
	mask[4] = ~({ __be32 msk = 0; msk; });

The canonical way to do what you need is via the (__force ...) cast.
In fact, in the driver you're talking about, just a few lines above
this fill_mask() function, there is a few masks already defined that
do exactly this, like IP4_ADDR_FULL_MASK.

Luc

> The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
