From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] sparse: document that -Wbitwise is default
Date: Tue, 17 Oct 2017 16:31:36 -0700
Message-ID: <20171017233136.24533-1-jacob.e.keller@intel.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35996 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755538AbdJQXbi (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Oct 2017 19:31:38 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>

In commit commit 02a886bfa3d9 ("Introduce keyword driven
attribute parsing", 2007-03-08) the -Wbitwise keyword was broken and did
not actually work. Instead, bitwise checks were always enabled.

This was fixed by commit commit 0dfda0d1f0fe ("make -Wbitwise
operational again", 2017-02-18) which allowed -Wbitwise and -Wno-bitwise
to work as expected.

However, since -Wbitwise was enabled for so long, that commit changed
the default of -Wbitwise to be enabled, rather than the documented
"disabled".

Fix the documentation to match, and explain that -Wbitwise is enabled by
default and must be disabled.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 sparse.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sparse.1 b/sparse.1
index fd4527aa5c95..bdfe14902ba6 100644
--- a/sparse.1
+++ b/sparse.1
@@ -67,8 +67,8 @@ kind of like "NULL" for pointers). So "gfp_t" or the "safe endianness"
 types would be __bitwise: you can only operate on them by doing
 specific operations that know about *that* particular type.
 
-Generally, you want bitwise if you are looking for type safety. Sparse
-does not issue these warnings by default.
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-bitwise\fR.
 .
 .TP
 .B \-Wcast\-to\-as
-- 
2.14.1.436.g33e61a4f0239

