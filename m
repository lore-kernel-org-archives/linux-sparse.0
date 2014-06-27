From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCHv2 0/3] catch non-sign-extended '~' brainos
Date: Fri, 27 Jun 2014 14:19:00 +0300
Message-ID: <20140627111900.GA19158@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:41580 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbaF0LS1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2014 07:18:27 -0400
Content-Disposition: inline
In-Reply-To: <1402386847-23477-1-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org

On Tue, Jun 10, 2014 at 10:54:04AM +0300, Phil Carmody wrote:
> Bitwise-not is often used to create masks. Unfortunately implicit conversions
> to longer types may leave the recipient with fewer set bit than he expected,
> if he started with an unsigned type. It's nice to warn that such constructs
> are dubious.
> 
> v2: cleaned up as per recommendations from Josh Triplett.

Any comments on these? 

Cheers,
Phil 
