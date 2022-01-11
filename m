Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3856C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 11 Jan 2022 23:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiAKXlX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 11 Jan 2022 18:41:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:58589 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243308AbiAKXlX (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Jan 2022 18:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641944483; x=1673480483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZrSlmrHkG+kjcvrXXt035DriO463iyTTOLKkov5Ah/Y=;
  b=Ud4tPg4iVrCjKgJr1jQK5wzXLSZtM/YbvMlA0sJiFFXE+qNCtK4tuhmC
   ktPBCbDrpQ4aHIIl+znrGr8QDaZqlqaOxmTXRFLeje5PIHO0ZGSDvQCiH
   vVhKvw4735Wr5zh5FH6osfmYndr2Zw+BsN/BjsHLGTshUmT6JfNBYguQi
   XUNfsNiD+75suQ2DefcKdYXjzGP2fh95yK4EfmkuDmE7EcF4sgGLJCqr3
   MmAWrlmISd5J3uv9owVa9qtH63+6yQnJODTuEoq0V7stza+ePzTtbRa8Y
   k0dvoIqGN/cleiZqA2rHdBmHwhA3dRPlIEH/h6dSLCPzYzrP4phyzpwit
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="223599931"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="223599931"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:41:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="490550203"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 15:41:22 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] sparse: only warn about directly nested flexible arrays
Date:   Tue, 11 Jan 2022 15:39:59 -0800
Message-Id: <20220111233959.2301120-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.34.1.182.ge773545c7fe7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Commit 02ed28909f3b ("flex-array: warn on flexible array in nested
aggregate types") Introduced a new -Wflexible-array-nested warning which
produces a warning when code nests a flexible array aggregate type
within another aggregate type.

This can produce warnings that are difficult to understand if this
becomes nested. Consider the following example code:

struct a {
  int i;
  long f[];
};

struct b {
  struct a a;
};

struct c {
  struct b b;
};

This will produce a warning both at struct b which directly embeds the
struct a, and also at c which happens to include struct a recursively.

It does not make sense to warn at the site of struct c. We already
produce a warning at struct b! This just confuses users and can produce
lots of extra warnings. Consider if struct b was part of some header
and all of its users now see warnings for their usages like 'struct c'
which now look like their fault, when the fault really lies with the
definition of struct b.

To avoid this, stop proliferating has_flexible_array so that the outer
struct no longer produces a warning.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

This patch is a response to my query at
https://lore.kernel.org/linux-sparse/64238376-3882-2449-7758-e948cb4a6e1c@intel.com/T/#u

I think that proliferating this warning is unnecessary (since it will
produce one warning at the exact point where we embed the structure already)
and avoids confusing users of a header into thinking their code is at fault
when its the code in the header at fault.

 symbol.c                       | 2 --
 validation/flex-array-nested.c | 9 +++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/symbol.c b/symbol.c
index 91352a3a447b..d066515fc8ed 100644
--- a/symbol.c
+++ b/symbol.c
@@ -231,8 +231,6 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
 				info.max_align = member->ctype.alignment;
 		}
 
-		if (has_flexible_array(member))
-			info.has_flex_array = 1;
 		if (has_flexible_array(member) && Wflexible_array_nested)
 			warning(member->pos, "nested flexible array");
 		fn(member, &info);
diff --git a/validation/flex-array-nested.c b/validation/flex-array-nested.c
index 094de2fbc392..81384ec6fd32 100644
--- a/validation/flex-array-nested.c
+++ b/validation/flex-array-nested.c
@@ -11,11 +11,16 @@ union u {
 	struct f f;
 };
 
+struct v {
+	struct s s;
+};
+
 // trigger the examination of the offending types
-static int foo(struct s *s, union u *u)
+static int foo(struct s *s, union u *u, struct v *v)
 {
 	return    __builtin_offsetof(typeof(*s), f)
-		+ __builtin_offsetof(typeof(*u), f);
+		+ __builtin_offsetof(typeof(*u), f)
+		+ __builtin_offsetof(typeof(*v), s);
 }
 
 /*
-- 
2.34.1.182.ge773545c7fe7

