From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] added a bunch of gcc builtins
Date: Sun, 1 Oct 2006 19:49:13 +0100
Message-ID: <20061001184913.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:22703 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932182AbWJAStO
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 14:49:14 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

[PATCH] added a bunch of gcc builtins

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

[getting rid of ancient patches sitting in my tree]

 lib.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib.c b/lib.c
index cd46e03..005aaa5 100644
--- a/lib.c
+++ b/lib.c
@@ -483,6 +483,16 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern void __builtin_trap(void);\n");
 	add_pre_buffer("extern int __builtin_ffs(int);\n");
 	add_pre_buffer("extern void *__builtin_alloca(__SIZE_TYPE__);\n");
+	add_pre_buffer("extern int __builtin_popcount(unsigned int);\n");
+	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
+	add_pre_buffer("extern void __builtin_prefetch (const void *, ...);\n");
+	add_pre_buffer("extern long __builtin_alpha_extbl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_extwl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_insbl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_inswl(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_insql(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_inslh(long, long);\n");
+	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 }
 
 void create_builtin_stream(void)
-- 
1.4.2.GIT
