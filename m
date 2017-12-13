From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] fix: spaces in macro definition on the command line
Date: Wed, 13 Dec 2017 18:15:31 +0100
Message-ID: <20171213171531.43707-7-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35828 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbdLMRQD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:16:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id f9so6641445wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:16:02 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

GCC's manual or POSIX say about the '-D' option something like:
    '−D name[=value]' should be treated as if in directive
    '#define name value' (with '1' as default for the value),
    including its tokenization.
So an option like '-DM(X, Y)=...' should be processed like a
directive '#define M(X, Y) ...'.

However, the current code treat a space as a separator between
the macro and its definition, just like the '='. As consequence,
the above option is processed like the directive would be
'#define M(X, Y)=...', with 'M(X,' as the macro (name) and
'Y)=...' as its definition.

Fix this by stopping to treat the space character specially,
thus only using '=' as the separator.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                                 | 2 +-
 validation/preprocessor/cli-D-space.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 236d58fc9..e4bb639e5 100644
--- a/lib.c
+++ b/lib.c
@@ -335,7 +335,7 @@ static char **handle_switch_D(char *arg, char **next)
 		c = *arg;
 		if (!c)
 			break;
-		if (isspace((unsigned char)c) || c == '=') {
+		if (c == '=') {
 			*arg = '\0';
 			value = arg + 1;
 			break;
diff --git a/validation/preprocessor/cli-D-space.c b/validation/preprocessor/cli-D-space.c
index d104d66da..8343bf1ac 100644
--- a/validation/preprocessor/cli-D-space.c
+++ b/validation/preprocessor/cli-D-space.c
@@ -2,7 +2,6 @@ M(0,1)
 /*
  * check-name: cli: allow spaces in macros
  * check-command: sparse -E '-DM(X, Y)=a' $file
- * check-known-to-fail
  *
  * check-output-start
 
-- 
2.15.0

