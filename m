From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] fix boolean context
Date: Wed, 12 Apr 2017 21:33:38 +0200
Message-ID: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36023 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755080AbdDLTdx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id q125so8531168wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:52 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add explicit comparisons
against zero to create a boolean context when issuing
OP_AND_BOOL & OP_OR_BOOL. This is needed to fix an incorrect
simplification.
A consequence of adding this boolean context is that
OP_AND_BOOL and OP_OR_BOOL become unneeded and are simply
replaced by OP_AND and OP_OR.


This series is available at:
	git://github.com/lucvoo/sparse.git bool-context
based on commits (a merge):
	d4208cd1ef7df00f7d79dba1ccb365136d382914 (simplify-bool-mask)
	462a61a21b1e3bb17abce88fb1bdbc93d9653245 (cse-canonical)
up to commit:
	ac6c25bc066eab36942539ba11c7ab6cf0c63674

Luc Van Oostenryck (6):
  fix boolean context for OP_AND_BOOL & OP_OR_BOOL
  simplify intermediate casts in boolean expressions
  avoid useless compare with zero
  generate plain OP_{AND,OR} instead of OP_{AND,OR}_BOOL
  llvm: no need to special-case OP_AND_BOOL and OP_OR_BOOL
  remove OP_{AND,OR}_BOOL instructions

 cse.c                              |  4 +---
 example.c                          |  3 ---
 linearize.c                        | 44 ++++++++++++++++++++++++++++++++----
 linearize.h                        |  4 +---
 simplify.c                         | 44 ++++++++++++++++--------------------
 sparse-llvm.c                      | 24 --------------------
 validation/optim/bool-context-fp.c | 46 ++++++++++++++++++++++++++++++++++++++
 validation/optim/bool-context.c    | 12 ++++++++++
 validation/optim/bool-simplify.c   | 30 +++++++++++++++++++++++--
 validation/optim/bool-simplify2.c  | 11 +++++++++
 10 files changed, 158 insertions(+), 64 deletions(-)
 create mode 100644 validation/optim/bool-context.c
 create mode 100644 validation/optim/bool-simplify2.c

-- 
2.12.0

