From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 09/15] Handle a terminal -o option properly.
Date: Mon, 15 Dec 2008 03:27:02 +0300
Message-ID: <20081215002702.16107.31316.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:24915 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbYLOARv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:17:51 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1361957fkq.5
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:17:50 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib.c b/lib.c
index ea40ce1..665a6b7 100644
--- a/lib.c
+++ b/lib.c
@@ -347,10 +347,13 @@ static char **handle_switch_m(char *arg, char **next)
 
 static char **handle_switch_o(char *arg, char **next)
 {
-	if (!strcmp (arg, "o") && *next)
-		return next + 1; // "-o foo"
-	else
-		return next;     // "-ofoo" or (bogus) terminal "-o"
+	if (!strcmp (arg, "o")) {       // "-o foo"
+		if (!*++next)
+			die("argument to '-o' is missing");
+	}
+	// else "-ofoo"
+
+	return next;
 }
 
 static const struct warning {

