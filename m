From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] lib.c: skip --param parameters
Date: Mon, 16 Jun 2014 13:43:06 +0300
Message-ID: <1402915386-28210-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-sparse@vger.kernel.org

Very dumb patch to just skip --param allow-store-data-races=0 introduced in
newest Linux kernel buildsystem.

Actually the option is present in few GCC versions and probably should be
handled properly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib.c b/lib.c
index bf3e91c..e56037b 100644
--- a/lib.c
+++ b/lib.c
@@ -673,6 +673,12 @@ static char **handle_version(char *arg, char **next)
 	exit(0);
 }
 
+static char **handle_param(char *arg, char **next)
+{
+	++next;
+	return ++next;
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
@@ -681,6 +687,7 @@ struct switches {
 static char **handle_long_options(char *arg, char **next)
 {
 	static struct switches cmd[] = {
+		{ "param", handle_param },
 		{ "version", handle_version },
 		{ NULL, NULL }
 	};
-- 
2.0.0
