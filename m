From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] dissect: simplify lookup_member()
Date: Tue, 27 Feb 2007 20:18:00 -0500
Message-ID: <1172625480.2363.21.camel@dv>
References: <20061214213715.GB422@tv-sign.ru>
	 <45E47B26.8010006@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:50802 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbXB1BSD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 20:18:03 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HMDQg-0003GB-UG
	for linux-sparse@vger.kernel.org; Tue, 27 Feb 2007 20:16:27 -0500
In-Reply-To: <45E47B26.8010006@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Tue, 2007-02-27 at 10:40 -0800, Josh Triplett wrote:
> Oleg Nesterov wrote:
> > Change examine_sym_node() to recursively inspect the members of SYM_STRUCT.
> > This allows us to simplify lookup_member(): no need to do examine_sym_node(),
> > the member was already examined.
> > 
> > This is also good because now ->r_symdef(member) is called on declaration,
> > not when dissect detects the first usage of ->member.
> > 
> > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> Applied.

Josh, I'll really appreciate if you push your changes to the publicly
available repository as soon as you post "applied".  This way, when I
have some time for sparse, I read the list, see your post, update sparse
and see how it's affecting my projects.

If the changes are only available the next day, I'll probably be busy
with other things.

-- 
Regards,
Pavel Roskin
