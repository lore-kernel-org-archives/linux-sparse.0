From: Josh Triplett <josh@joshtriplett.org>
Subject: Bug: "typeof(*p) *" drops const
Date: Fri, 6 Sep 2013 07:53:21 -0700
Message-ID: <20130906145320.GA26549@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44738 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab3IFOx1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Sep 2013 10:53:27 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com

The following test case compiles via GCC with no errors or warnings, but
generates a type warning with sparse:

void f(void);
void f(void)
{
    const int *pc;
    typeof(*pc) *pc2 = pc;
}

Sparse says:

typeof-const.c:5:24: warning: incorrect type in initializer (different modifiers)
typeof-const.c:5:24:    expected int *pc2
typeof-const.c:5:24:    got int const *pc

Since pc has type "const int *", "typeof(*pc) *" should also have type
"const int *", not "int *".

The actual use case for which this came up occurred in the kernel when
using the equivalent of:

typeof(*p) __attribute__((address_space(0),force)) *

to generate the same type as p but in address space 0 rather than
whatever address space p had.  That worked fine for non-const pointers,
but const pointers lost their constness, resulting in constness
warnings.

The following patch adds a test case for this; please apply once sparse
handles this case correctly:

---------->8----------
From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] validation: Add new test case for typeof(*ptr) preserving const

If ptr has type "const foo *", then "typeof(*ptr) *" should also have
type "const foo *", not "foo *".  Add a test to ensure that.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 validation/typeof-const.c | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 validation/typeof-const.c

diff --git a/validation/typeof-const.c b/validation/typeof-const.c
new file mode 100644
index 0000000..d02d39a
--- /dev/null
+++ b/validation/typeof-const.c
@@ -0,0 +1,9 @@
+void f(void);
+void f(void)
+{
+    const int *pc;
+    typeof(*pc) *pc2 = pc;
+}
+/*
+ * check-name: typeof-const.c
+ */
-- 
1.8.4.rc3
