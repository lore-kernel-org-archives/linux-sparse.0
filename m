From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add support for arch specific asm constraints
Date: Sat,  4 Jul 2020 15:57:45 +0200
Message-ID: <20200704135747.87752-2-luc.vanoostenryck@gmail.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgGDN5x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 09:57:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6101BC061794
        for <linux-sparse@vger.kernel.org>; Sat,  4 Jul 2020 06:57:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w6so37383318ejq.6
        for <linux-sparse@vger.kernel.org>; Sat, 04 Jul 2020 06:57:53 -0700 (PDT)
In-Reply-To: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When evaluating asm operands it must be known if they correspond
to a memory operand or not in order to process/ignore the 'noderef'
attribute.

This is done for operands specified with the common constraints
but not for the machine specific constraints.

So, add support for processing machine specific constraints.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 5 ++++-
 target.h   | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 3b9aec3c13c0..f515ce6f2de6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3642,7 +3642,10 @@ static void parse_asm_constraint(struct asm_operand *op)
 			return;
 
 		default:
-			// FIXME: arch-specific (and multi-letter) constraints
+			if (arch_target->asm_constraint)
+				str = arch_target->asm_constraint(op, c, str);
+
+			// FIXME: multi-letter constraints
 			break;
 		}
 	}
diff --git a/target.h b/target.h
index 8640026cc6d4..3ef0d520f83c 100644
--- a/target.h
+++ b/target.h
@@ -53,7 +53,7 @@ extern int pointer_alignment;
 extern int bits_in_enum;
 extern int enum_alignment;
 
