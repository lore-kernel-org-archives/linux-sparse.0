From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 21:52:50 +0000
Message-ID: <20090319215250.GF28946@ZenIV.linux.org.uk>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com> <20090319144622.GA28946@ZenIV.linux.org.uk> <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com> <20090319191431.GD28946@ZenIV.linux.org.uk> <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40159 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbZCSVwy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 17:52:54 -0400
Content-Disposition: inline
In-Reply-To: <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Thu, Mar 19, 2009 at 01:04:20PM -0700, Christopher Li wrote:

> We should stop the segfault though. I take a look at it. It seems that
> there is a SYM_NODE with base_type is NULL. I guess in some of
> the error path we result in an invalid AST three.

We are getting some mess with K&R declarations.  Which is bloody likely
to be my fault; will check.
