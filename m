From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 17:00:50 +0100
Message-ID: <20070627160050.GY21478@ftp.linux.org.uk>
References: <20070627103320.GA11047@localhost.sw.ru> <1182956472.8970.35.camel@josh-work.beaverton.ibm.com> <46827F4D.7010305@knosof.co.uk> <20070627153133.GD11047@localhost.sw.ru> <4682836C.10201@knosof.co.uk> <468285D1.1020506@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40748 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757043AbXF0QA6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 12:00:58 -0400
Content-Disposition: inline
In-Reply-To: <468285D1.1020506@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, Jun 27, 2007 at 04:44:17PM +0100, Derek M Jones wrote:
 
> The point I did not mention before sending the email
> was the extent to which Sparse needs to check constructs
> that are constraint violations and thus assumed to be checked
> by the compiler.
> 
> Ok, it is possible to get weird looking stuff through sparse
> without complaint, but is it worth spending time flagging it?

Yes, if they turn into problems later on.  One practical reason
is that we are short on MOD_... bits; carrying MOD_LONG et.al.
might be a bad idea - we might want to choose the right integer
type (as in, the right struct symbol out of small set) and be
done with those; conversions can be done that way just fine, we
don't need to look at MOD_LONG et.al. for those.
