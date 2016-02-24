From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 24 Feb 2016 13:13:07 +0100
Message-ID: <87si0il31o.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <87y4ahun1h.fsf@gmail.com>
	<CANeU7QmexP2=N49uP3fgWQDvqaFSO_APr+DD6C2_exBSTfyW+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34531 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcBXMNK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Feb 2016 07:13:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id b205so2608365wmb.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Feb 2016 04:13:10 -0800 (PST)
In-Reply-To: <CANeU7QmexP2=N49uP3fgWQDvqaFSO_APr+DD6C2_exBSTfyW+A@mail.gmail.com>
	(Christopher Li's message of "Wed, 24 Feb 2016 17:45:22 +0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hi Chris,

Christopher Li <sparse@chrisli.org> writes:

> Sorry for the late reply.

no problem, I just wanted to make sure that this series doesn't orphan
in the end.

> I take a look of your V3 patches.
>
> May I ask a few questions regarding the constant expression.
>
> +       CONSTEXPR_FLAG_INT_CONST = (1 << 0),
> +       CONSTEXPR_FLAG_FP_CONST = (1 << 1),
> +       CONSTEXPR_FLAG_ENUM_CONST = (1 << 2),
> +       CONSTEXPR_FLAG_CHAR_CONST = (1 << 3),
>
> Can I say each of the above constant type are elusive to each other?
> e.g. the floating point constant can not be a integer constant at the
> same time.

Yes, that's correct, they are all exclusive to each other.
To make it explicit: the above flags apply to literals.

>
> +
> +       /*
> +        * A constant expression in the sense of [6.6]:
> +        * - integer constant expression [6.6(6)]
> +        */
> +       CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),
>
> Can we express the const expression in terms of above constant flags?
> Each expression will have a ctype associate with it. It can be one of the
> int/fp/enum/char type.
>
> e.g. "1.0 + 1" is a floating type expression according to the C rules.

Yes, it is an arithmetic constant expression of floating point type.

Just like (int)(1.0 + 1) is an arithmetic constant expression of integer
type, but *not* and integer constant expression: floating constants are
allowed in integer constant expressions only if they are the *immediate*
operands of casts [6.6(6)].

>
> In other words, it seems to me that the constant expression
> should have a deterministic ctype. We should be able to reuse the above
> constant flag without adding a new one. If not, please give some example
> to help me understand the issue.

I.
In the first place, we really need to distinguish between the higher
level constant expression productions
- integer constant expressions
- arithmetic constant expressions
- address constants

Example:
  int a[] = { [(int)(0.0 + 0)] = 0 };

is not valid C code, since (int)(0.0 + 0) is not an integer constant
expression (see above).

OTOH, (int)0.0 *is* an integer constant expression.

Thus, it is not enough to tag floating constants as simply being an
arithmetic constant expression, the distinction is really needed here.


II.
For the case of integer constant literals vs. integer constant
expressions: in theory, the distinction between integer constant
literals and enum/char constants is necessary, because

  (void*)0

qualifies as an address constant, but

  enum foo { bar = 0, };
  (void*)bar

does not [6.6(9)].

To be honest, this overly strict requirement on address constants is
relaxed in
  [18/21] ("evaluate: relax some constant expression rules for pointer expressions")
again. However, this relaxation allows for constructs such as
  (void *)(int)0.0
qualifying as an address constant which might not be the desired behaviour.


Conclusion: As it stands, we should be able to do
  #define CONSTEXPR_FLAG_INT_CONST CONSTEXPR_FLAG_INT_CONST_EXPR
  #define CONSTEXPR_FLAG_ENUM_CONST CONSTEXPR_FLAG_INT_CONST_EXPR
  #define CONSTEXPR_FLAG_CHAR_CONST CONSTEXPR_FLAG_INT_CONST_EXPR
since we do not distinguish between integer constant expressions and
integer constant literals. However this ignorance violates the C
standard, in particular [6.6(9)] and we might want to be able to easily
change this in the future. And yes, we could certainly distinguish
between a char/enum constant and an integer constant literal based on
its ctype. However, I personally don't like to treat integer, enum and
char consts different than floating point consts, since they are kind of
at the same level logically.

>
> I am not suggesting to change your patches at this stage. It just
> help me understand your patch.


Thank you for reviewing!

Nicolai
