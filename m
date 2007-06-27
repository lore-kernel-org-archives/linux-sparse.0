From: Alexey Dobriyan <adobriyan@sw.ru>
Subject: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 14:33:20 +0400
Message-ID: <20070627103320.GA11047@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:16626 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbXF0KdY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 06:33:24 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: adobriyan@gmail.com

sparse silently accepts some peculiar combinations of declaration
specifiers:

"typedef extern;" passes.

"void char a;" errors about void declaration, however,
"extern void char a;" passes. Hey, "extern void a;" passes!

"char short a;" passes too. Ditto for "char float a;" and
"char long a".

"typedef inline a;" passes.

Not sure how many different bugs there are here, though...
