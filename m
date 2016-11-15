From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: sparse releases
Date: Tue, 15 Nov 2016 15:53:34 +0100
Message-ID: <1479221614.12007.37.camel@sipsolutions.net>
References: <1479219687.2547.20.camel@redhat.com>
         (sfid-20161115_152132_102579_99F7E0F1)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49528 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935544AbcKOOxl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Nov 2016 09:53:41 -0500
In-Reply-To: <1479219687.2547.20.camel@redhat.com> (sfid-20161115_152132_102579_99F7E0F1)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, 2016-11-15 at 09:21 -0500, Jeff Layton wrote:
> I have been maintaining the fedora sparse package for a few years now
> and have been simply updating the package when there are releases. It
> looks though like there haven't been any releases in the last couple
> of
> years.
> 
> Are sparse releases even "a thing" these days? Should I be revving
> the package from regular git pulls instead? I'd like to see the
> package get updates a little more regularly and am just trying to
> sort out how to do that.

Sadly, it seems that even the git tree is updated much less - and there
are a lot of pending patches. Perhaps there needs to be a maintainer
group/team?

johannes
