From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 2/2] sparse, llvm: set target specification
Date: Sun, 19 May 2013 08:13:10 -0400
Message-ID: <1368965590-6714-2-git-send-email-xi.wang@gmail.com>
References: <1368965590-6714-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f177.google.com ([209.85.161.177]:61891 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3ESMOl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 08:14:41 -0400
Received: by mail-gg0-f177.google.com with SMTP id r4so1104111ggn.22
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 05:14:40 -0700 (PDT)
In-Reply-To: <1368965590-6714-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Set target triple and data layout, which are required by LLVM's backend=
=2E

Also export arch_m64 for choosing the target architecture.

Cc: Pekka Enberg <penberg@kernel.org>
Cc: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
With the two patches, we will be able to recover struct access.

Consider t.c:

	struct A { int x, y; };

	void foo(struct A *a)
	{
		a->x =3D 123;
		a->y =3D 456;
	}

$ ./sparse-llvm t.c | opt -S -O2
=2E..
define void @foo(%A* nocapture) #0 {
L0:
  %1 =3D getelementptr inbounds %A* %0, i64 0, i32 0
  store i32 123, i32* %1, align 4
  %2 =3D getelementptr inbounds %A* %0, i64 0, i32 1
  store i32 456, i32* %2, align 4
  ret void
}
---
 lib.h         |  2 ++
 sparse-llvm.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/lib.h b/lib.h
index 680ad8f..5ab2bd9 100644
--- a/lib.h
+++ b/lib.h
@@ -113,6 +113,8 @@ extern int Wvla;
 extern int dbg_entry;
 extern int dbg_dead;
=20
+extern int arch_m64;
+
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, st=
ruct string_list **files);
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 02f43f7..09eedb8 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -6,6 +6,7 @@
 #include <llvm-c/Core.h>
 #include <llvm-c/BitWriter.h>
 #include <llvm-c/Analysis.h>
+#include <llvm-c/Target.h>
=20
 #include <stdbool.h>
 #include <stdio.h>
@@ -1066,14 +1067,63 @@ static int compile(LLVMModuleRef module, struct=
 symbol_list *list)
 	return 0;
 }
=20
+#define X86_LINUX_LAYOUT \
+	"e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-" \
+	"i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-" \
+	"a0:0:64-f80:32:32-n8:16:32-S128"
+
+#define X86_64_LINUX_LAYOUT \
+	"e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-" \
+	"i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-" \
+	"a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
+
+static void set_target(LLVMModuleRef module)
+{
+	char target[] =3D LLVM_DEFAULT_TARGET_TRIPLE;
+	const char *arch, *vendor, *os, *env, *layout =3D NULL;
+	char triple[256];
+
+	arch =3D strtok(target, "-");
+	vendor =3D strtok(NULL, "-");
+	os =3D strtok(NULL, "-");
+	env =3D strtok(NULL, "-");
+
+	if (!os)
+		return;
+	if (!env)
+		env =3D "unknown";
+
+	if (!strcmp(arch, "x86_64") && !strcmp(os, "linux")) {
+		if (arch_m64) {
+			layout =3D X86_64_LINUX_LAYOUT;
+		} else {
+			arch =3D "i386";
+			layout =3D X86_LINUX_LAYOUT;
+		}
+	}
+
+	/* unsupported target */
+	if (!layout)
+		return;
+
+	snprintf(triple, sizeof(triple), "%s-%s-%s-%s", arch, vendor, os, env=
);
+	LLVMSetTarget(module, triple);
+	LLVMSetDataLayout(module, layout);
+}
+
 int main(int argc, char **argv)
 {
-	struct string_list * filelist =3D NULL;
+	struct string_list *filelist =3D NULL;
+	struct symbol_list *symlist;
+	LLVMModuleRef module;
 	char *file;
=20
-	LLVMModuleRef module =3D LLVMModuleCreateWithName("sparse");
+	symlist =3D sparse_initialize(argc, argv, &filelist);
+
+	module =3D LLVMModuleCreateWithName("sparse");
+	set_target(module);
=20
-	compile(module, sparse_initialize(argc, argv, &filelist));
+	compile(module, symlist);
=20
 	/* need ->phi_users */
 	dbg_dead =3D 1;
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
