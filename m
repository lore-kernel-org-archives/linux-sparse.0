From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 02:25:53 -0400
Message-ID: <46835471.4070000@garzik.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46392 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755717AbXF1G0A (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:26:00 -0400
In-Reply-To: <46834FA0.8010201@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

Josh Triplett wrote:
> While I agree that I'd like a better approach (specifically, I want any Sparse
> build to support any target arch), I don't yet have a solution for that, and
> this patch does at least seem like an improvement over the current hardcoded
> values.

That's my desire as well:  My ideal sparse backend should be able to 
compile x86, x86-64, ppc64, ia64, arm, etc. with just a change of 
command line switches.

The gcc approach is just bloody awful.

	Jeff
