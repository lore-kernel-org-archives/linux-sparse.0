From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: complain about re-declared functions with different modifiers
Date: Thu, 14 May 2020 22:56:04 +0200
Message-ID: <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbgENU4H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 16:56:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60274C061A0C
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 13:56:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id 50so455637wrc.11
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 13:56:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, May 14, 2020 at 11:18:53AM -0700, Linus Torvalds wrote:
> On Thu, May 14, 2020 at 7:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > But then it's re-declared as not inline.
> >
> > Could Sparse print a warning for that?
> 
> I actually think that would be a bug.
> 
> Having a non-inline declaration for an inline function sounds normal
> and correct and even expected. I'd not be surprised at all if a
> function is declared in a header file as non-inline (because there it
> is), but then in the implementation it's defined as inline (because
> later uses in that same file might want to inline it).
> 
> So warning about inline/non-inline differences is I think actively wrong.
> 
> HOWEVER.
> 
> In this case I wonder if the real difference is that first we have a
> "static" definition of the symbol, and then later there's a non-static
> declaration of it. That, to me, smells a bit odd - one has file scope,
> the other has external scope, and particularly with the external scope
> coming _after_ the file scope, which version of that same symbol does
> a subsequent use then use?
> 
> Because a static symbol and a symbol with external linkage are clearly
> not the same symbol. It's perfectly fine to have an external symbol
> 'x' that is shadowed by a static symbol 'x' in file scope.
> 
> But I wonder if smatch sees the *external* symbol nvme_put_ctrl()
> (which doesn't have an inline definition!) rather than the static one
> (which does!) because the external declaration comes after the static
> definition.
> 
> So _that_ might be worth warning about: seeing an external declaration
> after a static one makes for confusion.
> 
> I'm not sure that is the problem here.

Not sure if it's related to Dan's problem or not but with the
following code:

	static inline int foo(void)
	{
		return 1;
	}
	
	extern int foo(void);
	
	int dummy(void)
	{
		return foo();
	}

the static definition of foo() and the extern declaration are
distinct symbols (in the sense that neither has its sym->same_symbol
pointing to the other). As far as I understand, this is correct
because they have a different 'scope'. The problem occurs later,
when doing the lookup in dummy(): which symbol should be returned?
It should be the static one but it's the extern one that is returned
(because it's the last one and symbols are added in stack order).
This can be easily with test-linearize showing that foo is not inlined.

It's not clear to me what can be done for this.

Also, as far as I understand the standard (6.9.2p2 ?), I think
that if the 'extern' keyword would not have been used (like in Dan's
example), then the second, non-inline, occurence of 'foo' should
refer to the first, inline, one and thus be the same symbol.
This is currently the case since last November when a non-static
non-extern definition follows a static declaration but not when
the declaration follows the definition.

-- Luc
