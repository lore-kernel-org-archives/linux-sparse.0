From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] C11: teach sparse about '--std={c11,gnu11}'
Date: Thu,  5 Jan 2017 04:22:20 +0100
Message-ID: <20170105032220.7339-6-luc.vanoostenryck@gmail.com>
References: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755250AbdAEDaF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:30:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so56118682wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:30:04 -0800 (PST)
In-Reply-To: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that support have been added for C11 new syntax we can accept
'--std={c11,gnu11}' no more dying with "Unsupported C dialect" message.
Also adjust __STDC_VERSION__ accordingly and define the few
associated feature macros (__STD_NO_ATOMICS__, ...).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                         | 21 +++++++++++++++++++++
 validation/c11-stdc-version.c | 11 +++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/c11-stdc-version.c

diff --git a/lib.c b/lib.c
index e5b0bb63..49ff6906 100644
--- a/lib.c
+++ b/lib.c
@@ -250,6 +250,8 @@ int preprocess_only;
 static enum { STANDARD_C89,
               STANDARD_C94,
               STANDARD_C99,
+              STANDARD_C11,
+              STANDARD_GNU11,
               STANDARD_GNU89,
               STANDARD_GNU99, } standard = STANDARD_GNU89;
 
@@ -574,6 +576,8 @@ static void handle_switch_W_finalize(void)
 			case STANDARD_C99:
 			case STANDARD_GNU89:
 			case STANDARD_GNU99:
+			case STANDARD_C11:
+			case STANDARD_GNU11:
 				Wdeclarationafterstatement = 0;
 				break;
 
@@ -679,6 +683,14 @@ static char **handle_switch_s(char *arg, char **next)
 		else if (!strcmp (arg, "gnu99") || !strcmp (arg, "gnu9x"))
 			standard = STANDARD_GNU99;
 
+		else if (!strcmp(arg, "c11") ||
+			 !strcmp(arg, "c1x") ||
+			 !strcmp(arg, "iso9899:2011"))
+			standard = STANDARD_C11;
+
+		else if (!strcmp(arg, "gnu11"))
+			standard = STANDARD_GNU11;
+
 		else
 			die ("Unsupported C dialect");
 	}
@@ -971,6 +983,15 @@ void create_builtin_stream(void)
 			add_pre_buffer("#weak_define __STDC_VERSION__ 199901L\n");
 			break;
 
+		case STANDARD_C11:
+			add_pre_buffer("#weak_define __STRICT_ANSI__ 1\n");
+		case STANDARD_GNU11:
+			add_pre_buffer("#weak_define __STDC_NO_ATOMICS__ 1\n");
+			add_pre_buffer("#weak_define __STDC_NO_COMPLEX__ 1\n");
+			add_pre_buffer("#weak_define __STDC_NO_THREADS__ 1\n");
+			add_pre_buffer("#weak_define __STDC_VERSION__ 201112L\n");
+			break;
+
 		default:
 			assert (0);
 	}
diff --git a/validation/c11-stdc-version.c b/validation/c11-stdc-version.c
new file mode 100644
index 00000000..3acedd19
--- /dev/null
+++ b/validation/c11-stdc-version.c
@@ -0,0 +1,11 @@
+__STDC_VERSION__
+
+/*
+ * check-name: c11-stdc-version
+ * check-command: sparse -E -std=c11 $file
+ *
+ * check-output-start
+
+201112L
+ * check-output-end
+ */
-- 
2.11.0

