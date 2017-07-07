From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 34/34] ptrlist: addr vs entry
Date: Fri,  7 Jul 2017 15:40:02 +0200
Message-ID: <20170707134002.49500-35-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33309 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbdGGNkr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:47 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4030702lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:47 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 46 ++++++++++++++++++++++++++-------------------
 ptrlist.h | 64 +++++++++++++++++++++++++++++++++------------------------------
 2 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 95447eaea..90c3b81d7 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -167,14 +167,14 @@ void **__add_ptr_list_tag(struct ptr_list **listp, void *ptr, unsigned long tag)
 int delete_ptr_list_entry(struct ptr_list **list, void *entry, int count)
 {
 	struct ptr_cur cur;
+	void **this;
 
 	if (!ptr_cur_beg(&cur, *list))
                 goto out;
 
-	while (ptr_cur_next(&cur)) {
-		void *ptr = cur.l->list[cur.n];
-		if (ptr == entry) {
-			ptr_cur_delete(&cur, ptr);
+	while ((this = ptr_cur_next(&cur))) {
+		if (*this == entry) {
+			ptr_cur_delete(&cur, *this);
 			if (!--count)
 				goto out;
 		}
@@ -188,12 +188,12 @@ out:
 int replace_ptr_list_entry(struct ptr_list **list, void *old_ptr, void *new_ptr, int count)
 {
 	struct ptr_cur cur;
+	void **this;
 
 	if (!ptr_cur_beg(&cur, *list))
                 goto out;
 
-	while (ptr_cur_next(&cur)) {
-		void **this = &cur.l->list[cur.n];
+	while ((this = ptr_cur_next(&cur))) {
 		if (*this == old_ptr) {
 			*this = new_ptr;
 			if (!--count)
@@ -209,14 +209,18 @@ out:
 void * undo_ptr_list_last(struct ptr_list **head)
 {
 	struct ptr_cur cur;
+	void **this;
 	void *ptr;
 
-	if (!ptr_cur_end(&cur, *head) || !ptr_cur_prev(&cur))
+	if (!ptr_cur_end(&cur, *head))
+		return NULL;
+	if (!(this = ptr_cur_prev(&cur)))
 		return NULL;
 
-	ptr = cur.l->list[cur.n];
-	cur.l->list[cur.n--] = (void *)0xf1f1f1f1;
+	ptr = *this;
+	*this = (void *)0xf1f1f1f1;
 	cur.l->nr--;
+	cur.n--;
 
 	return ptr;
 }
@@ -224,12 +228,15 @@ void * undo_ptr_list_last(struct ptr_list **head)
 void * delete_ptr_list_last(struct ptr_list **head)
 {
 	struct ptr_cur cur;
+	void **this;
 	void *ptr;
 
-	if (!ptr_cur_end(&cur, *head) || !ptr_cur_prev(&cur))
+	if (!ptr_cur_end(&cur, *head))
+		return NULL;
+	if (!(this = ptr_cur_prev(&cur)))
 		return NULL;
 
-	ptr = ptr_cur_entry(&cur);
+	ptr = *this;
 	if (--cur.l->nr == 0) {
 		if (cur.l == cur.h)
 			*head = NULL;
@@ -245,12 +252,13 @@ void * delete_ptr_list_last(struct ptr_list **head)
 void concat_ptr_list(struct ptr_list *a, struct ptr_list **b)
 {
 	struct ptr_cur cur;
+	void **this;
 
 	if (!ptr_cur_beg(&cur, a))
                 return;
 
-	while (ptr_cur_next(&cur))
-		__add_ptr_list(b, ptr_cur_entry(&cur));
+	while ((this = ptr_cur_next(&cur)))
+		__add_ptr_list(b, *this);
 }
 
 void __free_ptr_list(struct ptr_list **listp)
@@ -271,19 +279,19 @@ void __free_ptr_list(struct ptr_list **listp)
 }
 
 
-int ptr_cur_next(struct ptr_cur *cur)
+void **ptr_cur_next(struct ptr_cur *cur)
 {
 	do {
 		struct ptr_list *curl = cur->l;
 
 		if (++cur->n < curl->nr)
-			return 1;
+			return &curl->list[cur->n];
 
 		cur->l = curl->next;
 		cur->n = -1;
 	} while (cur->l != cur->h);
 
-	return 0;
+	return NULL;
 }
 
 int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head)
@@ -297,13 +305,13 @@ int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head)
 	return 1;
 }
 
-int ptr_cur_prev(struct ptr_cur *cur)
+void **ptr_cur_prev(struct ptr_cur *cur)
 {
 	do {
 		struct ptr_list *curl = cur->l;
 
 		if (--cur->n >= 0)
-			return 1;
+			return &curl->list[cur->n];
 
 		if (curl == cur->h)
 			break;
@@ -312,7 +320,7 @@ int ptr_cur_prev(struct ptr_cur *cur)
 		cur->n = curl->nr;
 	} while (1);
 
-	return 0;
+	return NULL;
 }
 
 int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head)
diff --git a/ptrlist.h b/ptrlist.h
index 263e68d01..d71b8bfcf 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -53,9 +53,9 @@ extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
 
 int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head);
-int ptr_cur_next(struct ptr_cur *cur);
+void **ptr_cur_next(struct ptr_cur *cur);
 int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head);
-int ptr_cur_prev(struct ptr_cur *cur);
+void **ptr_cur_prev(struct ptr_cur *cur);
 void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr);
 void ptr_cur_delete(struct ptr_cur *cur, void *ptr);
 
@@ -113,81 +113,85 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
-#define DO_PREPARE(head, ptr, __cur)						\
+#define DO_PREPARE(head, ptr, __cur, __addr)					\
 do {										\
 		struct ptr_cur __cur;							\
+		void ** __addr;								\
 		CHECK_TYPE(head,ptr);							\
 		if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||			\
-		    !ptr_cur_next(&__cur)) ptr = NULL;					\
-		else ptr = ptr_cur_entry(&__cur);
+		    !(__addr = ptr_cur_next(&__cur))) ptr = NULL;			\
+		else ptr = *__addr;
 
-#define DO_NEXT(ptr, __cur)							\
+#define DO_NEXT(ptr, __cur, __addr)							\
 	if (ptr) {									\
-		if (ptr_cur_next(&__cur))						\
-			ptr = ptr_cur_entry(&__cur);					\
+		if ((__addr = ptr_cur_next(&__cur)))					\
+			ptr = *__addr;							\
 		else									\
 			ptr = NULL;							\
 	}
 
-#define DO_RESET(ptr, __cur)								\
-	if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||				\
-	    !ptr_cur_next(&__cur)) ptr = NULL;						\
-	else ptr = ptr_cur_entry(&__cur);
+#define DO_RESET(ptr, __cur, __addr)							\
+	if (!ptr_cur_beg(&__cur, __cur.h) ||						\
+	    !(__addr = ptr_cur_next(&__cur))) ptr = NULL;				\
+	else ptr = *__addr;
 
 #define DO_FINISH(ptr, __cur)								\
 		(void)(__cur.n); /* Sanity-check nesting */				\
 	} while (0)
 
 #define PREPARE_PTR_LIST(head, ptr) \
-	DO_PREPARE(head, ptr, __cur##ptr)
+	DO_PREPARE(head, ptr, __cur##ptr, __addr##ptr)
 
 #define NEXT_PTR_LIST(ptr) \
-	DO_NEXT(ptr, __cur##ptr)
+	DO_NEXT(ptr, __cur##ptr, __addr##ptr)
 
 #define RESET_PTR_LIST(ptr) \
-	DO_RESET(ptr, __cur##ptr)
+	DO_RESET(ptr, __cur##ptr, __addr##ptr)
 
 #define FINISH_PTR_LIST(ptr) \
 	DO_FINISH(ptr, __cur##ptr)
 
-#define DO_FOR_EACH(head, ptr, __cur) do {						\
+#define DO_FOR_EACH(head, ptr, __cur, __addr) do {					\
 	struct ptr_cur __cur;								\
+	void **__addr;									\
 	CHECK_TYPE(head,ptr);								\
 	if (!head) break;								\
 	ptr_cur_beg(&__cur, (struct ptr_list *)head);					\
-	while (ptr_cur_next(&__cur)) {							\
-		ptr = ptr_cur_entry(&__cur);
+	while ((__addr = ptr_cur_next(&__cur))) {					\
+		ptr = *__addr;
 
 #define DO_END_FOR_EACH(ptr, __cur)							\
 	}										\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __cur) do {					\
+#define DO_FOR_EACH_REVERSE(head, ptr, __cur, __addr) do {				\
 	struct ptr_cur __cur;								\
+	void **__addr;									\
 	CHECK_TYPE(head,ptr);								\
 	if (!head) break;								\
 	ptr_cur_end(&__cur, (struct ptr_list *)head);					\
-	while (ptr_cur_prev(&__cur)) {							\
-		ptr = ptr_cur_entry(&__cur);
+	while ((__addr = ptr_cur_prev(&__cur))) {					\
+		ptr = *__addr;
 
 #define DO_END_FOR_EACH_REVERSE(ptr, __cur)						\
 	}										\
 } while (0)
 
-#define DO_REVERSE(ptr, __cur, new, __newcur) do {					\
+#define DO_REVERSE(ptr, __cur, new, __newcur, __newaddr) do {				\
 	struct ptr_cur __newcur = __cur;						\
-	while (ptr_cur_prev(&__newcur)) {						\
-		new = ptr_cur_entry(&__newcur);
+	void **__newaddr;								\
+	while ((__newaddr = ptr_cur_prev(&__newcur))) {					\
+		new = *__newaddr;
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __cur##ptr,							\
-		   new, __cur##new)
+		   new, __cur##new, __newaddr##ptr)
 
-#define DO_THIS_ADDRESS(ptr, __cur)							\
-	((__typeof__(&(ptr))) (__cur.l->list + __cur.n))
+#define DO_THIS_ADDRESS(ptr, __addr)							\
+	((__typeof__(&(ptr))) (__addr))
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __cur##ptr)
+	DO_FOR_EACH(head, ptr, __cur##ptr, __addr##ptr)
 
 #define FOR_EACH_TAGGED_PTR(head, ptr) \
 	FOR_EACH_PTR(head, ptr) \
@@ -197,13 +201,13 @@ do {										\
 	DO_END_FOR_EACH(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, __addr##ptr)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
 	DO_END_FOR_EACH_REVERSE(ptr, __cur##ptr)
 
 #define THIS_ADDRESS(ptr) \
-	DO_THIS_ADDRESS(ptr, __cur##ptr)
+	DO_THIS_ADDRESS(ptr, __addr##ptr)
 
 extern void split_ptr_list_head(struct ptr_list *);
 
-- 
2.13.0

