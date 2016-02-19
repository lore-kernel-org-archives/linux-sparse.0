From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Fri, 19 Feb 2016 09:22:50 +0100
Message-ID: <87y4ahun1h.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37894 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426241AbcBSIWz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 19 Feb 2016 03:22:55 -0500
Received: by mail-wm0-f41.google.com with SMTP id a4so59713735wme.1
        for <linux-sparse@vger.kernel.org>; Fri, 19 Feb 2016 00:22:54 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Nicolai Stange <nicstange@gmail.com> writes:

> Here comes the greatly enhanced v3 of this series.

Just a gently push to get some reviews on this...


>
> Luc's suggestions about splitting some patches turned out to be very fruitful!
>
> Former [01/13] ("expression: introduce additional expression constness tracking flags")
> has been split into
> - [01/21] ("expression: introduce additional expression constness tracking flags")
> - [02/21] ("expression: init constexpr_flags at expression allocation")
> - [07/21] ("expression: add support for tagging arithmetic constant expressions")
>
> In particular, the introduction of the arithmetic constant expression
> flag is deferred until the last one of these three. This addresses
> Luc's concerns that the arithmetic constant expression handlings
> within the v2 "examine constness of XXX at evaluation only"-patches
> should better get split off into a separate patch each.
>
>
> Former [06/13] ("expression, evaluate: add support for recognizing address constants")
> has been split into
> - [08/21] ("expression, evaluate: add support for tagging address constants")
> - [10/21] ("expression, evaluate: recognize static objects as address constants")
> - [12/21] ("evaluate: recognize address constants created through pointer arithmetic")
> - [13/21] ("evaluate: recognize members of static compound objects as address constants")
> - [14/21] ("evaluate: recognize string literals as address constants")
>
> The address constant handling part from former
> [02/13] ("expression: examine constness of casts at evaluation only")
> has been extracted into a patch on its own, namely
> [11/21] ("evaluate: recognize address constants created through casts")
>
> Patches [10-14/21] have been placed just until after static initializer checking
> has been introduced in
> [09/21] ("evaluate: check static storage duration objects' intializers' constness").
> This way, the monster testcase from former
> [07/13] ("evaluate: check static storage duration objects' intializers' constness")
> can be split and the individual tests attached to the different
> patches as appropriate.
>
>
> Note that we still have got this
> [20/21] ("symbol: do not inherit storage modifiers from base types at examination")
> thing.
>
>
> Detailed changes:
> [01/21] ("expression: introduce additional expression constness tracking flags"):
>   - The expr_{set,clear}_flag() helpers have been replaced by bitmasks
>     to be ored in or anded outnow.
>   - Renamed ->flags to ->constexpr_flags
>   - ->constexpr_flags initialization at expression allocation has been
>     extracted into
>     [02/21] ("expression: init constexpr_flags at expression allocation")
>   - neither of the arithmetic constant expression flag nor address nor the
>     address constant flag gets introduced by this patch anymore.
>     They get introduced in 
>     [07/21] ("expression: add support for tagging arithmetic constant expressions")
>     [08/21] ("expression, evaluate: add support for tagging address constants")
>     as needed.
>   - Luc's remarks about the 'sic' comments carried over from the original
>     code have been addressed in the new 
>     [21/21] ("evaluation: treat comparsions between types as integer constexpr")
>   - Changes to patch description as suggested by Luc.
>   - Tag a TOKEN_ZERO_IDENT by integer constant instead of integer
>     constant expression. Feels more natural but should not matter.
>
> [02/21] ("expression: init constexpr_flags at expression allocation")
>   This one is new. Split off from former [01/13].
>
> [03-06/21] ("expression: examine constness of XXX at evaluation only")
>   Adjusted patch descriptions as suggested by Luc.
>
> [07/21] ("expression: add support for tagging arithmetic constant expressions")
>   This one is new. Split off from former [01/13].
>
> [08/21] ("expression, evaluate: add support for tagging address constants")
>   Split off actual recognition of various address constant forms into
>   separate patches [10-14/21]
>
> [09/21] ("evaluate: check static storage duration objects' intializers' constness").
>   - -W-flag has been renamed to -Wconstexpr-not-const
>   - the associated warning message has been shortened to
>     "non-constant initializer for static object".
>   - the attached testcase has been greatly reduced as the tests are now
>     attached to the patches [10-14/21].
>
> [10-14/21]
>   These ones are new and split off from former
>   [06/13] ("expression, evaluate: add support for tagging address constants")
>   They implement actual address constant recognition functionality.
>   
>   In
>   [12/21] ("evaluate: recognize address constants created through pointer arithmetic")
>   a whitespace issue from former
>   [06/13] ("expression, evaluate: add support for recognizing address constants")
>   in an if-clause has been fixed.
>
>
> [15/21] ("expression: recognize references to labels as address constants")
>   A testcase for has been added.
>
>
> [19/21] ("evaluate: relax some constant expression rules for pointer expressions")
>   A typo ("adress") has been fixed.
>
> [21/21] ("evaluation: treat comparsions between types as integer constexpr")
>   This one is new.
>
>
> Nicolai Stange (21):
>   expression: introduce additional expression constness tracking flags
>   expression: init constexpr_flags at expression allocation
>   expression: examine constness of casts at evaluation only
>   expression: examine constness of binops and alike at evaluation only
>   expression: examine constness of preops at evaluation only
>   expression: examine constness of conditionals at evaluation only
>   expression: add support for tagging arithmetic constant expressions
>   expression, evaluate: add support for tagging address constants
>   evaluate: check static storage duration objects' intializers'
>     constness
>   expression, evaluate: recognize static objects as address constants
>   evaluate: recognize address constants created through casts
>   evaluate: recognize address constants created through pointer
>     arithmetic
>   evaluate: recognize members of static compound objects as address
>     constants
>   evaluate: recognize string literals as address constants
>   expression: recognize references to labels as address constants
>   expression: examine constness of __builtin_offsetof at evaluation only
>   symbol: flag builtins constant_p, safe_p and warning as constexprs
>   evaluate: relax some constant expression rules for pointer expressions
>   expression, evaluate: support compound literals as address constants
>   symbol: do not inherit storage modifiers from base types at
>     examination
>   evaluation: treat comparsions between types as integer constexpr
>
>  evaluate.c                                   | 207 +++++++++++++++++++++------
>  expand.c                                     |  10 +-
>  expression.c                                 |  50 +++----
>  expression.h                                 |  83 ++++++++++-
>  lib.c                                        |   2 +
>  lib.h                                        |   1 +
>  sparse.1                                     |   9 ++
>  symbol.c                                     |  12 +-
>  validation/constexpr-addr-of-static-member.c |  26 ++++
>  validation/constexpr-addr-of-static.c        |  36 +++++
>  validation/constexpr-binop.c                 |  33 +++++
>  validation/constexpr-cast.c                  |  25 ++++
>  validation/constexpr-compound-literal.c      |  19 +++
>  validation/constexpr-conditional.c           |  34 +++++
>  validation/constexpr-init.c                  |  60 ++++++++
>  validation/constexpr-labelref.c              |  15 ++
>  validation/constexpr-offsetof.c              |  21 +++
>  validation/constexpr-pointer-arith.c         |  28 ++++
>  validation/constexpr-pointer-cast.c          |  13 ++
>  validation/constexpr-preop.c                 |  29 ++++
>  validation/constexpr-string.c                |   9 ++
>  validation/constexpr-types-compatible-p.c    |   9 ++
>  22 files changed, 640 insertions(+), 91 deletions(-)
>  create mode 100644 validation/constexpr-addr-of-static-member.c
>  create mode 100644 validation/constexpr-addr-of-static.c
>  create mode 100644 validation/constexpr-binop.c
>  create mode 100644 validation/constexpr-cast.c
>  create mode 100644 validation/constexpr-compound-literal.c
>  create mode 100644 validation/constexpr-conditional.c
>  create mode 100644 validation/constexpr-init.c
>  create mode 100644 validation/constexpr-labelref.c
>  create mode 100644 validation/constexpr-offsetof.c
>  create mode 100644 validation/constexpr-pointer-arith.c
>  create mode 100644 validation/constexpr-pointer-cast.c
>  create mode 100644 validation/constexpr-preop.c
>  create mode 100644 validation/constexpr-string.c
>  create mode 100644 validation/constexpr-types-compatible-p.c
