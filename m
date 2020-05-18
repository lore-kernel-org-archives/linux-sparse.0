From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: complain about re-declared functions with different modifiers
Date: Mon, 18 May 2020 17:42:57 +0300
Message-ID: <20200518144257.GL2078@kadam>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
 <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
 <20200515133617.GF2078@kadam>
 <20200517045637.5e4l6pxiuwsimjxf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:46310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgEROnO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 10:43:14 -0400
Content-Disposition: inline
In-Reply-To: <20200517045637.5e4l6pxiuwsimjxf@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, May 17, 2020 at 06:56:37AM +0200, Luc Van Oostenryck wrote:
> On Fri, May 15, 2020 at 04:36:17PM +0300, Dan Carpenter wrote:
> > On Thu, May 14, 2020 at 10:56:04PM +0200, Luc Van Oostenryck wrote:
> > > Not sure if it's related to Dan's problem or not but with the
> > > following code:
> > > 
> > > 	static inline int foo(void)
> > > 	{
> > > 		return 1;
> > > 	}
> > > 	
> > > 	extern int foo(void);
> > > 	
> > > 	int dummy(void)
> > > 	{
> > > 		return foo();
> > > 	}
> > > 
> > > the static definition of foo() and the extern declaration are
> > > distinct symbols (in the sense that neither has its sym->same_symbol
> > > pointing to the other). As far as I understand, this is correct
> > > because they have a different 'scope'. The problem occurs later,
> > > when doing the lookup in dummy(): which symbol should be returned?
> > 
> > Yeah.  That's it.  When I see the call, I want to parse the statements
> > so I need the symbol with the implementation.
> 
> There must something else too.
> In the example here above I added 'extern' to the second declaration.
> But in your first example no storage was given:
> 	void nvme_put_ctrl(struct nvme_ctrl *ctrl);'
> and in this case, Sparse give it the storage/linkage from the previous
> declaration which was 'static'.
> So in the case, the second occurent has its ->same_symbol set to the
> previous static inline version and it's ->definition points to it too.
> 
> So, I think everything is correct here regarding Sparse (the question
> of a warning is something else: IMO none should be give for a static
> declaration/definition followed by a plain declaration (thus implicitly
> static) but well if followed by an extern one. One is also when
> a static follow an extern or a plain (implicitly extern).
> 
> Doesn't smatch uses ->same_symbol and more importantly ->definition?

Ah...  No I wasn't.

I also need to merge with the last Sparse.  The last time I merged was
in September and back then the ->scope pointers were different so the
two functions weren't counted as the ->same_symbol.

It should all work now.  Thanks!

regards,
dan carpenter
