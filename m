From: Al Viro <viro@ftp.linux.org.uk>
Subject: [patches] misc fixes
Date: Fri, 25 May 2007 04:57:24 +0100
Message-ID: <E1HrQvc-00017z-Hz@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58091 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXEYD5Z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQvc-00017z-Hz
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:24 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Just starting to reduce the queue; there'll be more later.  In this
pile:
	handle __alignof as equivalent of __alignof__
	saner reporting of overlaps in initializers
	check for whitespace before object-like macro body
	fix alignment for _Bool
	fix interaction of typeof with bitwise types
	better recovery from bad operations on bitwise
