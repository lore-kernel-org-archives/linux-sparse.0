From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH] build: assign extra flags to ALL_CFLAGS instead of
 CFLAGS
Date: Thu, 19 Oct 2017 06:41:35 -0400
Message-ID: <1508409695.4912.7.camel@poochiereds.net>
References: <20171018150727.26821-1-jlayton@kernel.org>
         <CANeU7QmPgxKqjZpvudX_MYwhwGWx6nnZrats3brDMVvUUvBTFg@mail.gmail.com>
         <1508358019.4628.35.camel@poochiereds.net>
         <CANeU7QnRU7EgQTX1DiDHQj7JZBeKs2ZAeHKKSJNQxhKPXwoKjA@mail.gmail.com>
         <1508377663.19876.20.camel@poochiereds.net>
         <CANeU7Q=L53pByr1a7iFj-hzvGb_kHiW92tpUgThyE9QeYdCbzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:47065 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdJSKli (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 19 Oct 2017 06:41:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id t71so3079629ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 19 Oct 2017 03:41:38 -0700 (PDT)
In-Reply-To: <CANeU7Q=L53pByr1a7iFj-hzvGb_kHiW92tpUgThyE9QeYdCbzg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Wed, 2017-10-18 at 19:25 -0700, Christopher Li wrote:
> On Wed, Oct 18, 2017 at 6:47 PM, Jeff Layton <jlayton@poochiereds.net> wrote:
> > 
> > No, it wasn't intentional. Could we just turn that into a +=
> > assignment?
> 
> No, turn that into += does not work either. The variable come from
> command line has the $(origin varname) set to "command line".
> make will ignore normal modification to that variable, including "+="
> 
> If you really need to make modification of that variable.
> You need to use the "override" directive.
> 
> https://www.gnu.org/software/make/manual/make.html
> 
>      6.7 The override Directive
> 
> override CFLAGS += "...."
> 
> For that reason, I would suggest using a different variable
> to assign from the command line.
> 
> > 
> > Got it, thanks. Basically I just need a way to pass in a basic set of
> > flags to gcc, that are either appended or prepended to whatever you
> > need to have in there. If we need to call it something other than
> > CFLAGS, then that's fine.
> 
> Right. Given any makefile, I can always pick some internal variable,
> assign that variable from command line, then the make process does
> not work as intended. In our case, CFLAGS is such a variable.
> 
> I would suggest have one variable like CFLAGS_CMD to get
> overwrite from command line. You can suggest the variable name.
> 
> You should also examine your rpmbuild script for other open
> source packages. Weather they suffer from the same CFLAGS overwrite
> problems.
> 

I don't think it's generally a problem. Most of them use autotools or
cmake, which handle this correctly. This is mainly an issue with hand-
rolled makefiles.

> Again, patch is welcome.

Ok, how about this instead? This changes the makefile to just use
BASIC_CFLAGS internally. If CFLAGS is specified on the command line,
it's appended to the list of options.

This allows us to stick with passing in CFLAGS= to make during the build
process:

---------------------8<-------------------------

[PATCH] build: clean up CFLAGS handling in the makefile

The fedora packaging tools want to override $CFLAGS when building
sparse, but that fails on a couple of targets. There are a couple of
build targets in the makefile that want to add options to $CFLAGS.  When
we do a build though, we pass $ALL_CFLAGS to the compiler, and that ends
up without those extra options, if CFLAGS= was specified on the command
line. Change the code to append the options to ALL_CFLAGS instead of
CFLAGS.

At the same time, passing a CFLAGS argument to make ends up the initial
CFLAGS assignment being clobbered such that we lose the options that
are assigned to it internally. Fold the internal usage of CFLAGS into
BASIC_CFLAGS. They both just end up as part of ALL_CFLAGS anyway, so
this should be functionally equivalent.

Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d0341764158e..335dcfff54ce 100644
--- a/Makefile
+++ b/Makefile
@@ -12,8 +12,8 @@ OS = linux
 
 
 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
-CFLAGS += -Wall -Wwrite-strings
+BASIC_CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+BASIC_CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 LD = gcc
 AR = ar
@@ -21,7 +21,7 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
 
-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
+ALL_CFLAGS = $(BASIC_CFLAGS) $(CFLAGS)
 #
 # For debugging, put this in local.mk:
 #
@@ -44,7 +44,7 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+BASIC_CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
@@ -83,7 +83,7 @@ PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): ALL_CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -208,7 +208,7 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
+c2xml.o c2xml.sc: ALL_CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
-- 
2.13.6

