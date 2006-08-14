From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Recognize and ignore __alias__ and __visibility__
Date: Mon, 14 Aug 2006 15:25:29 -0400
Message-ID: <1155583529.24307.1.camel@dv>
References: <20060813055158.28706.93407.stgit@dv.roinet.com>
	 <1155570745.5410.8.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:7406 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932381AbWHNTZh
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Aug 2006 15:25:37 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GCi47-00030P-Gq
	for linux-sparse@vger.kernel.org; Mon, 14 Aug 2006 15:25:35 -0400
In-Reply-To: <1155570745.5410.8.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-sparse@vger.kernel.org

On Mon, 2006-08-14 at 08:52 -0700, Josh Triplett wrote:
> Stylistically, it looks like all of the existing ignored keywords in
> this function use a single combined if condition for the underscored and
> non-underscored versions of a given keyword, rather than two separate if
> conditions.  For consistency, what about something like the following
> instead:

Thanks for this improvement!

Signed-off-by: Pavel Roskin <proski@gnu.org>

-- 
Regards,
Pavel Roskin
