From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add intro stolen from the wiki
Date: Tue, 16 Jun 2020 02:11:22 +0200
Message-ID: <20200616001122.65350-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPAL2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 15 Jun 2020 20:11:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00604C061A0E
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 17:11:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so19434523ejn.10
        for <linux-sparse@vger.kernel.org>; Mon, 15 Jun 2020 17:11:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The wiki has a small into, perfectable but nice
enough while the doc here has no such thing.

So, copy the intro from the wiki into the entrypoint
of the documentation (and convert the wikimedia markup
into restructuredtext).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index eb3de63c9ca7..415da4bb27af 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -6,6 +6,43 @@ Welcome to sparse's documentation
 .. toctree::
    :maxdepth: 1
 
+About Sparse
+------------
+
+Sparse, the semantic parser, provides a compiler frontend capable of
+parsing most of ANSI C as well as many GCC extensions, and a collection
+of sample compiler backends, including a static analyzer also called `sparse`.
+Sparse provides a set of annotations designed to convey semantic information
+about types, such as what address space pointers point to, or what locks
+function acquires or releases.
+
+Linus Torvalds started writing Sparse in 2003, initially targeting issues such
+as mixing pointers to user address space and pointers to kernel address space.
+
+Josh Triplett was Sparse's first maintainer in 2006. This role was taken over
+by Christopher Li in 2009 and by Luc Van Oostenryck in late 2018.
+
+Getting Sparse
+--------------
+
+You can find released versions of sparse at http://www.kernel.org/pub/software/devel/sparse/dist/
+
+Obtaining sparse via Git
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sparse uses the `Git version control system <http://git-scm.com/>`_. You can obtain the most recent version of sparse directly from the Git repository with the command::
+
+	git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
+
+You can also `browse the Git repository <https://git.kernel.org/pub/scm/devel/sparse/sparse.git>`_.
+
+Mailing list
+~~~~~~~~~~~~
+
+Discussions about sparse occurs on the sparse mailing list, linux-sparse@vger.kernel.org. To subscribe to the list, send an email with ``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
+
+You can browse the list archives at https://marc.info/?l=linux-sparse.
+
 User documentation
 ------------------
 .. toctree::
-- 
2.27.0
