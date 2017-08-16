From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/29] add PSEUDO_UNDEF
Date: Wed, 16 Aug 2017 17:34:37 +0200
Message-ID: <20170816153455.97693-12-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38904 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPf3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so3683342wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:28 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Processing in the middle-end are much easier if undefined values
have been clearly identified. Once done, we can then make
choices like:
- always initialize them to zero
- allow arbitraly simplification,
- ...

Prepare for this by declaring a new type of pseudo: PSEUDO_UNDEF
somewhat similar to PSEUDO_VOID.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c   | 2 ++
 linearize.h   | 3 ++-
 sparse-llvm.c | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 190c47241..9ec65079a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -155,6 +155,8 @@ const char *show_pseudo(pseudo_t pseudo)
 		if (pseudo->ident)
 			sprintf(buf+i, "(%s)", show_ident(pseudo->ident));
 		break;
+	case PSEUDO_UNDEF:
+		return "UNDEF";
 	default:
 		snprintf(buf, 64, "<bad pseudo type %d>", pseudo->type);
 	}
diff --git a/linearize.h b/linearize.h
index c03940eea..54fcf2a46 100644
--- a/linearize.h
+++ b/linearize.h
@@ -21,6 +21,7 @@ DECLARE_PTR_LIST(pseudo_user_list, struct pseudo_user);
 
 enum pseudo_type {
 	PSEUDO_VOID,
+	PSEUDO_UNDEF,
 	PSEUDO_REG,
 	PSEUDO_SYM,
 	PSEUDO_VAL,
@@ -290,7 +291,7 @@ static inline void add_pseudo_user_ptr(struct pseudo_user *user, struct pseudo_u
 
 static inline int has_use_list(pseudo_t p)
 {
-	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
+	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_UNDEF && p->type != PSEUDO_VAL);
 }
 
 static inline struct pseudo_user *alloc_pseudo_user(struct instruction *insn, pseudo_t *pp)
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 29fb65f15..f8d48d264 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -289,6 +289,7 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 		assert(0);
 		break;
 	case PSEUDO_VAL:
+	case PSEUDO_UNDEF:
 		assert(0);
 		break;
 	case PSEUDO_ARG: {
@@ -372,6 +373,9 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 	case PSEUDO_VOID:
 		result = NULL;
 		break;
+	case PSEUDO_UNDEF:
+		result = LLVMGetUndef(symbol_type(fn->module, insn->type));
+		break;
 	default:
 		assert(0);
 	}
-- 
2.14.0

