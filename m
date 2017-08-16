From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 24/29] sssa: add PSEUDO_INDIR
Date: Wed, 16 Aug 2017 17:34:50 +0200
Message-ID: <20170816153455.97693-25-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38049 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id g32so3684831wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:50 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Simplification of trivial pseudos require to replace
a pseudo for another in all ptrmap. Since this could
be an annoying and relatively costly operation
if effectively done by looking after each pseudos,
this patch introduce a new type of pseudo used as a
a sort of a symlink for another one: PSEUDO_INDIR.

So the processing is almost for free and this indirection
has just to be done when looking after the corresponding var.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 ++
 linearize.h | 2 ++
 ssa.c       | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/linearize.c b/linearize.c
index 1630810d4..f47748b38 100644
--- a/linearize.c
+++ b/linearize.c
@@ -157,6 +157,8 @@ const char *show_pseudo(pseudo_t pseudo)
 		break;
 	case PSEUDO_UNDEF:
 		return "UNDEF";
+	case PSEUDO_INDIR:
+		return show_pseudo(pseudo->target);
 	default:
 		snprintf(buf, 64, "<bad pseudo type %d>", pseudo->type);
 	}
diff --git a/linearize.h b/linearize.h
index eba0323d0..3fdcd487c 100644
--- a/linearize.h
+++ b/linearize.h
@@ -29,6 +29,7 @@ enum pseudo_type {
 	PSEUDO_VAL,
 	PSEUDO_ARG,
 	PSEUDO_PHI,
+	PSEUDO_INDIR,
 };
 
 struct pseudo {
@@ -40,6 +41,7 @@ struct pseudo {
 		struct symbol *sym;
 		struct instruction *def;
 		long long value;
+		pseudo_t target;
 	};
 	void *priv;
 };
diff --git a/ssa.c b/ssa.c
index e50fae0cc..10279a602 100644
--- a/ssa.c
+++ b/ssa.c
@@ -73,6 +73,8 @@ pseudo_t load_var(struct basic_block *bb, struct symbol *var)
 	pseudo_t val = phi_map_lookup(var->phi_map, bb);
 	if (!val)
 		val = load_var_parents(bb, var);
+	while (val->type == PSEUDO_INDIR)
+		val = val->target;
 	return val;
 }
 
-- 
2.14.0

