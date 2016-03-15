From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 01/21] expression: introduce additional expression
 constness tracking flags
Date: Tue, 15 Mar 2016 22:23:18 +0100
Message-ID: <20160315212316.GA2679@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87h9htjh7v.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33675 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcCOVXW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 17:23:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id l68so163360566wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 14:23:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87h9htjh7v.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:29:40AM +0100, Nicolai Stange wrote:
> Even if sparse attempted to verify that initializers for static storage
> duration objects are constant expressions [6.7.8(4)] (which it
> currently does not), it could not tell reliably.
> Example:
> 
>   enum { b = 0 };
>   static void *c = { (void*)b }; /* disallowed by C99 */
> 
> References to enum members are not allowed in address constants [6.6(9)] and thus,
> the initializer is not a constant expression at all.
> 
> Prepare for a more fine-grained tracking of expression constness in the
> sense of C99 [6.4.4, 6.6].
> 
> Introduce a broader set of constness tracking flags, resembling the
> four types of primary expression constants [6.4.4] (integer, floating, enumeration,
> character). Define helper macros to consistently set and clear these flags as they
> are not completely independent.
> 
> In particular, introduce the following flags for tagging expression constness at
> the level of primary expressions:
> - CONSTEXPR_FLAG_INT_CONST: integer constant, i.e. literal
> - CONSTEXPR_FLAG_FP_CONST: floating point constant, equivalent to the former
>                            Float_literal flag
> - CONSTEXPR_FLAG_ENUM_CONST: enumeration constant
> - CONSTEXPR_FLAG_CHAR_CONST: character constant
> 
> Introduce the CONSTEXPR_FLAG_INT_CONST_EXPR flag meant for tagging integer constant
> expressions. It is equivalent to the former Int_const_expr flag.
> Note that the new CONSTEXPR_FLAG_INT_CONST, CONSTEXPR_FLAG_ENUM_CONST and
> CONSTEXPR_FLAG_CHAR_CONST flags imply CONSTEXPR_FLAG_INT_CONST_EXPR being set.
> 
> Finally, rename ->flags to ->constexpr_flags because they are solely used for the
> purpose of tracking an expression's constness.
> 

The changes are, in themselves, fine to me but I have a few remarks:

*) I think the patch would be nicer (abd certainly easier to review) if
   it would be splitted so that changes that can't possibly go wrong are
   not mixed with others which changes behaviour/semantics.
   So you can mechanically replace Int_const_expr by CONSTEXPR_...
   then ->flags by ...
   And only then replace ..._EXPR by ..._SET_MASK and so on

*) you will probably hate me for this but ...
   I think that the names you're using are way too long.
   It doesn't help readability at all, especially when because of the length
   you need to fole lines in if-expression
   'CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK', that's already really long
   and the change 'flags' to 'constexpr_flags' doesn't help either
