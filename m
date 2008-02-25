From: Pavel Roskin <proski@gnu.org>
Subject: Re: feature-request
Date: Sun, 24 Feb 2008 21:48:45 -0500
Message-ID: <1203907725.25518.17.camel@dv>
References: <20080223133945.GB10967@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:39309 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbYBYCsr (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Feb 2008 21:48:47 -0500
In-Reply-To: <20080223133945.GB10967@artemis.madism.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
Cc: linux-sparse@vger.kernel.org


On Sat, 2008-02-23 at 14:39 +0100, Pierre Habouzit wrote:
> While I'm at it, there is this feature I'd like to see in sparse: I'd
> love to be able to ask it to ignore errors that are located in some
> specific paths (like /usr/include e.g.). For now I'm doing that through
> a custom script, but it'd be simpler for me if it does it natively.  The
> reason is that I don't want to patch third party libraries headers.

We probably don't want to ignore _errors_, as they can indicate that the
parser doesn't understand the code correctly.  Ignoring warnings would
be a good idea.

Perhaps a simpler approach would be to turn off warnings in any files
included using angle brackets.

gcc doesn't report warnings in system files by default, but it can be
enabled with -Wsystem-headers.  Since sparse is primarily for the
kernel, I think the default should be to check the headers (as they are
part of the kernel), but sparse could support -Wno-system-headers.

Alternatively, sparse could have a userspace mode that would disable
warnings in system headers by default (unless -Wsystem-headers is used).
The kernel mode could be made stricter for the kernel without affecting
the userspace.

-- 
Regards,
Pavel Roskin
