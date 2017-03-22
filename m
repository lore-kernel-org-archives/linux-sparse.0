From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] fix is_scalar_type()
Date: Wed, 22 Mar 2017 18:32:57 +0100
Message-ID: <20170322173257.63019-8-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35152 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935400AbdCVRdR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id u108so27795459wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:15 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

This helper was introduced to add some warning in conditionals
which must accept arrays and functions as those degenerate as
pointers in this context.

There was some sign of a bug somewhere but it wasn't seen
and as consequence arrays and function type were added to
scalar type (yeah, brown paper bag).

Now that the bug is solved, fix this by removing array and
function type from is_scalar_type().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/symbol.h b/symbol.h
index 512a2f69f..327449611 100644
--- a/symbol.h
+++ b/symbol.h
@@ -395,8 +395,6 @@ static inline int is_scalar_type(struct symbol *type)
 	case SYM_ENUM:
 	case SYM_BITFIELD:
 	case SYM_PTR:
-	case SYM_ARRAY:		// OK, will be a PTR after conversion
-	case SYM_FN:
 	case SYM_RESTRICT:	// OK, always integer types
 		return 1;
 	default:
-- 
2.12.0

