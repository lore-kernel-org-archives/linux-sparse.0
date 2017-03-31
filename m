From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 00/25] improve constexpr handling
Date: Fri, 31 Mar 2017 03:44:34 +0200
Message-ID: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34139 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934699AbdCaBq3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so16582395wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Here is a respin of the series originally made and
submitted by Nicolai Stange.

The goal of this series is to improve the tracking of 
expression constness in the sense of C99 [6.4.4, 6.6]:
more fine-grained and more correct. A new flag is added
for a strict mode while by default offering the relaxed
mode we're used to, for example for kernel compile.

Many thanks for Nicolai for his great job.

Changes since v3:
* take Chris' remarks in account:
  - rename 'constexpr_flags' to the shorter 'flags'
  - rename 'CONSTEXPR_FLAG_XYZ' to something shorter
  - remove redundant 'INT' in the CONST_MASK
  - try to avoid long lines and 
  - try to avoid to have to break lines
* and also:
  - initialize EXPR_VALUE with SET_INT when typed
  - extract the logic added in evaluate_cast and
    use it in cast_to() where it is also needed
  - remove patch 20 (symbol: do not inherit storage mod...)
    as now MOD_PTRINHERIT doesn't imply MOD_STORAGE anymore
  - avoid borrowing of surrounding storage mods
  - add constness stuff for __builtin_bswap()


This serie can also be pulled from:
	git://github.com/lucvoo/sparse.git constexpr-v4
the changes up to commit:
	4d963a28d371ce75f65a70aa29f14cec5f08d8ff
since commit:
	5c9411a5c0482b0ceb70861114df4c229e1298ca

Nicolai Stange (20):
  constexpr: introduce additional expression constness tracking flags
  constexpr: init flags at expression allocation
  constexpr: examine constness of casts at evaluation only
  constexpr: examine constness of binops and alike at evaluation only
  constexpr: examine constness of preops at evaluation only
  constexpr: examine constness of conditionals at evaluation only
  constexpr: add support for tagging arithmetic constant expressions
  constexpr: add support for tagging address constants
  constexpr: check static storage duration objects' intializers' constness
  constexpr: recognize static objects as address constants
  constexpr: recognize address constants created through casts
  constexpr: recognize address constants created through pointer arithmetic
  constexpr: recognize members of static compound objects as address constants
  constexpr: recognize string literals as address constants
  constexpr: recognize references to labels as address constants
  constexpr: examine constness of __builtin_offsetof at evaluation only
  constexpr: flag builtins constant_p, safe_p and warning as constexprs
  constexpr: relax some constant expression rules for pointer expressions
  constexpr: support compound literals as address constants
  constexpr: treat comparisons between types as integer constexpr

Luc Van Oostenryck (5):
  constexpr: rename handle_simple_initializer() to handle_initializer()
  constexpr: collect storage modifiers of initializers
  return an error if too few args
  give default return type in evaluate_call()
  constexpr: flag __builtin_bswap() as constexpr


 builtin.c                                    |  26 +++-
 evaluate.c                                   | 206 ++++++++++++++++++++-------
 expand.c                                     |   2 +-
 expression.c                                 |  48 +++----
 expression.h                                 |  70 ++++++++-
 lib.c                                        |   2 +
 lib.h                                        |   1 +
 sparse.1                                     |   9 ++
 validation/constexpr-addr-of-static-member.c |  26 ++++
 validation/constexpr-addr-of-static.c        |  36 +++++
 validation/constexpr-binop.c                 |  33 +++++
 validation/constexpr-cast.c                  |  25 ++++
 validation/constexpr-compound-literal.c      |  19 +++
 validation/constexpr-conditional.c           |  34 +++++
 validation/constexpr-init.c                  |  60 ++++++++
 validation/constexpr-labelref.c              |  14 ++
 validation/constexpr-offsetof.c              |  21 +++
 validation/constexpr-pointer-arith.c         |  28 ++++
 validation/constexpr-pointer-cast.c          |  13 ++
 validation/constexpr-preop.c                 |  29 ++++
 validation/constexpr-pure-builtin.c          |  23 +++
 validation/constexpr-string.c                |   9 ++
 validation/constexpr-types-compatible-p.c    |   8 ++
 23 files changed, 649 insertions(+), 93 deletions(-)
 create mode 100644 validation/constexpr-addr-of-static-member.c
 create mode 100644 validation/constexpr-addr-of-static.c
 create mode 100644 validation/constexpr-binop.c
 create mode 100644 validation/constexpr-cast.c
 create mode 100644 validation/constexpr-compound-literal.c
 create mode 100644 validation/constexpr-conditional.c
 create mode 100644 validation/constexpr-init.c
 create mode 100644 validation/constexpr-labelref.c
 create mode 100644 validation/constexpr-offsetof.c
 create mode 100644 validation/constexpr-pointer-arith.c
 create mode 100644 validation/constexpr-pointer-cast.c
 create mode 100644 validation/constexpr-preop.c
 create mode 100644 validation/constexpr-pure-builtin.c
 create mode 100644 validation/constexpr-string.c
 create mode 100644 validation/constexpr-types-compatible-p.c

-- 
2.12.0

