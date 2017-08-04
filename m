From: Christopher Li <sparse@chrisli.org>
Subject: Fwd: [PATCH] mark pseudo user as deleted instead of removing them
Date: Fri, 4 Aug 2017 10:54:39 -0400
Message-ID: <CANeU7Q=eNTqHRS__DPFnoOMH7vnUJHRh+3wCcFR-EF_SB7zmSA@mail.gmail.com>
References: <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804002230.5047-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35292 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbdHDOyk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 10:54:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id t86so8866523pfe.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 07:54:40 -0700 (PDT)
In-Reply-To: <20170804002230.5047-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Luc mean to send this to the mailing list as well.

Here we go.

Chris


---------- Forwarded message ----------
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, Aug 3, 2017 at 8:22 PM
Subject: [PATCH] mark pseudo user as deleted instead of removing them
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


For discussion only.

This atch is also available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-nested-pseudo-users-deletion

----------------------------------------------------------------
Luc Van Oostenryck (1):
      mark pseudo user as deleted instead of removing them

 flow.c      | 28 ++++++++++++++++++++++------
 linearize.c |  2 ++
 memops.c    |  5 ++++-
 ptrlist.c   | 21 +++++++++++++++++++++
 ptrlist.h   | 14 +++++++++++++-
 simplify.c  |  8 ++++++--
 unssa.c     |  4 +++-
 7 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/flow.c b/flow.c
index 6cac21b24..1dbfd431e 100644
--- a/flow.c
+++ b/flow.c
@@ -283,6 +283,8 @@ void convert_instruction_target(struct instruction
*insn, pseudo_t src)
        if (target == src)
                return;
        FOR_EACH_PTR(target->users, pu) {
+               if (!pu)
+                       continue;
                if (*pu->userp != VOID) {
                        assert(*pu->userp == target);
                        *pu->userp = src;
@@ -675,8 +677,10 @@ static void simplify_one_symbol(struct entrypoint
*ep, struct symbol *sym)
        complex = 0;
        FOR_EACH_PTR(pseudo->users, pu) {
                /* We know that the symbol-pseudo use is the "src" in
the instruction */
-               struct instruction *insn = pu->insn;
-
+               struct instruction *insn;
+               if (!pu)
+                       continue;
+               insn = pu->insn;
                switch (insn->opcode) {
                case OP_STORE:
                        stores++;
@@ -715,7 +719,10 @@ static void simplify_one_symbol(struct entrypoint
*ep, struct symbol *sym)
                src = def->target;

        FOR_EACH_PTR(pseudo->users, pu) {
-               struct instruction *insn = pu->insn;
+               struct instruction *insn;
+               if (!pu)
+                       continue;
+               insn = pu->insn;
                if (insn->opcode == OP_LOAD) {
                        check_access(insn);
                        convert_load_instruction(insn, src);
@@ -731,7 +738,10 @@ complex_def:
 external_visibility:
        all = 1;
        FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
-               struct instruction *insn = pu->insn;
+               struct instruction *insn;
+               if (!pu)
+                       continue;
+               insn = pu->insn;
                if (insn->opcode == OP_LOAD)
                        all &= find_dominating_stores(pseudo, insn,
++bb_generation, !mod);
        } END_FOR_EACH_PTR_REVERSE(pu);
@@ -739,7 +749,10 @@ external_visibility:
        /* If we converted all the loads, remove the stores. They are dead */
        if (all && !mod) {
                FOR_EACH_PTR(pseudo->users, pu) {
-                       struct instruction *insn = pu->insn;
+                       struct instruction *insn;
+                       if (!pu)
+                               continue;
+                       insn = pu->insn;
                        if (insn->opcode == OP_STORE)
                                kill_store(insn);
                } END_FOR_EACH_PTR(pu);
@@ -749,7 +762,10 @@ external_visibility:
                 * of them..
                 */
                FOR_EACH_PTR(pseudo->users, pu) {
-                       struct instruction *insn = pu->insn;
+                       struct instruction *insn;
+                       if (!pu)
+                               continue;
+                       insn = pu->insn;
                        if (insn->opcode == OP_STORE)
                                kill_dominated_stores(pseudo, insn,
++bb_generation, insn->bb, !mod, 0);
                } END_FOR_EACH_PTR(pu);
diff --git a/linearize.c b/linearize.c
index ba76397ea..0933e935f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -542,6 +542,8 @@ static void show_symbol_usage(pseudo_t pseudo)

        if (pseudo) {
                FOR_EACH_PTR(pseudo->users, pu) {
+                       if (!pu)
+                               continue;
                        printf("\t%s\n", show_instruction(pu->insn));
                } END_FOR_EACH_PTR(pu);
        }
diff --git a/memops.c b/memops.c
index aeacdf566..ce5aecbe8 100644
--- a/memops.c
+++ b/memops.c
@@ -66,7 +66,10 @@ static int address_taken(pseudo_t pseudo)
 {
        struct pseudo_user *pu;
        FOR_EACH_PTR(pseudo->users, pu) {
-               struct instruction *insn = pu->insn;
+               struct instruction *insn;
+               if (!pu)
+                       continue;
+               insn = pu->insn;
                if (insn->bb && (insn->opcode != OP_LOAD &&
insn->opcode != OP_STORE))
                        return 1;
        } END_FOR_EACH_PTR(pu);
diff --git a/ptrlist.c b/ptrlist.c
index 5dc1117c5..609d4feba 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -29,6 +29,19 @@ int ptr_list_size(struct ptr_list *head)
        return nr;
 }

+int ptr_list_size_null(struct ptr_list *head)
+{
+       int nr = 0;
+
+       if (head) {
+               struct ptr_list *list = head;
+               do {
+                       nr += list->nr - list->rm;
+               } while ((list = list->next) != head);
+       }
+       return nr;
+}
+
 /*
  * Linearize the entries of a list up to a total of 'max',
  * and return the nr of entries linearized.
@@ -97,6 +110,14 @@ restart:
        }
 }

+void pack_ptr_list_null(struct ptr_list **listp)
+{
+       struct ptr_list *head = *listp;
+
+       if (ptr_list_size_null(head) == 0)
+               *listp = NULL;
+}
+
 void split_ptr_list_head(struct ptr_list *head)
 {
        int old = head->nr, nr = old / 2;
diff --git a/ptrlist.h b/ptrlist.h
index d09be2f51..cbdd34f93 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)

 struct ptr_list {
-       int nr;
+       int nr:8;
+       int rm:8;
        struct ptr_list *prev;
        struct ptr_list *next;
        void *list[LIST_NODE_NR];
@@ -43,6 +44,7 @@ extern void **__add_ptr_list(struct ptr_list **,
void *, unsigned long);
 extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
+extern int ptr_list_size_null(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);

 /*
@@ -283,10 +285,20 @@ extern void split_ptr_list_head(struct ptr_list *);
 #define DELETE_CURRENT_PTR(ptr) \
        DO_DELETE_CURRENT(ptr, __head##ptr, __list##ptr, __nr##ptr)

+#define DO_DELETE_CURRENT_NULL(__list, __nr) do {
         \
+       void **__this = __list->list + __nr;
         \
+       *__this = NULL;
         \
+       __list->rm++;
         \
+} while (0)
+
+#define DELETE_CURRENT_PTR_NULL(ptr) \
+       DO_DELETE_CURRENT_NULL(__list##ptr, __nr##ptr)
+
 #define REPLACE_CURRENT_PTR(ptr, new_ptr)
                 \
        do { *THIS_ADDRESS(ptr) = (new_ptr); } while (0)

 extern void pack_ptr_list(struct ptr_list **);
+extern void pack_ptr_list_null(struct ptr_list **);

 #define PACK_PTR_LIST(x) pack_ptr_list((struct ptr_list **)(x))

diff --git a/simplify.c b/simplify.c
index 03ff9c942..eddef76e8 100644
--- a/simplify.c
+++ b/simplify.c
@@ -171,15 +171,17 @@ static int delete_pseudo_user_list_entry(struct
pseudo_user_list **list, pseudo_
        struct pseudo_user *pu;

        FOR_EACH_PTR(*list, pu) {
+               if (!pu)
+                       continue;
                if (pu->userp == entry) {
-                       DELETE_CURRENT_PTR(pu);
+                       DELETE_CURRENT_PTR_NULL(pu);
                        if (!--count)
                                goto out;
                }
        } END_FOR_EACH_PTR(pu);
        assert(count <= 0);
 out:
-       pack_ptr_list((struct ptr_list **)list);
+       pack_ptr_list_null((struct ptr_list **)list);
        return count;
 }

@@ -308,6 +310,8 @@ static int dead_insn(struct instruction *insn,
pseudo_t *src1, pseudo_t *src2, p
 {
        struct pseudo_user *pu;
        FOR_EACH_PTR(insn->target->users, pu) {
+               if (!pu)
+                       continue;
                if (*pu->userp != VOID)
                        return 0;
        } END_FOR_EACH_PTR(pu);
diff --git a/unssa.c b/unssa.c
index e7c9154d5..28af0833c 100644
--- a/unssa.c
+++ b/unssa.c
@@ -36,7 +36,7 @@

 static inline int nbr_pseudo_users(pseudo_t p)
 {
-       return ptr_list_size((struct ptr_list *)p->users);
+       return ptr_list_size_null((struct ptr_list *)p->users);
 }

 static int simplify_phi_node(struct instruction *phi, pseudo_t tmp)
@@ -58,6 +58,8 @@ static int simplify_phi_node(struct instruction
*phi, pseudo_t tmp)
        // no need to make a copy of this one
        // -> replace the target pseudo by the tmp
        FOR_EACH_PTR(target->users, pu) {
+               if (!pu)
+                       continue;
                use_pseudo(pu->insn, tmp, pu->userp);
        } END_FOR_EACH_PTR(pu);

--
2.13.2
