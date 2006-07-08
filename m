From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix warnings from gcc 4.1.1
Date: Sat, 8 Jul 2006 13:28:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607081311540.3869@g5.osdl.org>
References: <20060708060004.20321.50429.stgit@dv.roinet.com>
 <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:24452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030337AbWGHU2E (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 8 Jul 2006 16:28:04 -0400
In-Reply-To: <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org



On Sat, 8 Jul 2006, Linus Torvalds wrote:
> 
> Please send a bug-report to the gcc people instead.
> 
> The code is correct, and the warning is bogus.

Ahhah.

I figured out a way to get gcc to not complain about it.

Making it a statement expression shuts gcc up about the unused result.

Damn gcc. But this patch _should_ fix things... (it also fixes 
"add_pseudo()" to return the proper type rather than silently drop the 
type information on the floor with "void *").

Does this silence the bogus compiler warnings for you?

		Linus

----
diff --git a/linearize.h b/linearize.h
index 5f021a3..66a76dc 100644
--- a/linearize.h
+++ b/linearize.h
@@ -237,7 +237,7 @@ static inline void add_multijmp(struct m
 	add_ptr_list(list, multijmp);
 }
 
-static inline void *add_pseudo(struct pseudo_list **list, struct pseudo *pseudo)
+static inline pseudo_t *add_pseudo(struct pseudo_list **list, pseudo_t pseudo)
 {
 	return add_ptr_list(list, pseudo);
 }
diff --git a/ptrlist.h b/ptrlist.h
index b42a0ca..719f437 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -15,6 +15,7 @@ #define DECLARE_PTR_LIST(listname,type)	
 #define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
 #define TYPEOF(head)			__typeof__(&(head)->list[0])
 #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
+#define MKTYPE(head,expr)		({ (TYPEOF(head))(expr); })
 
 #define LIST_NODE_NR (29)
 
@@ -46,7 +47,7 @@ extern int linearize_ptr_list(struct ptr
  * extensions..
  */
 #define add_ptr_list_tag(list,entry,tag) \
-	(TYPEOF(*(list))) (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag)))
+	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag))))
 #define add_ptr_list(list,entry) \
 	add_ptr_list_tag(list,entry,0)
 #define free_ptr_list(list) \
