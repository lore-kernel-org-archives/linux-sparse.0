From: Joe Perches <joe@perches.com>
Subject: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Wed, 26 Feb 2014 18:53:14 -0800
Message-ID: <1393469594.24588.71.camel@joe-AO722>
References: <530E6F76.1070605@zytor.com>
	 <1393462087.24588.50.camel@joe-AO722> <530E8C2E.7080307@zytor.com>
	 <1393466619.24588.65.camel@joe-AO722> <20140227022857.GC23659@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:53110 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752471AbaB0CxS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 26 Feb 2014 21:53:18 -0500
In-Reply-To: <20140227022857.GC23659@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Allow an override to emit or not the sizeof(bool) warning
Add a description to the manpage.

Signed-off-by: Joe Perches <joe@perches.com>
---
 evaluate.c | 3 ++-
 lib.c      | 2 ++
 lib.h      | 1 +
 sparse.1   | 9 +++++++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 6655615..a45f59b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2057,7 +2057,8 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 	}
 
 	if (size == 1 && is_bool_type(type)) {
-		warning(expr->pos, "expression using sizeof bool");
+		if (Wsizeof_bool)
+			warning(expr->pos, "expression using sizeof bool");
 		size = bits_in_char;
 	}
 
diff --git a/lib.c b/lib.c
index bf3e91c..676b72e 100644
--- a/lib.c
+++ b/lib.c
@@ -225,6 +225,7 @@ int Wone_bit_signed_bitfield = 1;
 int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
+int Wsizeof_bool = 1;
 int Wshadow = 0;
 int Wtransparent_union = 0;
 int Wtypesign = 0;
@@ -437,6 +438,7 @@ static const struct warning {
 	{ "paren-string", &Wparen_string },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "return-void", &Wreturn_void },
+	{ "sizeof-bool", &Wsizeof_bool },
 	{ "shadow", &Wshadow },
 	{ "transparent-union", &Wtransparent_union },
 	{ "typesign", &Wtypesign },
diff --git a/lib.h b/lib.h
index f09b338..7e3432f 100644
--- a/lib.h
+++ b/lib.h
@@ -119,6 +119,7 @@ extern int Wone_bit_signed_bitfield;
 extern int Wparen_string;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
+extern int Wsizeof_bool;
 extern int Wshadow;
 extern int Wtransparent_union;
 extern int Wtypesign;
diff --git a/sparse.1 b/sparse.1
index cd6be26..b4546be 100644
--- a/sparse.1
+++ b/sparse.1
@@ -288,6 +288,15 @@ programs consider this poor style, and those programs can use
 Sparse does not issue these warnings by default.
 .
 .TP
+.B \-Wsizeof-bool
+Warn when checking the sizeof a _Bool.
+
+C99 does not specify the sizeof a _Bool.  gcc uses 1.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-sizeof\-bool\fR.
+.
+.TP
 .B \-Wshadow
 Warn when declaring a symbol which shadows a declaration with the same name in
 an outer scope.
-- 
1.8.1.2.459.gbcd45b4.dirty



