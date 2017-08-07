From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix loading of partially defined bitfield
Date: Mon,  7 Aug 2017 03:33:35 +0200
Message-ID: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35347 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGBdm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:33:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id r77so12119367wmd.2
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:33:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the problem present in sparse
when a bitfield in an uninitialized automatic variable is first
set then read-back.

In this case the bitfield itself is initialized but not the
remaining of the structure/word and sparse was not smart
enough to handle it.

This is for testing only and the patches are not meant to 
be applied on the main tree becasue it need the new SSA
construction to handle the undefined vars correctly.

(two other simplifications is also needed to make the
generated code a no-op as it should be but not yet
implemented).

The whole code is available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-loading-partialy-defined-bitfields

----------------------------------------------------------------
Luc Van Oostenryck (3):
      new helper: def_opcode()
      change loading of bitfields
      simplify ((A & M') | B ) & M when M' & M == 0

 linearize.c                | 15 +++++++-----
 simplify.c                 | 61 ++++++++++++++++++++++++++++++++++++++++------
 validation/bitfield-size.c |  6 +++--
 3 files changed, 66 insertions(+), 16 deletions(-)
