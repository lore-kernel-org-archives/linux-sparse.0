From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Sparse fooled by double semicolon
Date: Wed, 31 Jan 2007 02:43:03 -0500
Message-ID: <1170229383.11455.102.camel@dv>
References: <1170219027.11455.68.camel@dv>
	 <20070131065838.GA23326@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:47295 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbXAaHnI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 02:43:08 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HCA6Z-0007j1-Rl
	for linux-sparse@vger.kernel.org; Wed, 31 Jan 2007 02:42:08 -0500
In-Reply-To: <20070131065838.GA23326@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Tue, 2007-01-30 at 22:58 -0800, Christopher Li wrote:
> Good catch, can you please try the following patch?

Good fix, it's working!  Even on the original code.  Thank you!

-- 
Regards,
Pavel Roskin
