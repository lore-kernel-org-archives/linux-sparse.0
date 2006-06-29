From: Josh Triplett <josht@vnet.ibm.com>
Subject: [PATCH] Add test cases for __context__ statement and context
	attribute
Date: Thu, 29 Jun 2006 15:31:04 -0700
Message-ID: <1151620264.6507.18.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:62378 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S933063AbWF2WbE
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 Jun 2006 18:31:04 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5TMV3oT009604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 18:31:04 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5TMVL9C188540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 16:31:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5TMV3tk031746
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 16:31:03 -0600
Received: from IBM-882E9B45D97.beaverton.ibm.com (dyn9047018143.beaverton.ibm.com [9.47.18.143] (may be forged))
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5TMV3wX031734
	for <linux-sparse@vger.kernel.org>; Thu, 29 Jun 2006 16:31:03 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Add validation/context.c, which includes various test cases for
__context__(...)  and __attribute__((context(...))).  These test cases include
both correct usage, in the functions named good_*, and incorrect usage, in the
functions named warn_*.

Signed-off-by: Josh Triplett <josh@freedesktop.org>

---

Running sparse -Wcontext validation/context.c gives:
sparse/validation/context.c:64:6: warning: context imbalance in 'warn_lock1' - wrong count at exit
sparse/validation/context.c:69:6: warning: context imbalance in 'warn_lock2' - wrong count at exit
sparse/validation/context.c:76:6: warning: context imbalance in 'warn_lock3' - wrong count at exit
sparse/validation/context.c:83:6: warning: context imbalance in 'warn_unlock1' - unexpected unlock
sparse/validation/context.c:88:6: warning: context imbalance in 'warn_unlock2' - unexpected unlock
sparse/validation/context.c:126:5: warning: context imbalance in 'warn_if1' - wrong count at exit
sparse/validation/context.c:135:5: warning: context imbalance in 'warn_if2' - different lock contexts for basic block
sparse/validation/context.c:197:2: warning: context imbalance in 'warn_while1' - different lock contexts for basic block
sparse/validation/context.c:205:3: warning: context imbalance in 'warn_while2' - unexpected unlock
sparse/validation/context.c:211:2: warning: context imbalance in 'warn_while3' - wrong count at exit
sparse/validation/context.c:269:6: warning: context imbalance in 'warn_goto1' - wrong count at exit
sparse/validation/context.c:278:6: warning: context imbalance in 'warn_goto2' - wrong count at exit
sparse/validation/context.c:295:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block

 validation/context.c |  296 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 296 insertions(+), 0 deletions(-)
 create mode 100644 validation/context.c

8e4964e89379a83c9fc66e25b0d1dd86a2cb7618
diff --git a/validation/context.c b/validation/context.c
new file mode 100644
index 0000000..165d4f6
--- /dev/null
+++ b/validation/context.c
@@ -0,0 +1,296 @@
+void a(void) __attribute__((context(0,1)))
+{
+	__context__(1);
+}
+
+void r(void) __attribute__((context(1,0)))
+{
+	__context__(-1);
+}
+
+void good_paired1(void)
+{
+	a();
+	r();
+}
+
+void good_paired2(void)
+{
+	a();
+	r();
+	a();
+	r();
+}
+
+void good_paired3(void)
+{
+	a();
+	a();
+	r();
+	r();
+}
+
+void good_lock1(void) __attribute__((context(0,1)))
+{
+	a();
+}
+
+void good_lock2(void) __attribute__((context(0,1)))
+{
+	a();
+	r();
+	a();
+}
+
+void good_lock3(void) __attribute__((context(0,1)))
+{
+	a();
+	a();
+	r();
+}
+
+void good_unlock1(void) __attribute__((context(1,0)))
+{
+	r();
+}
+
+void good_unlock2(void) __attribute__((context(1,0)))
+{
+	a();
+	r();
+	r();
+}
+
+void warn_lock1(void)
+{
+	a();
+}
+
+void warn_lock2(void)
+{
+	a();
+	r();
+	a();
+}
+
+void warn_lock3(void)
+{
+	a();
+	a();
+	r();
+}
+
+void warn_unlock1(void)
+{
+	r();
+}
+
+void warn_unlock2(void)
+{
+	a();
+	r();
+	r();
+}
+
+extern int condition, condition2;
+
+int good_if1(void)
+{
+	a();
+	if(condition) {
+		r();
+		return -1;
+	}
+	r();
+	return 0;
+}
+
+void good_if2(void)
+{
+	if(condition) {
+		a();
+		r();
+	}
+}
+
+void good_if3(void)
+{
+	a();
+	if(condition) {
+		a();
+		r();
+	}
+	r();
+}
+
+int warn_if1(void)
+{
+	a();
+	if(condition)
+		return -1;
+	r();
+	return 0;
+}
+
+int warn_if2(void)
+{
+	a();
+	if(condition) {
+		r();
+		return -1;
+	}
+	return 0;
+}
+
+void good_while1(void)
+{
+	a();
+	while(condition)
+		;
+	r();
+}
+
+void good_while2(void)
+{
+	while(condition) {
+		a();
+		r();
+	}
+}
+
+void good_while3(void)
+{
+	while(condition) {
+		a();
+		r();
+		if(condition2)
+			break;
+		a();
+		r();
+	}
+}
+
+void good_while4(void)
+{
+	a();
+	while(1) {
+		if(condition2) {
+			r();
+			break;
+		}
+	}
+}
+
+void good_while5(void)
+{
+	a();
+	while(1) {
+		r();
+		if(condition2)
+			break;
+		a();
+	}
+}
+
+void warn_while1(void)
+{
+	while(condition) {
+		a();
+	}
+}
+
+void warn_while2(void)
+{
+	while(condition) {
+		r();
+	}
+}
+
+void warn_while3(void)
+{
+	while(condition) {
+		a();
+		if(condition2)
+			break;
+		r();
+	}
+}
+
+void good_goto1(void)
+{
+    a();
+    goto label;
+label:
+    r();
+}
+
+void good_goto2(void)
+{
+    a();
+    goto label;
+    a();
+    r();
+label:
+    r();
+}
+
+void good_goto3(void)
+{
+    a();
+    if(condition)
+        goto label;
+    a();
+    r();
+label:
+    r();
+}
+
+void good_goto4(void)
+{
+    if(condition)
+        goto label;
+    a();
+    r();
+label:
+    ;
+}
+
+void good_goto5(void)
+{
+    a();
+    if(condition)
+        goto label;
+    r();
+    return;
+label:
+    r();
+}
+
+void warn_goto1(void)
+{
+    a();
+    goto label;
+    r();
+label:
+    ;
+}
+
+void warn_goto2(void)
+{
+    a();
+    goto label;
+    r();
+label:
+    a();
+    r();
+}
+
+void warn_goto3(void)
+{
+    a();
+    if(condition)
+        goto label;
+    r();
+label:
+    r();
+}
