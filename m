From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/17] detect invalid branches at evaluation time
Date: Mon, 13 Apr 2020 18:15:48 +0200
Message-ID: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgDMQQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A1C0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a201so10161760wme.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not allowed to do a goto into an expression statement.
For exemple, it's not well defined what should happen if such
an expression is not otherwise reachable and/or can be optimized
away. For such situations GCC issues an error, clang doesn't
and produce a valid IR but Spare produce an invalid IR with
branches to unexisting BBs.

The goal of the patches in this series is:
*) to detect such gotos at evaluation time;
*) issue a sensible error message;
*) avoid the linearization of functions with
   invalid gotos.

This series is an alternative to the one named
"detect invalid branches in the IR" whch was posted
last week.

-- Luc

Luc Van Oostenryck (17):
  bad-goto: add testcase for 'jump inside discarded expression statement'
  bad-goto: add testcases for linearization of invalid labels
  bad-goto: add more testcases
  bad-goto: do not linearize if the IR will be invalid
  bad-goto: reorg test in evaluate_goto_statement()
  bad-goto: simplify testing of undeclared labels
  bad-goto: do not linearize function with undeclared labels
  bad-goto: catch labels with reserved names
  scope: no memset() needed after __alloc_scope()
  scope: move scope opening/ending inside compound_statement()
  scope: make function scope the same as the body block scope
  scope: s/{start,end}_symbol_scope/{start,end}_block_scope/
  scope: let labels have their own scope
  scope: add is_in_scope()
  scope: give a scope for labels & gotos
  bad-goto: catch gotos inside expression statements
  bad-goto: cleanup evaluate_goto()

 evaluate.c                              | 25 +++++++++++++--
 expression.c                            |  4 +--
 linearize.c                             |  2 +-
 parse.c                                 | 23 +++++++-------
 parse.h                                 |  1 +
 scope.c                                 | 33 +++++++++++++++----
 scope.h                                 | 10 ++++--
 symbol.h                                |  4 +++
 validation/label-scope1.c               | 42 +++++++++++++++++++++++++
 validation/label-stmt-expr1.c           | 29 +++++++++++++++++
 validation/linear/goto-and-expr-stmt0.c | 33 +++++++++++++++++++
 validation/linear/invalid-labels0.c     | 18 +++++++++++
 12 files changed, 199 insertions(+), 25 deletions(-)
 create mode 100644 validation/label-scope1.c
 create mode 100644 validation/label-stmt-expr1.c
 create mode 100644 validation/linear/goto-and-expr-stmt0.c
 create mode 100644 validation/linear/invalid-labels0.c


base-commit: 0f5a39dcea89c66236c04815b77b107763873431
-- 
2.26.0
