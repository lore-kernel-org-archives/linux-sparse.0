From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 14:59:23 +0200
Message-ID: <200908111459.23341.kdudka@redhat.com>
References: <200908072227.08652.kdudka@redhat.com> <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com> <154e089b0908110548t33b9114ej4bf3a019ee6ab80e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rsWgK/MkOv0fS24"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:42913 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbZHKM76 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 08:59:58 -0400
In-Reply-To: <154e089b0908110548t33b9114ej4bf3a019ee6ab80e@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Christopher Li <sparse@chrisli.org>, sparse <linux-sparse@vger.kernel.org>

--Boundary-00=_rsWgK/MkOv0fS24
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 11 of August 2009 14:48:39 Hannes Eder wrote:
> What about just using some forward decls instead of including the header
> files?
>
> e.g. for compile.h it is enough to have a "struct symbol;" there
> instead of the "#include <symbol.h>" to make it self-compilable.

Thanks for the hint! It's definitely better, though not sufficient in all 
cases. The amended patch is attached.

Kamil

--Boundary-00=_rsWgK/MkOv0fS24
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-make-sparse-headers-self-compilable.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-make-sparse-headers-self-compilable.patch"

=46rom 93455c6fe7dc84e1519bec70a9fd8625a879d791 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Tue, 11 Aug 2009 14:56:53 +0200
Subject: [PATCH] make sparse headers self-compilable...

=2E.. and thus possible to include them in arbitrary order and without any
external dependencies.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 compile.h |    2 ++
 flow.h    |    5 +++++
 ptrlist.h |    2 ++
 scope.h   |    2 ++
 storage.h |    3 +++
 5 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/compile.h b/compile.h
index 0db8fdb..177363a 100644
=2D-- a/compile.h
+++ b/compile.h
@@ -1,6 +1,8 @@
 #ifndef COMPILE_H
 #define COMPILE_H
=20
+struct symbol;
+
 extern void emit_one_symbol(struct symbol *);
 extern void emit_unit_begin(const char *);
 extern void emit_unit_end(void);
diff --git a/flow.h b/flow.h
index fbc9505..370aadd 100644
=2D-- a/flow.h
+++ b/flow.h
@@ -1,11 +1,16 @@
 #ifndef FLOW_H
 #define FLOW_H
=20
+#include "lib.h"
+
 extern unsigned long bb_generation;
=20
 #define REPEAT_CSE		1
 #define REPEAT_SYMBOL_CLEANUP	2
=20
+struct entrypoint;
+struct instruction;
+
 extern int simplify_flow(struct entrypoint *ep);
=20
 extern void simplify_symbol_usage(struct entrypoint *ep);
diff --git a/ptrlist.h b/ptrlist.h
index dae0906..fbfc080 100644
=2D-- a/ptrlist.h
+++ b/ptrlist.h
@@ -1,6 +1,8 @@
 #ifndef PTR_LIST_H
 #define PTR_LIST_H
=20
+#include <stdlib.h>
+
 /*
  * Generic pointer list manipulation code.=20
  *
diff --git a/scope.h b/scope.h
index 5f1f232..0fab286 100644
=2D-- a/scope.h
+++ b/scope.h
@@ -9,6 +9,8 @@
  *  Licensed under the Open Software License version 1.1
  */
=20
+struct symbol;
+
 struct scope {
 	struct token *token;		/* Scope start information */
 	struct symbol_list *symbols;	/* List of symbols in this scope */
diff --git a/storage.h b/storage.h
index 610cbfd..e049e23 100644
=2D-- a/storage.h
+++ b/storage.h
@@ -1,6 +1,9 @@
 #ifndef STORAGE_H
 #define STORAGE_H
=20
+#include "allocate.h"
+#include "lib.h"
+
 /*
  * The "storage" that underlies an incoming/outgoing pseudo. It's
  * basically the backing store for a pseudo, and may be a real hardware
=2D-=20
1.6.4


--Boundary-00=_rsWgK/MkOv0fS24--
