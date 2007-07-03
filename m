From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] explicitly signed and friends
Date: Wed, 4 Jul 2007 00:01:41 +0100
Message-ID: <20070703230141.GI21478@ftp.linux.org.uk>
References: <20070702203008.GH21478@ftp.linux.org.uk> <468A6D89.3050800@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56525 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbXGCXBm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Jul 2007 19:01:42 -0400
Content-Disposition: inline
In-Reply-To: <468A6D89.3050800@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: linux-sparse@vger.kernel.org

On Tue, Jul 03, 2007 at 04:38:49PM +0100, Derek M Jones wrote:
> Al,
> 
> >4)
> >gcc is kinda-sorta tolerant to mixing pointers to signed and unsigned,
> >unless you explicitly ask to be strict.  However, it's nowhere near
> >as lenient as sparse.

> Having sparse complain about
> constructs that gcc is rather lax about means that those involved in
> kernel development might fix the underlying problem in their code.

Compare the last two sentences...
