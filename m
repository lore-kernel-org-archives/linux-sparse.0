From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] lib: __builtin_object_size should accept void *
Date: Wed, 23 Nov 2016 22:24:41 +0200
Message-ID: <1479932572-12543-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbcKWUYp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 15:24:45 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

I'm seeing these warnings with current Linux:
./arch/x86/include/asm/uaccess.h:705:18: warning: incorrect type in argument 1 (different modifiers)
./arch/x86/include/asm/uaccess.h:705:18:    expected void *<noident>
./arch/x86/include/asm/uaccess.h:705:18:    got void const *from

Because of this code:

static __always_inline unsigned long __must_check
copy_to_user(void __user *to, const void *from, unsigned long n)
{
        int sz = __compiletime_object_size(from);

...
}

where we have

# define __compiletime_object_size(obj) __builtin_object_size(obj, 0)

to fix, mark the argument as const void *.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Sorry if this has already been reported/fixed.

 lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index d5b56b0..2d66aa0 100644
--- a/lib.c
+++ b/lib.c
@@ -888,7 +888,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
 
 	/* And some __FORTIFY_SOURCE ones.. */
-	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
+	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
 	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-- 
MST
