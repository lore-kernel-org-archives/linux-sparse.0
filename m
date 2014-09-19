From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 6/7] mm: Silence nested-externs warnings
Date: Fri, 19 Sep 2014 08:29:39 -0700
Message-ID: <1411140580-20909-7-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: owner-linux-mm@kvack.org
To: sparse@chrisli.org
Cc: Mark Rustad <mark.d.rustad@intel.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Brian Norris <computersforpeace@gmail.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>
List-Id: linux-sparse@vger.kernel.org

From: Mark Rustad <mark.d.rustad@intel.com>

Use diagnostic control macros to ignore nested-externs warnings
in this case.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>
CC: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 include/linux/mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8981cc8..9bf2c7e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1623,7 +1623,9 @@ static inline void mark_page_reserved(struct page *page)
  */
 static inline unsigned long free_initmem_default(int poison)
 {
+	DIAG_PUSH DIAG_IGNORE(nested-externs)
 	extern char __init_begin[], __init_end[];
+	DIAG_POP
 
 	return free_reserved_area(&__init_begin, &__init_end,
 				  poison, "unused kernel");
-- 
1.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
