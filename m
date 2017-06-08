From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] warn on implicit type
Date: Thu,  8 Jun 2017 04:47:34 +0200
Message-ID: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36110 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdFHCr5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Jun 2017 22:47:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id d17so270191wme.3
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jun 2017 19:47:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this mini-series is to warn about implicit.
It's part of a larger series whose goal is to straighten
situations where the return type of a function doesn't
match the type of what is returned, often silently and
with incoherence in the code generated.


This series can also be pulled from:
  git://github.com/lucvoo/sparse.git implicit-int

----------------------------------------------------------------
Luc Van Oostenryck (2):
      ret-void: add test case for toplevel asm
      ret-void: warn for implicit type

 parse.c                        |  9 +++++++++
 validation/alias-mixed.c       |  2 +-
 validation/asm-toplevel.c      |  7 +++++++
 validation/badtype2.c          |  1 +
 validation/implicit-ret-type.c | 15 +++++++++++++++
 validation/implicit-type.c     | 14 ++++++++++++++
 validation/typedef_shadow.c    |  1 +
 7 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 validation/asm-toplevel.c
 create mode 100644 validation/implicit-ret-type.c
 create mode 100644 validation/implicit-type.c
