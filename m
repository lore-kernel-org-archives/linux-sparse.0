From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE v2 00/28] detect invalid branches
Date: Tue, 19 May 2020 02:57:00 +0200
Message-ID: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgESA5d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6950AC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n24so2398917ejd.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not allowed to do a goto into an expression statement.
For example, it's not well defined what should happen if such
an expression is not otherwise reachable and/or can be optimized
away. For such situations GCC issues an error, clang doesn't
and produce a valid IR but Spare produce an invalid IR with
branches to unexisting BBs.

The goals of the patches in this series are:
*) to detect such gotos at evaluation time;
*) issue a sensible error message;
*) avoid the linearization of functions with invalid gotos.

The implementation principle behind these is to add a new kind
of scope (label_scope), one for the usual function scope of
labels one for each statement expressions. This new scope,
instead of being used as a real scope for the visibility of
labels, is used to mark where labels are defined and where
they're used. 

Using this label scope as a real scope controling the
visibility of labels was quite appealing and was the initial
drive for this implementation but has the problem of inner
scope shadowing earlier occurence of labels identically
named. This is of course desired for 'normal' symbols but for
labels (which are normally visible in the whole function
and which may be used before being declared/defined)
it has the disadvantage of:
*) inhibiting the detecting of misuses once an inner scope
   is closed
*) allowing several distinct labels with the same name
   in a single function (this can be regarded as a feature
   but __label__ at block scope should be used for this)
*) create diffrences about what is permssble or not between
   sparse and GCC or clang.


Changes since v1:
* move most of the checks from eveluation time to parsing time
* add warnings for unused labels based on code from Linus
* add support for label attributes 'unused'
* add to label-expressions the same kind of checks than
  those done for gotos
* use the correct position in warnings
* lots of small improvements


Luc Van Oostenryck (28):
  misc: fix testcase typeof-safe
  misc: s/fntype/rettype/
  misc: always use the node for current_fn
  bad-goto: add testcase for 'jump inside discarded expression statement'
  bad-goto: add testcases for linearization of invalid labels
  bad-goto: reorganize testcases and add some more
  bad-goto: do not linearize if the IR will be invalid
  bad-goto: reorg test in evaluate_goto_statement()
  bad-goto: simplify testing of undeclared labels
  bad-goto: do not linearize function with undeclared labels
  bad-goto: catch labels with reserved names
  scope: no memset() needed after __alloc_scope()
  scope: move scope opening/ending inside compound_statement()
  scope: extract bind_symbol_with_scope() from bind_symbol()
  scope: __func__ is special
  scope: __label__ is special
  scope: s/{start,end}_symbol_scope/{start,end}_block_scope/
  scope: make function_scope invalid outside functions
  scope: let labels have their own scope
  scope: add is_in_scope()
  scope: give a scope for labels & gotos
  bad-goto: jumping inside a statemet expression is an error
  bad-goto: label expression inside a statement expression is UB
  bad-goto: extract check_label_declaration()
  bad-goto: check declaration of label expressions
  bad-label: check for unused labels
  bad-label: mark labels as used when needed
  bad-label: respect attribute((unused))

 evaluate.c                                    | 36 ++++++--
 expand.c                                      |  2 +-
 expression.c                                  | 12 +--
 linearize.c                                   |  2 +-
 parse.c                                       | 73 +++++++++++++----
 parse.h                                       |  4 +-
 scope.c                                       | 46 +++++++++--
 scope.h                                       | 10 ++-
 symbol.c                                      | 13 ++-
 symbol.h                                      |  7 ++
 validation/__func__-scope.c                   |  8 ++
 .../{asm-goto-lables.c => asm-goto-labels.c}  |  0
 validation/label-asm.c                        |  1 +
 validation/label-attr.c                       |  2 +-
 validation/label-scope-cgoto.c                | 82 +++++++++++++++++++
 validation/label-scope.c                      |  5 +-
 validation/label-scope1.c                     | 42 ++++++++++
 validation/label-scope2.c                     | 31 +++++++
 validation/label-stmt-expr0.c                 | 38 +++++++++
 validation/label-stmt-expr1.c                 | 28 +++++++
 validation/label-stmt-expr2.c                 | 46 +++++++++++
 validation/label-unused.c                     | 29 +++++++
 validation/linear/goto-invalid.c              | 18 ++++
 .../linear/goto-stmt-expr-conditional.c       | 27 ++++++
 .../linear/goto-stmt-expr-short-circuit.c     | 31 +++++++
 validation/linear/label-scope-cgoto.c         | 10 +++
 .../label-stmt-dropped.c}                     |  4 +-
 .../label-stmt-expr0.c}                       |  4 +-
 ...reachable-label0.c => label-unreachable.c} |  3 +-
 validation/typeof-safe.c                      | 26 ++++--
 30 files changed, 576 insertions(+), 64 deletions(-)
 create mode 100644 validation/__func__-scope.c
 rename validation/{asm-goto-lables.c => asm-goto-labels.c} (100%)
 create mode 100644 validation/label-scope-cgoto.c
 create mode 100644 validation/label-scope1.c
 create mode 100644 validation/label-scope2.c
 create mode 100644 validation/label-stmt-expr0.c
 create mode 100644 validation/label-stmt-expr1.c
 create mode 100644 validation/label-stmt-expr2.c
 create mode 100644 validation/label-unused.c
 create mode 100644 validation/linear/goto-invalid.c
 create mode 100644 validation/linear/goto-stmt-expr-conditional.c
 create mode 100644 validation/linear/goto-stmt-expr-short-circuit.c
 create mode 100644 validation/linear/label-scope-cgoto.c
 rename validation/{discarded-label-statement.c => linear/label-stmt-dropped.c} (84%)
 rename validation/{label-expr.c => linear/label-stmt-expr0.c} (75%)
 rename validation/linear/{unreachable-label0.c => label-unreachable.c} (80%)


base-commit: 146e6a63e715e0c3e08aacbcaa79ff8930289297
-- 
2.26.2
