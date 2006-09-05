From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: broken 0 sized memset checks?
Date: Tue, 5 Sep 2006 14:20:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609051417270.27779@g5.osdl.org>
References: <20060905210512.GF22261@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:62850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751287AbWIEVUk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Sep 2006 17:20:40 -0400
In-Reply-To: <20060905210512.GF22261@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org



On Tue, 5 Sep 2006, Dave Jones wrote:
>
> I ran sparse over the current linux kernel, and noticed this..
> 
> drivers/net/chelsio/sge.c:341:9: warning: memset with byte count of 0
> drivers/net/chelsio/sge.c:469:9: warning: memset with byte count of 0
> 
> The first..
> 
>         q->size = p->freelQ_size[i];
>         ....
>         size = sizeof(struct freelQ_ce) * q->size;
>         q->centries = kmalloc(size, GFP_KERNEL);
>         if (!q->centries)
>             goto err_no_mem;
>         memset(q->centries, 0, size);
>
> Sparse bug ?

I _suspect_ sparse has had some type-parsing bug, and thinks that 
"sizeof(struct freelQ_ce)" is zero for some reason, and then does all the 
constant folding (yeah, sparse is clever when it isn't really stupid ;), 
and that's what is going on.

I'll see if I can figure out what's up.

		Linus
