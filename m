From: Pavel Roskin <proski@gnu.org>
Subject: Re: 0.3 ?
Date: Tue, 17 Apr 2007 22:31:14 -0400
Message-ID: <1176863474.3631.58.camel@dv>
References: <20070417162947.GA15753@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:40009 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030799AbXDRCbR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 17 Apr 2007 22:31:17 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HdzuV-0006a2-1Q
	for linux-sparse@vger.kernel.org; Tue, 17 Apr 2007 22:28:43 -0400
In-Reply-To: <20070417162947.GA15753@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Tue, 2007-04-17 at 12:29 -0400, Dave Jones wrote:
> Any plans to do another release sometime soon?
> I'm hitting a segfault with 0.2, that seems to be
> fixed in the current git tree.

Absolutely.  It would be very welcome.

I actually developed a habit of never loading any kernel code that
doesn't pass sparse checks on any system I don't want to hang, e.g. if
it's remote, it lacks a reset button or I'm writing an e-mail on it :)

I'm using sparse from git a lot, and whenever I have any issues, they
are in the sources sparse is checking, not in sparse itself.  It looks
quite stable to me.  It would be great to see sparse 0.3 released soon.

-- 
Regards,
Pavel Roskin
