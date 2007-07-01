From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] make size_t better approximate the reality
Date: Sun, 1 Jul 2007 08:49:53 +0100
Message-ID: <20070701074953.GC1101@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33476 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbXGAHty (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jul 2007 03:49:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I4uBt-0000PG-J8
	for linux-sparse@vger.kernel.org; Sun, 01 Jul 2007 08:49:53 +0100
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 26 Jun 2007 17:41:27 -0400
Subject: [PATCH] make size_t better approximate the reality

Instead of "always unsigned long" go for "unsigned int unless
-m64 is given, unsigned long otherwise".  Add an option (-msize-long)
forcing to unsigned long regardless.  Make __SIZE_TYPE__ expansion
match that.

The thing is, addition of checks on comparisons make for very unhappy
min() on (kernel) size_t and sizeof(something) on the targets where
the former is unsigned int.  Which is to say, more than half of them...
AFAICS, the only place needing explicit -msize-long in CHECK_FLAGS
is s390 (it's using unsigned long both for 31- and 64-bit).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib.c    |   10 +++++++++-
 target.c |    4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib.c b/lib.c
index 7fea474..efba3d4 100644
--- a/lib.c
+++ b/lib.c
@@ -325,6 +325,11 @@ static char **handle_switch_m(char *arg, char **next)
 		max_int_alignment = 8;
 		bits_in_pointer = 64;
 		pointer_alignment = 8;
+		size_t_ctype = &ulong_ctype;
+		ssize_t_ctype = &long_ctype;
+	} else if (!strcmp(arg, "msize-long")) {
+		size_t_ctype = &ulong_ctype;
+		ssize_t_ctype = &long_ctype;
 	}
 	return next;
 }
@@ -599,7 +604,10 @@ void create_builtin_stream(void)
 	// it is "long unsigned int".  In either case we can probably
 	// get away with this.  We need the #weak_define as cgcc will define
 	// the right __SIZE_TYPE__.
-	add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
+	if (size_t_ctype == &ulong_ctype)
+		add_pre_buffer("#weak_define __SIZE_TYPE__ long unsigned int\n");
+	else
+		add_pre_buffer("#weak_define __SIZE_TYPE__ unsigned int\n");
 	add_pre_buffer("#weak_define __STDC__ 1\n");
 
 	add_pre_buffer("#define __builtin_stdarg_start(a,b) ((a) = (__builtin_va_list)(&(b)))\n");
diff --git a/target.c b/target.c
index 22e948e..bf1bb8f 100644
--- a/target.c
+++ b/target.c
@@ -3,8 +3,8 @@
 #include "symbol.h"
 #include "target.h"
 
-struct symbol *size_t_ctype = &ulong_ctype;
-struct symbol *ssize_t_ctype = &long_ctype;
+struct symbol *size_t_ctype = &uint_ctype;
+struct symbol *ssize_t_ctype = &int_ctype;
 
 /*
  * For "__attribute__((aligned))"
-- 
1.5.0-rc2.GIT
