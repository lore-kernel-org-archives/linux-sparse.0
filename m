From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] memops.c: always true expression
Date: Sun, 21 Nov 2010 21:25:48 +0100
Message-ID: <20101121212548.6230da08@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:57283 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754993Ab0KUUbc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Nov 2010 15:31:32 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

I noticed that the second part of this conditional is always true.
Just a shot in the dark: Could that be a typo?

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 memops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/memops.c b/memops.c
index 9eafb72..45bd340 100644
--- a/memops.c
+++ b/memops.c
@@ -69,7 +69,7 @@ static int address_taken(pseudo_t pseudo)
 	struct pseudo_user *pu;
 	FOR_EACH_PTR(pseudo->users, pu) {
 		struct instruction *insn = pu->insn;
-		if (insn->bb && (insn->opcode != OP_LOAD || insn->opcode != OP_STORE))
+		if (insn->bb && (insn->opcode != OP_LOAD && insn->opcode != OP_STORE))
 			return 1;
 	} END_FOR_EACH_PTR(pu);
 	return 0;
-- 
1.7.2.2
