From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RFC 01/13] expression: introduce additional expression
 constness tracking flags
Date: Sat, 1 Aug 2015 15:00:44 +0200
Message-ID: <20150801130044.GB23735@ravnborg.org>
References: <87r3nzkct3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:59994 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbHANHg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 09:07:36 -0400
Content-Disposition: inline
In-Reply-To: <87r3nzkct3.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 23, 2015 at 01:11:36AM +0200, Nicolai Stange wrote:
> Prepare for a more fine-grained tracking of expression constness in the
> sense of C99 [6.4.4, 6.6].
> 
> User-visible behaviour remains unchanged.

Do this imply that you cannot write any testcase that fails before but is
fixed with this serie?

	Sam
