From: Josh Triplett <josh@kernel.org>
Subject: Sparse licensing
Date: Thu, 2 Jul 2009 16:08:36 -0700
Message-ID: <20090702230836.GI19009@feather>
References: <20090702214349.GA19009@feather>
 <4A4D3468.1010202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-v.mail.gandi.net ([217.70.178.77]:38417 "EHLO
	relay3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbZGBXPH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Jul 2009 19:15:07 -0400
Content-Disposition: inline
In-Reply-To: <4A4D3468.1010202@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 02, 2009 at 06:27:52PM -0400, Jeff Garzik wrote:
> Can you weigh in on the licensing threads, pretty please?  That is
> still blocked on you, AFAIK.

Sure.

For my part, I'd *love* to see Sparse relicensed to something more
palatable.  Ideally, I'd love to see Sparse become GPL-compatible.  I'd
prefer a stronger copyleft over a weaker one.

I have no problem with relicensing Sparse to any of the following
licenses, in rough order of preference:

- GPL (v2 or v3, with or without "or any later version")
- LGPL (v2.1 or v3, with or without "or any later version")
- Either of the above with some kind of additional exception similar to
  those used for GCC and related libraries.
- Any of the above dual-licensed with the OSL, if people care about
  preserving that for some reason.  Seems unnecessarily complex to do
  so, though.

I'd prefer not to see Sparse relicensed to something entirely
non-copyleft like the MIT license, but if the rest of the Sparse
community wants that for some reason, I won't stand in the way.

If you need any more formal approval from me, please let me know.

Thanks,
Josh Triplett
