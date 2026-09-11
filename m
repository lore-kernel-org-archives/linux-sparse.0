Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A048640B
	for <linux-sparse@vger.kernel.org>; Fri, 11 Sep 2026 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164900; cv=none; b=sKnElyoeK4RyALclojf0egWlpA/l/+spkCnFiBLictAyaepBgOP3mCXUdt944w07ImxAWvpttRSCV5Fm/llkCg2lqzq5ePgFTCYXRpwKndgDacS7yeYlwndGQmi0IAetrHkrAZmULtLj/PzS9l5qgrtOncaWAdT82cqKR1chP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164900; c=relaxed/simple;
	bh=kudAxJVFZ3LQbBf9zKs5zuF1NACSED3RdhqSu+YS0fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u33GSD+GabISCDh/m5q2TEwdghzzY5jUF0pTJ0VVJJ/95P1DfCWrgWjCJFCtckx9UI3G8MFiYBCE+wSEhUBUHv7OwNLuVbSr9L7oQc+IT4FPMZFHcv9/OuZekux3eNFbiem5zDYB4/02sJW5cxWAgP5OM51QENf5gk67Q/GTFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHJG2xrY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHJG2xrY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so43998a91.2
        for <linux-sparse@vger.kernel.org>; Fri, 11 Sep 2026 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164895; x=1789769695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SryPbedwt+PB/tIiQ1DKQcYvegcDPhcxT20I1ilZbIQ=;
        b=fHJG2xrYjiL5PLaGfFFj/j1/KQCLrVyMA6VNZN9eBuw2f2Y9Qwx0OERj4fIXafwoi9
         AjwLb12BpPcNEBDU2szOAnFqcj1CwnWzDIbYagfy0FbEXDKjszhlTo+76fUOR95TeQ+s
         FLWAOEGdCwyLsV6ul7SsoNhobgOQdufVuVTsKPnmWXvHt52E8405ieIZzjQSaIInky3b
         16nTjwGOJuiuFdc2OuBwaAIERak01AjMLJHyf1Mz91KyFPyoZhrpnAReU/JWxucRT/ZU
         3fevjdDFpDy2AAs8kUCtrAzwCTwKY6MPHzkpnYckQ0/SuYIBK3B3ALNGz9G9bBnj1hH2
         JkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164895; x=1789769695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SryPbedwt+PB/tIiQ1DKQcYvegcDPhcxT20I1ilZbIQ=;
        b=G7MwFjKDIdmFNyUJlHsy0w+eJBlevmff2lCn2ujejT7aEgbos5W9wMEH38hYl4WBrT
         wjJA39VWcRQoyQq2Tj/t6H1MpEogas6GmSR52ouIGfmT7W2KZ+UP/TzBqkYYA1PhkbAy
         LC++YWUCWiD801Tr0DBMNDrpJIlyzZB14x8B5aGwC3dZiNYS5Fm7CqYcmFUWEl8mZ5CC
         pp+kIvAOzp9oQvI4HWi/HRu8l8DqR9OiUsyd/GCzl1zRGcNxEDXFl6pemgzEcoHCF8Oq
         54sIOCUKtNFaNfEHV4WGzQDb8td7gfO93q80dYltwMT5qGEUx6o8TImMYvI59XO3dkkc
         wyIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFTCE//KnR1jS7bvYXrxtNrc7dAVhTK+IiNdAsHKxx/zBI9tiE+yzz56VvcysjS3kBEz5GC8ZPmFjdd7w=@vger.kernel.org
X-Gm-Message-State: AFuF++kGcauDQ13GwVoeXPfptciO0LuQohuNrVq8wvMdiZcallrpgGzP
	KyL+eAWIS5ExCBtgQzS2lU7fENkHwqZM2vUsIGG9oeuejFsl099l64Ed
X-Gm-Gg: AYBFou0QhFZMZAAO2uwv2KR6Qy3ZYO0QXD846EtwzWbxW4ouMNRidFwraR4PZZZeran
	dcqA/whA8aQJk6ISy/HfBaB229IRSTDpVmIMA2wU6VWGhQ8Y8Ct9zBb3dHZ4WdsxdBLkAHXHY20
	CraXKk3tWDKvaBN650WsTNNILwc7b6RBNepgax/KZykJJNiyYiw/QjzqzWDBStYBzM75Prd9HRs
	IgeOIyg4r7oilk7B+nw6lXN8x/LdRYX1XJwAHfWhkmI1GR0ZbCh3UBkvfW0HdFF4XFQ+txXlX0R
	GQHYalkVNgSHs2TQg6KJSUE3N/3nmjljGMRNducYg3Wh05gb6iuE9Vgr8uJkCCKZHALCZqJWYSm
	8viVoFXDmmd6pjirJJe/O7EVtql1g+UhijGR5DFuOY3sZi96fYpgEUu4IRRb1432kZvGgp69acm
	3JRtjN2Xm4UQPhvnP4icmyg38HkCyQewrlZkAtx7K2q0F0lk3T7vPqoA/zjsftaHdBOC0=
X-Received: by 2002:a17:90b:4c0d:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-39dbc6a3e56mr392229a91.13.1789164895357;
        Fri, 11 Sep 2026 15:14:55 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba71cesm8971595c88.13.2026.09.11.15.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:14:54 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <liam@infradead.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Chris Li <sparse@chrisli.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: [PATCH 3/3] maple_tree: assert static storage for DEFINE_MTREE()
Date: Fri, 11 Sep 2026 18:14:43 -0400
Message-ID: <20260911221444.1523311-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911221444.1523311-1-ynorov@nvidia.com>
References: <20260911221444.1523311-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEFINE_MTREE() uses MTREE_INIT(), which initializes the tree's embedded
lock with a static spinlock initializer. If the tree is an automatic
local object, lockdep rejects its address as a non-static class key and
disables locking validation on the first lock acquisition.

Apply ASSERT_STATIC_STORAGE() to DEFINE_MTREE() to catch automatic
local definitions at compile time. For example:

  void example(void)
  {
          DEFINE_MTREE(mt);
          mtree_destroy(&mt);
  }

GCC reports:

  error: initializer element is not constant
    name##_storage_check = &(name)
                           ^
  note: in expansion of macro 'ASSERT_STATIC_STORAGE'
    ASSERT_STATIC_STORAGE(name)
  note: in expansion of macro 'DEFINE_MTREE'
    DEFINE_MTREE(mt);

File-scope definitions and static local trees remain valid. Automatic
local trees must instead use mt_init() or mt_init_flags(). Direct uses of
MTREE_INIT() and MTREE_INIT_EXT() are unchanged.

Replace the local DEFINE_MTREE() in the interval-tree span test with a
plain declaration; the test already initializes the tree with
mt_init_flags() before use. Convert the three local Maple Trees in the
userspace radix-tree tests to mt_init().

Validated file-scope and static local definitions with a kernel object
build, and confirmed that an automatic local definition fails to compile.
The Maple Tree test and region allocation benchmark objects also build
with lockdep enabled.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/maple_tree.h       |  4 +++-
 lib/interval_tree_test.c         |  2 +-
 tools/testing/radix-tree/maple.c | 12 +++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e595ae5cd0ee..e30e57f5f3df 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 
@@ -297,7 +298,8 @@ struct maple_tree {
 #endif
 
 #define DEFINE_MTREE(name)						\
-	struct maple_tree name = MTREE_INIT(name, 0)
+	struct maple_tree name = MTREE_INIT(name, 0);		\
+	ASSERT_STATIC_STORAGE(name)
 
 #define mtree_lock(mt)		spin_lock((&(mt)->ma_lock))
 #define mtree_lock_nested(mas, subclass) \
diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index b0b07270ce7c..06f77fb3179f 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -244,7 +244,7 @@ static int span_iteration_check(void)
 	unsigned long start, last;
 	struct interval_tree_span_iter span, mas_span;
 
-	DEFINE_MTREE(tree);
+	struct maple_tree tree;
 
 	MA_STATE(mas, &tree, 0, 0);
 
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index d967e76a3c06..bfe4b8626c42 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36022,10 +36022,12 @@ static noinline void __init check_erase_rebalance(struct maple_tree *mt)
 
 static noinline void __init check_mtree_dup(struct maple_tree *mt)
 {
-	DEFINE_MTREE(new);
+	struct maple_tree new;
 	int i, j, ret, count = 0;
 	unsigned int rand_seed = 17, rand;
 
+	mt_init(&new);
+
 	/* store a value at [0, 0] */
 	mt_init_flags(mt, 0);
 	mtree_store_range(mt, 0, 0, xa_mk_value(0), GFP_KERNEL);
@@ -36319,7 +36321,9 @@ static inline int check_vma_modification(struct maple_tree *mt)
 void farmer_tests(void)
 {
 	struct maple_node *node;
-	DEFINE_MTREE(tree);
+	struct maple_tree tree;
+
+	mt_init(&tree);
 
 	mt_dump(&tree, mt_dump_dec);
 
@@ -36432,9 +36436,11 @@ static unsigned long get_last_index(struct ma_state *mas)
 static void test_spanning_store_regression(void)
 {
 	unsigned long from = 0, to = 0;
-	DEFINE_MTREE(tree);
+	struct maple_tree tree;
 	MA_STATE(mas, &tree, 0, 0);
 
+	mt_init(&tree);
+
 	/*
 	 * Build a 3-level tree. We require a parent node below the root node
 	 * and 2 leaf nodes under it, so we can span the entirety of the right
-- 
2.53.0

