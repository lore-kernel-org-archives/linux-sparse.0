From: Pavel Roskin <proski@gnu.org>
Subject: The __cold__ attribute again
Date: Fri, 27 Jun 2008 12:00:59 -0400
Message-ID: <1214582459.6045.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:24967 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbYF0QBB (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 12:01:01 -0400
Received: from [192.168.0.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 0754A618F22
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 12:00:59 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>

Hello!

It would be nice to have a new release with the __cold__ attribute
support in time for Linux 2.6.26 release, which uses __cold__ in some
important headers, including linux/kernel.h.  Otherwise, sparse will be
useless with the new kernel.

-- 
Regards,
Pavel Roskin
