From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 18:35:19 +0100
Message-ID: <20170228173519.hyq3aihtg3zouoih@macpro.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34727 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB1Rfv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 12:35:51 -0500
Received: by mail-wr0-f174.google.com with SMTP id l37so13709477wrc.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 09:35:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 06:03:05PM +0100, Luc Van Oostenryck wrote:
> On Tue, Feb 28, 2017 at 4:09 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > There is indeed some problems regarding this, we looked a bit at this
> > some weeks ago. However I firmly believe that the information about
> > the type belong to the operations and not the values.
> 
> I've taken a very quick look at this "mt->foo = (void *)0"
> The type info is perfectly present.
> If in sparse-llvm.c:output_op_store() you add somewhere something like:
>     fprintf(stderr, "-> %s\n", show_typename(insn->type));
> You will see that it display the expected type: "int *".
> This is all the type info needed: it's the type of insn->target (the
> value to be stored)
> and the type of the dereferencing of insn->src (the (base) address).
> 
> The problem is that output_op_store() doesn't use this info, it tries to deduce
> this type via pseudo_to_value() but pseudo_to_value() wrongly assumes that all
> PSEUDO_VALUE-pseudo are integer.


Not very pretty and incomplete but the following patch allow sparse-llvm
to compile this:
	struct mytype {
		int *foo;
	};
	
	extern void init_mytype(struct mytype *mt);
	void init_mytype(struct mytype *mt)
	{
		mt->foo = (int *)mt;
		mt->foo = (void *)mt;
		mt->foo = (int *)0;
		mt->foo = (void *)0;
		mt->foo = (void *)(long)0;
	}

It fail at " ... = (... *)1;" though.


diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f362b3ed..9e0450ae7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -306,6 +306,7 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
 	LLVMValueRef result = NULL;
+	LLVMTypeRef type;
 
 	switch (pseudo->type) {
 	case PSEUDO_REG:
@@ -360,7 +361,21 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = LLVMConstInt(insn_symbol_type(fn->module, insn), pseudo->value, 1);
+		type = insn_symbol_type(fn->module, insn);
+		switch (LLVMGetTypeKind(type)) {
+		case LLVMPointerTypeKind:
+			assert(!pseudo->value);
+			result = LLVMConstPointerNull(type);
+			break;
+		case LLVMIntegerTypeKind:
+			result = LLVMConstInt(type, pseudo->value, 1);
+			break;
+		default:
+			assert(0);
+		}
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
@@ -626,6 +641,7 @@ static void output_op_store(struct function *fn, struct instruction *insn)
 
 	addr = calc_memop_addr(fn, insn);
 
 	target_in = pseudo_to_value(fn, insn, insn->target);
 
 	/* perform store */
