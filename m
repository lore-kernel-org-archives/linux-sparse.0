From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] doc: do not use obsolete sphinx.ext.autodoc.AutodocReporter
Date: Mon, 18 May 2020 01:27:17 +0200
Message-ID: <20200517232719.1789-2-luc.vanoostenryck@gmail.com>
References: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgEQX1Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:27:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9347DC061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so9658686wrp.12
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:27:25 -0700 (PDT)
In-Reply-To: <20200517232719.1789-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sphinx.ext.autodoc.AutodocReporter is obsolete since Sphinx 1.7
and removed in some later versions.

So, replace it by the code suggested in the release notes when
it was obsoleted.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/sphinx/cdoc.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/sphinx/cdoc.py b/Documentation/sphinx/cdoc.py
index 318e9b23626e..73c128cb7b35 100755
--- a/Documentation/sphinx/cdoc.py
+++ b/Documentation/sphinx/cdoc.py
@@ -269,7 +269,7 @@ if __name__ == '__main__':
 	dump_doc(extract(sys.stdin, '<stdin>'))
 
 
-from sphinx.ext.autodoc import AutodocReporter
+from sphinx.util.docutils import switch_source_input
 import docutils
 import os
 class CDocDirective(docutils.parsers.rst.Directive):
@@ -294,13 +294,13 @@ class CDocDirective(docutils.parsers.rst.Directive):
 
 		## let parse this new reST content
 		memo = self.state.memo
-		save = memo.reporter, memo.title_styles, memo.section_level
-		memo.reporter = AutodocReporter(lst, memo.reporter)
+		save = memo.title_styles, memo.section_level
 		node = docutils.nodes.section()
 		try:
-			self.state.nested_parse(lst, 0, node, match_titles=1)
+			with switch_source_input(self.state, lst):
+				self.state.nested_parse(lst, 0, node, match_titles=1)
 		finally:
-			memo.reporter, memo.title_styles, memo.section_level = save
+			memo.title_styles, memo.section_level = save
 		return node.children
 
 def setup(app):
-- 
2.26.2
