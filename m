From: Pekka Enberg <penberg@kernel.org>
Subject: [RFC/PATCH] sparse, llvm: Fix string globals access
Date: Fri,  8 Jun 2012 15:58:47 +0300
Message-ID: <1339160327-8534-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64524 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab2FHM65 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 08:58:57 -0400
Received: by lbbgm6 with SMTP id gm6so1325062lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 05:58:53 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

This patch attempts to fix code generation for global string access:

  static char *foo = "Foo !\n";

  extern int puts(const char *s);

  int main(int argc, char *argv[])
  {
          puts(foo);

          return 0;
  }

Unfortunately the generated executable SIGSEGVs:

  [penberg@tux sparse]$ ./sparsec foo.c && ./a.out
  Segmentation fault

Looking at the IR, Sparse/LLVM generates this:

  [penberg@tux sparse]$ ./sparse-llvm foo.c | llvm-dis
  ; ModuleID = '<stdin>'

  @"<noident>" = private global [7 x i8] c"Foo !\0A\00"
  @foo = private global [7 x i8]* @"<noident>"

  define i32 @main(i32, i8**) {
  L0:
    %load_target = load i64* bitcast ([7 x i8]* @"<noident>" to i64*)
    %2 = call i32 @puts(i64 %load_target)
    ret i32 0
  }

  declare i32 @puts(i64)

whereas Clang generates the following:

  @.str = private unnamed_addr constant [7 x i8] c"Foo !\0A\00", align 1

  define i32 @main(i32 %argc, i8** nocapture %argv) nounwind uwtable {
    %1 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0)) nounwind
    ret i32 0
  }

  declare i32 @puts(i8* nocapture) nounwind

I'm not sure what the LLVM backend can do here. Sparse linearizes the code to
this which is why LLVM backend does the casting:

  [penberg@tux sparse]$ ./test-linearize foo.c
  main:
  .L0x7f341f6f1010:
          <entry-point>
          load.64     %r1 <- 0[foo]
          call.32     %r2 <- puts, %r1
          ret.32      $0

Comments?

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
NOT-Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 89c6a2e..6b94205 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -308,7 +308,6 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		struct expression *expr;
 
 		assert(sym->bb_target == NULL);
-		assert(sym->ident == NULL);
 
 		expr = sym->initializer;
 		if (expr) {
@@ -326,6 +325,13 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 				result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
 				break;
 			}
+			case EXPR_SYMBOL: {
+				struct symbol *sym = expr->symbol;
+
+				result = LLVMGetNamedGlobal(fn->module, show_ident(sym->ident));
+				assert(result != NULL);
+				break;
+			}
 			default:
 				assert(0);
 			}
-- 
1.7.7.6

