From: Ed Cashin <ecashin@coraid.com>
Subject: Re: "unexpected unlock" when unlocking, conditional, lock in loop
Date: Sun, 7 Oct 2012 07:49:25 -0500
Message-ID: <E7D62B13-C7E3-4A4B-B579-81E773DDC641@coraid.com>
References: <1349552876.20963@cat.he.net> <20121006202102.GA28179@leaf>
 <66AC2AD6-C0FA-4F60-850A-D8C9426184B8@coraid.com>
 <20121007023946.GA30713@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from server505f.appriver.com ([98.129.35.10]:2856 "EHLO
	server505.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750760Ab2JGMta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 7 Oct 2012 08:49:30 -0400
In-Reply-To: <20121007023946.GA30713@leaf>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Oct 6, 2012, at 10:39 PM, Josh Triplett wrote:

> On Sat, Oct 06, 2012 at 08:56:57PM -0500, Ed Cashin wrote:
...
>> OK.  From the sparse man page section on context, along with
>> include/linux/compiler.h, it sounds like the way to do exactly that 
>> would be something unusual:
>> 
>> int demofn(void) __attribute__((context(&lk,1,1)))
>> 
>> ... but using that in demo.c causes sparse to warn me that it's 
>> ignoring that attribute, so I doubt that can be what you mean.
> 
> I did mean precisely that; I don't know why Sparse complains about that
> syntax.

Maybe there's a header I need.  Searching with cscope and ctags for definitions of "context" doesn't seem to be the right kind of searching.

The complaint looks like:

  CC [M]  drivers/block/aoe/demo.o
drivers/block/aoe/demo.c:9: warning: `context' attribute directive ignored
drivers/block/aoe/demo.c:9: error: expected `,' or `;' before `{' token
make[1]: *** [drivers/block/aoe/demo.o] Error 1
make: *** [drivers/block/aoe/aoe.ko] Error 2

... for this code:

     1  #include <linux/netdevice.h>
     2  
     3  static spinlock_t lk;
     4  static struct sk_buff_head q;
     5  int demofn(void);
     6  
     7  /* enters with lk held */
     8  int demofn(void) __attribute__((context(&lk,1,1)))
     9  {
    10          struct sk_buff *skb;
    11  
    12          while ((skb = skb_dequeue(&q))) {
    13                  spin_unlock_irq(&lk);
    14                  if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
    15                          pr_warn("informative warning\n");
    16                  spin_lock_irq(&lk);
    17          }
    18          return 0;
    19  }

Thanks.

-- 
  Ed Cashin
  ecashin@coraid.com


