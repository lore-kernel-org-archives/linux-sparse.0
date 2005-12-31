From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] fix sparse warnings
Date: Sat, 31 Dec 2005 15:21:18 +0800
Message-ID: <20051231072118.GA3574@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:9285 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbVLaHOv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Dec 2005 02:14:51 -0500
Received: by zproxy.gmail.com with SMTP id 13so2191966nzn
        for <linux-sparse@vger.kernel.org>; Fri, 30 Dec 2005 23:14:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

sort.c:192:5: warning: mixing declarations and code
sort.c:234:2: warning: mixing declarations and code

Signed-off-by: Alecs King <alecsk@gmail.com>


diff --git a/sort.c b/sort.c
index c2ac8b7..749339a 100644
--- a/sort.c
+++ b/sort.c
@@ -186,10 +186,10 @@ merge_block_seqs (struct ptr_list *b1, i
 			// Element from b2 is smaller
 			buffer[nbuf++] = d2;
 			if (++i2 >= b2->nr) {
+				struct ptr_list *l = b2;
 				BEEN_THERE('M');
 				// Ok, we finished with b2.  Pull it out
 				// and plug it in before b1.
-				struct ptr_list *l = b2;
 
 				b2 = b2->next;
 				b2->prev = l->prev;
@@ -224,14 +224,13 @@ merge_block_seqs (struct ptr_list *b1, i
 
 void sort_list(struct ptr_list **plist, int (*cmp)(const void *, const void *))
 {
-	struct ptr_list *head = *plist;
+	struct ptr_list *head = *plist, *list = head;
 	int blocks = 1;
 
 	if (!head)
 		return;
 
 	// Sort all the sub-lists
-	struct ptr_list *list = head;
 	do {
 		array_sort(list->list, list->nr, cmp);
 #ifdef PARANOIA

-- 
Alecs King
