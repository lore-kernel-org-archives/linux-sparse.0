From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: Re: [PATCH] memops.c: fix load instruction simplification
Date: Sun, 10 Apr 2011 17:36:10 +0200
Message-ID: <4DA1CE6A.9000202@seznam.cz>
References: <4D9E37A4.8040902@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep20.mx.upcmail.net ([62.179.121.40]:59762 "EHLO
	fep20.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab1DJPgP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 10 Apr 2011 11:36:15 -0400
In-Reply-To: <4D9E37A4.8040902@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Semantically same as previous, I should have noticed that I can use pseudo
directly.  Also, may the assert denote the original intention?

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 memops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/memops.c b/memops.c
index 45bd340..3178af9 100644
--- a/memops.c
+++ b/memops.c
@@ -126,7 +126,7 @@ static void simplify_loads(struct basic_block *bb)
 				if (!dominators) {
 					if (local) {
 						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
+						convert_load_instruction(insn, pseudo);
 					}
 					goto next_load;
 				}
-- 
1.7.1
