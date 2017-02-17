From: Edward Cree <ecree@solarflare.com>
Subject: Re: Casting 0 to a __bitwise type
Date: Fri, 17 Feb 2017 11:01:53 +0000
Message-ID: <5dcaea41-102c-ce1f-a4eb-6c1b917ba31c@solarflare.com>
References: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
 <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo01.seg.att.com ([209.65.160.76]:33219 "EHLO
        nbfkord-smmo01.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbdBQLCH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 06:02:07 -0500
In-Reply-To: <20170214225127.gxvtfnbe5dkqp4lq@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On 14/02/17 22:51, Luc Van Oostenryck wrote:
> On Tue, Feb 14, 2017 at 09:36:40PM +0000, Edward Cree wrote:
>> I'm given to understand that bitwise types consider 0 'special', in that
>>  sparse will allow, say:
>>         typedef __u32 __bitwise __be32;
>>         __be32 value = 0;
>> However, it appears that if I try to cast a constant 0 to a bitwise type,
>>         static inline void ip6_fill_mask(__be32 *mask)
>>         {
>>                 mask[0] = mask[1] = mask[2] = mask[3] = ~(__be32)0;
>>         }
>> sparse complains "warning: cast to restricted __be32".
> I can't reproduce this with the current head.
> Wich version of sparse are you using? Can you retry with sparse's head?
I was using v0.5.0, which appears to be the most recent tag.
With latest HEAD (9208e04972f2) I still reproduce.
*However*, on either version I can only reproduce it 'in situ' in my code, it
 turns out that the synthetic example I gave above does _not_ reproduce it.
sparse only gives the warning if the function is _used_; if I comment out the
 calls to the function in my 'real' code, the warning goes away.  The calls
 are passing a __be32[4] as the mask argument.
(The actual code that is hitting this is drivers/net/ethernet/sfc/ethtool.c
 in recent Linux trees.)
From this I was able to create a new synthetic example, which *does*
 reproduce the warning:

    typedef unsigned int __attribute__((bitwise)) __be32;

    static inline void ip6_fill_mask(__be32 *mask)
    {
        mask[0] = mask[1] = mask[2] = mask[3] = ~(__be32)0;
    }

    static void f(void)
    {
        __be32 mask[4];

        ip6_fill_mask(mask);
    }

Feeding the above program to sparse yields the output
"test.c:5:51: warning: cast to restricted __be32"

In fact the example can be reduced even further:

    typedef unsigned int __attribute__((bitwise)) __be32;

    static __be32 foo = (__be32)0;

yields "test.c:3:22: warning: cast to restricted __be32"

My apologies for previously providing an incorrect example; I should have
 tested it rather than assuming, as I did, that a static inline that was
 never called would still be type-checked.
-Ed
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
