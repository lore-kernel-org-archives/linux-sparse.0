From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] make sparse headers self-compilable...
Date: Fri, 7 Aug 2009 22:27:08 +0200
Message-ID: <200908072227.08652.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_c4IfKEAQe3HiagY"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:38643 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933755AbZHGU1h (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Aug 2009 16:27:37 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n77KRcs5029832
	for <linux-sparse@vger.kernel.org>; Fri, 7 Aug 2009 16:27:38 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n77KRbHV022144
	for <linux-sparse@vger.kernel.org>; Fri, 7 Aug 2009 16:27:38 -0400
Received: from vpn1-4-53.ams2.redhat.com (vpn1-4-53.ams2.redhat.com [10.36.4.53])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n77KRaRr003873
	for <linux-sparse@vger.kernel.org>; Fri, 7 Aug 2009 16:27:37 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_c4IfKEAQe3HiagY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

attached is another fix for SPARSE headers improving their sanity. I am
also attaching a simple test for the dependency tracking of headers. It's
not enough generic and portable and therefore not really useful. Maybe 
someone skilled in writing makefiles might want to include something like
that to the SPARSE Makefile as part of the 'check' target.

Kamil

--Boundary-00=_c4IfKEAQe3HiagY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-make-sparse-headers-self-compilable.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-make-sparse-headers-self-compilable.patch"

=46rom 8ffbb46652f69e662ce39c135f1867599c0f5477 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Fri, 7 Aug 2009 21:48:44 +0200
Subject: [PATCH] make sparse headers self-compilable...

=2E.. and thus possible to include them in arbitrary order and without any
external dependencies.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 compile.h |    2 ++
 flow.h    |    2 ++
 ptrlist.h |    2 ++
 scope.h   |    2 ++
 storage.h |    2 ++
 5 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/compile.h b/compile.h
index 0db8fdb..6c5260d 100644
=2D-- a/compile.h
+++ b/compile.h
@@ -1,6 +1,8 @@
 #ifndef COMPILE_H
 #define COMPILE_H
=20
+#include "symbol.h"
+
 extern void emit_one_symbol(struct symbol *);
 extern void emit_unit_begin(const char *);
 extern void emit_unit_end(void);
diff --git a/flow.h b/flow.h
index 9f2e165..241f081 100644
=2D-- a/flow.h
+++ b/flow.h
@@ -1,6 +1,8 @@
 #ifndef FLOW_H
 #define FLOW_H
=20
+#include "symbol.h"
+
 extern unsigned long bb_generation;
=20
 #define REPEAT_CSE		1
diff --git a/ptrlist.h b/ptrlist.h
index dae0906..85b23fc 100644
=2D-- a/ptrlist.h
+++ b/ptrlist.h
@@ -7,6 +7,8 @@
  * (C) Copyright Linus Torvalds 2003-2005
  */
=20
+#include <stdlib.h>
+
 #define container(ptr, type, member) \
 	(type *)((void *)(ptr) - offsetof(type, member))
=20
diff --git a/scope.h b/scope.h
index 5f1f232..aff7b6b 100644
=2D-- a/scope.h
+++ b/scope.h
@@ -9,6 +9,8 @@
  *  Licensed under the Open Software License version 1.1
  */
=20
+#include "symbol.h"
+
 struct scope {
 	struct token *token;		/* Scope start information */
 	struct symbol_list *symbols;	/* List of symbols in this scope */
diff --git a/storage.h b/storage.h
index 610cbfd..0d3bbc5 100644
=2D-- a/storage.h
+++ b/storage.h
@@ -1,6 +1,8 @@
 #ifndef STORAGE_H
 #define STORAGE_H
=20
+#include "lib.h"
+
 /*
  * The "storage" that underlies an incoming/outgoing pseudo. It's
  * basically the backing store for a pseudo, and may be a real hardware
=2D-=20
1.6.3.3


--Boundary-00=_c4IfKEAQe3HiagY
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="Makefile.chk"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile.chk"

# all SPARSE headers (except ident-list.h which is not an ordinary header)
HEADERS ?= \
	allocate.h \
	bitmap.h \
	compat.h \
	compile.h \
	dissect.h \
	expression.h \
	flow.h \
	lib.h \
	linearize.h \
	parse.h \
	ptrlist.h \
	scope.h \
	storage.h \
	symbol.h \
	target.h \
	token.h \

SINK ?= /dev/null

.PHONY: check $(HEADERS)

# check whether each header is self-compilable
check: $(HEADERS)
$(HEADERS):
	$(CC) -o $(SINK) -c $@

--Boundary-00=_c4IfKEAQe3HiagY--
