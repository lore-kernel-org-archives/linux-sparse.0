From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] lib.c: introduce split_value_from_arg helper
Date: Tue, 17 Jun 2014 12:11:45 +0300
Message-ID: <1402996306-6811-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1402996306-6811-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402996306-6811-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-sparse@vger.kernel.org

The function tries to split a key / value from the given argument where
delimiter can be either ' ' (space) or '=' (equal sign).

It will be useful later as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib.c b/lib.c
index bf3e91c..4e5a846 100644
--- a/lib.c
+++ b/lib.c
@@ -275,14 +275,8 @@ void add_pre_buffer(const char *fmt, ...)
 	pre_buffer_end = end;
 }
 
-static char **handle_switch_D(char *arg, char **next)
+static const char *split_value_from_arg(char *arg, const char *def)
 {
-	const char *name = arg + 1;
-	const char *value = "1";
-
-	if (!*name || isspace(*name))
-		die("argument to `-D' is missing");
-
 	for (;;) {
 		char c;
 		c = *++arg;
@@ -290,10 +284,21 @@ static char **handle_switch_D(char *arg, char **next)
 			break;
 		if (isspace((unsigned char)c) || c == '=') {
 			*arg = '\0';
-			value = arg + 1;
-			break;
+			return arg + 1;
 		}
 	}
+	return def;
+}
+
+static char **handle_switch_D(char *arg, char **next)
+{
+	const char *name = arg + 1;
+	const char *value = "1";
+
+	if (!*name || isspace(*name))
+		die("argument to `-D' is missing");
+
+	value = split_value_from_arg(arg, value);
 	add_pre_buffer("#define %s %s\n", name, value);
 	return next;
 }
-- 
2.0.0
