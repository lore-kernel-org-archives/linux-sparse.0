From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 3/3] Adding _Pragma()
Date: Mon, 17 Jul 2017 00:01:03 -0400
Message-ID: <CANeU7QnTHFpwvdHzLFUhYPky4oxfkvsgU-8z2-g59DFnN2rd7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34718 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdGQEBF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 00:01:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id c24so18130259pfe.1
        for <linux-sparse@vger.kernel.org>; Sun, 16 Jul 2017 21:01:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This will make the selfcheck target reduce a lot of error on
test-inspect.c.  The gtk header file use _Pragma().

Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib.c b/lib.c
index de63504..ce66a81 100644
--- a/lib.c
+++ b/lib.c
@@ -1156,6 +1156,7 @@ void create_builtin_stream(void)

  add_pre_buffer("#define __extension__\n");
  add_pre_buffer("#define __pragma__\n");
+ add_pre_buffer("#define _Pragma(x)\n");

  // gcc defines __SIZE_TYPE__ to be size_t.  For linux/i86 and
  // solaris/sparc that is really "unsigned int" and for linux/x86_64
-- 
2.9.4
