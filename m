From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] Add the __builtin functions needed for INFINITY and nan().
Date: Thu, 12 Mar 2015 00:19:19 +0100
Message-ID: <20150311231919.GA14617@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbbCKXTV (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2015 19:19:21 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BNJKSX021139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2015 19:19:20 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2BNJKIk029872
	for <linux-sparse@vger.kernel.org>; Wed, 11 Mar 2015 19:19:20 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
Needed for Wine. Not all of those but have added them for completeness.


 lib.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib.c b/lib.c
index 8dc5bcf..58a7f2e 100644
--- a/lib.c
+++ b/lib.c
@@ -876,6 +876,17 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_islessgreater(float, float);\n");
 	add_pre_buffer("extern int __builtin_isunordered(float, float);\n");
 
+	/* And some INFINITY / NAN stuff.. */
+	add_pre_buffer("extern double __builtin_huge_val(void);\n");
+	add_pre_buffer("extern float __builtin_huge_valf(void);\n");
+	add_pre_buffer("extern long double __builtin_huge_vall(void);\n");
+	add_pre_buffer("extern double __builtin_inf(void);\n");
+	add_pre_buffer("extern float __builtin_inff(void);\n");
+	add_pre_buffer("extern long double __builtin_infl(void);\n");
+	add_pre_buffer("extern double __builtin_nan(const char *);\n");
+	add_pre_buffer("extern float __builtin_nanf(const char *);\n");
+	add_pre_buffer("extern long double __builtin_nanl(const char *);\n");
+
 	/* And some __FORTIFY_SOURCE ones.. */
 	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
 	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
-- 
2.1.0
