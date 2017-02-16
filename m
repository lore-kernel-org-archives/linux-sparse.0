From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/16] fix killing OP_CALL via pointers
Date: Thu, 16 Feb 2017 05:57:02 +0100
Message-ID: <20170216045708.50661-11-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35786 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbdBPE5Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:25 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so628581wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:24 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When killing an OP_CALL corresponding to a function pointer
the ->func field needs also to have its usage adjusted.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/simplify.c b/simplify.c
index cacf81f9f..b80d05b87 100644
--- a/simplify.c
+++ b/simplify.c
@@ -245,6 +245,8 @@ void kill_insn(struct instruction *insn, int force)
 				return;
 		}
 		kill_use_list(insn->arguments);
+		if (insn->func->type == PSEUDO_REG)
+			kill_use(&insn->func);
 		break;
 
 	case OP_ENTRY:
-- 
2.11.0

