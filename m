From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] fix: accept 'sparse -D M...'
Date: Wed, 13 Dec 2017 18:15:27 +0100
Message-ID: <20171213171531.43707-3-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41021 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbdLMRPq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:15:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so6512776wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:15:45 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Till now, sparse was unneedlessly strict in what it accepted in
'-D' options. More specifically, it doesn't accept:
1) separated '-D' and the macro definition, like:
	sparse -D MACRO[=definition] ...
2) a space between the '-D' and the macro name, like:
	sparse '-D MACRO[=definition] ...

Case 1) is clearly accepted by GCC, clang and should be
accepted for a POSIX's c99. Case 2's status is less clear
but is also accepted by GCC and clang (leaving any validation
to the corresponding internal #define).

Fix this by accepting separated command line argument for '-D'
and the macro (and removing the check that rejected the macro
part if it started with a space).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                               | 12 ++++++++----
 validation/preprocessor/cli-D-arg.c |  1 -
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib.c b/lib.c
index 037206f72..236d58fc9 100644
--- a/lib.c
+++ b/lib.c
@@ -323,12 +323,16 @@ static char **handle_switch_D(char *arg, char **next)
 	const char *name = arg + 1;
 	const char *value = "1";
 
-	if (!*name || isspace((unsigned char)*name))
-		die("argument to `-D' is missing");
+	if (!*name) {
+		arg = *++next;
+		if (!arg)
+			die("argument to `-D' is missing");
+		name = arg;
+	}
 
-	for (;;) {
+	for (;;arg++) {
 		char c;
-		c = *++arg;
+		c = *arg;
 		if (!c)
 			break;
 		if (isspace((unsigned char)c) || c == '=') {
diff --git a/validation/preprocessor/cli-D-arg.c b/validation/preprocessor/cli-D-arg.c
index b098e98bd..03c5bac34 100644
--- a/validation/preprocessor/cli-D-arg.c
+++ b/validation/preprocessor/cli-D-arg.c
@@ -3,7 +3,6 @@ B
 /*
  * check-name: cli: -D MACRO
  * check-command: sparse -E -D A -D B=abc $file
- * check-known-to-fail
  *
  * check-output-start
 
-- 
2.15.0

