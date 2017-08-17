From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 12/14] cast: add support for -Wpointer-to-int-cast
Date: Thu, 17 Aug 2017 06:05:27 +0200
Message-ID: <20170817040529.7289-13-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33087 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEGF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:06:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id n88so6177384wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:06:04 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's relatively common to cast a pointer to an unsigned long,
for example to make some bit operations.
It's much less sensicla to cast a pointer to an integer smaller
(or bigger) than a pointer is.

So allow to emit a diagnostic for this, under the control of a
new warning flag: -Wpointer-to-cast.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                         | 2 ++
 lib.h                         | 1 +
 linearize.c                   | 5 +++++
 validation/cast-kinds-check.c | 2 +-
 validation/cast-kinds.c       | 2 ++
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 1c67e1912..7bfe9eb4e 100644
--- a/lib.c
+++ b/lib.c
@@ -241,6 +241,7 @@ int Woverride_init = 1;
 int Woverride_init_all = 0;
 int Woverride_init_whole_range = 0;
 int Wparen_string = 0;
+int Wpointer_to_int_cast = 1;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
 int Wshadow = 0;
@@ -532,6 +533,7 @@ static const struct warning {
 	{ "override-init", &Woverride_init },
 	{ "override-init-all", &Woverride_init_all },
 	{ "paren-string", &Wparen_string },
+	{ "pointer-to-int-cast", &Wpointer_to_int_cast },
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "return-void", &Wreturn_void },
 	{ "shadow", &Wshadow },
diff --git a/lib.h b/lib.h
index 010317970..e588bb8c5 100644
--- a/lib.h
+++ b/lib.h
@@ -134,6 +134,7 @@ extern int Woverride_init;
 extern int Woverride_init_all;
 extern int Woverride_init_whole_range;
 extern int Wparen_string;
+extern int Wpointer_to_int_cast;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
 extern int Wshadow;
diff --git a/linearize.c b/linearize.c
index a1b647864..cae402ad3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1246,6 +1246,11 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 		src = cast_pseudo(ep, src, from, size_t_ctype);
 		from = size_t_ctype;
 		break;
+	case OP_PTRTU:
+		if (from->bit_size == to->bit_size)
+			break;
+		if (Wpointer_to_int_cast)
+			warning(to->pos, "non size-preserving pointer to integer cast");
 	default:
 		break;
 	}
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index 365fe6e40..0eb94d047 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -2,7 +2,7 @@
 
 /*
  * check-name: cast-kinds check
- * check-command: sparse -m64 -v $file
+ * check-command: sparse -m64 -v -Wno-pointer-to-int-cast $file
  *
  * check-error-start
 cast-kinds.c:5:45: warning: cast drops bits
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index f60013e68..747a181ce 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -58,6 +58,8 @@ static double double_2_double(double a) { return a; }
  * check-command: test-linearize -m64 $file
  *
  * check-error-start
+cast-kinds.c:8:41: warning: non size-preserving pointer to integer cast
+cast-kinds.c:15:43: warning: non size-preserving pointer to integer cast
 cast-kinds.c:37:42: warning: non size-preserving integer to pointer cast
 cast-kinds.c:38:44: warning: non size-preserving integer to pointer cast
  * check-error-end
-- 
2.14.0

