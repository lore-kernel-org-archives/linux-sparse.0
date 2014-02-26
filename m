From: behanw@converseincode.com
Subject: [PATCH 1/5] kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang
Date: Tue, 25 Feb 2014 17:08:39 -0800
Message-ID: <1393376923-21892-2-git-send-email-behanw@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, Behan Webster <behanw@converseincode.com>, =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-sparse@vger.kernel.org

=46rom: Behan Webster <behanw@converseincode.com>

Add support to toplevel Makefile for compiling with clang, both for
HOSTCC and CC. Use cc-option to prevent gcc option from breaking clang,=
 and
from clang options from breaking gcc.

Clang 3.4 semantics are the same as gcc semantics for unsupported flags=
=2E For
unsupported warnings clang 3.4 returns true but shows a warning and gcc=
 shows
a warning and returns false.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Cc: PaX Team <pageexec@freemail.hu>
---
 Makefile | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 831b36a..c4ab30d 100644
--- a/Makefile
+++ b/Makefile
@@ -247,6 +247,15 @@ HOSTCXX      =3D g++
 HOSTCFLAGS   =3D -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -f=
omit-frame-pointer
 HOSTCXXFLAGS =3D -O2
=20
+ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
+HOSTCOMPILER :=3D clang
+HOSTCFLAGS  +=3D -Wno-unused-value -Wno-unused-parameter \
+		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
+else
+HOSTCOMPILER :=3D gcc
+endif
+export HOSTCOMPILER
+
 # Decide whether to build built-in, modular, or both.
 # Normally, just do built-in.
=20
@@ -323,6 +332,12 @@ endif
=20
 export quiet Q KBUILD_VERBOSE
=20
+ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
+COMPILER :=3D clang
+else
+COMPILER :=3D gcc
+endif
+export COMPILER
=20
 # Look for make include files relative to root of kernel src
 MAKEFLAGS +=3D --include-dir=3D$(srctree)
@@ -382,7 +397,7 @@ KBUILD_CFLAGS   :=3D -Wall -Wundef -Wstrict-prototy=
pes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
 		   -Wno-format-security \
-		   -fno-delete-null-pointer-checks
+		   $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_AFLAGS_KERNEL :=3D
 KBUILD_CFLAGS_KERNEL :=3D
 KBUILD_AFLAGS   :=3D -D__ASSEMBLY__
@@ -620,9 +635,24 @@ else
 endif
 KBUILD_CFLAGS +=3D $(stackp-flag)
=20
+ifeq ($(COMPILER),clang)
+KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
+KBUILD_CPPFLAGS +=3D $(call cc-option,-Wno-unknown-warning-option,)
+KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-variable)
+KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifier=
)
+KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
+# Quiet clang warning: comparison of unsigned expression < 0 is always=
 false
+KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
+# CLANG uses a _MergedGlobals as optimization, but this breaks modpost=
, as the
+# source of a reference will be _MergedGlobals and not on of the white=
listed names.
+# See modpost pattern 2
+KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
+else
+
 # This warning generated too much noise in a regular build.
 # Use make W=3D1 to enable this warning (see scripts/Makefile.build)
 KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
+endif
=20
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
