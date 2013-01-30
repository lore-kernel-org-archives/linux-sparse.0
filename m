From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 2/2] Ignore address space for IS_ERR() and friends
Date: Wed, 30 Jan 2013 20:32:57 +0100
Message-ID: <1359574377-3402-2-git-send-email-thierry.reding@avionic-design.de>
References: <1359574377-3402-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64764 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab3A3TdB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Jan 2013 14:33:01 -0500
In-Reply-To: <1359574377-3402-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

This patch ignores sparse' address_space and noderef attributes for
pointers passed to the IS_ERR() and related functions. Since they only
extract an error code or compare the pointer to an integer value, they
can safely be used on any type of pointer.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note that in order for this to work a patched version of sparse is
required.

 include/linux/err.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/err.h b/include/linux/err.h
index f2edce2..92103bf 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -24,17 +24,17 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
-static inline long __must_check PTR_ERR(const void *ptr)
+static inline long __must_check PTR_ERR(const void __force *ptr)
 {
 	return (long) ptr;
 }
 
-static inline long __must_check IS_ERR(const void *ptr)
+static inline long __must_check IS_ERR(const void __force *ptr)
 {
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
-static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
+static inline long __must_check IS_ERR_OR_NULL(const void __force *ptr)
 {
 	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
 }
@@ -46,13 +46,13 @@ static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
  * Explicitly cast an error-valued pointer to another pointer type in such a
  * way as to make it clear that's what's going on.
  */
-static inline void * __must_check ERR_CAST(const void *ptr)
+static inline void * __must_check ERR_CAST(const void __force *ptr)
 {
 	/* cast away the const */
 	return (void *) ptr;
 }
 
-static inline int __must_check PTR_RET(const void *ptr)
+static inline int __must_check PTR_RET(const void __force *ptr)
 {
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
-- 
1.8.1.2

