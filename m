From: Pavel Roskin <proski@gnu.org>
Subject: Sparse fooled by double semicolon
Date: Tue, 30 Jan 2007 23:50:27 -0500
Message-ID: <1170219027.11455.68.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:39414 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbXAaEu3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Jan 2007 23:50:29 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HC7PV-0004Hu-Mc
	for linux-sparse@vger.kernel.org; Tue, 30 Jan 2007 23:49:29 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HC7QS-0007CB-0e
	for linux-sparse@vger.kernel.org; Tue, 30 Jan 2007 23:50:28 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hello!

I have reduced a spurious sparse message to the following test:

#include <string.h>
void test(void)
{
	struct { int foo;; } val;
	memset(&val, 0, sizeof(val));
}

Running sparse on this code gives:

test.c:5:8: warning: memset with byte count of 0

Replacing two semicolons with one fixes the warning.  That's the current
sparse (006eff06c7adcfb0d06c6fadf6e9b64f0488b2bf) with no local changes.

-- 
Regards,
Pavel Roskin
