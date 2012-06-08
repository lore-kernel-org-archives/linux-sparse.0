From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 2/2] sparse, llvm: Fix string initializer code generation
Date: Fri,  8 Jun 2012 15:34:37 +0300
Message-ID: <1339158877-32024-2-git-send-email-penberg@kernel.org>
References: <1339158877-32024-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48200 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760278Ab2FHMes (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 08:34:48 -0400
Received: by lahd3 with SMTP id d3so1206752lah.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 05:34:47 -0700 (PDT)
In-Reply-To: <1339158877-32024-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

This fixes code generation for string initializer such as:

  static char *foo = "Foo !\n";

It's the same fix Ben proposed earlier with the small difference that we now
use LLVMTypeOf() instead of symbol_type() to resolve the type.

The generated LLVM IR looks as follows:

  [penberg@tux sparse]$ ./sparse-llvm foo.c |llvm-dis
  ; ModuleID = '<stdin>'

  @"<noident>" = private global [7 x i8] c"Foo !\0A\00"
  @foo = private global [7 x i8]* @"<noident>"

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a39bc02..89c6a2e 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1181,6 +1181,12 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 				initial_value = output_data(module, sym);
 			break;
 		}
+		case EXPR_STRING: {
+			const char *s = initializer->string->data;
+
+			initial_value = LLVMConstString(strdup(s), strlen(s) + 1, true);
+			break;
+		}
 		default:
 			assert(0);
 		}
-- 
1.7.7.6

