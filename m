From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC PATCH] Handling multiple -include directives
Date: Fri, 22 Dec 2006 02:36:48 -0500
Message-ID: <1166773008.21614.4.camel@dv>
References: <1166771189.18955.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:51230 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945958AbWLVHgv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Dec 2006 02:36:51 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1GxexS-0001OX-Jn
	for linux-sparse@vger.kernel.org; Fri, 22 Dec 2006 02:36:46 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1GxexU-0005j1-Lc
	for linux-sparse@vger.kernel.org; Fri, 22 Dec 2006 02:36:48 -0500
In-Reply-To: <1166771189.18955.10.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Fri, 2006-12-22 at 02:06 -0500, Pavel Roskin wrote:
> It seems to me that the existing add_pre_buffer() mechanism can be used
> instead.  I'm just a bit worried why it wasn't done like this in the
> first place.

There was a reason to worry.  Now create_builtin_stream() is run after
the includes have been processed, so that e.g. the Linux compiler.h
tells me that my compiler is too old (because it was included from the
command line before __GNUC__ was defined).

The initialization order needs some untangling.  It's too intertwined
with the command line processing.

-- 
Regards,
Pavel Roskin
