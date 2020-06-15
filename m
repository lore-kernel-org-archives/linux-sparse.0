From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: minimal version for Sphinx is 1.7
Date: Mon, 15 Jun 2020 18:40:22 +0200
Message-ID: <20200615164022.59492-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgFOQk1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Jun 2020 12:40:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3526C061A0E
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 09:40:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f7so18154165ejq.6
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 09:40:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Because of the changes needed after the removal of the obsolete
sphinx.ext.autodoc.AutodocReporter, the minimal version of Sphinx
is 1.7 (the first one containing switch_source_input()).

So, update this information in the conf file.

Fixes: b741a793e63c0fd4a333cd575ac2339f5a9b2698
Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/conf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 90583908c5ed..bd2532f7c777 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -21,7 +21,7 @@ import datetime
 
 # -- General configuration ------------------------------------------------
 
-needs_sphinx = '1.3'
+needs_sphinx = '1.7'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
-- 
2.27.0
