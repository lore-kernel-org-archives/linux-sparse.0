From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] testsuite: simplify test function-pointer-inheritance
Date: Thu, 24 Nov 2016 18:09:43 +0100
Message-ID: <20161124170947.14379-3-luc.vanoostenryck@gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35929 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756864AbcKXRJ6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 12:09:58 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so3656580wjb.3
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 09:09:58 -0800 (PST)
In-Reply-To: <20161124170947.14379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The function used had so much args that it was hard
to see what's the difference between them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/function-pointer-modifier-inheritance.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/validation/function-pointer-modifier-inheritance.c b/validation/function-pointer-modifier-inheritance.c
index 3428715a..13df6ff7 100644
--- a/validation/function-pointer-modifier-inheritance.c
+++ b/validation/function-pointer-modifier-inheritance.c
@@ -1,15 +1,6 @@
-struct sk_buff;
-struct sock;
+extern int foo(int f(int, void *));
 
-extern int skb_append_datato_frags(struct sock *sk, struct sk_buff *skb,
-                    int getfrag(void *from, char *to, int offset,
-                    int len,int odd, struct sk_buff *skb),
-                    void *from, int length);
