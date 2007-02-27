From: Pavel Roskin <proski@gnu.org>
Subject: Re: Bogus locking warnings
Date: Tue, 27 Feb 2007 02:24:26 -0500
Message-ID: <1172561066.19312.28.camel@dv>
References: <1172540552.5835.41.camel@dv>
	 <Pine.LNX.4.64.0702262000460.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:59308 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbXB0HY2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 02:24:28 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HLwfl-0001Va-Hg
	for linux-sparse@vger.kernel.org; Tue, 27 Feb 2007 02:22:53 -0500
In-Reply-To: <Pine.LNX.4.64.0702262000460.12485@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

On Mon, 2007-02-26 at 20:19 -0800, Linus Torvalds wrote:

> and don't expect sparse to do any dynamic checking. It's expressly 
> designed to *not* do that, although some of the static optimizations
> are 
> clever enough that sometimes you are fooled into *thinking* that it 
> actually understands dynamic behaviour (ie being able to statically
> follow 
> a conditional jump to another identical conditional jump and simplify
> it 
> to a single branch).

It has been fooling me until now.  Anyway, thanks for the detailed
answer!  I'll try to do what you are suggesting.

-- 
Regards,
Pavel Roskin
