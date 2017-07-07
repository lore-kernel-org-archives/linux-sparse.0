From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 18:18:48 -0700
Message-ID: <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34303 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbdGGBSt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 21:18:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so2405755pfe.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 18:18:49 -0700 (PDT)
In-Reply-To: <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 5:40 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Thanks for catching it. That is a very serious bug.
> The release will be on hold until this bug has been fix.
> It is actually more than one of them. I will send out a separate patch
> catching this kind of behavior.
>

Here is the patch. There is another offender in simplify.c

Chris

From: Christopher Li <sparse@chrisli.org>
Date: Thu, 6 Jul 2017 16:25:38 -0700
Subject: [PATCH 2/2] check on delete list entry while parent caller using it.

This is checking for type the bug Luc reported.
Basiclly, the parent DO_FOR_EACH() has __nr caching the
current ptr position. When the inner loop function delete
one entry before the current position. The parent current
position needs to be adjust, because the entry[] has been
move forward.

This patch only check usage FOR_EACH_XXX macro. There is
also PREPARE_PTR_LIST haven't cover by this patch.
It is already catching bugs left and right.

Most noticablely remove_usage() inside of the  kill_use_list()
loop.
---
 ptrlist.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f..4f38a4e 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)

 struct ptr_list {
- int nr;
+ unsigned int nr:16;
+ unsigned int active:16;
  struct ptr_list *prev;
  struct ptr_list *next;
  void *list[LIST_NODE_NR];
@@ -44,6 +45,7 @@ extern void concat_ptr_list(struct ptr_list *a,
struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
+extern void die(const char *, ...);

 /*
  * Hey, who said that you can't do overloading in C?
@@ -158,6 +160,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  CHECK_TYPE(head,ptr); \
  if (__head) { \
  do { int __nr; \
+ __list->active++; \
  for (__nr = 0; __nr < __list->nr; __nr++) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -167,6 +170,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \
  } while ((__list = __list->next) != __head); \
  } \
 } while (0)
@@ -179,6 +183,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  do { int __nr; \
  __list = __list->prev; \
  __nr = __list->nr; \
+ __list->active++; \
  while (--__nr >= 0) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -189,6 +194,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \
  } while (__list != __head); \
  } \
 } while (0)From: Christopher Li <sparse@chrisli.org>
Date: Thu, 6 Jul 2017 16:25:38 -0700
Subject: [PATCH 2/2] check on delete list entry while parent caller using it.

This is checking for type the bug Luc reported.
Basiclly, the parent DO_FOR_EACH() has __nr caching the
current ptr position. When the inner loop function delete
one entry before the current position. The parent current
position needs to be adjust, because the entry[] has been
move forward.

This patch only check usage FOR_EACH_XXX macro. There is
also PREPARE_PTR_LIST haven't cover by this patch.
It is already catching bugs left and right.

Most noticablely remove_usage() inside of the  kill_use_list()
loop.
---
 ptrlist.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f..4f38a4e 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)

 struct ptr_list {
- int nr;
+ unsigned int nr:16;
+ unsigned int active:16;
  struct ptr_list *prev;
  struct ptr_list *next;
  void *list[LIST_NODE_NR];
@@ -44,6 +45,7 @@ extern void concat_ptr_list(struct ptr_list *a,
struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
+extern void die(const char *, ...);

 /*
  * Hey, who said that you can't do overloading in C?
@@ -158,6 +160,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  CHECK_TYPE(head,ptr); \
  if (__head) { \
  do { int __nr; \
+ __list->active++; \
  for (__nr = 0; __nr < __list->nr; __nr++) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -167,6 +170,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \From: Christopher Li <sparse@chrisli.org>
Date: Thu, 6 Jul 2017 16:25:38 -0700
Subject: [PATCH 2/2] check on delete list entry while parent caller using it.

This is checking for type the bug Luc reported.
Basiclly, the parent DO_FOR_EACH() has __nr caching the
current ptr position. When the inner loop function delete
one entry before the current position. The parent current
position needs to be adjust, because the entry[] has been
move forward.

This patch only check usage FOR_EACH_XXX macro. There is
also PREPARE_PTR_LIST haven't cover by this patch.
It is already catching bugs left and right.

Most noticablely remove_usage() inside of the  kill_use_list()
loop.
---
 ptrlist.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f..4f38a4e 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)

 struct ptr_list {
- int nr;
+ unsigned int nr:16;
+ unsigned int active:16;
  struct ptr_list *prev;
  struct ptr_list *next;
  void *list[LIST_NODE_NR];
@@ -44,6 +45,7 @@ extern void concat_ptr_list(struct ptr_list *a,
struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
+extern void die(const char *, ...);

 /*
  * Hey, who said that you can't do overloading in C?
@@ -158,6 +160,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  CHECK_TYPE(head,ptr); \
  if (__head) { \
  do { int __nr; \
+ __list->active++; \
  for (__nr = 0; __nr < __list->nr; __nr++) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -167,6 +170,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \
  } while ((__list = __list->next) != __head); \
  } \
 } while (0)
@@ -179,6 +183,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  do { int __nr; \
  __list = __list->prev; \
  __nr = __list->nr; \
+ __list->active++; \
  while (--__nr >= 0) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -189,6 +194,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \
  } while (__list != __head); \
  } \
 } while (0)
@@ -270,6 +276,9 @@ extern void split_ptr_list_head(struct ptr_list *);
  DO_INSERT_CURRENT(new, ptr, __head##ptr, __list##ptr, __nr##ptr)

 #define DO_DELETE_CURRENT(ptr, __head, __list, __nr) do { \
+ if (__list->active > 1) \
+ die("%s:%d delete entry with %d parent using ", \
+       __FILE__, __LINE__, __list->active - 1); \
  void **__this = __list->list + __nr; \
  void **__last = __list->list + __list->nr - 1; \
  while (__this < __last) { \
-- 
2.9.4

  } while ((__list = __list->next) != __head); \
  } \
 } while (0)
@@ -179,6 +183,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  do { int __nr; \
  __list = __list->prev; \
  __nr = __list->nr; \
+ __list->active++; \
  while (--__nr >= 0) { \
  do { \
  ptr = PTR_ENTRY(__list,__nr); \
@@ -189,6 +194,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
  } while (0); \
  } while (0); \
  } \
+ __list->active--; \
  } while (__list != __head); \
  } \
 } while (0)
@@ -270,6 +276,9 @@ extern void split_ptr_list_head(struct ptr_list *);
  DO_INSERT_CURRENT(new, ptr, __head##ptr, __list##ptr, __nr##ptr)

 #define DO_DELETE_CURRENT(ptr, __head, __list, __nr) do { \
+ if (__list->active > 1) \
+ die("%s:%d delete entry with %d parent using ", \
+       __FILE__, __LINE__, __list->active - 1); \
  void **__this = __list->list + __nr; \
  void **__last = __list->list + __list->nr - 1; \
  while (__this < __last) { \
-- 
2.9.4

@@ -270,6 +276,9 @@ extern void split_ptr_list_head(struct ptr_list *);
  DO_INSERT_CURRENT(new, ptr, __head##ptr, __list##ptr, __nr##ptr)

 #define DO_DELETE_CURRENT(ptr, __head, __list, __nr) do { \
+ if (__list->active > 1) \
+ die("%s:%d delete entry with %d parent using ", \
+       __FILE__, __LINE__, __list->active - 1); \
  void **__this = __list->list + __nr; \
  void **__last = __list->list + __list->nr - 1; \
  while (__this < __last) { \
-- 
2.9.4
