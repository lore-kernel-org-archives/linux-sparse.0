From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/15] testcases for bugs
Date: Fri, 15 Sep 2017 10:46:49 +0200
Message-ID: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51136 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:10 -0400
Received: by mail-wm0-f47.google.com with SMTP id v142so6352406wmv.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains testcases for some bugs or defects 
currently present in sparse.


The series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git testcases-bugs

----------------------------------------------------------------
Luc Van Oostenryck (15):
      add test case for using multiple input files
      add test case for VLA sizeof
      add test case for memory to register problem
      add test case for conditionally undefined var
      add test case for incomplete type
      add test case bitfields in K&R decl
      add test case storage specifier in struct member
      add test case using sizeof on incomplete type
      add test case for bad layout of bool in bitfields
      add test case for missed overflow detection
      add test case for compound literals
      add test case for pre-processor extra tokens warning
      add test case for space within command line
      add test case for superfluous cast with volatiles
      add test case for missing conversion to select

 validation/bad-return-type.c          | 19 ++++++++++++++++++
 validation/bitfield-bool-layout.c     | 26 ++++++++++++++++++++++++
 validation/bitfield-kr.c              | 14 +++++++++++++
 validation/compound-literal00.c       | 18 +++++++++++++++++
 validation/compound-literal01.c       | 27 +++++++++++++++++++++++++
 validation/incomplete-struct.c        | 23 ++++++++++++++++++++++
 validation/linear/cast-volatile.c     | 14 +++++++++++++
 validation/linear/stray-phisrc.c      | 25 +++++++++++++++++++++++
 validation/missing-return.c           | 20 +++++++++++++++++++
 validation/multi-input.c              | 11 +++++++++++
 validation/optim/missing-select.c     | 24 +++++++++++++++++++++++
 validation/overflow.c                 | 19 ++++++++++++++++++
 validation/preprocessor/arg-cli-ko.c  | 16 +++++++++++++++
 validation/preprocessor/arg-cli-ok.c  | 16 +++++++++++++++
 validation/preprocessor/extra-token.c | 15 ++++++++++++++
 validation/sizeof-incomplete-type.c   | 27 +++++++++++++++++++++++++
 validation/storage-struct-member.c    | 20 +++++++++++++++++++
 validation/var-undef-partial.c        | 21 ++++++++++++++++++++
 validation/vla-sizeof.c               | 37 +++++++++++++++++++++++++++++++++++
 19 files changed, 392 insertions(+)
 create mode 100644 validation/bad-return-type.c
 create mode 100644 validation/bitfield-bool-layout.c
 create mode 100644 validation/bitfield-kr.c
 create mode 100644 validation/compound-literal00.c
 create mode 100644 validation/compound-literal01.c
 create mode 100644 validation/incomplete-struct.c
 create mode 100644 validation/linear/cast-volatile.c
 create mode 100644 validation/linear/stray-phisrc.c
 create mode 100644 validation/missing-return.c
 create mode 100644 validation/multi-input.c
 create mode 100644 validation/optim/missing-select.c
 create mode 100644 validation/overflow.c
 create mode 100644 validation/preprocessor/arg-cli-ko.c
 create mode 100644 validation/preprocessor/arg-cli-ok.c
 create mode 100644 validation/preprocessor/extra-token.c
 create mode 100644 validation/sizeof-incomplete-type.c
 create mode 100644 validation/storage-struct-member.c
 create mode 100644 validation/var-undef-partial.c
 create mode 100644 validation/vla-sizeof.c
