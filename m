From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/16] fix killing of otherwise not-handled instructions
Date: Thu, 16 Feb 2017 05:56:59 +0100
Message-ID: <20170216045708.50661-8-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33120 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbdBPE5W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:22 -0500
Received: by mail-wr0-f194.google.com with SMTP id i10so641717wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:22 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The instructions which are otherwise not handled in
kill_instruction() were simply ignored  but they must
still have their ->bb set to NULL.

Fix this by separating the default case from OP_ENTRY,
the only kind that must be ignored in all circonstances.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 82ae97ae9..1fbad1060 100644
--- a/simplify.c
+++ b/simplify.c
@@ -228,9 +228,11 @@ void kill_instruction(struct instruction *insn)
 		break;
 
 	case OP_ENTRY:
-	default:
 		/* ignore */
 		return;
+
+	default:
+		break;
 	}
 
 	insn->bb = NULL;
-- 
2.11.0

