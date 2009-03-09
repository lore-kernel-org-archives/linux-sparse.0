From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patches] more declarations fixes
Date: Mon, 9 Mar 2009 23:32:11 +0000
Message-ID: <20090309233211.GT28946@ZenIV.linux.org.uk>
References: <E1LgZcm-0000qk-0S@ZenIV.linux.org.uk> <70318cbf0903091555t2f456476u16e06d642f1fd02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40452 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZCIXcN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 19:32:13 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0903091555t2f456476u16e06d642f1fd02@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Mon, Mar 09, 2009 at 03:55:47PM -0700, Christopher Li wrote:
> Great change. Thanks.
> 
> I will try it out later tonight.

And while we are at it, here come 3 scope-related fixes...

BTW, what in the name of everything unholy have you got in
validation/static-forward-decl.c?  Misplaced error line?
