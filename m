From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] patches for -rc3
Date: Wed, 21 Jun 2017 15:58:32 +0200
Message-ID: <20170621135831.h27ixpxbqdlvlhtn@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33816 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdFUN6g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Jun 2017 09:58:36 -0400
Received: by mail-lf0-f65.google.com with SMTP id l200so9833107lfg.1
        for <linux-sparse@vger.kernel.org>; Wed, 21 Jun 2017 06:58:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

Chris,

Please pull these patches for v0.5.1-rc3.
The patches of two kinds:
*) fixes for problem found during pre-release testing:
   - missing examine in evaluate_dereference()
   - workaround for bogus phi-nodes
   - fix for OP_PHI liveness
   - fix for __builtin_bswap{16,32,64}() constantness
*) small things inhibiting testing:
   - dissect: use built_in_ident() instead of MK_IDENT()
   - little/big-endian flag & defines
   - cgcc support for arm, arm64 & ppc64 


Everything have now been tested on:
- linux i386, x86-64, arm64, arm, ppc64 & ppc64le
- freebsd x86-64
- openbsd i386 (llvm backend not tested)
- darwin x86-64
and the tests consisted in:
- sparse's testsuite, of course,
- on linux, a kernel compile for an allyesconfig and looking
  after some oddities in the logs, like a crash or an unusal
  warning.
- doing a 'make sparse' on the git's tree

The only remaining problem I saw was a failire in the llvm
backend on arm (but I only had a rather old version of LLVM).

Unless a last minute problem, this should be the last patches
for the release.

Regards,
Luc

----------------------------------------------------------------

The following changes since commit bcfe020ed939fa1e8474efaf31a86d80d0e5c5fe:

  add support for -fmemcpy-max-count (2017-06-15 10:03:49 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/for-chris

for you to fetch changes up to a6fbbbf01a1ca358e0a991dd0fb1a1cca60b6f0b:

  bump sparse's version to -rc3 (2017-06-21 15:30:04 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (13):
      fix: add missing examine in evaluate_dereference()
      fix OP_PHI usage in try_to_simplify_bb() only when non-bogus
      fix: try_to_simplify_bb eargerness
      add fallback for missing __builtin_bswapXX()
      fix: __builtin_bswap{16,32,64}() constantness
      dissect: use built_in_ident() instead of MK_IDENT()
      teach sparse about -m{big,little}-endian
      teach sparse about __{BIG,LITTLE}_ENDIAN__
      teach sparse about __BYTE_ORDER__ & __ORDER_{BIG,LITTLE}_ENDIAN__
      cgcc: teach cgcc about arm64
      cgcc: teach cgcc about ppc64[le]
      cgcc: teach cgcc about arm
      bump sparse's version to -rc3

 Makefile                              |  2 +-
 builtin.c                             | 11 ++++---
 cgcc                                  | 20 +++++++++++++
 compat/bswap.h                        | 54 +++++++++++++++++++++++++++++++++++
 dissect.h                             | 11 -------
 evaluate.c                            |  2 ++
 flow.c                                | 47 +++++++++++++++++-------------
 lib.c                                 | 24 +++++++++++++++-
 lib.h                                 |  1 +
 test-dissect.c                        |  6 ++--
 validation/badtype5.c                 | 18 ++++++++++++
 validation/builtin-bswap-constant.c   |  6 ++++
 validation/crazy03.c                  | 33 +++++++++++++++++++++
 validation/endian-big.c               | 14 +++++++++
 validation/endian-little.c            | 14 +++++++++
 validation/linear/missing-insn-size.c | 19 ++++++++++++
 16 files changed, 242 insertions(+), 40 deletions(-)
 create mode 100644 compat/bswap.h
 create mode 100644 validation/badtype5.c
 create mode 100644 validation/crazy03.c
 create mode 100644 validation/endian-big.c
 create mode 100644 validation/endian-little.c
 create mode 100644 validation/linear/missing-insn-size.c
