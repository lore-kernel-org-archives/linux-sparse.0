From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/8] fix loading of partially defined bitfield
Date: Mon,  7 Aug 2017 21:11:57 +0200
Message-ID: <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35362 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdHGTML (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id r77so2060912wmd.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 12:12:10 -0700 (PDT)
In-Reply-To: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
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

This is for testing only as it still requires some verifications.

Dibyendu,
This should now really solve your test case with:
	s3.onebit = 1;
	if (s3.onebit != 1)
		...


Changes since v1:
- use the hack from March to work-around the problem 
  with undefined vars.
- add the missing simplifications to make the
  store-and-load-back of a bitfield almost a no-op
  as it should be.


The series is available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-loading-partialy-defined-bitfields-v2

----------------------------------------------------------------
Luc Van Oostenryck (8):
      Remove single-store shortcut
      new helper: def_opcode()
      reuse nbr_pseudo_users()
      change the masking when loading bitfields
      simplify ((A & M') | B ) & M when M' & M == 0
      transform (A & M) >> S to (A >> S) & (M >> S)
      transform (A << S) >> S into A & (-1 >> S)
      fix: cast of OP_AND only valid if it's an OP_CAST

 flow.c                                 |  39 +-----------
 linearize.c                            |  15 +++--
 linearize.h                            |   5 ++
 simplify.c                             | 107 ++++++++++++++++++++++++++++++---
 unssa.c                                |   5 --
 validation/bitfield-size.c             |   4 +-
 validation/optim/store-load-bitfield.c |  66 ++++++++++++++++++++
 7 files changed, 181 insertions(+), 60 deletions(-)
 create mode 100644 validation/optim/store-load-bitfield.c
