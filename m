From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] Small test/exemple for using '-vdata'
Date: Sun,  1 Feb 2015 03:19:46 +0100
Message-ID: <1422757186-8007-5-git-send-email-luc.vanoostenryck@gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
 <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:65095 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbbBACUf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 21:20:35 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so33232438wev.8
        for <linux-sparse@vger.kernel.org>; Sat, 31 Jan 2015 18:20:34 -0800 (PST)
In-Reply-To: <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux@rasmusvillemoes.dk, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/show_data.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 validation/show_data.c

diff --git a/validation/show_data.c b/validation/show_data.c
new file mode 100644
index 00000000..b620b610
--- /dev/null
+++ b/validation/show_data.c
@@ -0,0 +1,75 @@
+#define P "\001"
+
+static const char a[] = P "a";
+static const char b[] = P "b";
+
+static const char *c = "abc";
+
+static int i = 42;
+
+static int  *ipi = &i;
+static void *vpi = &i;
+
+struct s {
+	int i;
+};
+static struct s s = {
+	.i = 42,
+};
+
+union u {
+	int i;
+	void *p;
+};
+static union u u = {
+	.i = 42,
+};
+
+enum e {
+	first,
+	next,
+	last
+};
+static enum e e = next;
+/*
+ * check-name: show_data.c
+ * check-command: sparse -m32 -vdata $file
+ * check-output-start:
+symbol a:
+	char static const [toplevel] a[0]
+	bit_size = 24
+	val = "\1a"
+symbol b:
+	char static const [toplevel] b[0]
+	bit_size = 32
+	val = "\1b"
+symbol c:
+	char const *static [toplevel] c
+	bit_size = 32
+	val = &"abc"
+symbol i:
+	int static [signed] [addressable] [toplevel] i
+	bit_size = 32
+	val = 42
+symbol ipi:
+	int *static [toplevel] ipi
+	bit_size = 32
+	val = &i
+symbol vpi:
+	void *static [toplevel] vpi
+	bit_size = 32
+	val = &i
+symbol s:
+	struct s static [toplevel] s
+	bit_size = 32
+	val = {	}
+symbol u:
+	union u static [toplevel] u
+	bit_size = 32
+	val = {	}
+symbol e:
+	int enum e static [signed] [toplevel] e
+	bit_size = 32
+	val = 1
+ * check-output-end
+ */
-- 
2.2.0

