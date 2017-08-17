From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 00/14] rework of cast operations
Date: Thu, 17 Aug 2017 06:05:15 +0200
Message-ID: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35259 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:38 -0400
Received: by mail-wr0-f170.google.com with SMTP id 49so23863560wrw.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:37 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to specialize the few cast
instuctions into more specialized ones so that the
precise nature of the operations is fully specified
by the instruction and thus no additional need to be
done later.

With this series we have:
- TRUNC, for int to smaller size int
- ZEXT,  for int to bigger int with zero extend
- SEXT,  for int to bigger int with sign extend
- PTRTU, for pointer to same sized [unsigned] int
- UTPTR, for pointer from same sized [unsigned] int
- PTRCAST, for pointer to pointer
- FCVT[US], for float to unsigned/signed integer
- [US]CVTF, for float from unsigned/signed integer
- FCVTF, for float to float

Also:
- for these casts, void pointer are treated as unsigned integers
- casts from int to same sized int are trated as NOP and never
  generated.


There are few points I'm not yet decided about, especially thinking
about what would be needed to to [type based] analysis:
- maybe we should no drop the NOP and have a real NOPCAST ?
- this NOPCAST may then be used for floats and pointers too?
- this NOPCAST could then be simplified away when needed
- PTRTU & UTPTR are in the same situation:
  - are they needed?
  - when can we simplified them away?
- it may be good to split FCVTF into: FTRUNC, NOPCAST & TEXT
- is it still good to treat void pointers the same as some integer?

----------------------------------------------------------------
This series is also available in the git repository at:

  git://github.com/lucvoo/sparse.git cast-rework

----------------------------------------------------------------
Luc Van Oostenryck (14):
      add documentation for IR instructions
      cast: add tests for warnings issued by sparse -v
      cast: prepare finer grained cast instructions
      cast: specialize FPCAST into [USF]CVTF
      cast: handle NO-OP casts
      cast: specialize floats to integer conversion
      cast: specialize casts from unsigned to pointers
      cast: make [u]intptr_ctype alias of [s]size_t_ctype
      cast: make pointer casts always size preserving
      cast: temporary simplify handling cast to/from void*
      cast: specialize cast from pointers
      cast: add support for -Wpointer-to-int-cast
      cast: make casts from pointer always size preserving
      cast: specialize integer casts

 Documentation/IR.md                    | 330 +++++++++++++++++++++++++++++++++
 cse.c                                  |  10 +-
 example.c                              |  22 ++-
 lib.c                                  |   4 +
 lib.h                                  |   2 +
 linearize.c                            | 165 ++++++++++++++---
 linearize.h                            |  11 +-
 liveness.c                             |  10 +-
 simplify.c                             |  54 +++---
 sparse-llvm.c                          |  21 ++-
 sparse.c                               |   5 +-
 symbol.h                               |   3 +
 validation/bitfield-size.c             |   5 +-
 validation/builtin-bswap-variable.c    |   4 +-
 validation/cast-kinds-check.c          |  19 ++
 validation/cast-kinds.c                | 181 ++++++++++--------
 validation/cast-weirds.c               |  51 +++++
 validation/compound-assign-type.c      |   3 +-
 validation/linear/bitfield-init-zero.c |   8 +-
 validation/memops-volatile.c           |   4 +-
 validation/optim/bool-simplify.c       |   4 +-
 21 files changed, 757 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/IR.md
 create mode 100644 validation/cast-kinds-check.c
 create mode 100644 validation/cast-weirds.c
