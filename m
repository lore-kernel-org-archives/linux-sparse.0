From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Thu, 25 Sep 2014 10:11:17 +0200
Message-ID: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40581 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbaIYILV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Sep 2014 04:11:21 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

Make sparse fail and return an error code if a warning is encountered
and -Werror is specified or a hard error is found. This allows to use
sparse in automated build systems to more easily catch new sparse
warnings.

The validation script is extended to parse the expected output message
for an error message and validate the a non zero return value if such
a error message is found.

Also changes cgcc to die if the checker fails.

Signed-off-by: Thomas Graf <tgraf@suug.ch>
---
v2:
 - Detect non zero return value via expected output in validation script
   as suggested by Christopher Li <sparse@chrisli.org>.

 cgcc                  |  2 +-
 lib.c                 | 49 ++++++++++++++++++++++++++++++-------------------
 lib.h                 |  1 +
 sparse.1              |  3 +++
 sparse.c              |  3 +++
 validation/test-suite | 18 ++++++++++++------
 6 files changed, 50 insertions(+), 26 deletions(-)

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
index 4e6fc81..5203d98 100644
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
@@ -467,6 +475,9 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
 		}
 	}
 
+	if (!strcmp(p, "error"))
+		Werror = 1;
+
 	// Prefixes "no" and "no-" mean to turn warning off.
 	if (p[0] == 'n' && p[1] == 'o') {
 		p += 2;
diff --git a/lib.h b/lib.h
index f6cd9b4..dc01684 100644
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
index 54da09b..acdce53 100644
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
diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..61667a5 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -106,20 +106,26 @@ do_test()
 	fi
 	verbose "Using command       : $cmd"
 
+	# grab the expected output
+	sed -n '/check-output-start/,/check-output-end/p' $file \
+		| grep -v check-output > "$file".output.expected
+	sed -n '/check-error-start/,/check-error-end/p' $file \
+		| grep -v check-error > "$file".error.expected
+
 	# grab the expected exit value
 	get_value "check-exit-value" $file
 	if [ "$?" -eq "0" ]; then
 		expected_exit_value=`echo $last_result | tr -d ' '`
 	else
-		expected_exit_value=0
+		grep -q -E "^[^:]+:[[:digit:]]+:[[:digit:]]+: error:" "$file".error.expected
+		if  [ "$?" -eq "0" ]; then
+			expected_exit_value=1
+		else
+			expected_exit_value=0
+		fi
 	fi
 	verbose "Expecting exit value: $expected_exit_value"
 
-	# grab the expected output
-	sed -n '/check-output-start/,/check-output-end/p' $file \
-		| grep -v check-output > "$file".output.expected
-	sed -n '/check-error-start/,/check-error-end/p' $file \
-		| grep -v check-error > "$file".error.expected
 
 	# grab the actual output & exit value
 	$cmd 1> $file.output.got 2> $file.error.got
-- 
1.9.3

