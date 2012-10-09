From: Pekka Enberg <penberg@kernel.org>
Subject: =?ISO-8859-15?Q?=5BGIT_PULL=5D=A0Sparse=2FLLVM_updates?=
Date: Tue, 9 Oct 2012 09:34:40 +0300 (EEST)
Message-ID: <alpine.LFD.2.02.1210090934050.3891@tux.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1454618545-1349764484=:3891"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48684 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab2JIGeq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Oct 2012 02:34:46 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3488293lbo.19
        for <linux-sparse@vger.kernel.org>; Mon, 08 Oct 2012 23:34:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1454618545-1349764484=:3891
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi Chris,

Please pull the latest Sparse/LLVM tree from:

  git@github.com:penberg/sparse-llvm.git llvm/core

It contains few LLVM backend fixes from myself and Jonathan Neuschäfer.

			Pekka

------------------>

The following changes since commit 063236fd3f46bc83b49172f5ecb597e0a91cede8:

  ptrlist.c: fix a typo in a comment (2012-06-26 00:54:24 -0700)

are available in the git repository at:
  git@github.com:penberg/sparse-llvm.git llvm/core

Jonathan Neuschäfer (2):
      sparse, llvm: 'Verify' the LLVM module before writing it
      sparse, llvm: convert the condition of branch/select to bool

Pekka Enberg (2):
      sparse, llvm: Fix SIGSEGV for extern symbols
      sparse, llvm: Fix 'void' return type code generation

 sparse-llvm.c                         |   36 +++++++++++++++++++++++++++++---
 validation/backend/extern.c           |   11 ++++++++++
 validation/backend/int-cond.c         |   30 +++++++++++++++++++++++++++
 validation/backend/void-return-type.c |   13 +++++++++++
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 validation/backend/extern.c
 create mode 100644 validation/backend/int-cond.c
 create mode 100644 validation/backend/void-return-type.c
--8323328-1454618545-1349764484=:3891--
