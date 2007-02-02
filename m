From: Christopher Li <sparse@chrisli.org>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 2 Feb 2007 15:03:17 -0800
Message-ID: <20070202230317.GE27667@chrisli.org>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org> <1170455865.4698.8.camel@dv> <20070202223155.GD27667@chrisli.org> <20070202231705.GF10050@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc15.comcast.net ([204.127.225.95]:57671 "EHLO
	alnrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946157AbXBBXaP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 18:30:15 -0500
Content-Disposition: inline
In-Reply-To: <20070202231705.GF10050@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 11:17:05PM +0000, Al Viro wrote:
> On Fri, Feb 02, 2007 at 02:31:55PM -0800, Christopher Li wrote:
> 
> I'm not sure.  __transparent_union__ is an atrocious kludge and it does
> deserve a warning.  So getting it to STFU on known offenders we have no
> chance to fix is OK, but legitimizing that abortion is not.

I did not mean to legitimizing it. I just don't want to silence
suppress this kind of warnings.

> Unlike __transparent_union__, restrict is at least a valid C...  It's not
> that hard to handle, except for the shortage of bits for modifiers...

I have a patch free up the specials bits in modifiers. It helps a little
bit. But I think we need a attribute pointer in ctype to fit more attributes
eventually.

Chris
