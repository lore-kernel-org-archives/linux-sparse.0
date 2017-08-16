From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 17/29] ptrmap: core implementation
Date: Wed, 16 Aug 2017 17:34:43 +0200
Message-ID: <20170816153455.97693-18-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34072 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id x43so3698110wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:38 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse currently has a memory efficient implementation for lists
of pointers to some objects.

These are used for 2 different purposes:
- either for a simple set of objects
- either as a sequence (ordered) of objects.

Incoming develpment has another need:
- a map of object (aka: dictionnary, table, ...)
where the only needed operations are:
- add a new element (with it's key)
- replace the element corresponding to a key)
- lookup an element via it's key

The implementation done in this patch is a very simple one
based on list of blocks of key-value pairs.

The idea being to later switch to a dynamic structure using
a hash-table as soon as the number of element reach some threshold.
However, these hash-table are only needed for some huge
and artificial input files.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile |  1 +
 ptrmap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ptrmap.h | 12 ++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 ptrmap.c
 create mode 100644 ptrmap.h

diff --git a/Makefile b/Makefile
index 48e1f508f..762aee505 100644
--- a/Makefile
+++ b/Makefile
@@ -117,6 +117,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
+	  ptrmap.o \
 	  stats.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
diff --git a/ptrmap.c b/ptrmap.c
new file mode 100644
index 000000000..2a08380c9
--- /dev/null
+++ b/ptrmap.c
@@ -0,0 +1,84 @@
+#include "ptrmap.h"
+#include "allocate.h"
+#include <stddef.h>
+
+#define	MAP_NR	7
+
+struct ptrpair {
+	void *key;
+	void *val;
+};
+struct ptrmap {
+	struct ptrmap *next;
+	int nr;
+	struct ptrpair pairs[MAP_NR];
+};
+
+DECLARE_ALLOCATOR(ptrmap);
+ALLOCATOR(ptrmap, "ptrmap");
+
+void __ptrmap_add(struct ptrmap **mapp, void *key, void *val)
+{
+	struct ptrmap *head = *mapp;
+	struct ptrmap *newmap;
+	struct ptrmap *map;
+	struct ptrpair *pair;
+	int nr;
+
+	if ((map = head)) {
+		struct ptrmap *next = map->next;
+		if (next)		// head is full
+			map = next;
+		if ((nr = map->nr) < MAP_NR)
+			goto oldmap;
+	}
+
+	// need a new block
+	newmap = __alloc_ptrmap(0);
+	if (!head) {
+		*mapp = newmap;
+	} else {
+		newmap->next = head->next;
+		head->next = newmap;
+	}
+	map = newmap;
+	nr = 0;
+
+oldmap:
+	pair = &map->pairs[nr];
+	pair->key = key;
+	pair->val = val;
+	map->nr = ++nr;
+}
+
+void *__ptrmap_lookup(struct ptrmap *map, void *key)
+{
+	for (; map; map = map->next) {
+		int i, n = map->nr;
+		for (i = 0; i < n; i++) {
+			struct ptrpair *pair = &map->pairs[i];
+			if (pair->key == key)
+				return pair->val;
+		}
+	}
+	return NULL;
+}
+
+void __ptrmap_update(struct ptrmap **mapp, void *key, void *val)
+{
+	struct ptrmap *map = *mapp;
+
+	for (; map; map = map->next) {
+		int i, n = map->nr;
+		for (i = 0; i < n; i++) {
+			struct ptrpair *pair = &map->pairs[i];
+			if (pair->key == key) {
+				if (pair->val != val)
+					pair->val = val;
+				return;
+			}
+		}
+	}
+
+	__ptrmap_add(mapp, key, val);
+}
diff --git a/ptrmap.h b/ptrmap.h
new file mode 100644
index 000000000..070db15e2
--- /dev/null
+++ b/ptrmap.h
@@ -0,0 +1,12 @@
+#ifndef PTRMAP_H
+#define PTRMAP_H
+
+struct ptrmap;
+
+
+/* ptrmap.c */
+void __ptrmap_add(struct ptrmap **mapp, void *key, void *val);
+void __ptrmap_update(struct ptrmap **mapp, void *key, void *val);
+void *__ptrmap_lookup(struct ptrmap *map, void *key);
+
+#endif
-- 
2.14.0

