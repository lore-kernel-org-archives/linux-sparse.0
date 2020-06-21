From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add some info to the main page
Date: Sun, 21 Jun 2020 11:39:28 +0200
Message-ID: <20200621093928.40272-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFUJje (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Jun 2020 05:39:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C3C061794
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jun 2020 02:39:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so14876680ejc.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jun 2020 02:39:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add some info about:
* how to get sparse
* how to install it,
* the mailing list and how to report bugs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 415da4bb27af..737f442323b5 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -25,23 +25,43 @@ by Christopher Li in 2009 and by Luc Van Oostenryck in late 2018.
 Getting Sparse
 --------------
 
-You can find released versions of sparse at http://www.kernel.org/pub/software/devel/sparse/dist/
+You can find tarballs of released versions of Sparse at
+http://www.kernel.org/pub/software/devel/sparse/dist/.
 
-Obtaining sparse via Git
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Sparse uses the `Git version control system <http://git-scm.com/>`_. You can obtain the most recent version of sparse directly from the Git repository with the command::
+The most recent version can be obtained directly from the Git
+repository with the command::
 
 	git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
 
-You can also `browse the Git repository <https://git.kernel.org/pub/scm/devel/sparse/sparse.git>`_.
+You can also `browse the Git repository <https://git.kernel.org/pub/scm/devel/sparse/sparse.git>`_
+or use the mirror at https://github.com/lucvoo/sparse.
+
+Once you have the sources, to build Sparse and install it in your ~/bin
+directory, just do::
+
+	cd sparse
+	make
+	make install
+
+To install it in another directory, use::
+
+	make PREFIX=<some directory> install
+
+Contributing and reporting bugs
+-------------------------------
 
-Mailing list
-~~~~~~~~~~~~
+Submission of patches and reporting of bugs, as well as discussions
+related to Sparse, should be done via the mailing list:
+linux-sparse@vger.kernel.org.
+You do not have to be subscribed to the list to send a message there.
+Previous discussions and bug reports are available on the list
+archives at https://marc.info/?l=linux-sparse.
 
-Discussions about sparse occurs on the sparse mailing list, linux-sparse@vger.kernel.org. To subscribe to the list, send an email with ``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
+To subscribe to the list, send an email with
+``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
 
-You can browse the list archives at https://marc.info/?l=linux-sparse.
+Bugs can also be reported and tracked via the Linux kernel's bugzilla:
+http://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools.
 
 User documentation
 ------------------
-- 
2.27.0
