From: Xi Wang <xi.wang@gmail.com>
Subject: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Mon,  4 Jun 2012 02:54:34 -0400
Message-ID: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36445 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab2FDGz1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 02:55:27 -0400
Received: by qcro28 with SMTP id o28so1994107qcr.19
        for <linux-sparse@vger.kernel.org>; Sun, 03 Jun 2012 23:55:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

This patchset tries to implement Chris's `counter RFC': adding ->ctype
to pseudo, while removing ->type and ->size from instruction.  In this
way, it provides easy access to type information for backend.

The first patch adds ->ctype to struct pseudo and doesn't touch struct
instruction.  It could be applied alone if we really want backward
compatibility.

The second patch does more destructive work.  It removes ->type and
->size from struct instruction and updates client uses.

The third patch updates sparse-llvm in a naive way, which should have
been much simpler with the new ->ctype in pseudo.  I guess in some cases
->ctype is even necessary.  Consider the example below.

void foo(int x, ...);
foo(1, 2, 3LL);

Is it possible to get the types of the 2nd and 3rd arguments in current
code, which are simply PSEUDO_VAL?

Xi Wang (3):
  add ->ctype to struct pseudo
  remove ->type and ->size from struct instruction
  sparse, llvm: sync with new struct instruction

 cse.c         |    6 +--
 example.c     |   12 ++---
 flow.c        |   12 ++---
 linearize.c   |  147 +++++++++++++++++++++++++--------------------------------
 linearize.h   |   17 ++++---
 memops.c      |    4 +-
 simplify.c    |   24 +++++-----
 sparse-llvm.c |   50 ++++++++++----------
 sparse.c      |    2 +-
 unssa.c       |    3 +-
 10 files changed, 131 insertions(+), 146 deletions(-)

-- 
1.7.9.5

