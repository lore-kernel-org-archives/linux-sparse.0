From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH v3 0/2] arm64 live patching
Date: Thu, 11 Aug 2016 18:34:51 +0200 (CEST)
Message-ID: <20160811163451.D455C68C43@newverein.lst.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42362 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932301AbcHKQey (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Aug 2016 12:34:54 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, andrew.wafaa@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org


V3, including suggestions from the replies and 2 fixes.

Reminder: make sure you have a prolog-pad gcc, and this in your
top level Makefile:

ifdef CONFIG_LIVEPATCH
KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-ra)
endif

Tested with v4.8-rc1 + gcc-6.1

Changes since v2:
  * Do not skip initial NOP conversion for CC_USING_PROLOG_PAD,
    in other words: don't introduce new #ifdefs into generic code.
    (as requested by Steven Rostedt after my intermediate suggestion)
    Instead, check in arm64 whether a call to mcount is to be NOPed,
    and be strict again about the expected "old" instructions.
  * issue a warning should the compiler not know about -fprolog-pad=
    (as suggested by Josh Poimboeuf)
    Only strip the compiler flag proper, not the cpp flag, for critical
    files.
  * fix thinko / bummer in live patch return address change detection.
    Skip the graph caller if the addresses are _not_ equal!

Changes since v1:
  * instead of a comment "should be CC_USING_PROLOG_PAD":
    do it. CC_FLAGS_FTRACE holds it now, and the IPA
    disabler has become a separate issue (see above).

Torsten Duwe (2):
  arm64: implement FTRACE_WITH_REGS
  arm64: implement live patching

 arch/arm64/Kconfig                 |   4 ++
 arch/arm64/Makefile                |   9 ++++
 arch/arm64/include/asm/ftrace.h    |   8 +++
 arch/arm64/include/asm/livepatch.h |  37 ++++++++++++++
 arch/arm64/kernel/Makefile         |   6 +--
 arch/arm64/kernel/entry-ftrace.S   | 102 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c         |  45 ++++++++++++++--
 include/asm-generic/vmlinux.lds.h  |   2 +-
 include/linux/compiler.h           |   4 ++
 9 files changed, 209 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h

-- 
2.6.2

