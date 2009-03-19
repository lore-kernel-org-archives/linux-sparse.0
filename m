From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [PATCH] test-suite: new preprocessor test case
Date: Thu, 19 Mar 2009 19:24:06 +0000
Message-ID: <49C29BD6.7050005@knosof.co.uk>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net> <20090319182628.GB28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:44139 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754818AbZCSTYU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 15:24:20 -0400
In-Reply-To: <20090319182628.GB28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Hannes Eder <hannes@hanneseder.net>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

Al,

> It doesn't.  6.10.3p11: "If there are sequences of preprocessing tokens
> within the list of arguments that would otherwise act as preprocessing
> directives, the behavior is undefined."
> 
> You are asking for identical nasal demons from two implementations, when
> it's not even promised that the same kind will fly on two invocations of
> the same implementation...

So what you are saying is that this is a bug in the header.
This is the approach I would favor.

> Seriously, this is undefined behaviour *and* it's extermely hard to come
> up with self-consistent semantics for it.  Standard doesn't even try and
> implementations are doing whatever's more convenient at the moment.  Try
> to think of it and you'll come up with really ugly corner cases very fast.

Unless gcc comes up with consistent behavior every time I would not
expect this usage to hang around very long in the header.

> What we probably ought to do is a warning when such stuff happens.

You mean a more easy to understand message.

-- 
Derek M. Jones                         tel: +44 (0) 1252 520 667
Knowledge Software Ltd                 mailto:derek@knosof.co.uk
Source code analysis                   http://www.knosof.co.uk
