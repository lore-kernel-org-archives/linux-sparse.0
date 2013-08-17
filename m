From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 09:17:18 -0700
Message-ID: <20130817161718.GA18897@leaf>
References: <nsxtxio1jeh.fsf@lambda.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47637 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3HQQR1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 12:17:27 -0400
Content-Disposition: inline
In-Reply-To: <nsxtxio1jeh.fsf@lambda.thunk.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Theodore Ts'o <tytso@thunk.org>
Cc: linux-fsdevel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sat, Aug 17, 2013 at 10:28:22AM -0400, Theodore Ts'o wrote:
> It apparently has something to do with rcu and "address spaces" but I'm
> not completely sure what sparse is complaining about --- and whether it
> is a false positive or a bug in the posix_acl.h.
> 
> Can someone explain what's going on, and whether it's something to be
> concerned about?
[...]
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9: warning: incorrect type in assignment (different address spaces)
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    expected struct posix_acl *<noident>
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    got struct posix_acl [noderef] <asn:4>*<noident>
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9: warning: incorrect type in assignment (different address spaces)
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    expected struct posix_acl *<noident>
> /usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    got struct posix_acl [noderef] <asn:4>*<noident>

Address space 4 is __rcu.  This warning means you accessed an RCU
pointer directly, without using the appropriate RCU primitive
(rcu_assign_pointer, rcu_dereference, etc).

- Josh Triplett
