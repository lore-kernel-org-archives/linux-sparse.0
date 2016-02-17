From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 5/5] test-locks: Add lock tester
Date: Wed, 17 Feb 2016 10:51:35 +0100
Message-ID: <1455702695-6199-6-git-send-email-daniel.wagner@bmw-carit.de>
References: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>
List-Id: linux-sparse@vger.kernel.org

I was playing a bit around to see if it is possible to figure out if a
variable is accessed without holding the corresponding lock. This never
got anywhere and that's why I abandon it. In case someone wants to
use parts of it or whatever, please be my guest.

Example output:

./test-locks validation/caps.c
validation/caps.c:49:13: warning: function 'set_str' not holding 'anon'
validation/caps.c:25:13: warning: leaks lock 'anon'
  frame: ep 0x7f0af437e010 a
  frame: ep 0x7f0af437e0a0 okay1 (call        a)
  frame: ep 0x7f0af437e0d0 bad2 (call        okay1)

validation/caps.c:70:8: warning: leaks lock 'global_lock'
  frame: ep 0x7f0af437e100 wtf_lock
  frame: ep 0x7f0af437e1f0 bad4 (call        wtf_lock, global_lock)

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 Makefile          |    3 +-
 lib.c             |    2 +
 lib.h             |    7 +
 test-locks.c      | 1020 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 validation/caps.c |   80 +++++
 5 files changed, 1111 insertions(+), 1 deletion(-)
 create mode 100644 test-locks.c
 create mode 100644 validation/caps.c

diff --git a/Makefile b/Makefile
index c7031af..db0c343 100644
--- a/Makefile
+++ b/Makefile
@@ -54,7 +54,8 @@ INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
-	 test-linearize example test-unssa test-dissect ctags
+	 test-linearize example test-unssa test-dissect ctags \
+	 test-locks
 INST_PROGRAMS=sparse cgcc
 INST_MAN1=sparse.1 cgcc.1
 
diff --git a/lib.c b/lib.c
index 8dc5bcf..7b49e2f 100644
--- a/lib.c
+++ b/lib.c
@@ -244,6 +244,7 @@ int Wvla = 1;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
+int dbg_caps = 0;
 
 int preprocess_only;
 
@@ -518,6 +519,7 @@ static char **handle_switch_W(char *arg, char **next)
 static struct warning debugs[] = {
 	{ "entry", &dbg_entry},
 	{ "dead", &dbg_dead},
+	{ "caps", &dbg_caps},
 };
 
 
diff --git a/lib.h b/lib.h
index 15b69fa..87d1948 100644
--- a/lib.h
+++ b/lib.h
@@ -130,6 +130,7 @@ extern int Wvla;
 
 extern int dbg_entry;
 extern int dbg_dead;
+extern int dbg_caps;
 
 extern int arch_m64;
 
@@ -189,6 +190,12 @@ static inline struct basic_block *first_basic_block(struct basic_block_list *hea
 {
 	return first_ptr_list((struct ptr_list *)head);
 }
+
+static inline struct basic_block *last_basic_block(struct basic_block_list *head)
+{
+	return last_ptr_list((struct ptr_list *)head);
+}
+
 static inline struct instruction *last_instruction(struct instruction_list *head)
 {
 	return last_ptr_list((struct ptr_list *)head);
diff --git a/test-locks.c b/test-locks.c
new file mode 100644
index 0000000..f311f4c
--- /dev/null
+++ b/test-locks.c
@@ -0,0 +1,1020 @@
+/*
+ * This is an miserable attempt in static code analysis. The test
+ * executes the program and maintains a current set of locks. At every
+ * function entry and exit point all the current lock set is attached
+ * to the function and the current calling stack is also added to the lock.
+ *
+ * In the second phase the check_leaking() function then looks at all
+ * locks and the calling stacks and reports all those function which
+ * have an lock in the exit lock set and no other function is calling them.
+ * Obvioysly reallity is much more complex and this simple testing
+ * will not catch a lot of wrong cases.
+ *
+ * There is also the attempt to figure out if a variable has been accessed
+ * without holding the corresponding lock.
+ *
+ * If you want to understand what is doing run it with
+ *
+ *   $ test-locks validation/caps.c -vcaps -v -v -v
+ *
+ * which print a lot of details.
+ *
+ * Copyright (C) 2016  BMW Car IT GmbH.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "linearize.h"
+#include "flow.h"
+#include "scope.h"
+
+#define dbg_level0 (dbg_caps)
+#define dbg_level1 (dbg_caps && verbose > 0)
+#define dbg_level2 (dbg_caps && verbose > 1)
+#define dbg_level3 (dbg_caps && verbose > 2)
+
+struct frame {
+	struct instruction *insn;
+	struct entrypoint *ep;
+};
+
+ALLOCATOR(frame, "call stack");
+DECLARE_PTR_LIST(frame_list, struct frame);
+
+struct frame *alloc_frame(struct entrypoint *ep, struct instruction *insn)
+{
+	struct frame *frame = __alloc_frame(0);
+
+	frame->ep = ep;
+	frame->insn = insn;
+	return frame;
+}
+
+static inline struct frame *last_frame(struct frame_list *head)
+{
+	return last_ptr_list((struct ptr_list *)head);
+}
+
+static inline struct frame *first_frame(struct frame_list *head)
+{
+	return first_ptr_list((struct ptr_list *)head);
+}
+
+static inline struct frame *delete_last_frame(struct frame_list **head)
+{
+	return delete_ptr_list_last((struct ptr_list **)head);
+}
+
+static inline void add_frame(struct frame_list **list, struct frame *frame)
+{
+	add_ptr_list(list, frame);
+}
+
+static inline struct frame *lookup_frame(struct frame_list *list,
+					struct  entrypoint *ep)
+{
+	struct frame *c;
+
+	FOR_EACH_PTR(list, c) {
+		if (c->ep == ep)
+			return c;
+	} END_FOR_EACH_PTR(c);
+
+	return NULL;
+}
+
+static inline int frame_list_size(struct frame_list *head)
+{
+	return ptr_list_size((struct ptr_list *)head);
+}
+
+static inline int frame_cmp(struct frame *f1, struct frame *f2)
+{
+	return !(f1->ep == f2->ep && f1->insn == f2->insn);
+}
+
+static int stack_cmp(struct frame_list *s1, struct frame_list *s2)
+{
+	struct frame *f1, *f2;
+
+	PREPARE_PTR_LIST(s1, f1);
+	PREPARE_PTR_LIST(s2, f2);
+	for (;;) {
+		if (!f1 || !f2)
+			return 1;
+
+		if (frame_cmp(f1, f2))
+			return 1;
+
+		NEXT_PTR_LIST(f1);
+		NEXT_PTR_LIST(f2);
+	}
+	FINISH_PTR_LIST(f2);
+	FINISH_PTR_LIST(f1);
+
+	return 0;
+}
+
+static int stack_frame_position(struct frame_list *stack, struct entrypoint *ep)
+{
+	struct frame *f;
+	int pos = 0;
+
+	FOR_EACH_PTR(stack, f) {
+		if (f->ep == ep)
+			return pos;
+		pos++;
+	} END_FOR_EACH_PTR(f);
+
+	return -1;
+}
+
+static void copy_stack(struct frame_list *from, struct frame_list **to)
+{
+	struct frame *c;
+
+	FOR_EACH_PTR(from, c) {
+		add_frame(to, alloc_frame(c->ep, c->insn));
+	} END_FOR_EACH_PTR(c);
+}
+
+/* Better naming wouldn't hurt. we could also do a frame_list** in
+ * struct lock but that is really hard to read. Let's wrap it here and
+ * use it as 2 dimensional list.
+ */
+struct stack {
+	struct frame_list *stack;
+};
+ALLOCATOR(stack, "stack list");
+DECLARE_PTR_LIST(stack_list, struct stack);
+
+static inline void add_stack(struct stack_list **list, struct stack *stack)
+{
+	add_ptr_list(list, stack);
+}
+
+struct lock {
+	unsigned int ref;
+	struct symbol *sym;
+	struct capability_list *caps;
+	struct stack_list *stacks;
+};
+
+ALLOCATOR(lock, "lock list");
+DECLARE_PTR_LIST(lock_list, struct lock);
+
+static struct lock *alloc_lock(struct symbol *sym)
+{
+	struct lock *lock = __alloc_lock(0);
+
+	lock->ref = 1;
+	lock->sym = sym;
+
+	return lock;
+};
+
+static inline void ref_lock(struct lock *lock)
+{
+	lock->ref++;
+}
+
+static inline unsigned int unref_lock(struct lock *lock)
+{
+	return --lock->ref;
+}
+
+static inline void add_lock(struct lock_list **list, struct lock *lock)
+{
+	add_ptr_list(list, lock);
+}
+
+static inline void remove_lock(struct lock_list **list, struct lock *lock)
+{
+	delete_ptr_list_entry((struct ptr_list **)list, lock, 1);
+}
+
+static struct lock *lookup_lock(struct lock_list *list, struct symbol *sym)
+{
+	struct lock *l;
+
+	FOR_EACH_PTR(list, l) {
+		if (sym == l->sym)
+			return l;
+	} END_FOR_EACH_PTR(l);
+
+	return NULL;
+}
+
+static struct lock_list *all_locks;
+
+static void add_stack_trace(struct frame_list *stack, struct lock *lock)
+{
+	struct stack *st;
+
+	/* Filter out duplicates */
+	FOR_EACH_PTR(lock->stacks, st) {
+		if (!stack_cmp(stack, st->stack))
+			return;
+	} END_FOR_EACH_PTR(st);
+
+	st = __alloc_stack(0);
+	copy_stack(stack, &st->stack);
+	add_stack(&lock->stacks, st);
+}
+
+/* Copy the current lock set to either the entry or exit list of the
+ * function. Remember also the calling stack. This will be handy
+ * in the second step of the analysis when we check for leaking
+ * locks etc.
+ */
+static void copy_lock_list(struct frame_list *stack,
+				struct lock_list *from, struct lock_list **to)
+{
+	struct lock *lock, *l;
+
+	FOR_EACH_PTR(from, lock) {
+		/* let's colapse symbols with the same addresse to one
+		 * lock and remove duplicates by this.
+		 */
+		l = lookup_lock(all_locks, lock->sym);
+		if (!l) {
+			l = alloc_lock(lock->sym);
+			add_lock(&all_locks, l);
+		} else
+			ref_lock(l);
+
+		if (!lookup_lock(*to, lock->sym))
+			add_lock(to, l);
+
+		add_stack_trace(stack, l);
+	} END_FOR_EACH_PTR(lock);
+}
+
+static inline int lock_list_size(struct lock_list *list)
+{
+	return ptr_list_size((struct ptr_list *)list);
+}
+
+struct bb_info {
+	struct lock_list *entry;
+	struct lock_list *exit;
+};
+ALLOCATOR(bb_info, "bb info");
+
+/* debug printfs helpers */
+
+static void show_call_stack(struct frame_list *list, int level)
+{
+	struct frame *c;
+
+	FOR_EACH_PTR_REVERSE(list, c) {
+		printf("%*sframe: ep %p %s", level * 2, "", c->ep,
+			show_ident(c->ep->name->ident));
+		if (c->insn)
+			printf(" (%s)", show_instruction(c->insn));
+		printf("\n");
+	} END_FOR_EACH_PTR_REVERSE(c);
+}
+
+static void show_short_symbol_list(struct symbol_list *list, const char *name)
+{
+	struct symbol *sym;
+	const char *prepend = "";
+
+	printf("%s:\t", name);
+	FOR_EACH_PTR(list, sym) {
+		printf("%s", prepend);
+		prepend = ", ";
+		printf("%s",  show_ident(sym->ident));
+	} END_FOR_EACH_PTR(sym);
+	puts("");
+}
+
+static void show_pseudo_user_list(struct pseudo_user_list *list,
+				  const char *name)
+{
+	struct pseudo_user *pu;
+
+	if (ptr_list_empty(list))
+		return;
+	printf("%s:\n", name);
+	FOR_EACH_PTR(list, pu) {
+		printf("\t%s used by %p, %s\n",
+			show_pseudo(*pu->userp), pu->insn,
+			show_instruction(pu->insn));
+	} END_FOR_EACH_PTR(pu);
+}
+
+static void show_pseudo_list(struct pseudo_list *list, const char *name)
+{
+	struct pseudo *p;
+	struct symbol *s;
+
+	printf("%s:\n", name);
+	FOR_EACH_PTR(list, p) {
+		printf("\t%s",  show_pseudo(p));
+		switch (p->type) {
+		case PSEUDO_SYM:
+			printf(" (symbol %p scope %p ", p->sym, p->sym->scope);
+			s = p->sym->next_id;
+			while (s) {
+				printf("next_id %p ", s);
+				s = s->next_id;
+			}
+			show_type(p->sym);
+			printf(")\n");
+			break;
+		case PSEUDO_ARG:
+			printf(" (");
+			show_pseudo_user_list(p->users, "users");
+			printf(" )\n");
+			break;
+		default:
+			break;
+		}
+	} END_FOR_EACH_PTR(p);
+}
+
+static void show_basic_block_list(struct basic_block_list *list,
+				  const char *name)
+{
+	struct basic_block *bb;
+	const char *prepend = "";
+
+	printf("%s:\t", name);
+	FOR_EACH_PTR(list, bb) {
+		printf("%s", prepend);
+		prepend = ", ";
+		printf("%p",  bb);
+	} END_FOR_EACH_PTR(bb);
+	puts("");
+}
+
+static const char * const cap_ops[] = {
+	[CAP_ACQUIRE] = "acquire",
+	[CAP_RELEASE] = "release",
+	[CAP_REQUIRES] = "requires",
+	[CAP_GUARDED_BY] = "guarded_by",
+};
+
+static void show_cap(struct capability *cap)
+{
+	printf("cap %p %s '%s'\n", cap,
+		cap_ops[cap->op],
+		cap->expr ? show_ident(cap->expr->symbol_name) : "anon");
+}
+
+static void show_lock(struct lock *lock, const char *prepend,
+		const char *postfix)
+{
+	printf("%ssym %p '%s' %s",
+		prepend, lock->sym,
+		lock->sym ? show_ident(lock->sym->ident) : "anon",
+		postfix);
+}
+
+static void show_lock_list(struct lock_list *locks,
+			const char *prepend, const char *postfix)
+{
+	struct lock *lock;
+
+	FOR_EACH_PTR(locks, lock) {
+		show_lock(lock, prepend, postfix);
+	} END_FOR_EACH_PTR(lock);
+}
+
+static void show_cap_list(struct capability_list *list, const char *name)
+{
+	struct capability *cap;
+	const char *prepend = "";
+
+	printf("%s:\t", name);
+	FOR_EACH_PTR(list, cap) {
+		printf("%s", prepend);
+		prepend = ", ";
+		show_cap(cap);
+	} END_FOR_EACH_PTR(cap);
+	puts("");
+}
+
+static void show_bb_lock_list(struct basic_block_list *list, const char *name)
+{
+	struct basic_block *bb;
+
+	printf("%s:\n", name);
+	FOR_EACH_PTR(list, bb) {
+		struct bb_info *info = bb->priv;
+
+		printf("\tbb %p\n", bb);
+		printf("\t\tlocks entry:\n");
+		show_lock_list(info->entry, "\t\t\t", "\n");
+		printf("\t\tlocks exit:\n");
+		show_lock_list(info->exit, "\t\t\t", "\n");
+	} END_FOR_EACH_PTR(bb);
+}
+
+static void show_entry_lock_list(struct entrypoint *ep, int level)
+{
+	struct basic_block *bb = ep->entry->bb;
+	struct bb_info *info = bb->priv;
+
+	printf("%*slocks entry:", level * 2, "");
+	show_lock_list(info->entry, " ", ",");
+	printf("\n");
+}
+
+static void show_exit_lock_list(struct entrypoint *ep, int level)
+{
+	struct basic_block *bb = last_basic_block(ep->bbs);
+	struct bb_info *info = bb->priv;
+
+	printf("%*slocks exit:", level * 2, "");
+	show_lock_list(info->exit, " ", ",");
+	printf("\n");
+}
+
+static void show_entrypoint(struct entrypoint *ep)
+{
+	printf("ep:\t%s\n", ep->name->ident->name);
+	show_short_symbol_list(ep->name->ctype.base_type->arguments, "args");
+	show_short_symbol_list(ep->syms, "syms");
+	show_pseudo_list(ep->accesses, "accesses");
+	show_basic_block_list(ep->bbs, "bbs");
+	show_pseudo_list(ep->entry->arg_list, "arg_list");
+	show_cap_list(ep->name->ctype.capabilities, "caps");
+	show_bb_lock_list(ep->bbs, "locks");
+}
+
+static struct pseudo *lookup_accesses(struct entrypoint *ep,
+					struct ident *ident)
+{
+	struct pseudo *p;
+
+	if (!ident)
+		return NULL;
+
+	FOR_EACH_PTR(ep->accesses, p) {
+		if (p->ident && !strcmp(p->ident->name, ident->name))
+			return p;
+	} END_FOR_EACH_PTR(p);
+
+	return NULL;
+}
+
+static struct pseudo *get_argument_pseudo(struct pseudo_list *list, int nr)
+{
+	struct pseudo *p;
+	int i = 1;
+
+	FOR_EACH_PTR(list, p) {
+		if (i == nr)
+			return p;
+		i++;
+	} END_FOR_EACH_PTR(p);
+
+	return NULL;
+}
+
+static int get_argument_nr(struct symbol_list *list, struct pseudo *p)
+{
+	int i = 0;
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		i++;
+		if (strcmp(sym->ident->name, p->ident->name))
+			continue;
+		return i;
+	} END_FOR_EACH_PTR(sym);
+
+	return -1;
+}
+
+static struct symbol *figure_access(struct pseudo *p, struct frame_list *stack)
+{
+	struct symbol *sym, *type;
+	struct frame *f;
+	int argc = -1;
+
+	FOR_EACH_PTR_REVERSE(stack, f) {
+		if (argc >= 0) {
+			p = get_argument_pseudo(f->insn->arguments, argc);
+			if (!p) {
+				printf("bug bug bug bug for YOUUUUU!!\n");
+				return NULL;
+			}
+
+			argc = -1;
+		}
+
+		if (p->type == PSEUDO_ARG) {
+			/* this is an argument so we can just go on
+			 * frame up and look at the caller.
+			 */
+			argc = p->nr;
+			continue;
+		}
+
+		if (p->type == PSEUDO_SYM) {
+			sym = get_base_type(p->sym);
+			if (is_ptr_type(sym)) {
+				/* so we have a pointer. was it passed
+				 * in as argument?
+				 */
+				type = f->ep->name->ctype.base_type;
+				argc = get_argument_nr(type->arguments, p);
+				continue;
+			} else
+				return p->sym;
+		}
+
+		/* p is not ARG nor SYM, that's the end of the story */
+		break;
+	} END_FOR_EACH_PTR_REVERSE(f);
+
+	return NULL;
+}
+
+static struct symbol *figure_capability(struct capability *cap,
+					struct entrypoint *ep,
+					struct frame_list *stack)
+{
+	struct symbol *sym;
+	struct pseudo *p;
+
+	if (!cap->expr)
+		return NULL;
+
+	if (cap->expr->symbol) {
+		/* so from the linearization step we have a proper symbol,
+		 * just get the pseudo.
+		 */
+		p = lookup_accesses(ep, cap->expr->symbol->ident);
+	} else {
+		/* no luck, we only have the name so let's use that one
+		 * instead.
+		 */
+		p = lookup_accesses(ep, cap->expr->symbol_name);
+	}
+
+	if (p) {
+		/* we found a pseudo in this function, let's try to
+		 * defer it, that is where is defined. note the final
+		 * call frame also handles the global symbols because
+		 * they are also listed in the accesses list.
+		 */
+		sym = figure_access(p, stack);
+	} else {
+		/* the context attributes didn't get the linearize
+		 * treatment, that means the access has not been
+		 * added to the accesses list. first we tried
+		 * to lookup in the accesses list but it is not there
+		 * so we just try to see if it is a global symbol.
+		 */
+		sym = lookup_symbol(cap->expr->symbol_name, NS_SYMBOL);
+	}
+
+	return sym;
+}
+
+static void acquire_lock(struct lock_list **lset, struct entrypoint *ep,
+			struct frame_list *stack, struct capability *cap)
+{
+	struct symbol *sym;
+	struct lock *lock;
+
+	sym = figure_capability(cap, ep, stack);
+	lock = lookup_lock(*lset, sym);
+
+	if (!lock) {
+		lock = alloc_lock(sym);
+		add_lock(lset, lock);
+	} else
+		ref_lock(lock);
+}
+
+static void release_lock(struct lock_list **lset, struct entrypoint *ep,
+			struct frame_list *stack, struct capability *cap)
+{
+	struct symbol *sym;
+	struct lock *lock;
+
+	sym = figure_capability(cap, ep, stack);
+	lock = lookup_lock(*lset, sym);
+
+	if (!lock)
+		return;
+
+	if (!unref_lock(lock)) {
+		remove_lock(lset, lock);
+		__free_lock(lock);
+	}
+}
+
+static void check_cap_requires(struct lock_list **lset,
+				struct entrypoint *ep, struct frame_list *stack)
+{
+	struct capability *cap;
+
+	if (frame_list_size(stack) == 1) {
+		/* there is little point in checking if the caller holds
+		 * the required locks if there is no caller.
+		 */
+		return;
+	}
+
+	/* First step of validation. Let's check if we see
+	 * the required lock in the working set.
+	 */
+	FOR_EACH_PTR(ep->name->ctype.capabilities, cap) {
+		struct symbol *s = figure_capability(cap, ep, stack);
+		struct lock *l;
+
+		switch (cap->op) {
+		case CAP_REQUIRES:
+			l = lookup_lock(*lset, s);
+			if (!l) {
+				warning(ep->name->pos,
+					"function '%s' not holding '%s'",
+					show_ident(ep->name->ident),
+					s ? s->ident->name : "anon");
+			}
+			break;
+		default:
+			break;
+		}
+	} END_FOR_EACH_PTR(cap);
+}
+
+static void update_locks_on_entry(struct lock_list **lset,
+				  struct entrypoint *ep,
+				  struct frame_list *stack,
+				  int level)
+{
+	struct basic_block *bb = ep->entry->bb;
+	struct bb_info *info = bb->priv;
+
+	copy_lock_list(stack, *lset, &info->entry);
+
+	check_cap_requires(lset, ep, stack);
+
+	if (dbg_level0)
+		show_entry_lock_list(ep, level);
+}
+
+static void update_locks_on_exit(struct lock_list **lset,
+				 struct entrypoint *ep,
+				 struct frame_list *stack,
+				 int level)
+{
+	struct basic_block *bb = last_basic_block(ep->bbs);
+	struct bb_info *info = bb->priv;
+	struct capability *cap;
+
+	FOR_EACH_PTR(ep->name->ctype.capabilities, cap) {
+		struct symbol *s = figure_capability(cap, ep, stack);
+		struct lock *l;
+
+		switch (cap->op) {
+		case CAP_ACQUIRE:
+			acquire_lock(lset, ep, stack, cap);
+			break;
+		case CAP_RELEASE:
+			release_lock(lset, ep, stack, cap);
+			break;
+		case CAP_REQUIRES:
+			l = lookup_lock(*lset, s);
+			if (!l) {
+				warning(ep->name->pos,
+					"function '%s' not holding '%s'",
+					show_ident(ep->name->ident),
+					s ? s->ident->name : "anon");
+			}
+			break;
+		default:
+			break;
+		}
+	} END_FOR_EACH_PTR(cap);
+
+	copy_lock_list(stack, *lset, &info->exit);
+
+	if (dbg_level0)
+		show_exit_lock_list(ep, level);
+}
+
+static int function_acquires_lock(struct entrypoint *ep)
+{
+	struct capability *cap;
+
+	FOR_EACH_PTR(ep->name->ctype.capabilities, cap) {
+		if (cap->op == CAP_ACQUIRE)
+			return 1;
+	} END_FOR_EACH_PTR(cap);
+
+	return 0;
+}
+
+static void check_leaking(struct entrypoint *ep)
+{
+	struct basic_block *bb = last_basic_block(ep->bbs);
+	struct bb_info *info = bb->priv;
+	struct lock *lock;
+
+	/* Let's ignore function which acquire locks for the time
+	 * beeing.
+	 */
+	if (function_acquires_lock(ep))
+		return;
+
+	FOR_EACH_PTR(info->exit, lock) {
+		struct stack *st;
+		struct frame_list *leak = NULL;
+		int pos;
+
+		FOR_EACH_PTR(lock->stacks, st) {
+			/* Find a call stack where this ep is the first
+			 * one.
+			 */
+			pos = stack_frame_position(st->stack, ep);
+			if (pos == 0) {
+				if (function_acquires_lock(
+						last_frame(st->stack)->ep)) {
+					leak = st->stack;
+				}
+			} else if (pos > 0) {
+				leak = NULL;
+			}
+		} END_FOR_EACH_PTR(st);
+
+		if (!leak)
+			continue;
+
+		warning(ep->name->pos, "leaks lock '%s'",
+			lock->sym ? show_ident(lock->sym->ident) : "anon");
+		show_call_stack(leak, 1);
+		printf("\n");
+	} END_FOR_EACH_PTR(lock);
+}
+
+static void check_sym_access(struct instruction *insn,
+			struct symbol *sym, struct basic_block *bb,
+			struct lock_list *lset,
+			struct frame_list *stack)
+{
+	struct capability *c;
+	struct lock *l;
+
+	FOR_EACH_PTR(sym->ctype.capabilities, c) {
+		struct symbol *s = figure_capability(c, bb->ep, stack);
+
+		l = lookup_lock(lset, s);
+		if (!l) {
+			warning(insn->pos,
+				"accessing '%s' without holding '%s'",
+				sym->ident->name,
+				s->ident->name);
+		}
+	} END_FOR_EACH_PTR(c);
+}
+
+static void check_bb(struct basic_block *bb, struct lock_list **lset,
+		struct frame_list *stack, unsigned long generation,
+		int level);
+
+static void handle_call(struct instruction *insn, struct lock_list **lset,
+			struct frame_list *stack, int level)
+{
+	struct entrypoint *ep;
+	struct symbol *sym;
+	struct frame *frame;
+
+	if (!insn->func->ident)
+		return;
+
+	sym = lookup_symbol(insn->func->ident, NS_SYMBOL);
+	if (!sym)
+		return;
+	ep = sym->ep;
+
+	/* no code/entrypoint for this symbol, decleration only */
+	if (!ep)
+		return;
+
+	/* prevent recursions */
+	frame = lookup_frame(stack, ep);
+	if (frame)
+		return;
+
+	frame = last_frame(stack);
+	frame->insn = insn;
+	frame = alloc_frame(ep, NULL);
+	add_frame(&stack, frame);
+
+	if (dbg_level0)
+		printf("%*scall %s\n", level * 2, "",
+			show_ident(ep->name->ident));
+	level++;
+	if (dbg_level2)
+		show_call_stack(stack, level);
+
+	update_locks_on_entry(lset, ep, stack, level);
+	check_bb(ep->entry->bb, lset, stack, ++bb_generation, level);
+	update_locks_on_exit(lset, ep, stack, level);
+	level--;
+
+	if (dbg_level0)
+		printf("%*sret %s\n", level * 2, "",
+			show_ident(ep->name->ident));
+
+	frame = delete_last_frame(&stack);
+	__free_frame(frame);
+}
+
+static void check_bb(struct basic_block *bb,
+		struct lock_list **lset, struct frame_list *stack,
+		unsigned long generation, int level)
+{
+	struct instruction *insn;
+	struct multijmp *mj;
+	struct symbol *sym;
+	struct bb_info *info = bb->priv;
+
+	if (!info) {
+		info = __alloc_bb_info(0);
+		bb->priv = info;
+	}
+
+	if (generation == bb->generation)
+		return;
+	bb->generation = generation;
+
+	if (dbg_level2)
+		printf("%*sentry bb %p\n", level * 2, "", bb);
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		switch (insn->opcode) {
+		case OP_CALL:
+			handle_call(insn, lset, stack, level);
+			break;
+		case OP_BR:
+			if (dbg_level2)
+				level++;
+
+			if (insn->bb_true)
+				check_bb(insn->bb_true, lset, stack,
+					 generation, level);
+			if (insn->bb_false)
+				check_bb(insn->bb_false, lset, stack,
+					 generation, level);
+			if (dbg_level2)
+				level--;
+			break;
+		case OP_SWITCH:
+		case OP_COMPUTEDGOTO:
+			/* Note this one might jump backwards, which means
+			 * we need to be careful and not endup in an endless
+			 * loop.
+			 */
+			if (dbg_level2)
+				level++;
+			FOR_EACH_PTR(insn->multijmp_list, mj) {
+				check_bb(mj->target, lset, stack,
+					 generation, level);
+			} END_FOR_EACH_PTR(mj);
+			if (dbg_level2)
+				level--;
+			break;
+
+		case OP_LOAD:
+		case OP_STORE:
+			sym = figure_access(insn->src, stack);
+			if (dbg_level1)
+				printf("%*sld/st: %p %s\n", level * 2, "",
+					sym, sym ? show_ident(sym->ident) : "");
+			if (sym)
+				check_sym_access(insn, sym, bb, *lset, stack);
+			break;
+		}
+	} END_FOR_EACH_PTR(insn);
+
+	if (dbg_level2)
+		printf("%*sexit  bb %p\n", level * 2, "", bb);
+}
+
+static void check_entrypoint(struct entrypoint *ep)
+{
+	struct frame_list *stack;
+	struct frame *frame;
+	struct lock_list *lset = NULL;
+	struct bb_info *info = ep->entry->bb->priv;
+	int level = 0;
+
+	if (!info) {
+		info = __alloc_bb_info(0);
+		ep->entry->bb->priv = info;
+	}
+
+	stack = NULL;
+	frame = alloc_frame(ep, NULL);
+	add_frame(&stack, frame);
+
+	update_locks_on_entry(&lset, ep, stack, level);
+	check_bb(ep->entry->bb, &lset, stack, ++bb_generation, level);
+	update_locks_on_exit(&lset, ep, stack, level);
+
+	frame = delete_last_frame(&stack);
+	__free_frame(frame);
+}
+
+DECLARE_PTR_LIST(entrypoint_list, struct entrypoint);
+
+static inline void add_entrypoint(struct entrypoint_list **list,
+				  struct entrypoint *ep)
+{
+	add_ptr_list(list, ep);
+}
+
+static void check_symbols(struct symbol_list *list)
+{
+	struct entrypoint_list *eps = NULL;
+	struct entrypoint *ep;
+	struct symbol *sym;
+
+	/* First pass collect all locks */
+	FOR_EACH_PTR(list, sym) {
+		expand_symbol(sym);
+		ep = linearize_symbol(sym);
+		if (ep) {
+			if (dbg_level0)
+				printf("\n## %s()\n",
+					show_ident(ep->name->ident));
+
+			/* Call each function and collect all locks
+			 * taken at entry and exit point of function.
+			 */
+			check_entrypoint(ep);
+
+			add_entrypoint(&eps, ep);
+		}
+	} END_FOR_EACH_PTR(sym);
+
+	FOR_EACH_PTR(eps, ep) {
+		if (dbg_level3) {
+			printf("\n## %s()\n",
+				show_ident(ep->name->ident));
+			show_entrypoint(ep);
+			printf("\n");
+		}
+
+		check_leaking(ep);
+	} END_FOR_EACH_PTR(ep);
+}
+
+int main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL;
+	char *file;
+
+	add_pre_buffer("#define __TESTLOCK__ 1\n");
+
+	check_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		check_symbols(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
+
+#if 0
+	show_frame_alloc();
+	show_lock_alloc();
+#endif
+	return 0;
+}
diff --git a/validation/caps.c b/validation/caps.c
new file mode 100644
index 0000000..0ffa407
--- /dev/null
+++ b/validation/caps.c
@@ -0,0 +1,80 @@
+#define __must_hold(x)	__attribute__((requires_capability(x)))
+#define __acquires(x)	__attribute__((acquire_capability(x)))
+#define __releases(x)	__attribute__((release_capability(x)))
+#define __guarded_by(x)	__attribute__((guarded_by(x)))
+
+static void a(void) __acquires()
+{
+}
+
+static void r(void) __releases()
+{
+}
+
+static void good1(void)
+{
+	a();
+	r();
+}
+
+static void okay1(void)
+{
+	a();
+}
+
+static void bad2(void)
+{
+	okay1();
+}
+
+struct hello {
+	char *str;
+	int lock;
+};
+
+static struct hello info __guarded_by(info.lock);
+
+static void wtf_lock(int *lock)
+	__acquires(lock)
+{
+	*lock = 1;
+}
+
+static void wtf_unlock(int *lock)
+	__releases(lock)
+{
+	*lock = 0;
+}
+
+static void set_str(struct hello *h)
+	__must_hold(h->lock)
+{
+	h->str = "hello";
+}
+
+static good2(void)
+{
+	wtf_lock(&info.lock);
+	set_str(&info);
+	wtf_unlock(&info.lock);
+}
+
+static int global_lock;
+
+static good3(void)
+{
+	wtf_lock(&global_lock);
+	wtf_unlock(&global_lock);
+}
+
+static bad4(void)
+{
+	wtf_lock(&global_lock);
+}
+
+/*
+ * check-name: Check capabilities
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.5.0
