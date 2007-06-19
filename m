From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 23:41:25 +0100
Message-ID: <20070619224125.GP21478@ftp.linux.org.uk>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk> <46783975.4080704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34023 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbXFSWl2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 18:41:28 -0400
Content-Disposition: inline
In-Reply-To: <46783975.4080704@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On Tue, Jun 19, 2007 at 10:15:49PM +0200, Michael Stefaniuc wrote:
> Not sure if this is a poll but -Wparen-string doesn't add any new
> warnings to the Wine run. And Wine has a "strange" way of specifying
> wide char strings.

Oh?  FWIW, C99 way is L"......" for wide string literals and L'...' for
wide character ones.  sparse doesn't handle either and I'm not sure if
we really want to open that can of worms...
