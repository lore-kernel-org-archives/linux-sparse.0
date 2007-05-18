From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Differences in the behaviour of sparse and gcc within cygwin environment
Date: Fri, 18 May 2007 21:47:35 +0100
Message-ID: <20070518204735.GY4095@ftp.linux.org.uk>
References: <OFD0819B39.CB485382-ONC12572DF.003FFDE5-C12572DF.004060F0@br-automation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57741 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbXERUrh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 May 2007 16:47:37 -0400
Content-Disposition: inline
In-Reply-To: <OFD0819B39.CB485382-ONC12572DF.003FFDE5-C12572DF.004060F0@br-automation.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Schmid <Thomas.Schmid@br-automation.com>
Cc: linux-sparse@vger.kernel.org

On Fri, May 18, 2007 at 01:43:11PM +0200, Thomas Schmid wrote:
> I use sparse in a cygwin environment to obtain pre-build info from 
> sourcefiles which get comiled with gcc (also compiled with cygwin).
> 
> After some time of using sparse, I noticed some differences in the 
> behaviour of sparse and gcc:
> 1. Symbolnames with "$" are accepted by gcc but not by sparse

ewww...  It's not hard to change, but I strongly recommend making it
ifdefed and *not* included on sane boxen.  Rationale: that affects one
of the hottest paths in the entire thing.

Who uses $ in identifiers, anyway, when it's guaranteed to be non-portable?
gcc accepts it as a bloody misguided extension, but it's not standard C by
any stretch of imagination.  What are you working with, a bunch of old code
originating on VMS?

> 2. #include "..\plc.h" is accepted by gcc but not by sparse => "\" is 
> interpreted as escape- character
> 3. #include "D:\plc.h" is accepted by gcc but not by sparse

*argh*

sparse takes a shortcut - it treats header-name as string-literal.  In
principle, these are distinct tokens.  We could try to change that, but...
that makes tokenizer context-dependent in a fairly upleasant way.

Note that \ in header-name is explicitly undefined behaviour (6.4.7(3)),
and compilers I've seen on weird systems of that kind tend to remap / on \
in header names anyway before trying to look for files to include.
