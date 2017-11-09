From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 26/37] build: use one line per item
Date: Thu,  9 Nov 2017 07:46:37 +0100
Message-ID: <20171109064648.15379-27-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47555 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGrm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so14827223wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:42 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This help to minimize merge conflicts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 0aaad52b3..4f6ab108c 100644
--- a/Makefile
+++ b/Makefile
@@ -29,17 +29,52 @@ MAN1DIR=$(MANDIR)/man1
 ########################################################################
 
 
-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
-	 test-linearize example test-unssa test-dissect ctags
+LIB_OBJS :=
+LIB_OBJS += allocate.o
+LIB_OBJS += builtin.o
+LIB_OBJS += char.o
+LIB_OBJS += compat-$(OS).o
+LIB_OBJS += cse.o
+LIB_OBJS += dissect.o
+LIB_OBJS += evaluate.o
+LIB_OBJS += expand.o
+LIB_OBJS += expression.o
+LIB_OBJS += flow.o
+LIB_OBJS += inline.o
+LIB_OBJS += lib.o
+LIB_OBJS += linearize.o
+LIB_OBJS += liveness.o
+LIB_OBJS += memops.o
+LIB_OBJS += parse.o
+LIB_OBJS += pre-process.o
+LIB_OBJS += ptrlist.o
+LIB_OBJS += scope.o
+LIB_OBJS += show-parse.o
+LIB_OBJS += simplify.o
+LIB_OBJS += sort.o
+LIB_OBJS += stats.o
+LIB_OBJS += storage.o
+LIB_OBJS += symbol.o
+LIB_OBJS += target.o
+LIB_OBJS += tokenize.o
+LIB_OBJS += unssa.o
+
+PROGRAMS :=
+PROGRAMS += compile
+PROGRAMS += ctags
+PROGRAMS += example
+PROGRAMS += graph
+PROGRAMS += obfuscate
+PROGRAMS += sparse
+PROGRAMS += test-dissect
+PROGRAMS += test-lexing
+PROGRAMS += test-linearize
+PROGRAMS += test-parsing
+PROGRAMS += test-unssa
+
 INST_PROGRAMS=sparse cgcc
 INST_MAN1=sparse.1 cgcc.1
 
-LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
-	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
-	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  builtin.o \
-	  stats.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 all:
 
-- 
2.14.0

