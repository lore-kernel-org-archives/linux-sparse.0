From: Pavel Roskin <proski@gnu.org>
Subject: Apostrophes confuse preprocessor
Date: Thu, 12 Jul 2007 12:33:47 -0400
Message-ID: <1184258027.9594.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:37411 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759794AbXGLQdt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jul 2007 12:33:49 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I91cT-0008AK-3B
	for linux-sparse@vger.kernel.org; Thu, 12 Jul 2007 12:34:21 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1I91bv-0003eX-DK
	for linux-sparse@vger.kernel.org; Thu, 12 Jul 2007 12:33:47 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

Sparse reports errors for apostrophes in preprocessor directives.  To
make things worse, it suppresses all useful warnings in the file.

$ cat test.c
#error Don't do it
$ sparse test.c 
test.c:1:13: error: Bad character constant
test.c:1:2: error: Don do it
$ gcc test.c
test.c:1:2: error: #error Don't do it
$

-- 
Regards,
Pavel Roskin
