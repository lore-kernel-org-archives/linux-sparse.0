From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 11/27] llvm: fix type of literal integer passed as arguments
Date: Sat, 11 Mar 2017 10:06:50 +0100
Message-ID: <20170311090706.17171-12-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35142 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755341AbdCKJHe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so2304821wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:32 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Like for all others instructions, LLVM needs the type
of each operands. However this information is not always
available via the pseudo. An example of such situation
is when passing a integer constant as argument since,
for sparse, constants are typeless.

Fix this by getting the type via the function prototype.
Two cases need to be handled:
- normal function call (prototype easiy acccessible).
- call via function pointer (a bit more complex).

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                     |  22 +++++-
 symbol.h                          |   5 ++
 validation/backend/function-ptr.c | 137 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c143cfb28..5ea0e5229 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -728,6 +728,14 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
+static struct symbol *get_function_basetype(struct symbol *type)
+{
+	if (type->type == SYM_PTR)
+		type = type->ctype.base_type;
+	assert(type->type == SYM_FN);
+	return type;
+}
+
 static void output_op_call(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef target, func;
@@ -745,7 +753,19 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 
 	i = 0;
 	FOR_EACH_PTR(insn->arguments, arg) {
-		args[i++] = pseudo_to_value(fn, insn, arg);
+		struct symbol *ftype = get_function_basetype(insn->fntype);
+		LLVMValueRef value;
+		if (arg->type == PSEUDO_VAL) {
+			struct symbol *atype;
+
+			atype = get_nth_symbol(ftype->arguments, i);
+			/* Value pseudos do not have type information. */
+			/* Use the function prototype to get the type. */
+			value = val_to_value(fn, arg->value, atype);
+		} else {
+			value = pseudo_to_value(fn, insn, arg);
+		}
+		args[i++] = value;
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
diff --git a/symbol.h b/symbol.h
index 36f8345b5..5823cd621 100644
--- a/symbol.h
+++ b/symbol.h
@@ -416,6 +416,11 @@ static inline int get_sym_type(struct symbol *type)
 	return type->type;
 }
 
+static inline struct symbol *get_nth_symbol(struct symbol_list *list, unsigned int idx)
+{
+	return ptr_list_nth_entry((struct ptr_list *)list, idx);
+}
+
 static inline struct symbol *lookup_keyword(struct ident *ident, enum namespace ns)
 {
 	if (!ident->keyword)
diff --git a/validation/backend/function-ptr.c b/validation/backend/function-ptr.c
index fc022b3cd..e035fe958 100644
--- a/validation/backend/function-ptr.c
+++ b/validation/backend/function-ptr.c
@@ -5,6 +5,143 @@ static int run(fn_t fn, int x, int y)
 	return fn(x, y);
 }
 
+extern int ival;
+extern int *ipval;
+extern int array[3];
+extern int matrix[3][3];
+extern int fun(int);
+
+// via an argument
+void arg(int a, int *p, int (*fb)(unsigned char), int (*fi)(int), int (*fl)(long), int (*fv)(void), int (*fip)(int *), int (*fim)(int (*)[3]), int (*fvp)(void *), int (*ffp)(int (*)(int)));
+void arg(int a, int *p, int (*fb)(unsigned char), int (*fi)(int), int (*fl)(long), int (*fv)(void), int (*fip)(int *), int (*fim)(int (*)[3]), int (*fvp)(void *), int (*ffp)(int (*)(int)))
+{
+	fv();
+
+	fb(a);
+	fi(a);
+	fl(a);
+	fb(123);
+	fi(123);
+	fl(123);
+	fb(123L);
+	fi(123L);
+	fl(123L);
+	fb(ival);
+	fi(ival);
+	fl(ival);
+
+	fip(p);
+	fip((void*)0);
+	fip(ipval);
+	fip(&ival);
+
+	fvp(p);
+	fvp((void*)0);
+	fvp(ipval);
+	fvp(&ival);
+
+	fvp(fun);
+	fvp(&fun);
+	ffp(fun);
+	ffp(&fun);
+}
+
+// a global
+extern int (*fb)(unsigned char);
+extern int (*fi)(int);
+extern int (*fl)(long);
+extern int (*fv)(void);
+extern int (*fip)(int *);
+extern int (*fim)(int (*)[3]);
+extern int (*fvp)(void *);
+extern int (*ffp)(int (*)(int));
+
+void glb(int a, int *p);
+void glb(int a, int *p)
+{
+	fv();
+
+	fb(a);
+	fi(a);
+	fl(a);
+	fb(123);
+	fi(123);
+	fl(123);
+	fb(123L);
+	fi(123L);
+	fl(123L);
+	fb(ival);
+	fi(ival);
+	fl(ival);
+
+	fip(p);
+	fip((void*)0);
+	fip(ipval);
+	fip(&ival);
+
+	fvp(p);
+	fvp((void*)0);
+	fvp(ipval);
+	fvp(&ival);
+
+	fvp(fun);
+	fvp(&fun);
+	ffp(fun);
+	ffp(&fun);
+}
+
+// via a struct member:
+// -> force to create a register containing the function pointer
+struct ops {
+	int (*fb)(unsigned char);
+	int (*fi)(int);
+	int (*fl)(long);
+	int (*fv)(void);
+	int (*fip)(int *);
+	int (*fim)(int (*)[3]);
+	int (*fvp)(void *);
+	int (*ffp)(int (*)(int));
+
+	int (*const cfi)(int);		// for the fun of it
+};
+
+void ops(int a, int *p, struct ops *ops);
+void ops(int a, int *p, struct ops *ops)
+{
+	ops->fv();
+
+	ops->fb(a);
+	ops->fi(a);
+	ops->fl(a);
+	ops->fb(123);
+	ops->fi(123);
+	ops->fl(123);
+	ops->fb(123L);
+	ops->fi(123L);
+	ops->fl(123L);
+	ops->fb(ival);
+	ops->fi(ival);
+	ops->fl(ival);
+
+	ops->fip(p);
+	ops->fip((void*)0);
+	ops->fip(ipval);
+	ops->fip(&ival);
+
+	ops->fvp(p);
+	ops->fvp((void*)0);
+	ops->fvp(ipval);
+	ops->fvp(&ival);
+
+	ops->fvp(fun);
+	ops->fvp(&fun);
+	ops->ffp(fun);
+	ops->ffp(&fun);
+	ops->fvp(fi);
+
+	ops->cfi(42);
+}
+
 /*
  * check-name: Function pointer code generation
  * check-command: ./sparsec -c $file -o tmp.o
-- 
2.11.1

