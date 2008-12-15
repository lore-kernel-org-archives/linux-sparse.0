From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 11/15] Mark handle_switch as static and don't export it from
	lib.h
Date: Mon, 15 Dec 2008 03:27:20 +0300
Message-ID: <20081215002720.16107.99631.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:63881 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbYLOASK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:18:10 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1293836muf.1
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:18:08 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c |    2 +-
 lib.h |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 665a6b7..965fbfb 100644
--- a/lib.c
+++ b/lib.c
@@ -592,7 +592,7 @@ struct switches {
 	char **(*fn)(char *, char **);
 };
 
-char **handle_switch(char *arg, char **next)
+static char **handle_switch(char *arg, char **next)
 {
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
diff --git a/lib.h b/lib.h
index 42a3396..b22fa93 100644
--- a/lib.h
+++ b/lib.h
@@ -83,7 +83,6 @@ extern void sparse_error(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void error_die(struct position, const char *, ...) FORMAT_ATTR(2) NORETURN_ATTR;
 extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR(2);
 
-extern char **handle_switch(char *arg, char **next);
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 
 extern int preprocess_only;

