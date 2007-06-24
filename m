From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 21:40:06 +0200
Message-ID: <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:59011 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751352AbXFXTka (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 15:40:30 -0400
In-Reply-To: <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

>> Why?  I'd say it's not better than BUILD_BUG_ON_ZERO() use
>> instead of that ?:
>
> Oh, _that_ part I have no problem with. It's more that it seems that 
> the
> gcc optimization is ok at least as an extension.

Sure, but it's not an extension (yet), but an implementation
side-effect; it would have to be (semi-formally) defined in
the manual to be an extension.  Until that happens, anyone
using this "feature" risks haven his code broken at any time
(or, rather, his code already was broken but he didn't know
it).

See gcc.gnu.org/PR456 for more discussion.  Yes it's an old
bug...


Segher
