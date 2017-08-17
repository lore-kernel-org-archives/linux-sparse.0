From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 09/14] cast: make pointer casts always size preserving
Date: Thu, 17 Aug 2017 06:05:24 +0200
Message-ID: <20170817040529.7289-10-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33054 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEF7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id n88so6177133wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:58 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently casts to pointers can be done from any integer type.
However, casts to (or from) pointers are only meaningful if value
preserving and thus between object of the same size.

To avoid to have to worry about sign/zero extension while doing
casts to pointers it's good to not have to deal with such casts.

Do this by doing first, if needed, a cast an integer of the same
size as a pointer before doing the cast to a pointer.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md      |  2 +-
 linearize.c              |  2 ++
 validation/cast-kinds.c  | 62 +++++++++++++++++++++++++-----------------------
 validation/cast-weirds.c | 18 +++++++-------
 4 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 039bdb097..a1a32c562 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -164,7 +164,7 @@ Cast to unsigned integer (and to void pointer).
 Cast to signed integer.
 
 ### OP_UTPTR
-Cast from unsigned integer to pointer type.
+Cast from pointer-sized unsigned integer to pointer type.
 
 ### OP_PTRCAST
 Cast to pointer.
diff --git a/linearize.c b/linearize.c
index 85d472ca6..8be26db58 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1225,6 +1225,8 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 			break;
 		if (Wint_to_pointer_cast)
 			warning(to->pos, "non size-preserving integer to pointer cast");
+		src = cast_pseudo(ep, src, from, size_t_ctype);
+		from = size_t_ctype;
 		break;
 	default:
 		break;
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index e5b64b768..aa9f9bb29 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -293,106 +293,108 @@ iptr_2_vptr:
 int_2_iptr:
 .L66:
 	<entry-point>
-	utptr.64    %r101 <- (32) %arg1
-	ret.64      %r101
+	scast.64    %r101 <- (32) %arg1
+	utptr.64    %r102 <- (64) %r101
+	ret.64      %r102
 
 
 uint_2_iptr:
 .L68:
 	<entry-point>
-	utptr.64    %r104 <- (32) %arg1
-	ret.64      %r104
+	cast.64     %r105 <- (32) %arg1
+	utptr.64    %r106 <- (64) %r105
+	ret.64      %r106
 
 
 long_2_iptr:
 .L70:
 	<entry-point>
-	utptr.64    %r107 <- (64) %arg1
-	ret.64      %r107
+	utptr.64    %r109 <- (64) %arg1
+	ret.64      %r109
 
 
 ulong_2_iptr:
 .L72:
 	<entry-point>
-	utptr.64    %r110 <- (64) %arg1
-	ret.64      %r110
+	utptr.64    %r112 <- (64) %arg1
+	ret.64      %r112
 
 
 vptr_2_iptr:
 .L74:
 	<entry-point>
-	ptrcast.64  %r113 <- (64) %arg1
-	ret.64      %r113
+	ptrcast.64  %r115 <- (64) %arg1
+	ret.64      %r115
 
 
 int_2_float:
 .L76:
 	<entry-point>
-	scvtf.32    %r116 <- (32) %arg1
-	ret.32      %r116
+	scvtf.32    %r118 <- (32) %arg1
+	ret.32      %r118
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	ucvtf.32    %r119 <- (32) %arg1
-	ret.32      %r119
+	ucvtf.32    %r121 <- (32) %arg1
+	ret.32      %r121
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	scvtf.32    %r122 <- (64) %arg1
-	ret.32      %r122
+	scvtf.32    %r124 <- (64) %arg1
+	ret.32      %r124
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	ucvtf.32    %r125 <- (64) %arg1
-	ret.32      %r125
+	ucvtf.32    %r127 <- (64) %arg1
+	ret.32      %r127
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	fcvtf.32    %r128 <- (64) %arg1
-	ret.32      %r128
+	fcvtf.32    %r130 <- (64) %arg1
+	ret.32      %r130
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	scvtf.64    %r131 <- (32) %arg1
-	ret.64      %r131
+	scvtf.64    %r133 <- (32) %arg1
+	ret.64      %r133
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	ucvtf.64    %r134 <- (32) %arg1
-	ret.64      %r134
+	ucvtf.64    %r136 <- (32) %arg1
+	ret.64      %r136
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	scvtf.64    %r137 <- (64) %arg1
-	ret.64      %r137
+	scvtf.64    %r139 <- (64) %arg1
+	ret.64      %r139
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	ucvtf.64    %r140 <- (64) %arg1
-	ret.64      %r140
+	ucvtf.64    %r142 <- (64) %arg1
+	ret.64      %r142
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	fcvtf.64    %r143 <- (32) %arg1
-	ret.64      %r143
+	fcvtf.64    %r145 <- (32) %arg1
+	ret.64      %r145
 
 
 float_2_float:
diff --git a/validation/cast-weirds.c b/validation/cast-weirds.c
index 136137b4c..71e52ff57 100644
--- a/validation/cast-weirds.c
+++ b/validation/cast-weirds.c
@@ -20,29 +20,31 @@ cast-weirds.c:5:44: warning: non size-preserving integer to pointer cast
 int_2_iptr:
 .L0:
 	<entry-point>
-	utptr.64    %r2 <- (32) %arg1
-	ret.64      %r2
+	scast.64    %r2 <- (32) %arg1
+	utptr.64    %r3 <- (64) %r2
+	ret.64      %r3
 
 
 uint_2_iptr:
 .L2:
 	<entry-point>
-	utptr.64    %r5 <- (32) %arg1
-	ret.64      %r5
+	cast.64     %r6 <- (32) %arg1
+	utptr.64    %r7 <- (64) %r6
+	ret.64      %r7
 
 
 int_2_vptr:
 .L4:
 	<entry-point>
-	scast.64    %r8 <- (32) %arg1
-	ret.64      %r8
+	scast.64    %r10 <- (32) %arg1
+	ret.64      %r10
 
 
 uint_2_vptr:
 .L6:
 	<entry-point>
-	cast.64     %r11 <- (32) %arg1
-	ret.64      %r11
+	cast.64     %r13 <- (32) %arg1
+	ret.64      %r13
 
 
  * check-output-end
-- 
2.14.0

