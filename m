From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Test that causes sparse to hang
Date: Wed, 16 May 2007 08:17:16 +0100
Message-ID: <20070516071716.GJ4095@ftp.linux.org.uk>
References: <464AAEA0.9020300@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59367 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbXEPHRS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 03:17:18 -0400
Content-Disposition: inline
In-Reply-To: <464AAEA0.9020300@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Wed, May 16, 2007 at 12:11:28AM -0700, Josh Triplett wrote:
> While poking at the GCC testsuite, I found a source file that hangs Sparse.  I
> cut it down to the following minimal test case:
> 
> #if L'\x1234' != 0x1234
> #endif
> #if ''
> #endif
> 
> Documenting this on-list in case someone wants to look at it before I can get
> to it later.

No wide characters, so don't expect the identical behaviour...  Shouldn't
hang, obviously.  BTW, I wouldn't be too surprised if wide chars blow not
only in preprocessor.
