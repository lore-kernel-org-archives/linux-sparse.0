From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/15] options: move declaration of tabstop out of "token.h"
Date: Sun,  5 Jul 2020 15:02:14 +0200
Message-ID: <20200705130220.26230-10-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGENCh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922CBC061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dg28so32196802edb.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:37 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

'tabstop' is unusual in the sense that it's one the few (the only?)
variable defined via an option flag which is not declared in "lib.h"
but in "token.h". This for to have to include "token.h" in the code
doing the parsing of the options ...

Move this declaration to "lib.h".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h   | 1 +
 token.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib.h b/lib.h
index 4f67958efdb9..e938f18dfc92 100644
--- a/lib.h
+++ b/lib.h
@@ -48,6 +48,7 @@ extern int die_if_error;
 extern int repeat_phase;
 extern int do_output;
 extern int gcc_major, gcc_minor, gcc_patchlevel;
+extern unsigned int tabstop;
 
 extern const char *base_filename;
 
diff --git a/token.h b/token.h
index 33a6eda1cc53..c5fdf3d0c879 100644
--- a/token.h
+++ b/token.h
@@ -64,7 +64,6 @@ struct stream {
 
 extern int input_stream_nr;
 extern struct stream *input_streams;
-extern unsigned int tabstop;
 extern int *hash_stream(const char *name);
 
 struct ident {
-- 
2.27.0
