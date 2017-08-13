From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 4/4] Makefile: Adding OPT variable for optmize level
Date: Sun, 13 Aug 2017 15:12:50 -0400
Message-ID: <CANeU7Q=SHC7ca-FMkud58nr+zxnhWe1uRfN1i4erkmFpraSpGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38349 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMTMv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:12:51 -0400
Received: by mail-yw0-f194.google.com with SMTP id p68so5078082ywg.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:12:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So that some one can do "make OPT=0" for compiling
sparse with -O0.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9db6b15..dfda866 100644
--- a/Makefile
+++ b/Makefile
@@ -12,7 +12,8 @@ OS = linux


 CC = gcc
-CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
+OPT = 2
+CFLAGS = -O$(OPT) -finline-functions -fno-strict-aliasing -g
 CFLAGS += -Wall -Wwrite-strings
 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 DBG_CFLAGS = $(ALL_CFLAGS) -DSPARSE_DEBUG
-- 
2.13.4
