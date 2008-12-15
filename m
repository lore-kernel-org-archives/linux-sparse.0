From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 03/15] Add type information to struct instruction.
Date: Mon, 15 Dec 2008 03:26:10 +0300
Message-ID: <20081215002610.16107.25437.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYLOAQ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:16:58 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:16:57 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: David Given <dg@cowlark.com>

Currently there is no generic way to derive phy
type information from the instruction flow.
---
 linearize.c |    4 +++-
 linearize.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/linearize.c b/linearize.c
index fce1ae8..526a710 100644
--- a/linearize.c
+++ b/linearize.c
@@ -55,7 +55,9 @@ static inline int type_size(struct symbol *type)
 
 static struct instruction *alloc_typed_instruction(int opcode, struct symbol *type)
 {
-	return alloc_instruction(opcode, type_size(type));
+	struct instruction *insn = alloc_instruction(opcode, type_size(type));
+	insn->type = type;
+	return insn;
 }
 
 static struct entrypoint *alloc_entrypoint(void)
diff --git a/linearize.h b/linearize.h
index 32b1c1a..0c5e4ef 100644
--- a/linearize.h
+++ b/linearize.h
@@ -71,6 +71,7 @@ struct instruction {
 		 size:24;
 	struct basic_block *bb;
 	struct position pos;
+	struct symbol *type;
 	union {
 		pseudo_t target;
 		pseudo_t cond;		/* for branch and switch */

