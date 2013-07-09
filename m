From: Pekka Enberg <penberg@kernel.org>
Subject: [GIT PULL] Sparse/LLVM updates
Date: Tue, 9 Jul 2013 15:21:21 +0300
Message-ID: <CAOJsxLGSp7oPm8-qHEZvS4Oj=nfA2ZgnQAHwT762QxWSUj_JuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35010 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab3GIMVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Jul 2013 08:21:22 -0400
Received: by mail-wi0-f170.google.com with SMTP id ey16so11106315wid.5
        for <linux-sparse@vger.kernel.org>; Tue, 09 Jul 2013 05:21:21 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Xi Wang <xi.wang@gmail.com>, =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>

Hi Chris,

Please consider pulling the latest Sparse/LLVM tree:

  git@github.com:penberg/sparse-llvm.git llvm/core

It has various LLVM backend fixes from Jonathan and Xi.

                        Pekka

------------------>

The following changes since commit 5449cfbfe55eea2a602a40122c122b5040d6=
7243:

  Allow forced attribute in function argument (2013-04-26 08:27:41 -070=
0)

are available in the git repository at:

  git@github.com:penberg/sparse-llvm.git llvm/core

for you to fetch changes up to c0296d71405a97349d82e9909cad82a2af3271c2=
:

  Fix expression type for floating point negation ('!') (2013-05-27
14:15:56 +0300)

----------------------------------------------------------------
Jonathan Neusch=E4fer (4):
      sparse, llvm: Fix resulting type of store address calculations
      sparse, llvm: de-duplicate load/store address calculation code
      sparse, llvm: base load/store address type on insn_symbol_type()
      sparse, llvm: add a struct access test case

Pekka Enberg (1):
      sparse, llvm: Use LLVM_HOSTTRIPLE

Xi Wang (12):
      sparse, llvm: fix phi generation
      sparse, llvm: simplify function generation
      sparse, llvm: improve pointer arithmetic handling
      sparse, llvm: set target specification
      sparse, llvm: use LLVM_DEFAULT_TARGET_TRIPLE
      sparse, llvm: fix array size
      sparse, llvm: cache symbol_type() result
      sparse, llvm: fix struct name generation
      sparse, llvm: set more data attributes
      sparse, llvm: die if error
      Fix result type of relational and logical operators
      Fix expression type for floating point negation ('!')

 evaluate.c                         |  17 ++--
 lib.h                              |   2 +
 linearize.c                        |   4 +-
 sparse-llvm.c                      | 488
++++++++++++++++++++++++++++++++++++-----------------------------------=
---------------------
 sparsei                            |  13 +++
 validation/backend/loop2.c         |  14 +++
 validation/backend/store-type.c    |  12 +++
 validation/backend/struct-access.c |  28 ++++++
 validation/backend/struct.c        |   6 ++
 validation/backend/sum.c           |  28 ++++++
 validation/cond_expr3.c            |  17 ++++
 11 files changed, 320 insertions(+), 309 deletions(-)
 create mode 100755 sparsei
 create mode 100644 validation/backend/loop2.c
 create mode 100644 validation/backend/store-type.c
 create mode 100644 validation/backend/struct-access.c
 create mode 100644 validation/backend/sum.c
 create mode 100644 validation/cond_expr3.c
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
