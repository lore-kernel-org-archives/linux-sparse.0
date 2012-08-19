From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Fix 'void' return type code generation
Date: Sun, 19 Aug 2012 12:28:00 +0300
Message-ID: <1345368480-8431-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36622 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751358Ab2HSJ2K (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 05:28:10 -0400
Received: by lagy9 with SMTP id y9so2844657lag.19
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 02:28:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: j.neuschaefer@gmx.net, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

Jonathan Neusch=C3=A4fer reports:

  A simple function like this will compile to the following llvm
  bitcode:

        /* C */
        void func(void) {
                return;
        }

        /* LLVM */
        define i8 @func() {
        L0:
          ret void
        }

  The return type of the function and the type in the return instructio=
n
  don't match.

  I found this inconsistency by running LLVM's bitcode validation on th=
e
  bitcode produced by sparse-llvm.

Move 'void *' special-casing from sym_basetype_type() to sym_ptr_type()
to fix the issue.

Reported by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                         |   12 ++++++++++--
 validation/backend/void-return-type.c |   13 +++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 validation/backend/void-return-type.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index e02e212..213d42d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -150,7 +150,13 @@ static LLVMTypeRef sym_union_type(LLVMModuleRef mo=
dule, struct symbol *sym)
=20
 static LLVMTypeRef sym_ptr_type(LLVMModuleRef module, struct symbol *s=
ym)
 {
-	LLVMTypeRef type =3D symbol_type(module, sym->ctype.base_type);
+	LLVMTypeRef type;
+
+	/* 'void *' is treated like 'char *' */
+	if (is_void_type(sym->ctype.base_type))
+		type =3D LLVMInt8Type();
+	else
+		type =3D symbol_type(module, sym->ctype.base_type);
=20
 	return LLVMPointerType(type, 0);
 }
@@ -176,10 +182,12 @@ static LLVMTypeRef sym_basetype_type(struct symbo=
l *sym)
 		}
 	} else {
 		switch (sym->bit_size) {
+		case -1:
+			ret =3D LLVMVoidType();
+			break;
 		case 1:
 			ret =3D LLVMInt1Type();
 			break;
-		case -1:	/* 'void *' is treated like 'char *' */
 		case 8:
 			ret =3D LLVMInt8Type();
 			break;
diff --git a/validation/backend/void-return-type.c b/validation/backend=
/void-return-type.c
new file mode 100644
index 0000000..b282fde
--- /dev/null
+++ b/validation/backend/void-return-type.c
@@ -0,0 +1,13 @@
+static void foo(void)
+{
+}
+
+static void *bar(void *p)
+{
+	return p;
+}
+
+/*
+ * check-name: void return type code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
--=20
1.7.7.6

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
