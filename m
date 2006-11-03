From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 4/4] Typo fixes
Date: Fri, 03 Nov 2006 17:17:17 -0500
Message-ID: <20061103221717.7811.2112.stgit@dv.roinet.com>
References: <20061103221659.7811.73832.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:65417
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S932080AbWKCWRS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Nov 2006 17:17:18 -0500
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Fri, 03 Nov 2006 17:17:17 -0500 (EST)
    (envelope-from proski@gnu.org)
In-Reply-To: <20061103221659.7811.73832.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 evaluate.c                                   |    2 +-
 example.c                                    |    4 ++--
 expand.c                                     |    2 +-
 inline.c                                     |    2 +-
 memops.c                                     |    2 +-
 pre-process.c                                |    2 +-
 simplify.c                                   |    2 +-
 symbol.c                                     |    2 +-
 validation/initializer-entry-defined-twice.c |    2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 6fb6be2..ca49ed0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1475,7 +1475,7 @@ static struct symbol *evaluate_dereferen
 
 	switch (ctype->type) {
 	default:
-		sparse_error(expr->pos, "cannot derefence this type");
+		sparse_error(expr->pos, "cannot dereference this type");
 		return NULL;
 	case SYM_PTR:
 		node->ctype.modifiers = target->ctype.modifiers & MOD_SPECIFIER;
diff --git a/example.c b/example.c
index 7e30c22..7c2bae3 100644
--- a/example.c
+++ b/example.c
@@ -942,7 +942,7 @@ static void generate_commutative_binop(s
 	if (!is_dead_reg(state, src1, reg1))
 		goto do_switch;
 
-	/* Both are dead. Is one preferrable? */
+	/* Both are dead. Is one preferable? */
 	if (reg2 != preferred_reg(state, insn->target))
 		goto dont_switch;
 
@@ -1493,7 +1493,7 @@ static void write_reg_to_storage(struct
 
 		/* Fall back on stack allocation ... */
 		alloc_stack(state, storage);
-		/* Fallthroigh */
+		/* Fallthrough */
 	default:
 		output_insn(state, "movl %s,%s", reg->name, show_memop(storage));
 		return;
diff --git a/expand.c b/expand.c
index a34d07d..90f7f36 100644
--- a/expand.c
+++ b/expand.c
@@ -562,7 +562,7 @@ static int expand_dereference(struct exp
 	/*
 	 * NOTE! We get a bogus warning right now for some special
 	 * cases: apparently I've screwed up the optimization of
-	 * a zero-offset derefence, and the ctype is wrong.
+	 * a zero-offset dereference, and the ctype is wrong.
 	 *
 	 * Leave the warning in anyway, since this is also a good
 	 * test for me to get the type evaluation right..
diff --git a/inline.c b/inline.c
index 81530d1..77adfab 100644
--- a/inline.c
+++ b/inline.c
@@ -428,7 +428,7 @@ static struct statement *copy_one_statem
 }
 
 /*
- * Copy a stateemnt tree from 'src' to 'dst', where both
+ * Copy a statement tree from 'src' to 'dst', where both
  * source and destination are of type STMT_COMPOUND.
  *
  * We do this for the tree-level inliner.
diff --git a/memops.c b/memops.c
index 8fd777d..bdecf14 100644
--- a/memops.c
+++ b/memops.c
@@ -69,7 +69,7 @@ found_dominator:
  * we can no longer really use "container()" to get from a user to
  * the instruction that uses it.
  *
- * This happens to work, simply because the likelyhood of the
+ * This happens to work, simply because the likelihood of the
  * (possibly non-instruction) containing the right bitpattern
  * in the right place is pretty low. But this is still wrong.
  *
diff --git a/pre-process.c b/pre-process.c
index 08d1a2e..81a535e 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -630,7 +630,7 @@ static int already_tokenized(const char
 	return 0;
 }
 
-/* Hande include of header files.
+/* Handle include of header files.
  * The relevant options are made compatible with gcc. The only options that
  * are not supported is -withprefix and friends.
  *
diff --git a/simplify.c b/simplify.c
index 495f5d3..a8b736b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -550,7 +550,7 @@ offset:
 
 /*
  * We walk the whole chain of adds/subs backwards. That's not
- * only more efficient, but it allows us to find looops.
+ * only more efficient, but it allows us to find loops.
  */
 static int simplify_memop(struct instruction *insn)
 {
diff --git a/symbol.c b/symbol.c
index 6c91112..a9b26b5 100644
--- a/symbol.c
+++ b/symbol.c
@@ -360,7 +360,7 @@ static struct symbol *examine_pointer_ty
 	 * We need to set the pointer size first, and
 	 * examine the thing we point to only afterwards.
 	 * That's because this pointer type may end up
-	 * being needed for the base type size evalutation.
+	 * being needed for the base type size evaluation.
 	 */
 	if (!sym->bit_size)
 		sym->bit_size = bits_in_pointer;
diff --git a/validation/initializer-entry-defined-twice.c b/validation/initializer-entry-defined-twice.c
index 80434f1..58f314b 100644
--- a/validation/initializer-entry-defined-twice.c
+++ b/validation/initializer-entry-defined-twice.c
@@ -29,7 +29,7 @@ struct has_union union_error = {
 };
 
 /* Empty structures can make two fields have the same offset in a struct.
- * Initialzing both should not trigger the warning. */
+ * Initializing both should not trigger the warning. */
 struct empty { };
 
 struct same_offset {
