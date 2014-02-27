From: Joe Perches <joe@perches.com>
Subject: [PATCH] sparse: Allow override of sizeof(bool) warning
Date: Wed, 26 Feb 2014 18:03:39 -0800
Message-ID: <1393466619.24588.65.camel@joe-AO722>
References: <530E6F76.1070605@zytor.com>
	 <1393462087.24588.50.camel@joe-AO722> <530E8C2E.7080307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530E8C2E.7080307@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, linux-sparse@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Allow an override to emit or not the sizeof(bool) warning

Signed-off-by: Joe Perches <joe@perches.com>
---
 evaluate.c | 3 ++-
 lib.c      | 2 ++
 lib.h      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

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
-- 
1.8.1.2.459.gbcd45b4.dirty
