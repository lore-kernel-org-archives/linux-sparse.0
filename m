From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] modifiers inheritance by '&' and 'typeof()'
Date: Thu, 24 Nov 2016 18:09:41 +0100
Message-ID: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36894 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756694AbcKXRJ4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:09:56 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so67943661wmt.0
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:09:55 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is several issues regarding which modifiers is or must be
preserved when using the '&' or 'typeof()' operators. There is
also no explicit tests for these. This serie aims to improve this
situation by:
  - avoid to inherit storage modifiers by '&' (patch 1)
  - simplify an existing test (patch 2 & 3)
  - create a bunch of test cases (patch 4 & 5)
  - partial fix for modifiers needing to be inherited by typeof
    (patch 6)

The last patch is marked as '[RFC]' because it needs some clarification
on the wanted semantics of some modifiers in some situations.
In particular, MOD_NODEREF & MOD_SAFE are for the moment not addressed,
like the address space.
Lastly, especially for what concerns MOD_SAFE, some others changes are
needed.

Luc Van Oostenryck (6):
  storage should not be inherited by pointers
  testsuite: simplify test function-pointer-inheritance
  use a shorter name for function-pointer-modifier-inheritance.c
  testsuite: test modifiers preserved by '&' operator
  testsuite: test modifiers preserved by 'typeof()'
  [RFC] some modifiers need to be preserved by 'typeof()'

 symbol.c                                           |   8 +-
 symbol.h                                           |   4 +-
 validation/function-pointer-inheritance.c          |   9 ++
 validation/function-pointer-modifier-inheritance.c |  18 ----
 validation/nocast.c                                |   2 +-
 validation/ptr-inherit.c                           |  80 +++++++++++++++
 validation/typeof-addresspace.c                    |  20 ++++
 validation/typeof-mods.c                           | 109 +++++++++++++++++++++
 validation/typeof-noderef.c                        |  19 ++++
 validation/typeof-safe.c                           |  23 +++++
 10 files changed, 270 insertions(+), 22 deletions(-)
 create mode 100644 validation/function-pointer-inheritance.c
 delete mode 100644 validation/function-pointer-modifier-inheritance.c
 create mode 100644 validation/ptr-inherit.c
 create mode 100644 validation/typeof-addresspace.c
 create mode 100644 validation/typeof-mods.c
 create mode 100644 validation/typeof-noderef.c
 create mode 100644 validation/typeof-safe.c

-- 
2.10.2

