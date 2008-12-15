From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 12/15] Handle missing argument to -D.
Date: Mon, 15 Dec 2008 03:27:29 +0300
Message-ID: <20081215002729.16107.46489.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48930 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYLOAZD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:25:03 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so1159553bwz.13
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:25:02 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index 965fbfb..8dadfa9 100644
--- a/lib.c
+++ b/lib.c
@@ -248,6 +248,10 @@ static char **handle_switch_D(char *arg, char **next)
 {
 	const char *name = arg + 1;
 	const char *value = "1";
+
+	if (!*name || isspace(*name))
+		die("argument to `-D' is missing");
+
 	for (;;) {
 		char c;
 		c = *++arg;

