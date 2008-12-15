From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 08/15] Make show_symbol newline-consistent
Date: Mon, 15 Dec 2008 03:26:54 +0300
Message-ID: <20081215002654.16107.8841.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:24915 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbYLOARn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:17:43 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1361957fkq.5
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:41 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 show-parse.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index c79a288..99795e8 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -390,8 +390,10 @@ void show_symbol(struct symbol *sym)
 
 	show_type(sym);
 	type = sym->ctype.base_type;
-	if (!type)
+	if (!type) {
+		printf("\n");
 		return;
+	}
 
 	/*
 	 * Show actual implementation information
@@ -410,9 +412,9 @@ void show_symbol(struct symbol *sym)
 
 	case SYM_FN: {
 		struct statement *stmt = type->stmt;
+		printf("\n");
 		if (stmt) {
 			int val;
-			printf("\n");		
 			val = show_statement(stmt);
 			if (val)
 				printf("\tmov.%d\t\tretval,%d\n", stmt->ret->bit_size, val);
@@ -422,6 +424,7 @@ void show_symbol(struct symbol *sym)
 	}
 
 	default:
+		printf("\n");
 		break;
 	}
 

