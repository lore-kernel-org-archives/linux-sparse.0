From: Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v2] add __builtin functions for isinf_sign, isfinite and isnan
Date: Thu, 16 Nov 2017 16:08:17 -0700
Message-ID: <20171116230817.10011-1-logang@deltatee.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47068 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965988AbdKPXIW (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Nov 2017 18:08:22 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Logan Gunthorpe <logang@deltatee.com>

These bultins are defined by in gcc since 4.4. They are also now
used by the isinf, isfinite and isnan macros. So using them with a
newer gcc causes 'undefined identifier' errors.

Add the builtin definitions and some validation checks for these
functions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---

Changes since v1:
 * Remove math.h dependancy from validation tests. As a consequnce
   we don't test that the math functions work. (Per a request from
   Christopher.)

 lib.c                    | 3 +++
 validation/builtin_inf.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/lib.c b/lib.c
index 4602cf8..cc740e9 100644
--- a/lib.c
+++ b/lib.c
@@ -1105,6 +1105,9 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern double __builtin_nan(const char *);\n");
 	add_pre_buffer("extern float __builtin_nanf(const char *);\n");
 	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
+	add_pre_buffer("extern int __builtin_isinf_sign(float);\n");
+	add_pre_buffer("extern int __builtin_isfinite(float);\n");
+	add_pre_buffer("extern int __builtin_isnan(float);\n");

 	/* And some __FORTIFY_SOURCE ones.. */
 	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
diff --git a/validation/builtin_inf.c b/validation/builtin_inf.c
index 48546e4..f09f53f 100644
--- a/validation/builtin_inf.c
+++ b/validation/builtin_inf.c
@@ -7,6 +7,9 @@ static long double li = __builtin_infl();
 static double dn = __builtin_nan("");
 static float fn = __builtin_nanf("");
 static long double ln = __builtin_nanl("");
+static int inf = __builtin_isinf_sign(0.0);
+static int fin = __builtin_isfinite(0.0);
+static int nan = __builtin_isnan(0.0);

 /*
  * check-name: __builtin INFINITY / nan()
--
2.11.0
