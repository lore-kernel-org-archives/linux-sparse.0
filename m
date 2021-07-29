Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46004C4338F
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278CB604D7
	for <linux-sparse@archiver.kernel.org>; Thu, 29 Jul 2021 21:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhG2VVF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhG2VVE (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jul 2021 17:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA86604D7;
        Thu, 29 Jul 2021 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627593660;
        bh=AamUp6V6/GmSWDAe+QCv7NVD2ZVFZ8bVGB1rCgiixm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTtXY/ZPC0JNLT9aWqdujhF3npWwYzIpZU3hkYaTuloKC63dAi7nC3mlNb2PG6JFP
         SszxmX7yXJTOJEaVgcblsaYzpMTZf6N2r8kvA03WgRRUz7xFUnIaR7uNa34E66/amD
         /+rw7DNceUwBTYR/QJsdxQwvzr2BJJKS88wOS6/hzZ5sQSlmZupCmeU7nLfuitJAay
         F8OINbFChb5SsqSQZiUx5NPN8D4rF8twQfCkh6OjDLuwFjNnbzHmMeTx6VFdFLBvHM
         V5ZaqoTeQz60N9ca1F0BOEjb6YT8WStL4SQ+Opj3gIY7JoJlL0W11BUVL7HVc1XN94
         5+YIxYEnfHnqw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] scheck: better diagnostic for unsupported instructions
Date:   Thu, 29 Jul 2021 23:20:50 +0200
Message-Id: <20210729212054.34327-2-lucvoo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729212054.34327-1-lucvoo@kernel.org>
References: <20210729212054.34327-1-lucvoo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When reporting an unsupported instruction, display the instruction
together with the diagnostic message.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 scheck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scheck.c b/scheck.c
index 754fe76f986a..c830f56a0985 100644
--- a/scheck.c
+++ b/scheck.c
@@ -134,7 +134,7 @@ static void binary(Btor *btor, BoolectorSort s, struct instruction *insn)
 	case OP_SET_AE:	t = zext(btor, insn, boolector_ugte(btor, a, b)); break;
 	case OP_SET_A:	t = zext(btor, insn, boolector_ugt(btor, a, b)); break;
 	default:
-		fprintf(stderr, "unsupported insn\n");
+		fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 		return;
 	}
 	insn->target->priv = t;
@@ -167,7 +167,7 @@ static void unop(Btor *btor, struct instruction *insn)
 	case OP_ZEXT:	t = zext(btor, insn, a); break;
 	case OP_TRUNC:	t = slice(btor, insn, a); break;
 	default:
-		fprintf(stderr, "unsupported insn\n");
+		fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 		return;
 	}
 	insn->target->priv = t;
@@ -190,7 +190,7 @@ static void ternop(Btor *btor, struct instruction *insn)
 		t = boolector_cond(btor, d, b, c);
 		break;
 	default:
-		fprintf(stderr, "unsupported insn\n");
+		fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 		return;
 	}
 	insn->target->priv = t;
@@ -314,7 +314,7 @@ static bool check_function(struct entrypoint *ep)
 			case OP_RET:
 				goto out;
 			default:
-				fprintf(stderr, "unsupported insn\n");
+				fprintf(stderr, "unsupported insn: %s\n", show_instruction(insn));
 				goto out;
 			}
 		} END_FOR_EACH_PTR(insn);
-- 
2.32.0

