From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] cleanup: there is no 'struct phi' to allocate
Date: Wed, 15 Feb 2017 23:13:55 +0100
Message-ID: <20170215221358.68400-2-luc.vanoostenryck@gmail.com>
References: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35416 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdBOWOH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 17:14:07 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so2159865wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 14:14:07 -0800 (PST)
In-Reply-To: <20170215221358.68400-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This wasn't removed when the 'struct phi' was replaced
(commit 6e4960a3: "Remove "struct phi", replace with instruction that generates a pseudo.")

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 allocate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/allocate.h b/allocate.h
index 9f1dc8cc4..9e51ed7da 100644
--- a/allocate.h
+++ b/allocate.h
@@ -75,7 +75,6 @@ DECLARE_ALLOCATOR(basic_block);
 DECLARE_ALLOCATOR(entrypoint);
 DECLARE_ALLOCATOR(instruction);
 DECLARE_ALLOCATOR(multijmp);
-DECLARE_ALLOCATOR(phi);
 DECLARE_ALLOCATOR(pseudo);
 
 #endif
-- 
2.11.0

