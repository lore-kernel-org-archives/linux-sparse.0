From: Pekka Enberg <penberg@kernel.org>
Subject: [RFC/PATCH 2/2] sparse, llvm: Fix varargs functions
Date: Wed,  1 Feb 2012 11:55:52 +0200
Message-ID: <1328090152-28299-2-git-send-email-penberg@kernel.org>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63424 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756075Ab2BAJ4C (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 04:56:02 -0500
Received: by lagu2 with SMTP id u2so546473lag.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 01:56:01 -0800 (PST)
In-Reply-To: <1328090152-28299-1-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>

=46rom: Benjamin Herrenschmidt <benh@kernel.crashing.org>

We need to tell llvm about it or it won't generate the proper
stack frame & argument list on some architectures.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[ penberg@kernel.org: Fix function pointer calls=C2=A0]
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a291a0d..9226a21 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -79,7 +79,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module=
, struct symbol *sym)
 		arg_type[idx++] =3D symbol_type(module, arg_sym);
 	} END_FOR_EACH_PTR(arg);
 	func_type =3D LLVMFunctionType(ret_type, arg_type, n_arg,
-				     /* varargs? */ 0);
+				     sym->ctype.base_type->variadic);
=20
 	return func_type;
 }
@@ -744,7 +744,7 @@ static LLVMTypeRef get_func_type(struct function *f=
n, struct instruction *insn)
 	} END_FOR_EACH_PTR(arg);
=20
 	func_type =3D LLVMFunctionType(ret_type, arg_type, n_arg,
-				     /* varargs? */ 0);
+				     insn->fntype->variadic);
=20
 	return func_type;
 }
--=20
1.7.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
