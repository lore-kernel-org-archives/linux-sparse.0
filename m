From: "Emilio G. Cota" <cota@braap.org>
Subject: [PATCH v2] Define __CHAR_BIT__
Date: Wed,  8 Jan 2014 16:32:42 -0500
Message-ID: <1389216762-10884-1-git-send-email-cota@braap.org>
References: <CANeU7QnwK86w5TjboqjDm4xAPf0P9rw6bnp3jDWrF8j3C2vqQg@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60775 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757437AbaAHVeA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Jan 2014 16:34:00 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 59B97215B1
	for <linux-sparse@vger.kernel.org>; Wed,  8 Jan 2014 16:33:59 -0500 (EST)
In-Reply-To: <CANeU7QnwK86w5TjboqjDm4xAPf0P9rw6bnp3jDWrF8j3C2vqQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

From: "Emilio G. Cota" <cota@braap.org>

gcc defines __CHAR_BIT__ as a pre-defined macro.

Define __CHAR_BIT__ in sparse so that code that needs it (e.g. code
using CHAR_BIT from limits.h) does not generate false warnings.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 lib.c                         | 1 +
 validation/builtin_char_bit.c | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 validation/builtin_char_bit.c

diff --git a/lib.c b/lib.c
index fe20f93..bbdb9b7 100644
--- a/lib.c
+++ b/lib.c
@@ -911,6 +911,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __LONG_LONG_MAX__ " STRINGIFY(__LONG_LONG_MAX__) "\n");
 	add_pre_buffer("#weak_define __WCHAR_MAX__ " STRINGIFY(__WCHAR_MAX__) "\n");
 	add_pre_buffer("#weak_define __SIZEOF_POINTER__ " STRINGIFY(__SIZEOF_POINTER__) "\n");
+	add_pre_buffer("#weak_define __CHAR_BIT__ " STRINGIFY(__CHAR_BIT__) "\n");
 }
 
 static struct symbol_list *sparse_tokenstream(struct token *token)
diff --git a/validation/builtin_char_bit.c b/validation/builtin_char_bit.c
new file mode 100644
index 0000000..30e6bed
--- /dev/null
+++ b/validation/builtin_char_bit.c
@@ -0,0 +1,7 @@
+#include <limits.h>
+
+static unsigned int word_bits = sizeof(unsigned int) * CHAR_BIT;
+
+/*
+ * check-name: __CHAR_BIT__
+ */
-- 
1.8.3

