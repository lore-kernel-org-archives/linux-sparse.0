From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH] sparse: Increase pre_buffer[] and check overflow
Date: Wed, 09 Jul 2008 00:28:05 +0900 (JST)
Message-ID: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-sparse@vger.kernel.org
Cc: linux-mips@linux-mips.org
List-Id: linux-sparse@vger.kernel.org

I got this error when running sparse on mips kernel with gcc 4.3:

builtin:272:1: warning: Newline in string or character constant

The linus-mips kernel uses '$(CC) -dM -E' to generates arguments for
sparse.  With gcc 4.3, it generates lot of '-D' options and causes
pre_buffer overflow.

This patch increase pre_buffer[] size and add extra checking for
overflow instead of silently truncating.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/lib.c b/lib.c
index 0abcc9a..b8b2d57 100644
--- a/lib.c
+++ b/lib.c
@@ -186,7 +186,7 @@ void die(const char *fmt, ...)
 }
 
 static unsigned int pre_buffer_size;
-static char pre_buffer[8192];
+static char pre_buffer[16384];
 
 int Waddress_space = 1;
 int Wbitwise = 0;
@@ -238,6 +238,8 @@ void add_pre_buffer(const char *fmt, ...)
 		fmt, args);
 	pre_buffer_size = size;
 	va_end(args);
+	if (pre_buffer_size >= sizeof(pre_buffer) - 1)
+		die("pre_buffer overflow");
 }
 
 static char **handle_switch_D(char *arg, char **next)
