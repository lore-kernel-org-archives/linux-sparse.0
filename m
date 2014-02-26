From: behanw@converseincode.com
Subject: [PATCH 0/5] kbuild: LLVMLinux: Initial updates to kbuild to enable the kernel to be compiled with clang/LLVM
Date: Tue, 25 Feb 2014 17:08:38 -0800
Message-ID: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, Behan Webster <behanw@converseincode.com>
List-Id: linux-sparse@vger.kernel.org

=46rom: Behan Webster <behanw@converseincode.com>

These patches add initial support for compiling the x86 kernel with cla=
ng. More
patches to the kernel code are required to actually compile the kernel =
with
clang. The intent of these patches are just to get things started with =
kbuild.

The LLVMLinux project aims to fully build the Linux kernel using both g=
cc and
clang (the C front end for the LLVM compiler infrastructure project).=20


Behan Webster (1):
  kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang

Jan-Simon M=C3=B6ller (3):
  kbuild: LLVMLinux: Adapt warnings for compilation with clang
  kbuild: LLVMLinux: Fix LINUX_COMPILER definition script for
    compilation with clang
  x86 kbuild: LLVMLinux: More cc-options added for clang

Mark Charlebois (1):
  LLVMLinux: Add support for clang to compiler.h and new
    compiler-clang.h

 Makefile                       | 32 +++++++++++++++++++++++++++++++-
 arch/x86/Makefile              |  8 +++++++-
 include/linux/compiler-clang.h | 12 ++++++++++++
 include/linux/compiler.h       |  7 +++++++
 scripts/Makefile.build         | 13 ++++++++++++-
 scripts/mkcompile_h            |  2 +-
 6 files changed, 70 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/compiler-clang.h

--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
