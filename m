From: ricknu-0@student.ltu.se
Subject: Re: Booleans, what a wonderful type!
Date: Thu, 19 Jul 2007 02:23:07 +0200
Message-ID: <1184804587.469eaeebb670c@portal.student.luth.se>
References: <1184723019.469d704b6111b@portal.student.luth.se>  <20070718021907.GS21668@ftp.linux.org.uk> <1184776398.2640.8.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:43852 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545AbXGSAXU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jul 2007 20:23:20 -0400
In-Reply-To: <1184776398.2640.8.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

Citerar Josh Triplett <josht@linux.vnet.ibm.com>:

> On Wed, 2007-07-18 at 03:19 +0100, Al Viro wrote:
> > On Wed, Jul 18, 2007 at 03:43:39AM +0200, ricknu-0@student.ltu.se wrote:
> > 
> > > * Most likly a _really_ stupid newbie question, but I have seen several
> of this
> > > form:
> > > <function>
> > > {
> > >         <variable> a;
> > >         <doing something useful (no sign of 'a')>
> > >         a = <some value/variable>;
> > >         <exit>
> > > }
> > > How is this variable useful?
> > 
> > Explain, please.  If you mean moving the declaration down - it's not
> > idiomatic in C and frankly, C++ style tends to make declarations harder
> > to find when you read the code.
> 
> Judging by that pseudocode, I would guess that he means the function
> never uses the value of a after assigning to it.  That would generally
> represent a bug.
> 
Yes exactly :)

Ok, then I know. Worrid it was some magic I could not get my mind around.

Thanks
Richard
