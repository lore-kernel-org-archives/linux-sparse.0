From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Structures from -include are "weak"
Date: Sun, 8 Jul 2007 06:42:18 +0100
Message-ID: <20070708054218.GD21668@ftp.linux.org.uk>
References: <1183865570.12651.18.camel@gx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34382 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbXGHFmV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 01:42:21 -0400
Content-Disposition: inline
In-Reply-To: <1183865570.12651.18.camel@gx>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Sat, Jul 07, 2007 at 11:32:50PM -0400, Pavel Roskin wrote:

> It looks like the definition of struct st is sort of "weak" when it's
> read from the header included on the command line, so that the forward
> declaration from test.c removes the original definition.
> 
> It's also possible to define struct st to something else, and sparse
> won't warn about it.  But omitting "struct st;" fixes the error, so the
> original definition is known to sparse.

Looks like it gets a scope boundary between those.  There is one case
when presense of struct st; changes things: struct st; in

struct st {....};
....
{
	struct st;
	struct st *p;
	...
	struct st {....} x;
	...
}

will make p a pointer to struct st from that scope.  If you omit it,
p will be a pointer to struct st from the outer scope and x will have
a different type.  Too late beginning of file scope, perhaps?
