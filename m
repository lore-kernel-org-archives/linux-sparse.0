From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] sparse: gcc 4.1 warnings
Date: Sat, 8 Apr 2006 00:14:19 -0400
Message-ID: <20060408041419.GA8943@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:14554 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965015AbWDHEO0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 8 Apr 2006 00:14:26 -0400
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id AB83D1C02C4F
	for <linux-sparse@vger.kernel.org>; Sat,  8 Apr 2006 00:14:19 -0400 (EDT)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id k384EJm5009002
	for linux-sparse@vger.kernel.org; Sat, 8 Apr 2006 00:14:19 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


This patch kills the sparse warnings that appeared for me on FC5/x86-64,
which uses gcc 4.1.0.

Note this MAY OR MAY NOT be the right thing to do; I didn't audit each
location to see if checking the return value would be more appropriate.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/compile-i386.c b/compile-i386.c
index d61652e..158b879 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -472,12 +472,12 @@ static inline void push_cstring(struct f
 	atom->string = str;
 	atom->label = label;
 
-	add_ptr_list(&f->str_list, atom);	/* note: _not_ atom_list */
+	(void) add_ptr_list(&f->str_list, atom);     /* note: _not_ atom_list */
 }
 
 static inline void push_atom(struct function *f, struct atom *atom)
 {
-	add_ptr_list(&f->atom_list, atom);
+	(void) add_ptr_list(&f->atom_list, atom);
 }
 
 static void push_text_atom(struct function *f, const char *text)
@@ -518,7 +518,7 @@ static struct storage *stack_alloc(int n
 	f->stack_size += n_bytes;
 	f->pseudo_nr++;
 
-	add_ptr_list(&f->pseudo_list, stor);
+	(void) add_ptr_list(&f->pseudo_list, stor);
 
 	return stor;
 }
diff --git a/example.c b/example.c
index 7e30c22..42e64c1 100644
--- a/example.c
+++ b/example.c
@@ -230,7 +230,7 @@ static struct storage_hash *find_or_crea
 	if (!entry) {
 		entry = alloc_storage_hash(alloc_storage());
 		entry->pseudo = pseudo;
-		add_ptr_list(listp, entry);
+		(void) add_ptr_list(listp, entry);
 	}
 	return entry;
 }
@@ -460,7 +460,7 @@ static void mark_reg_dead(struct bb_stat
 static void add_pseudo_reg(struct bb_state *state, pseudo_t pseudo, struct hardreg *reg)
 {
 	output_comment(state, "added pseudo %s to reg %s", show_pseudo(pseudo), reg->name);
-	add_ptr_list_tag(&reg->contains, pseudo, TAG_DIRTY);
+	(void) add_ptr_list_tag(&reg->contains, pseudo, TAG_DIRTY);
 }
 
 static struct hardreg *preferred_reg(struct bb_state *state, pseudo_t target)
diff --git a/lib.h b/lib.h
index a61b2dd..7c31dd2 100644
--- a/lib.h
+++ b/lib.h
@@ -168,17 +168,17 @@ static inline void concat_instruction_li
 
 static inline void add_symbol(struct symbol_list **list, struct symbol *sym)
 {
-	add_ptr_list(list, sym);
+	(void) add_ptr_list(list, sym);
 }
 
 static inline void add_statement(struct statement_list **list, struct statement *stmt)
 {
-	add_ptr_list(list, stmt);
+	(void) add_ptr_list(list, stmt);
 }
 
 static inline void add_expression(struct expression_list **list, struct expression *expr)
 {
-	add_ptr_list(list, expr);
+	(void) add_ptr_list(list, expr);
 }
 
 #define hashval(x) ((unsigned long)(x))
diff --git a/linearize.c b/linearize.c
index f47bad9..6986517 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1664,7 +1664,7 @@ static void add_asm_input(struct entrypo
 	rule->ident = ident;
 	rule->constraint = constraint;
 	use_pseudo(pseudo, &rule->pseudo);
-	add_ptr_list(&insn->asm_rules->inputs, rule);
+	(void) add_ptr_list(&insn->asm_rules->inputs, rule);
 }
 
 static void add_asm_output(struct entrypoint *ep, struct instruction *insn, struct expression *expr,
@@ -1682,7 +1682,7 @@ static void add_asm_output(struct entryp
 	rule->ident = ident;
 	rule->constraint = constraint;
 	use_pseudo(pseudo, &rule->pseudo);
-	add_ptr_list(&insn->asm_rules->outputs, rule);
+	(void) add_ptr_list(&insn->asm_rules->outputs, rule);
 }
 
 static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement *stmt)
diff --git a/linearize.h b/linearize.h
index 5f021a3..fa37c8b 100644
--- a/linearize.h
+++ b/linearize.h
@@ -224,17 +224,17 @@ static inline int is_branch_goto(struct 
 
 static inline void add_bb(struct basic_block_list **list, struct basic_block *bb)
 {
-	add_ptr_list(list, bb);
+	(void) add_ptr_list(list, bb);
 }
 
 static inline void add_instruction(struct instruction_list **list, struct instruction *insn)
 {
-	add_ptr_list(list, insn);
+	(void) add_ptr_list(list, insn);
 }
 
 static inline void add_multijmp(struct multijmp_list **list, struct multijmp *multijmp)
 {
-	add_ptr_list(list, multijmp);
+	(void) add_ptr_list(list, multijmp);
 }
 
 static inline void *add_pseudo(struct pseudo_list **list, struct pseudo *pseudo)
@@ -263,7 +263,7 @@ static inline int bb_reachable(struct ba
 
 static inline void add_pseudo_ptr(pseudo_t *ptr, struct pseudo_ptr_list **list)
 {
-	add_ptr_list(list, ptr);
+	(void) add_ptr_list(list, ptr);
 }
 
 static inline int has_use_list(pseudo_t p)
diff --git a/liveness.c b/liveness.c
index 8b0dfd8..5a8bb06 100644
--- a/liveness.c
+++ b/liveness.c
@@ -288,7 +288,7 @@ static void track_phi_uses(struct instru
 			continue;
 		def = phi->def;
 		assert(def->opcode == OP_PHISOURCE);
-		add_ptr_list(&def->phi_users, insn);
+		(void) add_ptr_list(&def->phi_users, insn);
 	} END_FOR_EACH_PTR(phi);
 }
 
diff --git a/parse.c b/parse.c
index 4339657..d2d24e1 100644
--- a/parse.c
+++ b/parse.c
@@ -278,7 +278,7 @@ static struct token *parse_enum_declarat
 
 		sym->initializer = expr;
 		sym->ctype.base_type = parent;
-		add_ptr_list(&entries, sym);
+		(void) add_ptr_list(&entries, sym);
 
 		if (base_type != &bad_ctype) {
 			if (ctype->type == SYM_NODE)
diff --git a/storage.c b/storage.c
index acbc477..1b34e1e 100644
--- a/storage.c
+++ b/storage.c
@@ -52,7 +52,7 @@ struct storage_hash_list *gather_storage
 		struct storage_hash *hash;
 		FOR_EACH_PTR(storage_hash_table[i], hash) {
 			if (hash->bb == bb && hash->inout == inout)
-				add_ptr_list(&list, hash);
+				(void) add_ptr_list(&list, hash);
 		} END_FOR_EACH_PTR(hash);
 	}
 	sort_hash_list(&list);
@@ -106,7 +106,7 @@ void add_storage(struct storage *storage
 	hash->pseudo = pseudo;
 	hash->inout = inout;
 
-	add_ptr_list(listp, hash);
+	(void) add_ptr_list(listp, hash);
 }
 
 
@@ -203,7 +203,7 @@ static struct storage * combine_storage(
 	FOR_EACH_PTR(src->users, usep) {
 		assert(*usep == src);
 		*usep = dst;
-		add_ptr_list(&dst->users, usep);
+		(void) add_ptr_list(&dst->users, usep);
 	} END_FOR_EACH_PTR(usep);
 
 	/* Mark it unused */
diff --git a/storage.h b/storage.h
index c1822e5..fee106f 100644
--- a/storage.h
+++ b/storage.h
@@ -69,7 +69,7 @@ static inline struct storage_hash *alloc
 	struct storage **usep = &entry->storage;
 
 	*usep = s;
-	add_ptr_list(&s->users, usep);
+	(void) add_ptr_list(&s->users, usep);
 	return entry;
 }
 
