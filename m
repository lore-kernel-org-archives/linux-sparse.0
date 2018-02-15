From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 0/2] drop the concept of 'known-but-ignored'
 attributes
Date: Thu, 15 Feb 2018 07:57:25 -0800
Message-ID: <20180215155724.GB1882@localhost>
References: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:50163 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424912AbeBOP5e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Feb 2018 10:57:34 -0500
Content-Disposition: inline
In-Reply-To: <20180213232109.20933-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Lance Richardson <lrichard@redhat.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Randy Dunlap <rdunlap@infradead.org>, Rui Teng <rui.teng@linux.vnet.ibm.com>, Christopher Li <sparse@chrisli.org>

On Wed, Feb 14, 2018 at 12:21:07AM +0100, Luc Van Oostenryck wrote:
> The goal of this series is to drop the concept of
> 'known-but-ignored' attributes which, for a semantic
> checker like sparse, adds absolutely no added value
> but bring endless annoyances.

I absolutely agree that these have been annoying. However, they've also
been useful in the past to identify new flags used in the kernel and
other projects that we may need to actually act on, rather than just
ignore.
