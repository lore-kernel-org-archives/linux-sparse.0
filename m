From: Jeff Garzik <jeff@garzik.org>
Subject: Re: suggestion for Merging LLVM
Date: Wed, 23 Nov 2011 01:01:07 -0500
Message-ID: <4ECC8C23.4080909@garzik.org>
References: <CANeU7QkLTOaH7LNiyTEmUOrWb4Tb39+HKM0xPnowL5s0Qbbwyw@mail.gmail.com> <4ECB38B1.8020803@garzik.org> <1321941674.1428.124.camel@jaguar> <4ECC06F7.8040006@garzik.org> <CAOJsxLGqsH9vbE9AQO2chV28Wx=iw5hA9dJzR3X1Cvrd5Sv6Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57068 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab1KWGBJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 Nov 2011 01:01:09 -0500
Received: by vcbfk1 with SMTP id fk1so1015203vcb.19
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2011 22:01:09 -0800 (PST)
In-Reply-To: <CAOJsxLGqsH9vbE9AQO2chV28Wx=iw5hA9dJzR3X1Cvrd5Sv6Eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 11/22/2011 03:38 PM, Pekka Enberg wrote:
> So pasting the above test program tohttp://llvm.org/demo/  and
> switching to "LLVM C++ API code" target seems to suggest you're
> interested in the LLVMReplaceAllUsesWith() API for forward references.

Sent pull req via github.

List implementation is cheesy (inefficient if list ever gets woefully 
large) singly-linked list, but it is pretty simple.  Turned out that 
postponing LLVMAddIncoming() call works better than 
LLVMReplaceAllUsesWith() API:


(warning: do not apply directly, patch is unfortunately word-wrapped; 
see pull request)

--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -17,11 +17,21 @@
  #include "linearize.h"
  #include "flow.h"

+struct phi_fwd {
+       struct phi_fwd                  *next;
+
+       LLVMValueRef                    phi;
+       pseudo_t                        pseudo;
+       bool                            resolved;
+};
+
  struct function {
         LLVMBuilderRef                  builder;
         LLVMTypeRef                     type;
         LLVMValueRef                    fn;
         LLVMModuleRef                   module;
+
+       struct phi_fwd                  *fwd_list;
  };

  static inline bool symbol_is_fp_type(struct symbol *sym)
@@ -794,6 +804,67 @@ static void output_op_call(struct function *fn, 
struct instruction *insn)
         insn->target->priv = target;
  }

+static void store_phi_fwd(struct function *fn, LLVMValueRef phi,
+                         pseudo_t pseudo)
+{
+       struct phi_fwd *fwd;
+
+       fwd = calloc(1, sizeof(*fwd));
+       fwd->phi = phi;
+       fwd->pseudo = pseudo;
+
+       /* append fwd ref to function-wide list */
+       if (!fn->fwd_list)
+               fn->fwd_list = fwd;
+       else {
+               struct phi_fwd *last = fn->fwd_list;
+
+               while (last->next)
+                       last = last->next;
+               last->next = fwd;
+       }
+}
+
+static void output_phi_fwd(struct function *fn, pseudo_t pseudo, 
LLVMValueRef v)
+{
+       struct phi_fwd *fwd = fn->fwd_list;
+
+       while (fwd) {
+               struct phi_fwd *tmp;
+
+               tmp = fwd;
+               fwd = fwd->next;
+
+               if (tmp->pseudo == pseudo && !tmp->resolved) {
+                       LLVMValueRef phi_vals[1];
+                       LLVMBasicBlockRef phi_blks[1];
+
+                       phi_vals[0] = v;
+                       phi_blks[0] = pseudo->def->bb->priv;
+
+                       LLVMAddIncoming(tmp->phi, phi_vals, phi_blks, 1);
+
+                       tmp->resolved = true;
+               }
+       }
+}
+
+static void output_op_phisrc(struct function *fn, struct instruction *insn)
+{
+       LLVMValueRef v;
+
+       assert(insn->target->priv == NULL);
+
+       /* target = src */
+       v = pseudo_to_value(fn, insn, insn->phi_src);
+       insn->target->priv = v;
+
+       assert(insn->target->priv != NULL);
+
+       /* resolve forward references to this phi source, if present */
+       output_phi_fwd(fn, insn->target, v);
+}
+
  static void output_op_phi(struct function *fn, struct instruction *insn)
  {
         pseudo_t phi;
@@ -803,7 +874,7 @@ static void output_op_phi(struct function *fn, 
struct instruction *insn)
                                 "phi");
         int pll = 0;
         FOR_EACH_PTR(insn->phi_list, phi) {
-               if (pseudo_to_value(fn, insn, phi))     /* skip VOID */
+               if (pseudo_to_value(fn, insn, phi))     /* skip VOID, 
fwd refs*/
                         pll++;
         } END_FOR_EACH_PTR(phi);

@@ -815,11 +886,13 @@ static void output_op_phi(struct function *fn, 
struct instruction *insn)
                 LLVMValueRef v;

                 v = pseudo_to_value(fn, insn, phi);
-               if (v) {                        /* skip VOID */
+               if (v) {                        /* skip VOID, fwd refs */
                         phi_vals[idx] = v;
                         phi_blks[idx] = phi->def->bb->priv;
                         idx++;
                 }
+               else if (phi->type == PSEUDO_PHI)       /* fwd ref */
+                       store_phi_fwd(fn, target, phi);
         } END_FOR_EACH_PTR(phi);

         LLVMAddIncoming(target, phi_vals, phi_blks, pll);
@@ -916,8 +989,7 @@ static void output_insn(struct function *fn, struct 
instruction *insn)
                 assert(0);
                 break;
         case OP_PHISOURCE:
-               /* target = src */
-               insn->target->priv = pseudo_to_value(fn, insn, 
insn->phi_src);
+               output_op_phisrc(fn, insn);
                 break;
         case OP_PHI:
                 output_op_phi(fn, insn);
@@ -1026,7 +1098,7 @@ static void output_fn(LLVMModuleRef module, struct 
entrypoint *ep)
         struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
         LLVMTypeRef arg_types[MAX_ARGS];
         LLVMTypeRef return_type;
-       struct function function;
+       struct function function = { .module = module };
         struct basic_block *bb;
         struct symbol *arg;
         const char *name;
@@ -1043,8 +1115,6 @@ static void output_fn(LLVMModuleRef module, struct 
entrypoint *ep)

         return_type = symbol_type(module, ret_type);

-       function.module = module;
