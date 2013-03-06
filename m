From: Joe Perches <joe@perches.com>
Subject: [RFC PATCH] sparse: Add cmd line  --version option
Date: Wed, 06 Mar 2013 09:22:58 -0800
Message-ID: <1362590578.1759.48.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:47440 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752799Ab3CFRW7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 12:22:59 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.152])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 20768648 for linux-sparse@vger.kernel.org; Wed, 06 Mar 2013 09:22:59 -0800
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

There's no current way to know the version
of sparse.  Add --version to see it.

---

I'm not at all tied to this implementation
but it's always nice to be able to see what
version is being used.

Likely it needs something to always recompile
lib.o whenever appropriate.

 Makefile | 11 +++++++++--
 lib.c    |  7 +++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b195528..8d2ffea 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,12 @@
 VERSION=0.4.4
 
+HAVE_GIT:=$(shell git describe >/dev/null 2>&1 && echo 'yes')
+ifeq ($(HAVE_GIT),yes)
+SPARSE_VERSION=$(shell git describe)
+else
+SPARSE_VERSION=$(VERSION)
+endif
+
 OS = linux
 
 
@@ -27,7 +34,8 @@ HAVE_LLVM_VERSION:=$(shell llvm-config --version | grep "^[3-9].*" >/dev/null 2>
 LLVM_VERSION=$(shell llvm-config --version)
 
 GCC_BASE = $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\" \
+	       -DSPARSE_VERSION=\"$(SPARSE_VERSION)\"
 
 ifeq ($(HAVE_GCC_DEP),yes)
 BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
@@ -160,7 +168,6 @@ install: all-installable
 sparse.pc: sparse.pc.in
 	$(QUIET_GEN)sed $(SED_PC_CMD) sparse.pc.in > sparse.pc
 
-
 compile_EXTRA_DEPS = compile-i386.o
 
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
diff --git a/lib.c b/lib.c
index 4f69e11..ddc9a93 100644
--- a/lib.c
+++ b/lib.c
@@ -646,6 +646,12 @@ static char **handle_base_dir(char *arg, char **next)
 	return next;
 }
 
+static char **handle_version(char *arg, char **next)
+{
+	die("%s", SPARSE_VERSION);
+	return next;
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
@@ -656,6 +662,7 @@ static char **handle_switch(char *arg, char **next)
 	static struct switches cmd[] = {
 		{ "nostdinc", handle_nostdinc },
 		{ "gcc-base-dir", handle_base_dir},
+		{ "-version", handle_version },
 		{ NULL, NULL }
 	};
 	struct switches *s;


