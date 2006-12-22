From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC PATCH] Handling multiple -include directives
Date: Fri, 22 Dec 2006 17:27:44 -0500
Message-ID: <1166826464.27009.10.camel@dv>
References: <1166771189.18955.10.camel@dv> <1166773008.21614.4.camel@dv>
	 <20061222094748.GA32376@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:43236 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbWLVW1r (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Dec 2006 17:27:47 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1Gxsre-000454-1l
	for linux-sparse@vger.kernel.org; Fri, 22 Dec 2006 17:27:42 -0500
In-Reply-To: <20061222094748.GA32376@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hello!

On Fri, 2006-12-22 at 01:47 -0800, Christopher Li wrote:
> On Fri, Dec 22, 2006 at 02:36:48AM -0500, Pavel Roskin wrote:
> > On Fri, 2006-12-22 at 02:06 -0500, Pavel Roskin wrote:
> > > It seems to me that the existing add_pre_buffer() mechanism can be used
> > > instead.  I'm just a bit worried why it wasn't done like this in the
> > > first place.
> 
> I believe the reason it is not in the pre buffer is that it should first
> search the current directory instead of the source file directory. The command
> line -include has some subtle differences with #include "filename"

Then maybe we need some variation of #include, e.g. #include_cmdline.
And while at that, I think -imacros should be processed slightly
differently.
 
> > There was a reason to worry.  Now create_builtin_stream() is run after
> > the includes have been processed, so that e.g. the Linux compiler.h
> > tells me that my compiler is too old (because it was included from the
> > command line before __GNUC__ was defined).
> 
> That is the other reason as well :-)
>
> Can you please try this patch and see if it works for you?

I have tried it in current (svn) MadWifi, and the output is much more
agreeable, so I think the patch is working.

However, I would prefer that we don't use fixed size arrays.  It would
be much better in the long term to use the existing "code generator".
It would be a more uniform and scalable approach.  Besides, the
generated code could be dumped for debugging purposes.

By the way, the current MadWifi is a treasure trove for anyone looking
to improve sparse.  My impression is that most if not all reported
problems are bogus.

-- 
Regards,
Pavel Roskin
