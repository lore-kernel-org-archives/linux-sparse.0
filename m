From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv2] Rename -Wall to Wsparse-all, so it doesn't get turned on
 unintentionally
Date: Sun, 11 Oct 2009 15:47:03 -0700
Message-ID: <20091011224618.GA3963@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:53198 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbZJKW7y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 11 Oct 2009 18:59:54 -0400
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 4B4D53AA51
	for <linux-sparse@vger.kernel.org>; Mon, 12 Oct 2009 00:48:06 +0200 (CEST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

sparse's -Wall option turns on all sparse warnings, including those that
many projects will not want; for instance, warnings that enforce
particular stylistic choices, or behavior allowed by a standard but
considered questionable or error-prone.  Furthermore, using -Wall means
accepting all future warnings sparse may start issuing, not just those
intentionally turned on by default.

Other compilers like GCC also use -Wall, and interpret it to mean "turn
on a sensible set of warnings".  Since sparse exists to emit warnings,
it already defaults to emitting a sensible set of warnings.  Many
projects pass the same options to both sparse and the C compiler,
including warning options like -Wall; this results in turning on
excessive amounts of sparse warnings.

cgcc already filtered out -Wall, but many projects invoke sparse
directly rather than using cgcc.  Remove that filter, now that -Wall
does not change sparse's behavior.

Projects almost certainly don't want to use the new -Wsparse-all option;
they should choose the specific set of warnings they want, or just go
with sparse's defaults.

Also update cgcc to know about Wsparse-all and not pass it to GCC, and
update a test case that unnecessarily used -Wall.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

v2: Update cgcc and remove unnecessary (and now ignored) -Wall from a
test case.

My -Wdesignated-init patch also needs to include an update for cgcc, and
thus it will conflict with this one.  I'll rebase the Wdesignated-init
patch on this one, to avoid the conflict.  In the future, perhaps sparse
could have some kind of --print-warning-options option, and the Makefile
could generate cgcc from cgcc.in and that, avoiding the need to update
cgcc when adding a new Sparse option.

 cgcc                     |   17 ++---------------
 lib.c                    |    2 +-
 sparse.1                 |    4 ++++
 validation/specifiers1.c |    2 +-
 4 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/cgcc b/cgcc
index 995cc05..8005c3c 100755
--- a/cgcc
+++ b/cgcc
@@ -51,7 +51,7 @@ while (@ARGV) {
 
     my $this_arg = ' ' . &quote_arg ($_);
     $cc .= $this_arg unless &check_only_option ($_);
-    $check .= $this_arg unless &cc_only_option ($_);
+    $check .= $this_arg;
 }
 
 if ($gendeps) {
@@ -88,25 +88,12 @@ exit 0;
 
 sub check_only_option {
     my ($arg) = @_;
-    return 1 if $arg =~ /^-W(no-?)?(default-bitfield-sign|one-bit-signed-bitfield|cast-truncate|bitwise|typesign|context|undef|ptr-subtraction-blows|cast-to-as|decl|transparent-union|address-space|enum-mismatch|do-while|old-initializer|non-pointer-null|paren-string|return-void)$/;
+    return 1 if $arg =~ /^-W(no-?)?(default-bitfield-sign|one-bit-signed-bitfield|cast-truncate|bitwise|typesign|context|undef|ptr-subtraction-blows|cast-to-as|decl|transparent-union|address-space|enum-mismatch|do-while|old-initializer|non-pointer-null|paren-string|return-void|sparse-all)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
     return 0;
 }
 
 # -----------------------------------------------------------------------------
-# Check if an option is for "cc" only.
-
-sub cc_only_option {
-    my ($arg) = @_;
-    # -Wall turns on all Sparse warnings, including experimental and noisy
-    # ones.  Don't include it just because a project wants to pass -Wall to cc.
-    # If you really want cgcc to run sparse with -Wall, use
-    # CHECK="sparse -Wall".
-    return 1 if $arg =~ /^-Wall$/;
-    return 0;
-}
-
-# -----------------------------------------------------------------------------
 # Simple arg-quoting function.  Just adds backslashes when needed.
 
 sub quote_arg {
diff --git a/lib.c b/lib.c
index 622b547..963be08 100644
--- a/lib.c
+++ b/lib.c
@@ -407,7 +407,7 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
 	char *p = arg + 1;
 	unsigned i;
 
-	if (!strcmp(p, "all")) {
+	if (!strcmp(p, "sparse-all")) {
 		for (i = 0; i < n; i++) {
 			if (*warnings[i].flag != WARNING_FORCE_OFF)
 				*warnings[i].flag = WARNING_ON;
diff --git a/sparse.1 b/sparse.1
index d7fe444..abc75a2 100644
--- a/sparse.1
+++ b/sparse.1
@@ -20,6 +20,10 @@ off those warnings, pass the negation of the associated warning option,
 .
 .SH WARNING OPTIONS
 .TP
+.B \-Wsparse\-all
+Turn on all sparse warnings, except for those explicitly disabled via
+\fB\-Wno\-something\fR.
+.TP
 .B \-Waddress\-space
 Warn about code which mixes pointers to different address spaces.
 
diff --git a/validation/specifiers1.c b/validation/specifiers1.c
index 86db45d..1a4e1d5 100644
--- a/validation/specifiers1.c
+++ b/validation/specifiers1.c
@@ -97,5 +97,5 @@ TEST2(double, long)
 }
 /*
  * check-name: valid specifier combinations
- * check-command: sparse -Wall $file
+ * check-command: sparse $file
  */
-- 
1.6.4.3

