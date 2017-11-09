From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 36/37] build: use a single space before assignments
Date: Thu,  9 Nov 2017 07:46:47 +0100
Message-ID: <20171109064648.15379-37-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54549 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKIGr7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so15297283wmr.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:59 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index afae2a370..d7bcbf465 100644
--- a/Makefile
+++ b/Makefile
@@ -164,8 +164,8 @@ LIBS := libsparse.a
 OBJS := $(LIB_OBJS) $(EXTRA_OBJS) $(PROGRAMS:%=%.o)
 
 # Pretty print
-V	      = @
-Q	      = $(V:1=)
+V := @
+Q := $(V:1=)
 
 ########################################################################
 all: $(PROGRAMS)
-- 
2.14.0

