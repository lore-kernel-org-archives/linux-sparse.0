From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 08/16] Add test for acquire/release
Date: Fri, 19 Dec 2008 01:33:11 +0300
Message-ID: <20081218223237.23692.62518.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:5655 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYLRWX6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:23:58 -0500
Received: by ey-out-2122.google.com with SMTP id 22so46333eye.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:23:56 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

	Test that giving
	__attribute__((context(TEST,1,0)))
	__attribute__((context(TEST,0,1)))
instead of
	__attribute__((context(TEST,1,1)))
works.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 validation/context.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/validation/context.c b/validation/context.c
index 0b45ba3..e8bb125 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -380,6 +380,21 @@ static int warn_conditional(void)
     return 0;
 }
 
+static void good_require(void)
+__attribute__((context(TEST,1,0)))
+__attribute__((context(TEST,0,1)))
+{
+    __context__(TEST,-1);
+    __context__(TEST,1);
+}
+
+static void good_require_caller(void)
+{
+    __context__(TEST,1,0);
+    good_require();
+    __context__(TEST,-1,1);
+}
+
 /*
  * check-name: Check -Wcontext
  *

