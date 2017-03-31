From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 07/25] constexpr: add support for tagging arithmetic constant expressions
Date: Fri, 31 Mar 2017 03:44:41 +0200
Message-ID: <20170331014459.9351-8-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33272 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934847AbdCaBqg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:36 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so16611188wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:35 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Arithmetic constant expressions may be either of (6.6(8)):
- integer constant expressions
- floating point constants
or any arithmetic expression build up from them.
Furthermore, casts with arithmetic destination types preserve
arithmetic constness.

Arithmetic constant expressions may be used as initializers for
objects of static storage duration.

Introduce a new constexpr flag : CEF_ACE.

Modify CEF_SET_ICE and CEF_SET_FLOAT to also include that new bit.
Thus, whenever an integer constant expression or a floating point
constant is recognized, it is automatically tagged as an arithmetic
constant expression.

Note that everything has already been set up such that the new flag
propagates nicely from subexpressions to parent expressions at evaluation.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/expression.h b/expression.h
index c084783c8..67b6a83e3 100644
--- a/expression.h
+++ b/expression.h
@@ -96,16 +96,19 @@ enum constexpr_flag {
 	/*
 	 * A constant expression in the sense of [6.6]:
 	 * - integer constant expression [6.6(6)]
+	 * - arithmetic constant expression [6.6(8)]
 	 */
 	CEF_ICE = (1 << 4),
+	CEF_ACE = (1 << 5),
 
-
-	CEF_SET_ICE = (CEF_ICE),
+	/* integer constant expression => arithmetic constant expression */
+	CEF_SET_ICE = (CEF_ICE | CEF_ACE),
 
 	/* integer constant => integer constant expression */
 	CEF_SET_INT = (CEF_INT | CEF_SET_ICE),
 
-	CEF_SET_FLOAT = (CEF_FLOAT),
+	/* floating point constant => arithmetic constant expression */
+	CEF_SET_FLOAT = (CEF_FLOAT | CEF_ACE),
 
 	/* enumeration constant => integer constant expression */
 	CEF_SET_ENUM = (CEF_ENUM | CEF_SET_ICE),
@@ -118,14 +121,13 @@ enum constexpr_flag {
 	 * expression" [6.6] flags.
 	 */
 	CEF_CONST_MASK = (CEF_INT | CEF_FLOAT | CEF_CHAR),
-};
 
-/*
- * not an integer constant expression => neither of integer,
- * enumeration and character constant
- */
-#define CEF_CLR_ICE \
-	(CEF_ICE | CEF_INT | CEF_ENUM |	CEF_CHAR)
+	/*
+	 * not an integer constant expression => neither of integer,
+	 * enumeration and character constant
+	 */
+	CEF_CLR_ICE = (CEF_ICE | CEF_INT | CEF_ENUM | CEF_CHAR),
+};
 
 enum {
 	Taint_comma = 1,
-- 
2.12.0

