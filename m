From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Wed,  3 Sep 2014 20:54:05 +0200
Message-ID: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48536 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbaICSyK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2014 14:54:10 -0400
Received: from 77-56-195-25.dclient.hispeed.ch ([77.56.195.25] helo=lsx.localdomain)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1XPFh3-0000L2-KE
	for linux-sparse@vger.kernel.org; Wed, 03 Sep 2014 18:54:10 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Make sparse fail and return an error code if a warning is encountered
and -Werror is specified or a hard error is found. This allows to use
sparse in automated build systems to more easily catch new sparse
warnings.

Due to sparse now returning non zero on failure, the test cases
triggering a error have to be adapated to check for the non zero return
value.

Also changes cgcc to die if the checker fails.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
 cgcc                                          |  2 +-
 lib.c                                         | 49 ++++++++++++++++-----------
 lib.h                                         |  1 +
 sparse.1                                      |  3 ++
 sparse.c                                      |  3 ++
 validation/__func__.c                         |  1 +
 validation/bad-array-designated-initializer.c |  1 +
 validation/bad-assignment.c                   |  1 +
 validation/bad-cast.c                         |  1 +
 validation/bad-ternary-cond.c                 |  1 +
 validation/bad-typeof.c                       |  1 +
 validation/badtype2.c                         |  1 +
 validation/badtype3.c                         |  1 +
 validation/badtype4.c                         |  1 +
 validation/check_byte_count-ice.c             |  1 +
 validation/compare-null-to-int.c              |  1 +
 validation/cond_expr.c                        |  1 +
 validation/goto-label.c                       |  1 +
 validation/identifier_list.c                  |  1 +
 validation/nested-declarator.c                |  1 +
 validation/nested-declarator2.c               |  1 +
 validation/preprocessor/preprocessor11.c      |  1 +
 validation/preprocessor/preprocessor13.c      |  1 +
 validation/preprocessor/preprocessor18.c      |  1 +
 validation/preprocessor/preprocessor21.c      |  1 +
 validation/preprocessor/preprocessor22.c      |  1 +
 validation/preprocessor/preprocessor23.c      |  1 +
 validation/preprocessor/preprocessor8.c       |  1 +
 validation/reserved.c                         |  1 +
 validation/specifiers2.c                      |  1 +
 validation/typedef_shadow.c                   |  1 +
 31 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/cgcc b/cgcc
index c075e5f..204bda3 100755
--- a/cgcc
+++ b/cgcc
@@ -70,7 +70,7 @@ if ($do_check) {
 
     print "$check\n" if $verbose;
     if ($do_compile) {
-	system ($check);
+	system ($check) == 0 or die;
     } else {
 	exec ($check);
     }
diff --git a/lib.c b/lib.c
index bf3e91c..0209a40 100644
--- a/lib.c
+++ b/lib.c
@@ -126,25 +126,6 @@ void info(struct position pos, const char * fmt, ...)
 	va_end(args);
 }
 
-void warning(struct position pos, const char * fmt, ...)
-{
-	va_list args;
-
-	if (!max_warnings) {
-		show_info = 0;
-		return;
-	}
-
-	if (!--max_warnings) {
-		show_info = 0;
-		fmt = "too many warnings";
-	}
-
-	va_start(args, fmt);
-	do_warn("warning: ", pos, fmt, args);
-	va_end(args);
-}	
-
 static void do_error(struct position pos, const char * fmt, va_list args)
 {
 	static int errors = 0;
@@ -165,6 +146,32 @@ static void do_error(struct position pos, const char * fmt, va_list args)
 	errors++;
 }	
 
+void warning(struct position pos, const char * fmt, ...)
+{
+	va_list args;
+
+	if (Werror) {
+		va_start(args, fmt);
+		do_error(pos, fmt, args);
+		va_end(args);
+		return;
+	}
+
+	if (!max_warnings) {
+		show_info = 0;
+		return;
+	}
+
+	if (!--max_warnings) {
+		show_info = 0;
+		fmt = "too many warnings";
+	}
+
+	va_start(args, fmt);
+	do_warn("warning: ", pos, fmt, args);
+	va_end(args);
+}
+
 void sparse_error(struct position pos, const char * fmt, ...)
 {
 	va_list args;
@@ -219,6 +226,7 @@ int Wdesignated_init = 1;
 int Wdo_while = 0;
 int Winit_cstring = 0;
 int Wenum_mismatch = 1;
+int Werror = 0;
 int Wnon_pointer_null = 1;
 int Wold_initializer = 1;
 int Wone_bit_signed_bitfield = 1;
@@ -465,6 +473,9 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
 		}
 	}
 
+	if (!strcmp(p, "error"))
+		Werror = 1;
+
 	// Prefixes "no" and "no-" mean to turn warning off.
 	if (p[0] == 'n' && p[1] == 'o') {
 		p += 2;
diff --git a/lib.h b/lib.h
index f09b338..dd31664 100644
--- a/lib.h
+++ b/lib.h
@@ -112,6 +112,7 @@ extern int Wdefault_bitfield_sign;
 extern int Wdesignated_init;
 extern int Wdo_while;
 extern int Wenum_mismatch;
+extern int Werror;
 extern int Winit_cstring;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
diff --git a/sparse.1 b/sparse.1
index cd6be26..0c5f26c 100644
--- a/sparse.1
+++ b/sparse.1
@@ -24,6 +24,9 @@ off those warnings, pass the negation of the associated warning option,
 Turn on all sparse warnings, except for those explicitly disabled via
 \fB\-Wno\-something\fR.
 .TP
+.B \-Werror
+Turn all sparse warnings into errors.
+.TP
 .B \-Waddress\-space
 Warn about code which mixes pointers to different address spaces.
 
diff --git a/sparse.c b/sparse.c
index 233585b..7d389b1 100644
--- a/sparse.c
+++ b/sparse.c
@@ -287,6 +287,9 @@ static void check_symbols(struct symbol_list *list)
 			check_context(ep);
 		}
 	} END_FOR_EACH_PTR(sym);
+
+	if (die_if_error)
+		exit(1);
 }
 
 int main(int argc, char **argv)
diff --git a/validation/__func__.c b/validation/__func__.c
index 65ce928..6003a86 100644
--- a/validation/__func__.c
+++ b/validation/__func__.c
@@ -12,4 +12,5 @@ static void f(void)
 __func__.c:5:29: error: Expected ; at end of declaration
 __func__.c:5:29: error: got __func__
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/bad-array-designated-initializer.c b/validation/bad-array-designated-initializer.c
index fb7d91f..6de4131 100644
--- a/validation/bad-array-designated-initializer.c
+++ b/validation/bad-array-designated-initializer.c
@@ -10,4 +10,5 @@ bad-array-designated-initializer.c:3:10: error: Expected constant expression
 bad-array-designated-initializer.c:3:10: error: Expected } at end of initializer
 bad-array-designated-initializer.c:3:10: error: got \
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/bad-assignment.c b/validation/bad-assignment.c
index 71938db..9ebb51b 100644
--- a/validation/bad-assignment.c
+++ b/validation/bad-assignment.c
@@ -11,4 +11,5 @@ static int foo(int a)
 bad-assignment.c:3:13: error: Expected ; at end of statement
 bad-assignment.c:3:13: error: got \
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/bad-cast.c b/validation/bad-cast.c
index bf577e0..50fd2b9 100644
--- a/validation/bad-cast.c
+++ b/validation/bad-cast.c
@@ -12,4 +12,5 @@ bad-cast.c:5:23: error: expected declaration
 bad-cast.c:5:23: error: Expected ) at end of cast operator
 bad-cast.c:5:23: error: got /
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/bad-ternary-cond.c b/validation/bad-ternary-cond.c
index e3d07b5..4c59ffa 100644
--- a/validation/bad-ternary-cond.c
+++ b/validation/bad-ternary-cond.c
@@ -9,4 +9,5 @@ static int foo(int a)
 bad-ternary-cond.c:3:19: error: Expected : in conditional expression
 bad-ternary-cond.c:3:19: error: got ?
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/bad-typeof.c b/validation/bad-typeof.c
index 90c3e42..27ece6a 100644
--- a/validation/bad-typeof.c
+++ b/validation/bad-typeof.c
@@ -11,4 +11,5 @@ static int fun(void)
  * check-error-start
 bad-typeof.c:3:16: error: expected expression after the '(' token
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/badtype2.c b/validation/badtype2.c
index 90a5fa1..b29299d 100644
--- a/validation/badtype2.c
+++ b/validation/badtype2.c
@@ -21,4 +21,5 @@ badtype2.c:7:3: error: not in switch scope
 badtype2.c:10:1: error: Expected ; at the end of type declaration
 badtype2.c:10:1: error: got }
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/badtype3.c b/validation/badtype3.c
index 20f346c..74678e8 100644
--- a/validation/badtype3.c
+++ b/validation/badtype3.c
@@ -24,4 +24,5 @@ badtype3.c:10:1: error: Expected ; at the end of type declaration
 badtype3.c:10:1: error: got }
 badtype3.c:6:11: error: undefined identifier 'func'
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/badtype4.c b/validation/badtype4.c
index 7421ba4..9e40a50 100644
--- a/validation/badtype4.c
+++ b/validation/badtype4.c
@@ -12,4 +12,5 @@ void a(void)
 badtype4.c:3:16: error: undefined identifier 'x'
 badtype4.c:4:14: error: incompatible types for 'case' statement
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/check_byte_count-ice.c b/validation/check_byte_count-ice.c
index 7b85b96..4dcb3f6 100644
--- a/validation/check_byte_count-ice.c
+++ b/validation/check_byte_count-ice.c
@@ -16,4 +16,5 @@ builtin:0:0: error: Expected } at end of function
 builtin:0:0: error: got end-of-input
 check_byte_count-ice.c:5:15: error: not enough arguments for function memset
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/compare-null-to-int.c b/validation/compare-null-to-int.c
index 08e556b..a45bdaf 100644
--- a/validation/compare-null-to-int.c
+++ b/validation/compare-null-to-int.c
@@ -8,4 +8,5 @@ compare-null-to-int.c:1:44: error: incompatible types for operation (==)
 compare-null-to-int.c:1:44:    left side has type void *
 compare-null-to-int.c:1:44:    right side has type int
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/cond_expr.c b/validation/cond_expr.c
index e55711c..8d1978a 100644
--- a/validation/cond_expr.c
+++ b/validation/cond_expr.c
@@ -16,4 +16,5 @@ int a(void)
 cond_expr.c:10:16: error: incompatible types for operation (~)
 cond_expr.c:10:16:    argument has type double
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/goto-label.c b/validation/goto-label.c
index 1196fde..e4f788f 100644
--- a/validation/goto-label.c
+++ b/validation/goto-label.c
@@ -25,5 +25,6 @@ void bar(void)
 goto-label.c:5:1: error: label 'a' redefined
 goto-label.c:18:9: error: label 'neverland' was not declared
  * check-error-end
+ * check-exit-value: 1
  */
 
diff --git a/validation/identifier_list.c b/validation/identifier_list.c
index 4691989..0af4362 100644
--- a/validation/identifier_list.c
+++ b/validation/identifier_list.c
@@ -15,4 +15,5 @@ identifier_list.c:4:9: error: got ,
 identifier_list.c:6:9: error: Expected ) in function declarator
 identifier_list.c:6:9: error: got ,
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/nested-declarator.c b/validation/nested-declarator.c
index 1efe20c..723f6d8 100644
--- a/validation/nested-declarator.c
+++ b/validation/nested-declarator.c
@@ -26,4 +26,5 @@ nested-declarator.c:14:18: error: got (
 nested-declarator.c:15:14: error: Expected ) in function declarator
 nested-declarator.c:15:14: error: got (
  * check-error-end:
+ * check-exit-value: 1
  */
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
index 345a04b..4593d73 100644
--- a/validation/nested-declarator2.c
+++ b/validation/nested-declarator2.c
@@ -38,4 +38,5 @@ nested-declarator2.c:26:13: error: got -
 nested-declarator2.c:27:16: error: Expected ; at the end of type declaration
 nested-declarator2.c:27:16: error: got (
  * check-error-end:
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor11.c b/validation/preprocessor/preprocessor11.c
index 4b37664..364755b 100644
--- a/validation/preprocessor/preprocessor11.c
+++ b/validation/preprocessor/preprocessor11.c
@@ -28,4 +28,5 @@ preprocessor/preprocessor11.c:7:12: error: missing ')' in macro parameter list
 preprocessor/preprocessor11.c:8:12: error: missing ')' in macro parameter list
 preprocessor/preprocessor11.c:9:11: error: missing ')' in macro parameter list
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor13.c b/validation/preprocessor/preprocessor13.c
index b1af855..b95fc65 100644
--- a/validation/preprocessor/preprocessor13.c
+++ b/validation/preprocessor/preprocessor13.c
@@ -20,4 +20,5 @@ A(1,2,3)
 preprocessor/preprocessor13.c:6:1: error: '##' failed: concatenation is not a valid token
 preprocessor/preprocessor13.c:7:1: error: '##' failed: concatenation is not a valid token
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor18.c b/validation/preprocessor/preprocessor18.c
index 20169e8..0d677f1 100644
--- a/validation/preprocessor/preprocessor18.c
+++ b/validation/preprocessor/preprocessor18.c
@@ -14,4 +14,5 @@
 preprocessor/preprocessor18.c:2:2: error: expected identifier to 'define'
 preprocessor/preprocessor18.c:3:2: error: expected identifier to 'undef'
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor21.c b/validation/preprocessor/preprocessor21.c
index 4b55a6b..6de36ea 100644
--- a/validation/preprocessor/preprocessor21.c
+++ b/validation/preprocessor/preprocessor21.c
@@ -13,4 +13,5 @@
  * check-error-start
 preprocessor/preprocessor21.c:2:2: error: unterminated preprocessor conditional
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor22.c b/validation/preprocessor/preprocessor22.c
index af5bcb3..430d9da 100644
--- a/validation/preprocessor/preprocessor22.c
+++ b/validation/preprocessor/preprocessor22.c
@@ -32,4 +32,5 @@ struct {
 int b;
 } a;;
  * check-output-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor23.c b/validation/preprocessor/preprocessor23.c
index 25be508..4a068a6 100644
--- a/validation/preprocessor/preprocessor23.c
+++ b/validation/preprocessor/preprocessor23.c
@@ -44,4 +44,5 @@ preprocessor/preprocessor23.c:10:1: error: '##' failed: concatenation is not a v
 preprocessor/preprocessor23.c:12:1: error: '##' failed: concatenation is not a valid token
 preprocessor/preprocessor23.c:14:1: error: '##' failed: concatenation is not a valid token
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/preprocessor/preprocessor8.c b/validation/preprocessor/preprocessor8.c
index 524825c..be129d9 100644
--- a/validation/preprocessor/preprocessor8.c
+++ b/validation/preprocessor/preprocessor8.c
@@ -35,4 +35,5 @@ preprocessor/preprocessor8.c:2:16: error: '##' cannot appear at the ends of macr
 preprocessor/preprocessor8.c:3:22: error: '##' cannot appear at the ends of macro expansion
 preprocessor/preprocessor8.c:4:15: error: '#' is not followed by a macro parameter
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/reserved.c b/validation/reserved.c
index caacd21..736386a 100644
--- a/validation/reserved.c
+++ b/validation/reserved.c
@@ -37,4 +37,5 @@ reserved.c:16:12: error: Trying to use reserved word 'inline' as identifier
 reserved.c:17:12: error: Trying to use reserved word '__inline' as identifier
 reserved.c:18:12: error: Trying to use reserved word '__inline__' as identifier
  * check-error-end:
+ * check-exit-value: 1
  */
diff --git a/validation/specifiers2.c b/validation/specifiers2.c
index d5be118..2372a31 100644
--- a/validation/specifiers2.c
+++ b/validation/specifiers2.c
@@ -149,4 +149,5 @@ specifiers2.c:72:8: error: impossible combination of type specifiers: signed voi
 specifiers2.c:73:10: error: impossible combination of type specifiers: unsigned void
 specifiers2.c:74:6: error: two or more data types in declaration specifiers
  * check-error-end
+ * check-exit-value: 1
  */
diff --git a/validation/typedef_shadow.c b/validation/typedef_shadow.c
index c72cec7..e86817a 100644
--- a/validation/typedef_shadow.c
+++ b/validation/typedef_shadow.c
@@ -9,4 +9,5 @@ static void f(int T)
 typedef_shadow.c:4:18: error: Expected ; at end of declaration
 typedef_shadow.c:4:18: error: got a
  * check-error-end:
+ * check-exit-value: 1
  */
-- 
1.9.3

