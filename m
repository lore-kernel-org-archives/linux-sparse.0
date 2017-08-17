From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 13/14] cast: make casts from pointer always size preserving
Date: Thu, 17 Aug 2017 06:05:28 +0200
Message-ID: <20170817040529.7289-14-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35288 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEGH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:06:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id p8so124581wrf.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:06:06 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently casts from pointers can be done to any integer type.
However, casts to (or from) pointers are only meaningful if
it preserves the value and thus dince between same-sized objects.

To avoid to have to worry about sign/zero extension while doing
casts to pointers it's good to not have to deal with such casts.

Do this by doing first a cast to an unsigned integer of the same size
as a pointer and then, if needed, doing to cast to the final type.
As such we have only to support pointer cast to unsigned char of the
same size and on the other we have the generic integer-to-interger
casts we to support anyway.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md           |   2 +-
 linearize.c                   |   2 +
 sparse.c                      |   1 -
 validation/cast-kinds-check.c |   2 -
 validation/cast-kinds.c       | 170 +++++++++++++++++++++---------------------
 5 files changed, 89 insertions(+), 88 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 8f7083ea4..dcfd89bb6 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -170,7 +170,7 @@ Cast to signed integer.
 Cast from pointer-sized unsigned integer to pointer type.
 
 ### OP_PTRTU
-Cast from pointer type to unsigned integer.
+Cast from pointer type to pointer sized unsigned integer.
 
 ### OP_PTRCAST
 Cast between pointer.
diff --git a/linearize.c b/linearize.c
index cae402ad3..5d6cf7385 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1251,6 +1251,8 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 			break;
 		if (Wpointer_to_int_cast)
 			warning(to->pos, "non size-preserving pointer to integer cast");
+		src = cast_pseudo(ep, src, from, size_t_ctype);
+		return cast_pseudo(ep, src, size_t_ctype, to);
 	default:
 		break;
 	}
diff --git a/sparse.c b/sparse.c
index 9f9611e25..bceacd94e 100644
--- a/sparse.c
+++ b/sparse.c
@@ -215,7 +215,6 @@ static void check_one_instruction(struct instruction *insn)
 {
 	switch (insn->opcode) {
 	case OP_CAST: case OP_SCAST:
-	case OP_PTRTU:
 		if (verbose)
 			check_cast_instruction(insn);
 		break;
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index 0eb94d047..fe0f83e24 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -14,9 +14,7 @@ cast-kinds.c:13:50: warning: cast drops bits
 cast-kinds.c:14:49: warning: cast drops bits
 cast-kinds.c:15:48: warning: cast drops bits
 cast-kinds.c:21:49: warning: cast wasn't removed
-cast-kinds.c:22:48: warning: cast wasn't removed
 cast-kinds.c:28:52: warning: cast wasn't removed
-cast-kinds.c:29:51: warning: cast wasn't removed
 cast-kinds.c:34:52: warning: cast wasn't removed
 cast-kinds.c:35:54: warning: cast wasn't removed
 cast-kinds.c:36:52: warning: cast wasn't removed
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 747a181ce..3ac95c3dc 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -95,22 +95,23 @@ vptr_2_int:
 iptr_2_int:
 .L8:
 	<entry-point>
-	ptrtu.32    %r14 <- (64) %arg1
-	ret.32      %r14
+	ptrtu.64    %r14 <- (64) %arg1
+	cast.32     %r15 <- (64) %r14
+	ret.32      %r15
 
 
 float_2_int:
 .L10:
 	<entry-point>
-	fcvts.32    %r17 <- (32) %arg1
-	ret.32      %r17
+	fcvts.32    %r18 <- (32) %arg1
+	ret.32      %r18
 
 
 double_2_int:
 .L12:
 	<entry-point>
-	fcvts.32    %r20 <- (64) %arg1
-	ret.32      %r20
+	fcvts.32    %r21 <- (64) %arg1
+	ret.32      %r21
 
 
 int_2_uint:
@@ -122,57 +123,58 @@ int_2_uint:
 long_2_uint:
 .L16:
 	<entry-point>
-	scast.32    %r26 <- (64) %arg1
-	ret.32      %r26
+	scast.32    %r27 <- (64) %arg1
+	ret.32      %r27
 
 
 ulong_2_uint:
 .L18:
 	<entry-point>
-	cast.32     %r29 <- (64) %arg1
-	ret.32      %r29
+	cast.32     %r30 <- (64) %arg1
+	ret.32      %r30
 
 
 vptr_2_uint:
 .L20:
 	<entry-point>
-	cast.32     %r32 <- (64) %arg1
-	ret.32      %r32
+	cast.32     %r33 <- (64) %arg1
+	ret.32      %r33
 
 
 iptr_2_uint:
 .L22:
 	<entry-point>
-	ptrtu.32    %r35 <- (64) %arg1
-	ret.32      %r35
+	ptrtu.64    %r36 <- (64) %arg1
+	cast.32     %r37 <- (64) %r36
+	ret.32      %r37
 
 
 float_2_uint:
 .L24:
 	<entry-point>
-	fcvtu.32    %r38 <- (32) %arg1
-	ret.32      %r38
+	fcvtu.32    %r40 <- (32) %arg1
+	ret.32      %r40
 
 
 double_2_uint:
 .L26:
 	<entry-point>
-	fcvtu.32    %r41 <- (64) %arg1
-	ret.32      %r41
+	fcvtu.32    %r43 <- (64) %arg1
+	ret.32      %r43
 
 
 int_2_long:
 .L28:
 	<entry-point>
-	scast.64    %r44 <- (32) %arg1
-	ret.64      %r44
+	scast.64    %r46 <- (32) %arg1
+	ret.64      %r46
 
 
 uint_2_long:
 .L30:
 	<entry-point>
-	cast.64     %r47 <- (32) %arg1
-	ret.64      %r47
+	cast.64     %r49 <- (32) %arg1
+	ret.64      %r49
 
 
 ulong_2_long:
@@ -184,43 +186,43 @@ ulong_2_long:
 vptr_2_long:
 .L34:
 	<entry-point>
-	cast.64     %r53 <- (64) %arg1
-	ret.64      %r53
+	cast.64     %r55 <- (64) %arg1
+	ret.64      %r55
 
 
 iptr_2_long:
 .L36:
 	<entry-point>
-	ptrtu.64    %r56 <- (64) %arg1
-	ret.64      %r56
+	ptrtu.64    %r58 <- (64) %arg1
+	ret.64      %r58
 
 
 float_2_long:
 .L38:
 	<entry-point>
-	fcvts.64    %r59 <- (32) %arg1
-	ret.64      %r59
+	fcvts.64    %r61 <- (32) %arg1
+	ret.64      %r61
 
 
 double_2_long:
 .L40:
 	<entry-point>
-	fcvts.64    %r62 <- (64) %arg1
-	ret.64      %r62
+	fcvts.64    %r64 <- (64) %arg1
+	ret.64      %r64
 
 
 int_2_ulong:
 .L42:
 	<entry-point>
-	scast.64    %r65 <- (32) %arg1
-	ret.64      %r65
+	scast.64    %r67 <- (32) %arg1
+	ret.64      %r67
 
 
 uint_2_ulong:
 .L44:
 	<entry-point>
-	cast.64     %r68 <- (32) %arg1
-	ret.64      %r68
+	cast.64     %r70 <- (32) %arg1
+	ret.64      %r70
 
 
 long_2_ulong:
@@ -232,171 +234,171 @@ long_2_ulong:
 vptr_2_ulong:
 .L48:
 	<entry-point>
-	cast.64     %r74 <- (64) %arg1
-	ret.64      %r74
+	cast.64     %r76 <- (64) %arg1
+	ret.64      %r76
 
 
 iptr_2_ulong:
 .L50:
 	<entry-point>
-	ptrtu.64    %r77 <- (64) %arg1
-	ret.64      %r77
+	ptrtu.64    %r79 <- (64) %arg1
+	ret.64      %r79
 
 
 float_2_ulong:
 .L52:
 	<entry-point>
-	fcvtu.64    %r80 <- (32) %arg1
-	ret.64      %r80
+	fcvtu.64    %r82 <- (32) %arg1
+	ret.64      %r82
 
 
 double_2_ulong:
 .L54:
 	<entry-point>
-	fcvtu.64    %r83 <- (64) %arg1
-	ret.64      %r83
+	fcvtu.64    %r85 <- (64) %arg1
+	ret.64      %r85
 
 
 int_2_vptr:
 .L56:
 	<entry-point>
-	scast.64    %r86 <- (32) %arg1
-	ret.64      %r86
+	scast.64    %r88 <- (32) %arg1
+	ret.64      %r88
 
 
 uint_2_vptr:
 .L58:
 	<entry-point>
-	cast.64     %r89 <- (32) %arg1
-	ret.64      %r89
+	cast.64     %r91 <- (32) %arg1
+	ret.64      %r91
 
 
 long_2_vptr:
 .L60:
 	<entry-point>
-	scast.64    %r92 <- (64) %arg1
-	ret.64      %r92
+	scast.64    %r94 <- (64) %arg1
+	ret.64      %r94
 
 
 ulong_2_vptr:
 .L62:
 	<entry-point>
-	cast.64     %r95 <- (64) %arg1
-	ret.64      %r95
+	cast.64     %r97 <- (64) %arg1
+	ret.64      %r97
 
 
 iptr_2_vptr:
 .L64:
 	<entry-point>
-	cast.64     %r98 <- (64) %arg1
-	ret.64      %r98
+	cast.64     %r100 <- (64) %arg1
+	ret.64      %r100
 
 
 int_2_iptr:
 .L66:
 	<entry-point>
-	scast.64    %r101 <- (32) %arg1
-	utptr.64    %r102 <- (64) %r101
-	ret.64      %r102
+	scast.64    %r103 <- (32) %arg1
+	utptr.64    %r104 <- (64) %r103
+	ret.64      %r104
 
 
 uint_2_iptr:
 .L68:
 	<entry-point>
-	cast.64     %r105 <- (32) %arg1
-	utptr.64    %r106 <- (64) %r105
-	ret.64      %r106
+	cast.64     %r107 <- (32) %arg1
+	utptr.64    %r108 <- (64) %r107
+	ret.64      %r108
 
 
 long_2_iptr:
 .L70:
 	<entry-point>
-	utptr.64    %r109 <- (64) %arg1
-	ret.64      %r109
+	utptr.64    %r111 <- (64) %arg1
+	ret.64      %r111
 
 
 ulong_2_iptr:
 .L72:
 	<entry-point>
-	utptr.64    %r112 <- (64) %arg1
-	ret.64      %r112
+	utptr.64    %r114 <- (64) %arg1
+	ret.64      %r114
 
 
 vptr_2_iptr:
 .L74:
 	<entry-point>
-	ptrcast.64  %r115 <- (64) %arg1
-	ret.64      %r115
+	ptrcast.64  %r117 <- (64) %arg1
+	ret.64      %r117
 
 
 int_2_float:
 .L76:
 	<entry-point>
-	scvtf.32    %r118 <- (32) %arg1
-	ret.32      %r118
+	scvtf.32    %r120 <- (32) %arg1
+	ret.32      %r120
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	ucvtf.32    %r121 <- (32) %arg1
-	ret.32      %r121
+	ucvtf.32    %r123 <- (32) %arg1
+	ret.32      %r123
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	scvtf.32    %r124 <- (64) %arg1
-	ret.32      %r124
+	scvtf.32    %r126 <- (64) %arg1
+	ret.32      %r126
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	ucvtf.32    %r127 <- (64) %arg1
-	ret.32      %r127
+	ucvtf.32    %r129 <- (64) %arg1
+	ret.32      %r129
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	fcvtf.32    %r130 <- (64) %arg1
-	ret.32      %r130
+	fcvtf.32    %r132 <- (64) %arg1
+	ret.32      %r132
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	scvtf.64    %r133 <- (32) %arg1
-	ret.64      %r133
+	scvtf.64    %r135 <- (32) %arg1
+	ret.64      %r135
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	ucvtf.64    %r136 <- (32) %arg1
-	ret.64      %r136
+	ucvtf.64    %r138 <- (32) %arg1
+	ret.64      %r138
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	scvtf.64    %r139 <- (64) %arg1
-	ret.64      %r139
+	scvtf.64    %r141 <- (64) %arg1
+	ret.64      %r141
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	ucvtf.64    %r142 <- (64) %arg1
-	ret.64      %r142
+	ucvtf.64    %r144 <- (64) %arg1
+	ret.64      %r144
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	fcvtf.64    %r145 <- (32) %arg1
-	ret.64      %r145
+	fcvtf.64    %r147 <- (32) %arg1
+	ret.64      %r147
 
 
 float_2_float:
-- 
2.14.0

