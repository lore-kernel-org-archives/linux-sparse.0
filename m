From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] IR: fix typo in IR doc
Date: Wed, 14 Feb 2018 02:08:39 +0100
Message-ID: <20180214010843.23651-2-luc.vanoostenryck@gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44383 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBKy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:10:54 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so13604844wrc.11
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:10:54 -0800 (PST)
In-Reply-To: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index f18d3507d..f212fe6c4 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -8,7 +8,7 @@ used by which operation.
 Some of those fields are used by almost all instructions,
 some others are specific to only one or a few instructions.
 The common ones are:
-- .src1, .src2, .src2, .src3: (pseudo_t) operands of binops or ternary ops.
+- .src1, .src2, .src3: (pseudo_t) operands of binops or ternary ops.
 - .src: (pseudo_t) operand of unary ops (alias for .src1).
 - .target: (pseudo_t) result of unary, binary & ternary ops, is sometimes used
 	otherwise by some others instructions.
-- 
2.16.0

