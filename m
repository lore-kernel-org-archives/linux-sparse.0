From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 12:04:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk>
 <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org>
 <20070624183547.GA21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49580 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbXFXTF4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 15:05:56 -0400
In-Reply-To: <20070624183547.GA21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org



On Sun, 24 Jun 2007, Al Viro wrote:
> 
> Why?  I'd say it's not better than BUILD_BUG_ON_ZERO() use
> instead of that ?:

Oh, _that_ part I have no problem with. It's more that it seems that the 
gcc optimization is ok at least as an extension.

		Linus
