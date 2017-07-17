From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: suppress pkg-config output from make
Date: Mon, 17 Jul 2017 15:41:44 +0100
Message-ID: <8a9ee6b0-93e6-86fa-c572-8c74cc4be597@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:56491 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdGQOlr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 10:41:47 -0400
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Commit 2a4b245052 ("Makefile: clean up and simplify", 15-07-2017), moved
a PKG_CONFIG invocation from command scope to a top-level make variable
setting. For users who don't have libxml installed, this results in
pkg-config issuing warning messages on _each_ invocation of make:

  $ make
  ...
  Package libxml-2.0 was not found in the pkg-config search path.
  Perhaps you should add the directory containing `libxml-2.0.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'libxml-2.0' found
  ...
  $

In order to suppress the message, move the LIBXML_CFLAGS make variable
setting into the $(HAVE_LIBXML) conditional.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christopher,

I like the 'selfcheck' (dog-fooding) target - many years ago I had
patches to make sparse run clean on itself (both Linux and Cygwin).
I didn't get around to getting all of them upstream. I just tried
a selfcheck on cygwin and Linux and neither were clean. ;-)

ATB,
Ramsay Jones

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ae81586..4214e17 100644
--- a/Makefile
+++ b/Makefile
@@ -62,6 +62,7 @@ ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
 c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
+LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -194,7 +195,6 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
 %.o: %.c $(LIB_H)
-- 
2.13.0
