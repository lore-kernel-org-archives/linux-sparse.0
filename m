From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2] sparse: add __builtin_va_arg_pack() and __builtin_va_arg_pack_len()
Date: Fri, 19 Jul 2013 06:33:40 -0400
Message-ID: <1374230020-26826-1-git-send-email-jlayton@redhat.com>
References: <CANeU7Qn5LFSKN9+vX+yGVovbcWNMmJT4HU6Se4ObsoJHh851fA@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ye0-f182.google.com ([209.85.213.182]:51325 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089Ab3GSKdx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 19 Jul 2013 06:33:53 -0400
Received: by mail-ye0-f182.google.com with SMTP id m12so1236314yen.13
        for <linux-sparse@vger.kernel.org>; Fri, 19 Jul 2013 03:33:52 -0700 (PDT)
In-Reply-To: <CANeU7Qn5LFSKN9+vX+yGVovbcWNMmJT4HU6Se4ObsoJHh851fA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: penberg@kernel.org, sparse@chrisli.org

this patch stops sparse from complaining about them not being defined:

    /usr/include/bits/stdio2.h:98:25: error: undefined identifier '__builtin_va_arg_pack'
    /usr/include/bits/stdio2.h:98:25: error: not a function <noident>

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 lib.c                            |  2 ++
 validation/builtin_va_arg_pack.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 validation/builtin_va_arg_pack.c

diff --git a/lib.c b/lib.c
index 7e822eb..3f687ae 100644
--- a/lib.c
+++ b/lib.c
@@ -777,6 +777,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_alpha_cmpbge(long, long);\n");
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
+	add_pre_buffer("extern __SIZE_TYPE__ __builtin_va_arg_pack_len(void);\n");
 	add_pre_buffer("extern void __sync_synchronize();\n");
 	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
 
@@ -876,6 +877,7 @@ void create_builtin_stream(void)
 	add_pre_buffer("#define __builtin_va_copy(dest, src) ({ dest = src; (void)0; })\n");
 	add_pre_buffer("#define __builtin_va_end(arg)\n");
 	add_pre_buffer("#define __builtin_ms_va_end(arg)\n");
+	add_pre_buffer("#define __builtin_va_arg_pack()\n");
 
 	/* FIXME! We need to do these as special magic macros at expansion time! */
 	add_pre_buffer("#define __BASE_FILE__ \"base_file.c\"\n");
diff --git a/validation/builtin_va_arg_pack.c b/validation/builtin_va_arg_pack.c
new file mode 100644
index 0000000..3426b86
--- /dev/null
+++ b/validation/builtin_va_arg_pack.c
@@ -0,0 +1,20 @@
+extern void v(int a, ...);
+
+extern inline __attribute__((__always_inline__)) void f(int a, ...)
+{
+	__SIZE_TYPE__ b = __builtin_va_arg_pack_len();
+}
+
+extern inline __attribute__((__always_inline__)) void g(int a, ...)
+{
+	v(a, __builtin_va_arg_pack());
+}
+
+static void h(void)
+{
+	f(0, 0);
+	g(0, 0);
+}
+/*
+ * check-name: __builtin_va_arg_pack()
+ */
-- 
1.8.3.1

