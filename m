From: Kim Phillips <kim.phillips@linaro.org>
Subject: [PATCH] sparse: add built-in atomic memory access identifiers
Date: Wed, 11 Dec 2013 15:00:13 -0600
Message-ID: <20131211150013.e009efdb3fa2321f113a8a8d@linaro.org>
References: <e016529d-1344-4eaa-8419-86cdf1e830cb@linaro.org>
	<20131210125236.b44159c60acfd62b30b9bc69@linaro.org>
	<CAKb83kaz+csV4Q=0P5Q+L75_CxYnL=RrDh4mSTujPmzJ9B7K-g@mail.gmail.com>
	<e444e44d-ffb4-4ba0-86fd-9b66bc1b08d5@linaro.org>
	<CADz3at2h9gDJkEz9FctvvPqj7_isoXj_hpPzJiQzSi2UNyn97g@mail.gmail.com>
	<CAKb83kYKo=YP4JC2cjo-Y76xEvC45CM=5Wf9rO1Hv-06OSt5-Q@mail.gmail.com>
	<CADz3at1A3id81XpKFf3gJhutWEpFi4zM0+xF=cfY-h_+ABd=gw@mail.gmail.com>
	<20131211120204.4e17a616138823d09c89d298@linaro.org>
	<CAKb83kZ4jYeiFAxpxqVwLtWYA3sobrN0vGDRzK0vs_jommsCwQ@mail.gmail.com>
	<CADz3at0E7W=V17mO6D6hZrLp82VoC42_Jz==iSVUykz6+76phQ@mail.gmail.com>
	<e92f5ecc-097b-401b-8554-6d3ada6be667@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:65304 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3LKVAQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Dec 2013 16:00:16 -0500
Received: by mail-ob0-f169.google.com with SMTP id wm4so7648496obc.28
        for <linux-sparse@vger.kernel.org>; Wed, 11 Dec 2013 13:00:15 -0800 (PST)
In-Reply-To: <e92f5ecc-097b-401b-8554-6d3ada6be667@linaro.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: lng-odp@linaro.org, bill.fischofer@linaro.org, petri.savolainen@linaro.org, mike.holmes@linaro.org, Christopher Li <sparse@chrisli.org>

this patch stops sparse from complaining about them not being
defined:

source/odp_spinlock.c:41:10: error: undefined identifier '__sync_lock_release'
source/odp_spinlock.c:54:10: error: undefined identifier '__sync_lock_release'
./odp_atomic.h:112:16: error: undefined identifier '__sync_fetch_and_add'

Reported-by: Mike Holmes <mike.holmes@linaro.org>
Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
---
also available here:

git://git.linaro.org/people/kim.phillips/sparse.git

 lib.c                       | 21 +++++++++++++++++++--
 validation/builtin_atomic.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 validation/builtin_atomic.c

diff --git a/lib.c b/lib.c
index fe20f93..bf3e91c 100644
--- a/lib.c
+++ b/lib.c
@@ -777,6 +777,25 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
 	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
 
+	/* And atomic memory access functions.. */
+	add_pre_buffer("extern int __sync_fetch_and_add(void *, ...);\n");
+	add_pre_buffer("extern int __sync_fetch_and_sub(void *, ...);\n");
+	add_pre_buffer("extern int __sync_fetch_and_or(void *, ...);\n");
+	add_pre_buffer("extern int __sync_fetch_and_and(void *, ...);\n");
+	add_pre_buffer("extern int __sync_fetch_and_xor(void *, ...);\n");
+	add_pre_buffer("extern int __sync_fetch_and_nand(void *, ...);\n");
+	add_pre_buffer("extern int __sync_add_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_sub_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_or_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_and_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_xor_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_nand_and_fetch(void *, ...);\n");
+	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
+	add_pre_buffer("extern int __sync_val_compare_and_swap(void *, ...);\n");
+	add_pre_buffer("extern void __sync_synchronize();\n");
+	add_pre_buffer("extern int __sync_lock_test_and_set(void *, ...);\n");
+	add_pre_buffer("extern void __sync_lock_release(void *, ...);\n");
+
 	/* And some random ones.. */
 	add_pre_buffer("extern void *__builtin_return_address(unsigned int);\n");
 	add_pre_buffer("extern void *__builtin_extract_return_addr(void *);\n");
@@ -794,8 +813,6 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern long __builtin_labs(long);\n");
 	add_pre_buffer("extern double __builtin_fabs(double);\n");
 	add_pre_buffer("extern __SIZE_TYPE__ __builtin_va_arg_pack_len(void);\n");
-	add_pre_buffer("extern void __sync_synchronize();\n");
-	add_pre_buffer("extern int __sync_bool_compare_and_swap(void *, ...);\n");
 
 	/* Add Blackfin-specific stuff */
 	add_pre_buffer(
diff --git a/validation/builtin_atomic.c b/validation/builtin_atomic.c
new file mode 100644
index 0000000..e56321a
--- /dev/null
+++ b/validation/builtin_atomic.c
@@ -0,0 +1,28 @@
+static void fn(void)
+{
+	static int i, *ptr = (void *)0;
+
+	i = __sync_fetch_and_add(ptr, 0);
+	i = __sync_fetch_and_sub(ptr, 0);
+	i = __sync_fetch_and_or(ptr, 0);
+	i = __sync_fetch_and_and(ptr, 0);
+	i = __sync_fetch_and_xor(ptr, 0);
+	i = __sync_fetch_and_nand(ptr, 0);
+	i = __sync_add_and_fetch(ptr, 0);
+	i = __sync_sub_and_fetch(ptr, 0);
+	i = __sync_or_and_fetch(ptr, 0);
+	i = __sync_and_and_fetch(ptr, 0);
+	i = __sync_xor_and_fetch(ptr, 0);
+	i = __sync_nand_and_fetch(ptr, 0);
+	i = __sync_bool_compare_and_swap(ptr, 0, 1);
+	i = __sync_val_compare_and_swap(ptr, 0, 1);
+	__sync_synchronize();
+	i = __sync_lock_test_and_set(ptr, 0);
+	__sync_lock_release(ptr);
+}
+
+/*
+ * check-name: __builtin_atomic
+ * check-error-start
+ * check-error-end
+ */
-- 
1.8.5.1

