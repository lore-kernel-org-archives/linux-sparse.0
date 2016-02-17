From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 3/5] linearize: Add context symbol name when showing context instructions
Date: Wed, 17 Feb 2016 10:51:33 +0100
Message-ID: <1455702695-6199-4-git-send-email-daniel.wagner@bmw-carit.de>
References: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>
List-Id: linux-sparse@vger.kernel.org

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index c6ada1e..da3a190 100644
--- a/linearize.c
+++ b/linearize.c
@@ -441,7 +441,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_CONTEXT:
-		buf += sprintf(buf, "%s%d", insn->check ? "check: " : "", insn->increment);
+		buf += sprintf(buf, "%s %s%d", insn->context_expr? show_ident(insn->context_expr->symbol_name) : "",  insn->check ? "check: " : "", insn->increment);
 		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
-- 
2.5.0
