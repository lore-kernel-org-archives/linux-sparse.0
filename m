From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/29] ptrmap: add missing #include "compat.h"
Date: Wed, 16 Aug 2017 17:34:42 +0200
Message-ID: <20170816153455.97693-17-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36683 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id y67so3694294wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:37 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

"allocate.h" need to include "compat.h" for the definition of
	CHUNK

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 allocate.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/allocate.h b/allocate.h
index 64bb6dd64..6a57ed26c 100644
--- a/allocate.h
+++ b/allocate.h
@@ -1,6 +1,8 @@
 #ifndef ALLOCATE_H
 #define ALLOCATE_H
 
+#include "compat.h"
+
 struct allocation_blob {
 	struct allocation_blob *next;
 	unsigned int left, offset;
-- 
2.14.0

