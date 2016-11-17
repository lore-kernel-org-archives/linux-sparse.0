From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Thu, 17 Nov 2016 21:25:24 +0100
Message-ID: <20161117202523.GA35194@macpro.local>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34835 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcKQUZ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 15:25:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so24780669wme.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 12:25:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Nov 17, 2016 at 09:40:20AM -0800, Linus Torvalds wrote:
> On Thu, Nov 17, 2016 at 9:25 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The macros that do the ptrlist walking don't handle empty blocks.
> 
> Actually, most of the_do_ handle empty blocks. In particular, the
> normal FOR_EACH_PTR() case should handle it just fine.

Yes, indeed.
 
> The exception is, I think:
> 
>  - first_ptr_list/last_ptr_list
> 
>  - DO_PREPARE/DO_RESET

... 

> I suspect they should be fairly easy to update to just walk the list
> until they hit a non-empty case (like DO_NEXT() already does, for
> example).
> 
>               Linus
> --

Would something like the following be fine?

From bf7f856f95a71b931559a17c0f5144cd3a3875b5 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 17 Nov 2016 20:59:18 +0100
Subject: [PATCH] make ptrlist walking against robust against empty blocks

Not all macros or function involved in the ptrlist walking
can handle a ptrlist containing some empty blocks.

Fix this by:
- add the proper check & looping to first & last_ptr_list().
- add a safe version of PTR_ENTRY doing the needed check & looping.
- use this safe version for DO_PREPARE() & DO_RESET()

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
I've quickly checked it on the testsuite (and it seems to pass ;).
I'll validate this more thoroughly but I won't be able to do this
just now.
---
 ptrlist.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 61e159fd..d09be2f5 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -67,28 +67,51 @@ extern int linearize_ptr_list(struct ptr_list *, void **, int);
 
 static inline void *first_ptr_list(struct ptr_list *list)
 {
+	struct ptr_list *head = list;
+
 	if (!list)
 		return NULL;
+
+	while (list->nr == 0) {
+		list = list->next;
+		if (list == head)
+			return NULL;
+	}
 	return PTR_ENTRY(list, 0);
 }
 
 static inline void *last_ptr_list(struct ptr_list *list)
 {
+	struct ptr_list *head = list;
 
 	if (!list)
 		return NULL;
 	list = list->prev;
+	while (list->nr == 0) {
+		if (list == head)
+			return NULL;
+		list = list->prev;
+	}
 	return PTR_ENTRY(list, list->nr-1);
 }
 
+#define PTR_DEREF(__head, idx, PTR_ENTRY) ({						\
+	struct ptr_list *__list = __head;						\
+	while (__list && __list->nr == 0) {						\
+		__list = __list->next;							\
+		if (__list == __head)							\
+			__list = NULL;							\
+	}										\
+	__list ? PTR_ENTRY(__list, idx) : NULL;						\
+})
+
 #define DO_PREPARE(head, ptr, __head, __list, __nr, PTR_ENTRY)				\
 	do {										\
 		struct ptr_list *__head = (struct ptr_list *) (head);			\
 		struct ptr_list *__list = __head;					\
 		int __nr = 0;								\
 		CHECK_TYPE(head,ptr);							\
-		if (__head) ptr = PTR_ENTRY(__head, 0);					\
-		else ptr = NULL
+		ptr = PTR_DEREF(__head, 0, PTR_ENTRY);					\
 
 #define DO_NEXT(ptr, __head, __list, __nr, PTR_ENTRY)					\
 		if (ptr) {								\
@@ -110,7 +133,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	do {										\
 		__nr = 0;								\
 		__list = __head;							\
-		if (__head) ptr = PTR_ENTRY(__head, 0);					\
+		if (__head) ptr = PTR_DEREF(__head, 0, PTR_ENTRY);			\
 	} while (0)
 
 #define DO_FINISH(ptr, __head, __list, __nr)						\
-- 
2.10.2

