From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: complain about re-declared functions with different modifiers
Date: Fri, 15 May 2020 16:36:17 +0300
Message-ID: <20200515133617.GF2078@kadam>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
 <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:43976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEONga (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 May 2020 09:36:30 -0400
Content-Disposition: inline
In-Reply-To: <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 14, 2020 at 10:56:04PM +0200, Luc Van Oostenryck wrote:
> Not sure if it's related to Dan's problem or not but with the
> following code:
> 
> 	static inline int foo(void)
> 	{
> 		return 1;
> 	}
> 	
> 	extern int foo(void);
> 	
> 	int dummy(void)
> 	{
> 		return foo();
> 	}
> 
> the static definition of foo() and the extern declaration are
> distinct symbols (in the sense that neither has its sym->same_symbol
> pointing to the other). As far as I understand, this is correct
> because they have a different 'scope'. The problem occurs later,
> when doing the lookup in dummy(): which symbol should be returned?

Yeah.  That's it.  When I see the call, I want to parse the statements
so I need the symbol with the implementation.

regards,
dan carpenter
