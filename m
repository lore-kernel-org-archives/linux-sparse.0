From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse context tags
Date: Mon, 12 Mar 2007 21:31:06 -0400
Message-ID: <1173749466.13436.32.camel@dv>
References: <ee9e417a0703121537p49657eai662b3dce82c7af5d@mail.gmail.com>
	 <20070313003234.GA4640@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:55695 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbXCMBbL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Mar 2007 21:31:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HQvpH-0007s9-Eb
	for linux-sparse@vger.kernel.org; Mon, 12 Mar 2007 21:29:19 -0400
In-Reply-To: <20070313003234.GA4640@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Russ Cox <rsc@swtch.com>, linux-sparse@vger.kernel.org

On Mon, 2007-03-12 at 17:32 -0700, Christopher Li wrote:

> That is because sparse can't distinguish which lock is
> acquired. It is actually hard to get that information.
> Even though the expression is the same, the actual lock
> might be different.
> 
> e.g.
> 
> redlock(foo->redlock);
> foo = bar;
> redunlock (foo->redlock);

Just an idea.  The Linux "runtime locking correctness validator" (see
Documentation/lockdep-design.txt in the Linux sources) distinguishes
between lock classes.

Sparse could use a similar approach.  I think it would not catch your
example, but it would catch a more realistic case when one lock is
acquired and another is released even by the same function with the same
attributes:

lock(foo->redlock);
lock(foo->bluelock);
unlock(foo->redlock);
unlock(foo->bluelock);

Lock class could be just a unique reference to a place where the lock
was declared.  That would put some limitations on what a lock could be
(an address of a variable or a field), but I think it's OK.

-- 
Regards,
Pavel Roskin
