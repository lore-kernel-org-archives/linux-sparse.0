From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 01/15] Evaluate iterator symbols
Date: Mon, 15 Dec 2008 03:25:51 +0300
Message-ID: <20081215002551.16107.68533.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:24791 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbYLOAQl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:16:41 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1361842fkq.5
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:16:39 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

From: Christopher Li <sparse@chrisli.org>

evaluate.c forgets to evaluate iterator_syms, which
might have some expression in initializer.

Signed-Off-By: Christopher Li <sparse@chrisli.org>
---
 evaluate.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 2a126dd..e17da53 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3106,6 +3106,7 @@ static void evaluate_if_statement(struct statement *stmt)
 
 static void evaluate_iterator(struct statement *stmt)
 {
+	evaluate_symbol_list(stmt->iterator_syms);
 	evaluate_conditional(stmt->iterator_pre_condition, 1);
 	evaluate_conditional(stmt->iterator_post_condition,1);
 	evaluate_statement(stmt->iterator_pre_statement);

