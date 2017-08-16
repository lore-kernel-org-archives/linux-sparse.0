From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 20/29] sssa: add needed new members
Date: Wed, 16 Aug 2017 17:34:46 +0200
Message-ID: <20170816153455.97693-21-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34131 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdHPPfp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:45 -0400
Received: by mail-wr0-f194.google.com with SMTP id x43so3698554wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:44 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The incoming new method to construct the SSA needs
a few new members for pseudos, basic_blocks & symbols.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 12 +++++++++++-
 symbol.h    |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/linearize.h b/linearize.h
index a550035d3..30f34aa8f 100644
--- a/linearize.h
+++ b/linearize.h
@@ -6,6 +6,7 @@
 #include "token.h"
 #include "parse.h"
 #include "symbol.h"
+#include "ptrmap.h"
 
 struct instruction;
 DECLARE_PTR_LIST(pseudo_ptr_list, pseudo_t);
@@ -18,6 +19,7 @@ struct pseudo_user {
 DECLARE_ALLOCATOR(pseudo_user);
 DECLARE_PTR_LIST(pseudo_user_list, struct pseudo_user);
 
+DECLARE_PTRMAP(phi_map, struct basic_block *, pseudo_t);
 
 enum pseudo_type {
 	PSEUDO_VOID,
@@ -90,6 +92,7 @@ struct instruction {
 		};
 		struct /* phi_node */ {
 			struct pseudo_list *phi_list;
+			struct symbol *var;		/* SSSA only */
 		};
 		struct /* phi source */ {
 			pseudo_t phi_src;
@@ -231,7 +234,14 @@ struct basic_block {
 	struct basic_block_list *parents; /* sources */
 	struct basic_block_list *children; /* destinations */
 	struct instruction_list *insns;	/* Linear list of instructions */
-	struct pseudo_list *needs, *defines;
+	union {
+		struct {		// SSA construction
+			unsigned int sealed:1;
+		};
+		struct {		// liveness
+			struct pseudo_list *needs, *defines;
+		};
+	};
 	union {
 		unsigned int nr;	/* unique id for label's names */
 		void *priv;
diff --git a/symbol.h b/symbol.h
index 3f075c5bc..05a0d801c 100644
--- a/symbol.h
+++ b/symbol.h
@@ -184,6 +184,7 @@ struct symbol {
 			struct expression *initializer;
 			struct entrypoint *ep;
 			long long value;		/* Initial value */
+			struct phi_map *phi_map;
 			struct symbol *definition;
 		};
 	};
-- 
2.14.0

