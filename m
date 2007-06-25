From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Mon, 25 Jun 2007 08:13:57 +0200
Message-ID: <2bd4710c5c9abe1b1e423f11425c1ea5@kernel.crashing.org>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:32786 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753644AbXFYGO7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jun 2007 02:14:59 -0400
In-Reply-To: <20070624203837.GE21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

> Humm...  Right, so __builtin_offsetof() needs special treatment too.
> Oh, bugger.  Is
> 	offsetof(struct foo, a.x[n])
> a documented extension?

It is.  See  info gcc -> C Extensions -> Offsetof


Segher
