From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 0/5] keyword driven parsing
Date: Wed, 7 Mar 2007 02:01:09 -0800
Message-ID: <20070307100109.GA10577@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:62626 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932887AbXCGKfq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 05:35:46 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, Linus Torvalds <torvalds@osdl.org>

Here is an attempt to use keyword driven parsing.

The effect is that, we don't need to keep on adding keyword to
ident-list any more.

It might be marginally faster because it does not do a series
of testing for ident any more. I can't really tell because
sparse is already fast.

It almost remove the usage match_idents(). The only place
for using it now is parse_asm().

BTW, why asm is a statement not an expression? If it is an
expression, it seems make sense to merge the volatile to the
ctype modifiers.

Feel back is welcome.

Chris
