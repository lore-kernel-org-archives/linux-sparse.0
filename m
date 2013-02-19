From: Kim Phillips <kim.phillips@freescale.com>
Subject: [PATCH v2] sparse: add built-in byte swap identifiers
Date: Tue, 19 Feb 2013 11:41:03 -0600
Message-ID: <20130219114103.4630a9053ef81cd4e0e1a7b8@freescale.com>
References: <20130218183629.d2a9238ac848758359582e28@freescale.com>
	<CANeU7Q=W8zZEngeweCGDkEpPGJMrADFgnibQVUFvGBwsppVq=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:9765 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932784Ab3BSRoP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Feb 2013 12:44:15 -0500
In-Reply-To: <CANeU7Q=W8zZEngeweCGDkEpPGJMrADFgnibQVUFvGBwsppVq=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

this patch stops sparse from complaining about them not being
defined:

include/uapi/linux/swab.h:60:16: error: undefined identifier '__builtin_bswap32'
include/uapi/linux/swab.h:60:33: error: not a function <noident>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
v2: add a test for builtin_bswap{16,32,64}

 lib.c                      | 5 +++++
 validation/builtin_bswap.c | 9 +++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 validation/builtin_bswap.c

diff --git a/lib.c b/lib.c
index 6bd10d3..4f69e11 100644
--- a/lib.c
+++ b/lib.c
@@ -727,6 +727,11 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
 
+	/* And byte swaps.. */
+	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
+	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
+	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
+
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
 	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
diff --git a/validation/builtin_bswap.c b/validation/builtin_bswap.c
new file mode 100644
index 0000000..6a4a907
--- /dev/null
+++ b/validation/builtin_bswap.c
@@ -0,0 +1,9 @@
+static unsigned short x = __builtin_bswap16(0);
+static unsigned int y = __builtin_bswap32(0);
+static unsigned long long z = __builtin_bswap64(0);
+
+/*
+ * check-name: __builtin_bswap
+ * check-error-start
+ * check-error-end
+ */
-- 
1.8.1.3


