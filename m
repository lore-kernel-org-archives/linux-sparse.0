From: Edward Cree <ecree@solarflare.com>
Subject: Casting 0 to a __bitwise type
Date: Tue, 14 Feb 2017 21:36:40 +0000
Message-ID: <9c361aab-ee4b-8309-ff1a-b0e65bb93c5d@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo02.seg.att.com ([209.65.160.78]:10774 "EHLO
        nbfkord-smmo02.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753399AbdBNVqp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Feb 2017 16:46:45 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I'm given to understand that bitwise types consider 0 'special', in that
 sparse will allow, say:
        typedef __u32 __bitwise __be32;
        __be32 value = 0;
However, it appears that if I try to cast a constant 0 to a bitwise type,
        static inline void ip6_fill_mask(__be32 *mask)
        {
                mask[0] = mask[1] = mask[2] = mask[3] = ~(__be32)0;
        }
sparse complains "warning: cast to restricted __be32".
Why is this?  Is there some subtle reason why the cast is incorrect, or
 is sparse just unable to notice that the value being cast is 0?
It allows it if I rewrite it with a local variable, making the cast
 implicit:
        static inline void ip6_fill_mask(__be32 *mask)
        {
                __be32 nothing = 0;

                mask[0] = mask[1] = mask[2] = mask[3] = ~nothing;
        }

-Ed
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
