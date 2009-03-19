From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 19:14:31 +0000
Message-ID: <20090319191431.GD28946@ZenIV.linux.org.uk>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com> <20090319144622.GA28946@ZenIV.linux.org.uk> <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40645 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZCSTOe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 15:14:34 -0400
Content-Disposition: inline
In-Reply-To: <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Thu, Mar 19, 2009 at 07:38:51PM +0100, Hannes Eder wrote:

> http://hanneseder.net/sparse/kernel-cred-c.prep.tar.gz
> 
> $ sparse kernel-cred-c.prep.gcc
> 
> produces some warnings as usual.
> 
> $ sparse kernel-cred-c.prep.sparse
> 
> produces some warnings, a boatload of errors, and then segfaults.

Oh, joy.

a) some <expletives> has #define if(x) ....... (check it out, I'm not kidding)
b) ifdef that turd's conditional upon is present in your .config
c) ... and now,
	if (
#ifdef .....
		barf &&
#endif
		vomit)

steps into undefined behaviour.
