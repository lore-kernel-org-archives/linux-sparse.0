From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Re: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 09:29:05 -0800
Message-ID: <20070214172905.GA17959@chrisli.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.200.83]:59876 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbXBNR6t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 12:58:49 -0500
Content-Disposition: inline
In-Reply-To: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>

> fs/ntfs/sysctl.c:38:15: error: undefined identifier 'CTL_UNNUMBRED'
Sparse left empty ctype when error happen. Sparse should skip
the expand_symbol() at all if error happen. 

Please try this patch:

Fix the segfault when initializer has unknown symbol

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/expand.c
===================================================================
--- sparse.orig/expand.c	2007-02-14 09:28:57.000000000 -0800
+++ sparse/expand.c	2007-02-14 09:44:59.000000000 -0800
@@ -872,7 +872,7 @@ static void verify_nonoverlapping(struct
 	struct expression *b;
 
 	FOR_EACH_PTR(*list, b) {
-		if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
+		if (a && a->ctype && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
 			sparse_error(a->pos, "Initializer entry defined twice");
 			info(b->pos, "  also defined here");
 			return;
