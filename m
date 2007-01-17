From: Christopher Li <sparse@chrisli.org>
Subject: Re: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 22:31:47 -0800
Message-ID: <20070117063147.GA2077@chrisli.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org> <45ACC3DD.6050702@freedesktop.org> <20070117014923.GA641@chrisli.org> <45ADB71D.3080502@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([206.18.177.52]:36085 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXAQGyr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 01:54:47 -0500
Content-Disposition: inline
In-Reply-To: <45ADB71D.3080502@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 16, 2007 at 09:41:49PM -0800, Josh Triplett wrote:
> > Without cross function/file checking, the interrupt checking generates way
> > too many false positives.
> 
> Sounds a lot like the context checking. :)

That is because the rules of the checking is too restrictive. 

> The use of strcmp on asm strings for x86 instruction mnemonics seems like a
> problem, though.

Yes, I agree. The interrupt checking is an example of how the checker
can be written. It is not very usable as it is. I have a few idea to address
it, but it will not help the usability issue. Cross functions checking is the
way to go.

Chris
