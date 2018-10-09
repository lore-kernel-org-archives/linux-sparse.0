From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Tue, 9 Oct 2018 09:53:30 -0500
Message-ID: <20181009145330.GT29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197390-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
To: Richard Biener <rguenther@suse.de>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@n>, exb.com, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundatio
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> On Mon, 8 Oct 2018, Segher Boessenkool wrote:
> > On Sun, Oct 07, 2018 at 03:53:26PM +0000, Michael Matz wrote:
> > > On Sun, 7 Oct 2018, Segher Boessenkool wrote:
> > > > On Sun, Oct 07, 2018 at 11:18:06AM +0200, Borislav Petkov wrote:
> > > > > Now, Richard suggested doing something like:
> > > > > 
> > > > >  1) inline asm ("...")
> > > > 
> > > > What would the semantics of this be?
> > > 
> > > The size of the inline asm wouldn't be counted towards the inliner size 
> > > limits (or be counted as "1").
> > 
> > That sounds like a good option.
> 
> Yes, I also like it for simplicity.  It also avoids the requirement
> of translating the number (in bytes?) given by the user to
> "number of GIMPLE instructions" as needed by the inliner.

This patch implements this, for C only so far.  And the syntax is
"asm inline", which is more in line with other syntax.

How does this look?


Segher



diff --git a/gcc/c/c-parser.c b/gcc/c/c-parser.c
index 1f173fc..94b1d41 100644
--- a/gcc/c/c-parser.c
+++ b/gcc/c/c-parser.c
@@ -6287,7 +6287,7 @@ static tree
 c_parser_asm_statement (c_parser *parser)
 {
   tree quals, str, outputs, inputs, clobbers, labels, ret;
-  bool simple, is_goto;
+  bool simple, is_goto, is_inline;
   location_t asm_loc = c_parser_peek_token (parser)->location;
   int section, nsections;
 
@@ -6318,6 +6318,13 @@ c_parser_asm_statement (c_parser *parser)
       is_goto = true;
     }
 
+  is_inline = false;
+  if (c_parser_next_token_is_keyword (parser, RID_INLINE))
+    {
+      c_parser_consume_token (parser);
+      is_inline = true;
+    }
+
   /* ??? Follow the C++ parser rather than using the
      lex_untranslated_string kludge.  */
   parser->lex_untranslated_string = true;
@@ -6393,7 +6400,8 @@ c_parser_asm_statement (c_parser *parser)
     c_parser_skip_to_end_of_block_or_statement (parser);
 
   ret = build_asm_stmt (quals, build_asm_expr (asm_loc, str, outputs, inputs,
-					       clobbers, labels, simple));
+					       clobbers, labels, simple,
+					       is_inline));
 
  error:
   parser->lex_untranslated_string = false;
diff --git a/gcc/c/c-tree.h b/gcc/c/c-tree.h
index 017c01c..f5629300 100644
--- a/gcc/c/c-tree.h
+++ b/gcc/c/c-tree.h
@@ -677,7 +677,8 @@ extern tree build_compound_literal (location_t, tree, tree, bool,
 extern void check_compound_literal_type (location_t, struct c_type_name *);
 extern tree c_start_case (location_t, location_t, tree, bool);
 extern void c_finish_case (tree, tree);
-extern tree build_asm_expr (location_t, tree, tree, tree, tree, tree, bool);
+extern tree build_asm_expr (location_t, tree, tree, tree, tree, tree, bool,
+			    bool);
 extern tree build_asm_stmt (tree, tree);
 extern int c_types_compatible_p (tree, tree);
 extern tree c_begin_compound_stmt (bool);
diff --git a/gcc/c/c-typeck.c b/gcc/c/c-typeck.c
index 9d09b8d..e013100 100644
--- a/gcc/c/c-typeck.c
+++ b/gcc/c/c-typeck.c
@@ -10064,7 +10064,7 @@ build_asm_stmt (tree cv_qualifier, tree args)
    are subtly different.  We use a ASM_EXPR node to represent this.  */
 tree
 build_asm_expr (location_t loc, tree string, tree outputs, tree inputs,
-		tree clobbers, tree labels, bool simple)
+		tree clobbers, tree labels, bool simple, bool is_inline)
 {
   tree tail;
   tree args;
@@ -10182,6 +10182,7 @@ build_asm_expr (location_t loc, tree string, tree outputs, tree inputs,
      as volatile.  */
   ASM_INPUT_P (args) = simple;
   ASM_VOLATILE_P (args) = (noutputs == 0);
+  ASM_INLINE_P (args) = is_inline;
 
   return args;
 }
diff --git a/gcc/gimple-pretty-print.c b/gcc/gimple-pretty-print.c
index 83e2273..1a00fa3 100644
--- a/gcc/gimple-pretty-print.c
+++ b/gcc/gimple-pretty-print.c
@@ -2019,6 +2019,8 @@ dump_gimple_asm (pretty_printer *buffer, gasm *gs, int spc, dump_flags_t flags)
       pp_string (buffer, "__asm__");
       if (gimple_asm_volatile_p (gs))
 	pp_string (buffer, " __volatile__");
+      if (gimple_asm_inline_p (gs))
+	pp_string (buffer, " __inline__");
       if (gimple_asm_nlabels (gs))
 	pp_string (buffer, " goto");
       pp_string (buffer, "(\"");
diff --git a/gcc/gimple.h b/gcc/gimple.h
index a5dda93..8a58e07 100644
--- a/gcc/gimple.h
+++ b/gcc/gimple.h
@@ -137,6 +137,7 @@ enum gimple_rhs_class
 enum gf_mask {
     GF_ASM_INPUT		= 1 << 0,
     GF_ASM_VOLATILE		= 1 << 1,
+    GF_ASM_INLINE		= 1 << 2,
     GF_CALL_FROM_THUNK		= 1 << 0,
     GF_CALL_RETURN_SLOT_OPT	= 1 << 1,
     GF_CALL_TAILCALL		= 1 << 2,
@@ -3911,7 +3912,7 @@ gimple_asm_volatile_p (const gasm *asm_stmt)
 }
 
 
-/* If VOLATLE_P is true, mark asm statement ASM_STMT as volatile.  */
+/* If VOLATILE_P is true, mark asm statement ASM_STMT as volatile.  */
 
 static inline void
 gimple_asm_set_volatile (gasm *asm_stmt, bool volatile_p)
@@ -3923,6 +3924,27 @@ gimple_asm_set_volatile (gasm *asm_stmt, bool volatile_p)
 }
 
 
+/* Return true ASM_STMT ASM_STMT is an asm statement marked inline.  */
+
+static inline bool
+gimple_asm_inline_p (const gasm *asm_stmt)
+{
+  return (asm_stmt->subcode & GF_ASM_INLINE) != 0;
+}
+
+
+/* If INLINE_P is true, mark asm statement ASM_STMT as inline.  */
+
+static inline void
+gimple_asm_set_inline (gasm *asm_stmt, bool inline_p)
+{
+  if (inline_p)
+    asm_stmt->subcode |= GF_ASM_INLINE;
+  else
+    asm_stmt->subcode &= ~GF_ASM_INLINE;
+}
+
+
 /* If INPUT_P is true, mark asm ASM_STMT as an ASM_INPUT.  */
 
 static inline void
diff --git a/gcc/gimplify.c b/gcc/gimplify.c
index 509fc2f..10b80f2 100644
--- a/gcc/gimplify.c
+++ b/gcc/gimplify.c
@@ -6315,6 +6315,7 @@ gimplify_asm_expr (tree *expr_p, gimple_seq *pre_p, gimple_seq *post_p)
 
       gimple_asm_set_volatile (stmt, ASM_VOLATILE_P (expr) || noutputs == 0);
       gimple_asm_set_input (stmt, ASM_INPUT_P (expr));
+      gimple_asm_set_inline (stmt, ASM_INLINE_P (expr));
 
       gimplify_seq_add_stmt (pre_p, stmt);
     }
diff --git a/gcc/ipa-icf-gimple.c b/gcc/ipa-icf-gimple.c
index ba39ea3..5361139 100644
--- a/gcc/ipa-icf-gimple.c
+++ b/gcc/ipa-icf-gimple.c
@@ -993,6 +993,9 @@ func_checker::compare_gimple_asm (const gasm *g1, const gasm *g2)
   if (gimple_asm_input_p (g1) != gimple_asm_input_p (g2))
     return false;
 
+  if (gimple_asm_inline_p (g1) != gimple_asm_inline_p (g2))
+    return false;
+
   if (gimple_asm_ninputs (g1) != gimple_asm_ninputs (g2))
     return false;
 
diff --git a/gcc/tree-inline.c b/gcc/tree-inline.c
index 9134253..6b1d2ea 100644
--- a/gcc/tree-inline.c
+++ b/gcc/tree-inline.c
@@ -4108,6 +4108,8 @@ estimate_num_insns (gimple *stmt, eni_weights *weights)
 	   with very long asm statements.  */
 	if (count > 1000)
 	  count = 1000;
+	if (gimple_asm_inline_p (as_a <gasm *> (stmt)))
+	  count = !!count;
 	return MAX (1, count);
       }
 
diff --git a/gcc/tree.h b/gcc/tree.h
index 2e45f9d..160b3a7 100644
--- a/gcc/tree.h
+++ b/gcc/tree.h
@@ -1245,6 +1245,9 @@ extern tree maybe_wrap_with_location (tree, location_t);
    ASM_OPERAND with no operands.  */
 #define ASM_INPUT_P(NODE) (ASM_EXPR_CHECK (NODE)->base.static_flag)
 #define ASM_VOLATILE_P(NODE) (ASM_EXPR_CHECK (NODE)->base.public_flag)
+/* Nonzero if we want to consider this asm as minimum length and cost
+   for inlining decisions.  */
+#define ASM_INLINE_P(NODE) (ASM_EXPR_CHECK (NODE)->base.protected_flag)
 
 /* COND_EXPR accessors.  */
 #define COND_EXPR_COND(NODE)	(TREE_OPERAND (COND_EXPR_CHECK (NODE), 0))
