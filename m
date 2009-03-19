From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] test-suite: new preprocessor test case
Date: Thu, 19 Mar 2009 18:26:28 +0000
Message-ID: <20090319182628.GB28946@ZenIV.linux.org.uk>
References: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58834 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbZCSS0c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 14:26:32 -0400
Content-Disposition: inline
In-Reply-To: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Thu, Mar 19, 2009 at 06:56:11PM +0100, Hannes Eder wrote:
> Sparse currently fails on this test.

It doesn't.  6.10.3p11: "If there are sequences of preprocessing tokens
within the list of arguments that would otherwise act as preprocessing
directives, the behavior is undefined."

You are asking for identical nasal demons from two implementations, when
it's not even promised that the same kind will fly on two invocations of
the same implementation...

Seriously, this is undefined behaviour *and* it's extermely hard to come
up with self-consistent semantics for it.  Standard doesn't even try and
implementations are doing whatever's more convenient at the moment.  Try
to think of it and you'll come up with really ugly corner cases very fast.

What we probably ought to do is a warning when such stuff happens.
