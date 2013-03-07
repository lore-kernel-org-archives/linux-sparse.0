From: Chris Li <christ.li@gmail.com>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 6 Mar 2013 20:18:05 -0800
Message-ID: <CANeU7Q=vsxomdNSjy+84eTAnRq1OVXynpfkKqfkFGkYhF-FEmw@mail.gmail.com>
References: <1362590578.1759.48.camel@joe-AO722>
	<20130306214550.GA8486@jtriplet-mobl1>
	<1362607043.2093.19.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:43317 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab3CGESH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 23:18:07 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so59907oag.4
        for <linux-sparse@vger.kernel.org>; Wed, 06 Mar 2013 20:18:06 -0800 (PST)
In-Reply-To: <1362607043.2093.19.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

>
> This still doesn't recompile lib.o every time.
>
Ah, I finally get it what you mean the lib.o did not compile every
time. Here I add a new header file "version.h" which store the
SPARSE_VERSION. The makefile will regenerate the version.h
if it does not match the current 'git-describe'. Now lib.o will
recompile every time you change git branch.

Joe, I miss your sign off from the patch. Can you sign off on the patch?


> The "dist" target already has a call to "git describe"; could you unify
> the two?  (And, ideally, avoid calling git describe twice, once for
> HAVE_GIT and once for SPARSE_VERSION?)

That is a very good point. I make change the Makefile to only evaluate it once.

Chris

[PATCH] There's no current way to know the version of sparse.  Add
 --version to see it.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 10 +++++++++-
 lib.c    | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b195528..35e3801 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,13 @@
 VERSION=0.4.4

+# Generating file version.h if current version has changed
+SPARSE_VERSION:=$(shell git describe 2>/dev/null || echo '$(VERSION)')
+VERSION_H := $(shell cat version.h 2>/dev/null)
+ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
+$(info $(shell echo '     GEN      'version.h))
+$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h)
+endif
+
 OS = linux


@@ -191,7 +199,7 @@ clean: clean-check
 	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc

 dist:
-	@if test "`git describe`" != "v$(VERSION)" ; then \
+	@if test "v$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
 		echo 'Update VERSION in the Makefile before running "make dist".' ; \
 		exit 1 ; \
 	fi
diff --git a/lib.c b/lib.c
index 4f69e11..5e65a0c 100644
--- a/lib.c
+++ b/lib.c
@@ -27,6 +27,7 @@
 #include "scope.h"
 #include "linearize.h"
 #include "target.h"
+#include "version.h"

 int verbose, optimize, optimize_size, preprocessing;
 int die_if_error = 0;
@@ -646,11 +647,34 @@ static char **handle_base_dir(char *arg, char **next)
 	return next;
 }

+static char **handle_version(char *arg, char **next)
+{
+	printf("%s\n", SPARSE_VERSION);
+	exit(0);
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
 };

+static char **handle_long_options(char *arg, char **next)
+{
+	static struct switches cmd[] = {
+		{ "version", handle_version },
+		{ NULL, NULL }
+	};
+	struct switches *s = cmd;
+
+	while (s->name) {
+		if (!strcmp(s->name, arg))
+			return s->fn(arg, next);
+		s++;
+	}
+	return next;
+
+}
+
 static char **handle_switch(char *arg, char **next)
 {
 	static struct switches cmd[] = {
@@ -676,6 +700,7 @@ static char **handle_switch(char *arg, char **next)
 	case 'G': return handle_switch_G(arg, next);
 	case 'a': return handle_switch_a(arg, next);
 	case 's': return handle_switch_s(arg, next);
+	case '-': return handle_long_options(arg + 1, next);
 	default:
 		break;
 	}
-- 
1.8.1.2
