From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH] sparse: update __builtin_object_size() prototype
Date: Wed, 21 Sep 2016 10:13:58 -0400
Message-ID: <1474467238-20939-1-git-send-email-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756627AbcIUON7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 21 Sep 2016 10:13:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 739E9C04B93F
        for <linux-sparse@vger.kernel.org>; Wed, 21 Sep 2016 14:13:59 +0000 (UTC)
Received: from thinkcentre.nc.rr.com (vpn-54-57.rdu2.redhat.com [10.10.54.57])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8LEDwBe001640
        for <linux-sparse@vger.kernel.org>; Wed, 21 Sep 2016 10:13:59 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Sparse emits a large number of warnings for the linux kernel source
tree of the form:
    ./arch/x86/include/asm/uaccess.h:735:18: \
        warning: incorrect type in argument 1 (different modifiers)
    ./arch/x86/include/asm/uaccess.h:735:18:    expected void *<noident>
    ./arch/x86/include/asm/uaccess.h:735:18:    got void const *from

Fix by making the first parameter to __builtin_object_size()
type "const void *" instead of "void *", which is consistent with GCC
behavior (the prototype for this builtin in GCC documentation is evidently
incorrect).

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
 lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index aa2af68..122dd6f 100644
--- a/lib.c
+++ b/lib.c
@@ -917,7 +917,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
 
 	/* And some __FORTIFY_SOURCE ones.. */
-	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
+	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
 	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-- 
2.5.5

