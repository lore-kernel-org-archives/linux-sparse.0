From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] add get_<allocator>_stats()
Date: Wed, 12 Apr 2017 10:36:59 +0200
Message-ID: <20170412083703.11552-2-luc.vanoostenryck@gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34500 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdDLIht (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id x75so4882908wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:48 -0700 (PDT)
In-Reply-To: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There exists a function to display the stats from each allocator
but:
1) what it displays is a bit long and fixed
2) it doesn't allow to make totals and stuff.

Change this by adding a function that only collect the stats
from each allocator.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 allocate.c |  8 ++++++++
 allocate.h | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/allocate.c b/allocate.c
index f597caf16..daa4ac247 100644
--- a/allocate.c
+++ b/allocate.c
@@ -127,6 +127,14 @@ void show_allocations(struct allocator_struct *x)
 		(double) x->useful_bytes / x->allocations);
 }
 
+void get_allocator_stats(struct allocator_struct *x, struct allocator_stats *s)
+{
+	s->name = x->name;
+	s->allocations = x->allocations;
+	s->useful_bytes = x->useful_bytes;
+	s->total_bytes = x->total_bytes;
+}
+
 ALLOCATOR(ident, "identifiers");
 ALLOCATOR(token, "tokens");
 ALLOCATOR(context, "contexts");
diff --git a/allocate.h b/allocate.h
index 9e51ed7da..6e6c3a614 100644
--- a/allocate.h
+++ b/allocate.h
@@ -17,16 +17,24 @@ struct allocator_struct {
 	unsigned int allocations, total_bytes, useful_bytes;
 };
 
+struct allocator_stats {
+	const char *name;
+	unsigned int allocations;
+	unsigned long total_bytes, useful_bytes;
+};
+
 extern void protect_allocations(struct allocator_struct *desc);
 extern void drop_all_allocations(struct allocator_struct *desc);
 extern void *allocate(struct allocator_struct *desc, unsigned int size);
 extern void free_one_entry(struct allocator_struct *desc, void *entry);
 extern void show_allocations(struct allocator_struct *);
+extern void get_allocator_stats(struct allocator_struct *, struct allocator_stats *);
 
 #define __DECLARE_ALLOCATOR(type, x)		\
 	extern type *__alloc_##x(int);		\
 	extern void __free_##x(type *);		\
 	extern void show_##x##_alloc(void);	\
+	extern void get_##x##_stats(struct allocator_stats *);		\
 	extern void clear_##x##_alloc(void);	\
 	extern void protect_##x##_alloc(void);
 #define DECLARE_ALLOCATOR(x) __DECLARE_ALLOCATOR(struct x, x)
@@ -48,6 +56,10 @@ extern void show_allocations(struct allocator_struct *);
 	{							\
 		show_allocations(&x##_allocator);		\
 	}							\
+	void get_##x##_stats(struct allocator_stats *s)		\
+	{							\
+		get_allocator_stats(&x##_allocator, s);		\
+	}							\
 	void clear_##x##_alloc(void)				\
 	{							\
 		drop_all_allocations(&x##_allocator);		\
-- 
2.12.0

