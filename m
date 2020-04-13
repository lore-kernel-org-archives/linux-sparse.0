From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Mon, 13 Apr 2020 20:54:52 +0200
Message-ID: <20200413185452.pgj75pj5g7a42kik@ltop.local>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
 <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
 <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387774AbgDMSy4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 14:54:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F62C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 11:54:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so11240843wrv.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 11:54:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wiy-BFXMpmm9-GNT_WtDKVLeR0ki4OTj83xPk=npuNSHA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Apr 13, 2020 at 10:52:19AM -0700, Linus Torvalds wrote:
> On Mon, Apr 13, 2020 at 9:16 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Note: the label's symbols are still created in the function
> >       scope since they belong to a single namespace.
> 
> Oh, I saw that 13/17 and was like "yeah, this is the right thing to
> do", because I thought you were going in a different direction.
> 
> But then here in 15/17 I think you're doing it wrong.
> 
> Just give the symbol the proper scope, and make it simply not even
> _parse_ right if somebody tries to use a label from the wrong scope,
> instead of making the symbol visible, and then having to check whether
> the scopes nested right later.
> 
> So I think you should just bite the bullet, and change the
> bind_symbol() function so that a NS_LABEL is bound to label scope.
> 
> Then you can remove this 15/17 entirely (and all the "is this scope
> nesting" code - nesting is automatically enforced by the symbol
> scope).
> 
> I think that's a much cleaner approach. Yes, it gives a different
> error from gcc, but I think it's a *better* error.
> 
> This:
> 
>    int fn1(int arg)
>    {
>       target:
>          return 0;
>    }
> 
>    int fn2(int arg)
>    {
>       goto target;
>    }
> 
> is invalid code, and 'target' isn't even visible in fn2, because it is
> a local label to fn1.
> 
> I think the exact same thing is the right thing to do for expression
> statements, so
> 
>    int fn(int arg)
>    {
>       goto inside;
>       return ({ inside: 0; });
>    }
> 
> should fail with the exact same error message of having an undefined
> label (which sparse currently gets wrong too, but you're fixing that
> elsewhere).
> 
> Because "inside" simply shouldn't be defined at all in the outer
> scope, and you can only branch _within_ a statement expression, the
> same way you can only branch within a function.
> 
> So I think statement expressions should basically work kind of like
> local "nested functions": they have access to the state outside, but
> the outside doesn't have access to the state inside that statement
> expression.

Yes, I agree and in fact (if I understand you correctly) it was what
I tried first, mainly because it was "conceptualy neat" and simpler.
But then it wasn't working correctly in all situations and I
convinced myself it couldn't. The problem was with code like:
	void foo(void)
	{
		... = ({ ...  goto out; ... });

	out:
		...;
	}

In this case, when 'goto out' is parsed, the corresponding label
symbol would be created in the inner scope and later when the label
is defined the symbol lookup will only look in the outer scope, see
nothing and declare another symbol for it, then the obvious scope
check will complain that the goto's label is undeclared.
But this code is legit and both occurences of the ident 'out' should
refer to the same label, right?

I didn't saw a proper solution for this, hence the current patch 15
where I'm keeping all labels in the usual function scope but where
the new label scope is associated to the STMT_GOTO & STMT_LABEL
and where evaluate_goto_statement() check in the scope of the
goto is contained in the one of the label definition via the
new helper is_in_scope(). This is less elegant than I would have
liked but again I don't see a better solution.

-- Luc
