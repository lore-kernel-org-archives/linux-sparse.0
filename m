From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [SPARSE PATCH] univ-init: conditionally accept { 0 } without
 warnings
Date: Wed, 20 May 2020 22:40:01 +0200
Message-ID: <20200520204001.2nkuowfeftp7uhpl@ltop.local>
References: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
 <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETUkF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 16:40:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742AC061A0E
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 13:40:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so5831193ejb.10
        for <linux-sparse@vger.kernel.org>; Wed, 20 May 2020 13:40:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>

On Wed, May 20, 2020 at 01:22:22AM +0100, Ramsay Jones wrote:
> Hi Luc,
> 
> Sorry for not getting back to you sooner on this (you would
> think I was busy! ;-D ).

No problem, really. And I haven't been quite reactive myself lately. 

> I have now found (one of) the patch(es) I was referring to before
> (as a patch file on a memory stick - don't ask!).
I won't, promise ;) 

> On 19/05/2020 00:54, Luc Van Oostenryck wrote:
> > In standard C '{ 0 }' is valid to initialize any compound object.
> > OTOH, Sparse allows '{ }' for the same purpose but:
> > 1) '{ }' is not standard
> > 2) Sparse warns when using '0' to initialize pointers.
> > 
> > Some projects (git) legitimately like to be able to use the
> > standard '{ 0 }' without the null-pointer warnings
> > 
> > So, add a new warning flag (-Wno-universal-initializer) to
> > handle '{ 0 }' as '{ }', suppressing the warnings.
> 
> Hmm, I didn't think this would use a warning flag at all!
> 
> I remember the discussion (on lkml and sparse ml) in which
> there was general agreement that '{}' would be preferred
> solution (if only it was standard C!). However, I thought
> that (since some compilers don't support it e.g. msvc) the
> next best solution would be for sparse to suppress the
> warning if given the '= { 0 }' token sequence. (ie. no mention
> of it being conditional on a option).

Yes, I kinda agree but concerning the kernel, my understanding is
that the warning is desired (cfr. https://marc.info/?t=154704602900003 ) 
For example, for cases like:
	int *array[16] = { 0 };

So, I want to keep the current behavior as the default.

> ...  but this may well
> give the impression of a C++ like 'int i{}' type initializer!

This syntax is really terrible **shiver**.

> > @@ -2750,6 +2750,13 @@ static struct token *initializer_list(struct expression_list **list, struct toke
> >  {
> >  	struct expression *expr;
> >  
> > +	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
> > +	// warnings about using '0' to initialize a null-pointer.
> > +	if (!Wuniversal_initializer) {
> > +		if (match_token_zero(token) && match_op(token->next, '}'))
> > +			token = token->next;
> > +	}
> > +
> 
> Ha! This made me LOL! (see my patch below).
> 
> So simple. (I did think, at first, that deleting the '0' token was
> not a good idea - then I realized that it's more like skipping/ignoring
> the token than deleting it.)

Well ... I'm lazy, so ... and it gave me the garantee that it will
behave exactly like '{ }'.

> The patch below was (I think) my third attempt. If memory serves
> me, the first patch attempted to determine the '{0}' initializer
> from the 'struct expession *' passed to bad_null() alone. However,
> that did not allow me to distinguish '= { 0 }' from '= { 0, }',
> so I needed to backup from evaluation to the parse.

I think it's fine to allow the comma, I probably need to change
this is my version.

> Also, I didn't test the initialization of embedded struct/array fields
> (and what should happen anyway? should '{ 0 }' also work for initializing
> the sub-structure(s), or should it only work at the top-level?).

In fact, it works for literally anything: simple arrays, multi-dimensional
arrays (it must be because the braces doesn't need to match:
	int a[2][2] = { 1, 2, 3, 4 };
is perfectly legal), structures with a scalar as first member, more complex
strutures, sub-structures, and more suprisingly even for simple types:
	int a = { 0 };
	_Bool b = { 0 };
	double f = { 0 };
	int *ptr = { 0 };

If it is fine for you, I'll reuse your testcases.

> Also, I have just noticed, it seems that I can't decide if it should
> be called 'zero aggregate initializer' or 'aggregate zero initializer'! :-P

I don't think it has a specfic name in the standard but has Danh said
in his reply, in some books, articles, GCC & clang patches it's
called "universal [zero] initializer".

Best regards,
-- Luc
