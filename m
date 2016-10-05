From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] sparse: add 'alloc_align' to the ignored attributes
Date: Thu, 6 Oct 2016 00:49:18 +0100
Message-ID: <9a2e66f5-fdd3-1785-218b-4d5071d301c3@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:46179 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbcJEXtY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Oct 2016 19:49:24 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christopher,

As you requested, I have added a test for v2 of the patch.

[BTW gcc (version 5.4.0) issues numerous 'enumeration value
not handled in switch' warnings while compiling parse.c.]

ATB,
Ramsay Jones

 parse.c                  |  2 ++
 validation/alloc-align.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 validation/alloc-align.c

diff --git a/parse.c b/parse.c
index b43d683..4b03192 100644
--- a/parse.c
+++ b/parse.c
@@ -504,6 +504,8 @@ static struct init_keyword {
 const char *ignored_attributes[] = {
 	"alias",
 	"__alias__",
+	"alloc_align",
+	"__alloc_align__",
 	"alloc_size",
 	"__alloc_size__",
 	"always_inline",
diff --git a/validation/alloc-align.c b/validation/alloc-align.c
new file mode 100644
index 0000000..e414257
--- /dev/null
+++ b/validation/alloc-align.c
@@ -0,0 +1,38 @@
+typedef unsigned long int size_t;
+
+/*
+ * The alloc_align attribute is used to tell the compiler that the return
+ * value points to memory, where the returned pointer minimum alignment is given
+ * by one of the functions parameters. GCC uses this information to improve
+ * pointer alignment analysis.
+ *
+ * The function parameter denoting the allocated alignment is specified by one
+ * integer argument, whose number is the argument of the attribute. Argument
+ * numbering starts at one.
+ *
+ * For instance,
+ *
+ *    void* my_memalign(size_t, size_t) __attribute__((alloc_align(1)))
+ *
+ * declares that my_memalign returns memory with minimum alignment given by
+ * parameter 1.
+ */
+
+#define __alloc_align(x)  __attribute__((__alloc_align__(x)))
+
+/*
+ * The aligned_alloc function allocates space for an object whose alignment is
+ * specified by alignment, whose size is specified by size, and whose value is
+ * indeterminate. The value of alignment shall be a valid alignment supported
+ * by the implementation and the value of size shall be an integral multiple
+ * of alignment.
+ *
+ * The aligned_alloc function returns either a null pointer or a pointer to the
+ * allocated space.
+ */
+void *aligned_alloc(size_t alignment, size_t size) __alloc_align(1);
+
+
+/*
+ * check-name: attribute __alloc_align__
+ */
-- 
2.10.0
