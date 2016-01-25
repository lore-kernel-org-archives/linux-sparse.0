From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 00/13] improve constexpr handling
Date: Mon, 25 Jan 2016 15:47:51 +0100
Message-ID: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34887 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757274AbcAYOrz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:47:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so11733722wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:47:54 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

This is the second attempt to clean up and improve sparse's handling
of constant expressions. After I got some helpful reviews from
Josh Triplett and Luc Van Oostenryck on my initial RFC series, I feel
quite comfortable with this now and dropped the 'RFC' tag in favour of
'v2'.

Quote from my initial 'RFC' cover letter regarding the structure of
this series:

  This patch series is split into four parts:
  - The first part deals with the refactorization of the current integer
    constant expression handling and introduces some support for
    recognizing arithmetic expressions. [1-5/13]
  - The second part introduces support for recognizing address constants.
    [6/13]
  - The third part introduces a check for the constness of static storage
    duration objects' initializers. [7/13]
  - The last part stems from my tests with the kernel. It contains things
    I missed in the first [9-10/13] and second [8,12/13] parts and
    relaxes some of the constraints on constant expressions [11/13].
    For the last patch [13/13], please see below. 
  [...]
  Although the patches of the fourth part, the fixup part, fit very well
  into the first two categories, their associated testcases, if any,
  depend on [7/13]. Thus, I dediced to keep the order as is.

Quote end.


The question from the initial 'RFC' series whether or not to relax the
constexpr constraints, meaning that

  a difference of address constants may yield an integer constant

in order to make the kernel's ACPI_OFFSET macro happy, is still
unaddressed. However, if it turns out that we actually want to do so,
this single issue can be easily handled by some follow up patch.


Changes made between v2 and the initial, 'RFC' tagged series:
 - As suggested by Josh Triplett,
   [7/13] ("check static storage duration objects' intializers' constness")
   only warns now if -Wstatic-initializer-not-const is given.
   This option is not enabled by default and thus, the two testsuite
   failers reported by Luc Van Oostenryck cease to fail.
 - Luc Van Oostenryck didn't like the way the setting and clearing of
   flags is handled. I did not completely follow his advice of
   introducing predefined sets of masks to or in/and out resp., because
   setting and clearing is kind of different. However, I tried to
   address his concerns by changing expr_{set,clear}_flag_mask(...)
   into expr_{set,clear}_flag(...) whose interfaces are (hopefully) much
   saner.


Nicolai Stange (13):
  expression: introduce additional expression constness tracking flags
  expression: examine constness of casts at evaluation only
  expression: examine constness of binops and alike at evaluation only
  expression: examine constness of preops at evaluation only
  expression: examine constness of conditionals at evaluation only
  expression, evaluate: add support for recognizing address constants
  evaluate: check static storage duration objects' intializers'
    constness
  expression: recognize references to labels as address constants
  expression: examine constness of __builtin_offsetof at evaluation only
  symbol: flag builtins constant_p, safe_p and warning as constexprs
  evaluate: relax some constant expression rules for pointer expressions
  expression, evaluate: support compound literals as address constants
  symbol: do not inherit storage modifiers from base types at
    examination

 evaluate.c                              | 188 ++++++++++++++++++++++++--------
 expand.c                                |   2 +-
 expression.c                            |  52 ++++-----
 expression.h                            | 123 ++++++++++++++++++++-
 lib.c                                   |   2 +
 lib.h                                   |   2 +-
 sparse.1                                |   7 ++
 symbol.c                                |  12 +-
 validation/constexpr-binop.c            |  33 ++++++
 validation/constexpr-cast.c             |  25 +++++
 validation/constexpr-compound-literal.c |  19 ++++
 validation/constexpr-conditional.c      |  34 ++++++
 validation/constexpr-init.c             | 110 +++++++++++++++++++
 validation/constexpr-offsetof.c         |  21 ++++
 validation/constexpr-preop.c            |  29 +++++
 15 files changed, 575 insertions(+), 84 deletions(-)
 create mode 100644 validation/constexpr-binop.c
 create mode 100644 validation/constexpr-cast.c
 create mode 100644 validation/constexpr-compound-literal.c
 create mode 100644 validation/constexpr-conditional.c
 create mode 100644 validation/constexpr-init.c
 create mode 100644 validation/constexpr-offsetof.c
 create mode 100644 validation/constexpr-preop.c

-- 
2.7.0

