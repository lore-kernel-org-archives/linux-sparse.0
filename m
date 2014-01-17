From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: gcc tickets for sparse attributes
Date: Fri, 17 Jan 2014 09:33:16 +0100
Message-ID: <1389947596.4354.2.camel@jlt4.sipsolutions.net>
References: <52D8BF2C.9090604@zytor.com>
	 (sfid-20140117_062719_321749_D2A4BB7E)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46120 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaAQIdW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 Jan 2014 03:33:22 -0500
In-Reply-To: <52D8BF2C.9090604@zytor.com> (sfid-20140117_062719_321749_D2A4BB7E)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 2014-01-16 at 21:27 -0800, H. Peter Anvin wrote:

> However, I would also like support for the context extensions, but I'm
> not knowledgeable enough to describe the semantics accurately.  Would
> anyone be willing to file a ticket describing how the context extension
> works well enough that it could be implemented?

IMHO the context extension doesn't work well enough in sparse to
document and implement as is. It would be much better if it actually was
able to differentiate between contexts, rather than treating each one
the same. This would avoid the problem that locking one lock and
unlocking another (in the kernel's __acquire/ __release mechanism) could
still result in a warning.

johannes

