From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH v2 0/2] arm64 live patching
Date: Mon, 27 Jun 2016 17:15:00 +0200 (CEST)
Message-ID: <20160627151500.2247A68D20@newverein.lst.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45115 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0PPE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Jun 2016 11:15:04 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org

So here is a slightly updated FTRACE_WITH_REGS plus live patching.
Reminder: make sure you have a prolog-pad gcc, and this in your
top level Makefile:

ifdef CONFIG_LIVEPATCH
KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-ra)
endif

Tested with v4.7-rc3 + gcc-6.1

Changes since v1:
  * instead of a comment "should be CC_USING_PROLOG_PAD":
    do it. CC_FLAGS_FTRACE holds it now, and the IPA
    disabler has become a separate issue (see above).

Torsten Duwe (2):
  arm64: implement FTRACE_WITH_REGS
  arm64: implement live patching

 arch/arm64/Kconfig                 |   4 ++
 arch/arm64/Makefile                |   4 ++
 arch/arm64/include/asm/ftrace.h    |   8 +++
 arch/arm64/include/asm/livepatch.h |  37 ++++++++++++++
 arch/arm64/kernel/Makefile         |   6 +--
 arch/arm64/kernel/entry-ftrace.S   | 102 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c         |  43 ++++++++++++++--
 include/asm-generic/vmlinux.lds.h  |   2 +-
 include/linux/compiler.h           |   4 ++
 9 files changed, 203 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h

-- 
2.6.6

