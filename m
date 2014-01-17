From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: gcc tickets for sparse attributes
Date: Fri, 17 Jan 2014 01:18:46 -0800
Message-ID: <20140117091845.GB577@leaf>
References: <52D8BF2C.9090604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38740 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbaAQJSx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 Jan 2014 04:18:53 -0500
Content-Disposition: inline
In-Reply-To: <52D8BF2C.9090604@zytor.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jan 16, 2014 at 09:27:08PM -0800, H. Peter Anvin wrote:
> I have filed gcc tickets asking for direct support in gcc for some
> sparse extensions that we use heavily in the kernel:
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59850
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59851
> 
> However, I would also like support for the context extensions, but I'm
> not knowledgeable enough to describe the semantics accurately.  Would
> anyone be willing to file a ticket describing how the context extension
> works well enough that it could be implemented?

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59856

Also:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=59855

- Josh Triplett
