From: Al Viro <viro@ftp.linux.org.uk>
Subject: [patches] more type cleanups and fixes
Date: Fri, 13 Jul 2007 18:44:17 +0100
Message-ID: <E1I9PBh-0000DU-3s@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49714 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbXGMRoR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:44:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PBh-0000DU-3s
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:44:17 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

	Getting the handling of qualifiers/address spaces right on the
pointer operations, type_difference sanitized and taken closer to sanity
(in particular, kernel ARRAY_SIZE() works now), SYM_BASENAME and SYM_TYPEOF
handling sanitized.

	That takes us about halfway to getting rid of very brittle
dependencies between evaluate.c and type-handling details in symbol.c.

	The series can be pulled from branch type_difference2 in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/
individual patches follow in next postings...
