From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 06 Mar 2013 13:41:18 -0800
Message-ID: <1362606078.2093.10.camel@joe-AO722>
References: <1362590578.1759.48.camel@joe-AO722>
	 <CANeU7QmO=RoOraB0u52CLhzBbksw83SWR74S9-jHoN7xbf-W9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:53689 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752551Ab3CFVlT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Mar 2013 16:41:19 -0500
In-Reply-To: <CANeU7QmO=RoOraB0u52CLhzBbksw83SWR74S9-jHoN7xbf-W9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Wed, 2013-03-06 at 13:19 -0800, Christopher Li wrote:
> On Wed, Mar 6, 2013 at 9:22 AM, Joe Perches <joe@perches.com> wrote:
> > There's no current way to know the version
> > of sparse.  Add --version to see it.
> 
> Hi Joe,

Hi Chris.
> I agree that this the "--version" switch has its value.
> However, I don't like using "die" to print out the version string.
> I see no reason why sparse should exit with error for printing
> out version string. For example, gcc does not do that.
> 
> If you don't want to recompile lib.c every time, you can make
> a version.c to store the version string.
> 
> Another thing is nice to have, but not required.
> You consider to give "--" its own handing function. It is bit odd
> seeing the "-version" mix with other switch command. The
> patch is simpler. Either way is fine with me.
> 
> The exit code need to be fixed.
> 
> I will apply the patch once you fix the exit code.

This still doesn't recompile lib.o every time.

Maybe:
---
 Makefile | 10 +++++++++-
 lib.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b195528..e7db639 100644
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
diff --git a/lib.c b/lib.c
index 4f69e11..f1c284f 100644
--- a/lib.c
+++ b/lib.c
@@ -646,11 +646,39 @@ static char **handle_base_dir(char *arg, char **next)
 	return next;
 }
 
+static char **handle_version(char *arg, char **next)
+{
+	printf("%s\n", SPARSE_VERSION);
+	return next;
+}
+
 struct switches {
 	const char *name;
 	char **(*fn)(char *, char **);
 };
 
+static char **handle_options(char *arg, char **next)
+{
+	static struct switches cmd[] = {
+		{ "version", handle_version },
+		{ NULL, NULL }
+	};
+	struct switches *s;
+
+	s = cmd;
+	while (s->name) {
+		if (!strcmp(s->name, arg))
+			return s->fn(arg, next);
+		s++;
+	}
+
+	/*
+	 * Ignore unknown command line options:
+	 * they're probably gcc switches
+	 */
+	return next;
+}
+
 static char **handle_switch(char *arg, char **next)
 {
 	static struct switches cmd[] = {
@@ -952,6 +980,10 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 		if (!arg)
 			break;
 
+		if (arg[0] == '-' && arg[1] == '-' && arg[2]) {
+			args = handle_options(arg+2, args);
+			continue;
+		}
 		if (arg[0] == '-' && arg[1]) {
 			args = handle_switch(arg+1, args);
 			continue;


