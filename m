From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Update the information in README about using the library.
Date: Tue, 3 Dec 2013 15:45:17 -0800
Message-ID: <20131203234517.GB15141@jtriplet-mobl1>
References: <1386059165-3812-1-git-send-email-franzschrober@gmail.com>
 <CANeU7Qkh-bTrED7HeV-64Ngoi3ZhLZBo96v0mq-wMpCPJkHghA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43644 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3LCXp0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 18:45:26 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7Qkh-bTrED7HeV-64Ngoi3ZhLZBo96v0mq-wMpCPJkHghA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Franz Schrober <franzschrober@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, James Westby <james@jameswestby.net>

On Tue, Dec 03, 2013 at 03:17:37PM -0800, Christopher Li wrote:
> That will make you as the author of this commit.

The "From:" line at the top of the patch will make git set that person
as the author rather than the sender of the mail.

> I think not much people have pull from the sparse repository yet.

Bad assumption; if you've already pushed the patch, I'd suggest just
"git revert"ing the revert.

- Josh Triplett
