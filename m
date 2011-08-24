From: Josh Triplett <josh@joshtriplett.org>
Subject: sparse and multiarch include paths
Date: Wed, 24 Aug 2011 14:42:46 -0700
Message-ID: <20110824214244.GA12248@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45948 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1HXVmz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 17:42:55 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: debian-gcc@lists.debian.org, multiarch-devel@lists.alioth.debian.org

When trying to use sparse on some low-level userspace code, I ran into
the following error:

/usr/include/bits/socket.h:381:11: error: unable to open 'asm/socket.h'

It looks like that file lives in
/usr/include/x86_64-linux-gnu/asm/socket.h , and gcc has
/usr/include/x86_64-linux-gnu in its default include path.  This relates
to Debian's multiarch efforts, moving such headers to paths which
include the architecture to allow simultaneous installation of the
headers for multiple architectures.  I don't know how gcc ends up with
that directory in its include path, but sparse needs to follow suit to
compile any code which includes these architecture-specific
headers.

I've CCed the Debian GCC maintainers and multiarch developers, in the
hopes of getting some additional details that might help resolve this
problem.

- Josh Triplett
