From: "H. Peter Anvin" <hpa@zytor.com>
Subject: gcc tickets for sparse attributes
Date: Thu, 16 Jan 2014 21:27:08 -0800
Message-ID: <52D8BF2C.9090604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49440 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaAQF1Q (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 Jan 2014 00:27:16 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

I have filed gcc tickets asking for direct support in gcc for some
sparse extensions that we use heavily in the kernel:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59850
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59851

However, I would also like support for the context extensions, but I'm
not knowledgeable enough to describe the semantics accurately.  Would
anyone be willing to file a ticket describing how the context extension
works well enough that it could be implemented?

	-hpa
