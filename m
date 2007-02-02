From: Pavel Roskin <proski@gnu.org>
Subject: Feature request - suppress warnings for system libraries
Date: Fri, 02 Feb 2007 12:43:03 -0500
Message-ID: <1170438183.2272.29.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:39532 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945998AbXBBRnE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 12:43:04 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HD2QD-0006ER-7D
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 12:42:01 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HD2RD-00019A-DR
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 12:43:03 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

It would be great if sparse could optionally suppress warnings about
system headers included using from implicit locations, such as
"usr/include", "/usr/local/include" and GCC_INTERNAL_INCLUDE (see
pre-process.c).

Perhaps some major warnings could be left if they can indicate that
sparse may have failed to parse the header properly.  But the petty
stuff should be suppressed.

This would greatly help make sparse useful for code other than Linux
kernel.

-- 
Regards,
Pavel Roskin
