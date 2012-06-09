From: Pekka Enberg <penberg@kernel.org>
Subject: [GIT PULL] LLVM backend updates
Date: Sat, 9 Jun 2012 14:11:04 +0300 (EEST)
Message-ID: <alpine.LFD.2.02.1206091408320.4769@tux.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36361 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab2FILLP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2012 07:11:15 -0400
Received: by lbbgm6 with SMTP id gm6so1926283lbb.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jun 2012 04:11:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jgarzik@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Xi Wang <xi.wang@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

Please pull the latest sparse-llvm tree from:

  git@github.com:penberg/sparse-llvm.git for-chris

It has one new validation test case and fixes to handle strings properly 
in the LLVM backend.

			Pekka
------------------>

The following changes since commit 970d7169d75068146152ba01a66381c800dbeb71:

  I have updated the sparse.1 man page including the __bitwise relevant 
content, and created Documentation/sparse.txt with the complete comparison 
between __nocast vs __bitwise. (2012-05-19 23:42:36 -0700)

are available in the git repository at:
  git@github.com:penberg/sparse-llvm.git for-chris

Pekka Enberg (4):
      sparse, llvm: Add _Bool to cast validation test
      sparse, llvm: Simplify output_data() type logic
      sparse, llvm: Fix string initializer code generation
      sparse, llvm: Fix global string access code generation

 sparse-llvm.c             |   16 ++++++++++++++--
 validation/backend/cast.c |    3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)
