From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH 0/2] sparse-llvm: avoid SIGSEGV for function prototypes
Date: Sun, 17 May 2015 01:32:23 +0300
Message-ID: <1431815545-21250-1-git-send-email-a3at.mail@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34324 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbEPWcc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 May 2015 18:32:32 -0400
Received: by laat2 with SMTP id t2so170195470laa.1
        for <linux-sparse@vger.kernel.org>; Sat, 16 May 2015 15:32:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse ML <linux-sparse@vger.kernel.org>
Cc: Azat Khuzhin <a3at.mail@gmail.com>

Description is in the first patch, and the second patch contains regression.

Thanks!

Azat Khuzhin (2):
  sparse, llvm: compile: skip function prototypes to avoid SIGSEGV
  validation/prototype: regression for skipping prototypes

 sparse-llvm.c          | 11 +++++++++++
 validation/prototype.c |  6 ++++++
 2 files changed, 17 insertions(+)
 create mode 100644 validation/prototype.c

-- 
2.1.4

