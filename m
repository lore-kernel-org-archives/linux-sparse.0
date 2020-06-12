From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: move meta-doc to its own section
Date: Sat, 13 Jun 2020 00:12:55 +0200
Message-ID: <20200612221255.12173-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWNE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Jun 2020 18:13:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572CC03E96F
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so11017650ejj.5
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The documentation about the documentation is in the middle of the
documentation about sparse itself.

Move it to its own section.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9f907c9f7aae..5dd87e43d264 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -22,7 +22,6 @@ Developer documentation
    dev-options
    api
    IR
-   doc-guide
    types
 
 How to contribute
@@ -33,6 +32,13 @@ How to contribute
    submitting-patches
    TODO
 
+Documentation
+-------------
+.. toctree::
+   :maxdepth: 1
+
+   doc-guide
+
 Indices and tables
 ==================
 
-- 
2.27.0
