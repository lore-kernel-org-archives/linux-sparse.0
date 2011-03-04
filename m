From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Makefile: warn user when libxml and/or libgtk2 are not available
Date: Fri, 4 Mar 2011 11:03:37 +0100
Message-ID: <201103041103.37512.f.fainelli@gmail.com>
References: <201103030957.59003.f.fainelli@gmail.com> <AANLkTiktoPx77xUo5tJR96zYECWFQnazRVary3joCekE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60711 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1CDKCO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 Mar 2011 05:02:14 -0500
Received: by wyg36 with SMTP id 36so1916440wyg.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 Mar 2011 02:02:13 -0800 (PST)
In-Reply-To: <AANLkTiktoPx77xUo5tJR96zYECWFQnazRVary3joCekE@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Thursday 03 March 2011 23:52:25 Christopher Li wrote:
> On Thu, Mar 3, 2011 at 12:57 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Since sparse's c2xml is not always packaged by modern distributions, it
> > can be built as a host package in build systems, finding out why c2xml
> > was not compiled turned out to be easier if a warning was emitted, add
> > two for libxml and libgtk2 presence/absence.
> 
> The change looks good. How about using $(warning ...) instead of $(info
> ..)?

Indeed, looks better. Updated patch below:
--
From: Florian Fainelli <f.fainelli@gmail.com>

Since sparse's c2xml is not always packaged my modern distributions, it can be
built as a host package in build systems, finding out why c2xml was not
compiled turned out to be easier if a warning was emitted, add two for libxml
and libgtk2 presence/absence.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes since v1:
- use $(warning ..) instead of $(info ..)

diff --git a/Makefile b/Makefile
index 74905df..701cdc9 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,8 @@ ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
 c2xml_EXTRA_OBJS = `pkg-config --libs libxml-2.0`
+else
+$(warning Your system does not have libxml, disabling c2xml)
 endif

 ifeq ($(HAVE_GTK2),yes)
@@ -55,6 +57,8 @@ INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect.o $(test-inspect_EXTRA_DEPS): CFLAGS += $(GTK2_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK2_LIBS)
+else
+$(warning Your system does not have libgtk2, disabling test-inspect)
 endif

 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
--
1.7.1

