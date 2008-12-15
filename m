From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 10/15] Looks more evident this way.
Date: Mon, 15 Dec 2008 03:27:11 +0300
Message-ID: <20081215002711.16107.92359.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63676 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYLOASA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:18:00 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1154922bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:59 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 symbol.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/symbol.c b/symbol.c
index 49560ee..4da253b 100644
--- a/symbol.c
+++ b/symbol.c
@@ -49,7 +49,7 @@ struct symbol *lookup_symbol(struct ident *ident, enum namespace ns)
 			return sym;
 		}
 	}
-	return sym;
+	return NULL;
 }
 
 struct context *alloc_context(void)

