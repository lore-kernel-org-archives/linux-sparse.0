From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 10/14] cast: temporary simplify handling cast to/from void*
Date: Thu, 17 Aug 2017 06:05:25 +0200
Message-ID: <20170817040529.7289-11-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38436 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEGB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:06:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id 49so33699wrw.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:06:00 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently pointer cast from/to void are treated as casts
to/from integer. The rationale being that a void pointer can't
anyway be dereferenced.

Allow to contnue to do by using a new 'machine type' for void
pointer which then allow to select the right type of cast:
OP_PTRCAST or OP_[S]CAST.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 8be26db58..01e6abde8 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1121,6 +1121,7 @@ enum mtype {
 	MTYPE_UINT,
 	MTYPE_SINT,
 	MTYPE_PTR,
+	MTYPE_VPTR,	// TODO: must be removed ?
 	MTYPE_FLOAT,
 	MTYPE_BAD,
 };
@@ -1135,8 +1136,7 @@ retry:	switch (s->type) {
 		goto retry;
 	case SYM_PTR:
 		if (s->ctype.base_type == &void_ctype)
-			// handle void pointer like an uint
-			goto case_int;
+			return MTYPE_VPTR;
 		return MTYPE_PTR;
 	case SYM_BITFIELD:
 	case SYM_RESTRICT:
@@ -1180,14 +1180,25 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 		switch (stype) {
 		case MTYPE_UINT:
 		case MTYPE_SINT:
-			if (is_ptr_type(src))	// must be a void pointer
-				return OP_PTRCAST;// FIXME: to be removed?
 			return OP_UTPTR;
 		case MTYPE_PTR:
+		case MTYPE_VPTR:
 			return OP_PTRCAST;
 		default:
 			return OP_BADOP;
 		}
+	case MTYPE_VPTR:
+		switch (stype) {
+		case MTYPE_PTR:
+		case MTYPE_VPTR:
+		case MTYPE_UINT:
+			return OP_CAST;
+		case MTYPE_SINT:
+			return OP_SCAST;
+		default:
+			return OP_BADOP;
+			break;
+		}
 	case MTYPE_UINT:
 	case MTYPE_SINT:
 		switch (stype) {
-- 
2.14.0

