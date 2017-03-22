From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/7] teach sparse about -Waddress
Date: Wed, 22 Mar 2017 18:32:51 +0100
Message-ID: <20170322173257.63019-2-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34323 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759680AbdCVRdK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id y90so3982639wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:08 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

This is used by GCC to report suspicious use of addresses.

So, reuse the same name for same or similar use.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 2 ++
 lib.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/lib.c b/lib.c
index 272d2c88a..f4d5760b7 100644
--- a/lib.c
+++ b/lib.c
@@ -215,6 +215,7 @@ void die(const char *fmt, ...)
 static struct token *pre_buffer_begin = NULL;
 static struct token *pre_buffer_end = NULL;
 
+int Waddress = 0;
 int Waddress_space = 1;
 int Wbitwise = 1;
 int Wcast_to_as = 0;
@@ -467,6 +468,7 @@ static const struct warning {
 	const char *name;
 	int *flag;
 } warnings[] = {
+	{ "address", &Waddress },
 	{ "address-space", &Waddress_space },
 	{ "bitwise", &Wbitwise },
 	{ "cast-to-as", &Wcast_to_as },
diff --git a/lib.h b/lib.h
index 134e56040..0bf8c97e4 100644
--- a/lib.h
+++ b/lib.h
@@ -101,6 +101,7 @@ extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 
 extern int preprocess_only;
 
+extern int Waddress;
 extern int Waddress_space;
 extern int Wbitwise;
 extern int Wcast_to_as;
-- 
2.12.0

