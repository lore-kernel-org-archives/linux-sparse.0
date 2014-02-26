From: behanw@converseincode.com
Subject: [PATCH 5/5] x86 kbuild: LLVMLinux: More cc-options added for clang
Date: Tue, 25 Feb 2014 17:08:43 -0800
Message-ID: <1393376923-21892-6-git-send-email-behanw@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>, Behan Webster <behanw@converseincode.com>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-sparse@vger.kernel.org

=46rom: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>

Protect more options for x86 with cc-option so that we don't get errors=
 when
using clang instead of gcc.  Add more or different options when using c=
lang as
well. Also need to enforce that SSE is off for clang and the stack is 8=
-byte
aligned.

Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
---
 arch/x86/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index eeda43a..852d8f0 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -108,7 +108,7 @@ else
=20
         # this works around some issues with generating unwind tables =
in older gccs
         # newer gccs do it by default
-        KBUILD_CFLAGS +=3D -maccumulate-outgoing-args
+        KBUILD_CFLAGS +=3D $(call cc-option,-maccumulate-outgoing-args=
)
 endif
=20
 # Make sure compiler does not have buggy stack-protector support.
@@ -144,6 +144,12 @@ endif
 sp-$(CONFIG_X86_32) :=3D esp
 sp-$(CONFIG_X86_64) :=3D rsp
=20
+# enforce no-sse for clang
+ifneq ($(COMPILER),clang)
+        KBUILD_CFLAGS +=3D $(call cc-option,-mno-sse)
+        KBUILD_CFLAGS +=3D $(call cc-option,-mpreferred-stack-boundary=
=3D3)
+endif
+
 # do binutils support CFI?
 cfi :=3D $(call as-instr,.cfi_startproc\n.cfi_rel_offset $(sp-y)$(comm=
a)0\n.cfi_endproc,-DCONFIG_AS_CFI=3D1)
 # is .cfi_signal_frame supported too?
--=20
1.8.3.2
