From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/7] use long for all mem stats
Date: Thu, 29 Jun 2017 07:16:40 +0200
Message-ID: <20170629051646.35988-2-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36110 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdF2FS7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:18:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id y5so340580wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:18:59 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The 32bit 4G limit is not so easily reached but still
it's easy to flirt with 500M+, even with a moderatly big
program.

Avoid any possible overflow and use unsigned long as
they cost nothing here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 allocate.c | 2 +-
 allocate.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/allocate.c b/allocate.c
index daa4ac247..0cc556307 100644
--- a/allocate.c
+++ b/allocate.c
@@ -120,7 +120,7 @@ void *allocate(struct allocator_struct *desc, unsigned int size)
 
 void show_allocations(struct allocator_struct *x)
 {
-	fprintf(stderr, "%s: %d allocations, %d bytes (%d total bytes, "
+	fprintf(stderr, "%s: %d allocations, %lu bytes (%lu total bytes, "
 			"%6.2f%% usage, %6.2f average size)\n",
 		x->name, x->allocations, x->useful_bytes, x->total_bytes,
 		100 * (double) x->useful_bytes / x->total_bytes,
diff --git a/allocate.h b/allocate.h
index 64bb6dd64..cbddc2aa7 100644
--- a/allocate.h
+++ b/allocate.h
@@ -14,7 +14,8 @@ struct allocator_struct {
 	unsigned int chunking;
 	void *freelist;
 	/* statistics */
-	unsigned int allocations, total_bytes, useful_bytes;
+	unsigned int allocations;
+	unsigned long total_bytes, useful_bytes;
 };
 
 struct allocator_stats {
-- 
2.13.0

