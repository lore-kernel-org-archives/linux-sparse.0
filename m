From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/7] move arch-specific builtins to their own table
Date: Wed, 10 Jun 2020 22:27:28 +0200
Message-ID: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgFJU1o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:27:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACAC03E96B
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so4103572eju.2
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:44 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this to avoid the declaration of arch-specific builtins
when the architecture doesn't match. As nice side-effects it also:
* add support for arch-specific builtins in their target-<arch>.c
* let these builtins declarations be done via a table (it was done
  via a serie of function calls, one by builtin).
* add minimal support for the architectures Alpha, Blackfin & Nios2.

These changes are motivated by a recent report from the kbuild test
bot (which seems to find lately much more sparse-related issues
in the kernel than it used to, often address-space & endianness
problems).


Luc Van Oostenryck (7):
  builtin: can be initialized later
  builtin: use a table for the builtins
  builtin: unify the 2 tables of builtins
  builtin: add support for arch-specific builtins
  arch: add specificities for Nios2
  arch: add specificities for Blackfin
  arch: add specificities for Alpha

 Makefile       |   3 +
 builtin.c      | 439 ++++++++++++++++++++++---------------------------
 builtin.h      |  15 ++
 lib.c          |   2 +-
 machine.h      |   5 +
 symbol.c       |   1 -
 symbol.h       |   1 -
 target-alpha.c |  30 ++++
 target-bfin.c  |  26 +++
 target-nios2.c |  31 ++++
 target.c       |   6 +
 target.h       |   7 +
 12 files changed, 321 insertions(+), 245 deletions(-)
 create mode 100644 builtin.h
 create mode 100644 target-alpha.c
 create mode 100644 target-bfin.c
 create mode 100644 target-nios2.c


base-commit: 42323db3955557b223268ec4196acb77308ab204
-- 
2.27.0
