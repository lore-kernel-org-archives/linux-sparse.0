From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH](take II) Sparse fooled by double semicolon
Date: Wed, 31 Jan 2007 02:46:38 -0500
Message-ID: <1170229598.11455.104.camel@dv>
References: <1170219027.11455.68.camel@dv>
	 <20070131065838.GA23326@chrisli.org>  <20070131071717.GA23495@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:34778 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbXAaHql (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 02:46:41 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HCAA0-0007lk-SQ
	for linux-sparse@vger.kernel.org; Wed, 31 Jan 2007 02:45:41 -0500
In-Reply-To: <20070131071717.GA23495@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Tue, 2007-01-30 at 23:17 -0800, Christopher Li wrote:
> Actually, this version is better because it handle semicolon
> as the first member as well.

That's working too.

-- 
Regards,
Pavel Roskin
